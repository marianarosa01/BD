drop procedure Company.uspDeleteEmployee

go
create procedure Company.uspDeleteEmployee
	@ssn	char(9)
as
	begin
		delete from Company.[Works_on] where Essn=@ssn
		delete from Company.[Dependent] where Essn=@ssn
		update Company.[Department] set Mgr_ssn=null where Mgr_ssn=@ssn
		update Company.[Employee] set Super_ssn=null where Super_ssn=@ssn
		delete from Company.[Employee] where Ssn=@ssn
	end
go

declare @ssn char(9)
exec Company.uspDeleteEmployee @ssn='12652121'
go

--(b) Crie um stored procedure que retorne um record-set com os funcionários gestores de  departamentos,  assim como  o  ssn
-- e  número  de  anos  (como  gestor)  do funcionário mais antigo dessa lista.
drop procedure uspDeptManager

go
create procedure uspDeptManager
	@ssn		char(9)	output,
	@nOfYears	int		output
as
	begin
		select Ssn, Fname, Minit, Lname, Bdate, [Address], Sex, Salary, Super_ssn, Dnumber, Dname, Mgr_start_date
		from Company.Employee join Company.Department on Ssn=Mgr_ssn

		select @ssn = Mgr_ssn, @nOfYears=max(DATEDIFF(year, Mgr_start_date, getdate()))
		from Company.Department
		where Mgr_ssn is not null
		group by Mgr_ssn, Mgr_start_date
		order by Mgr_start_date desc, Mgr_ssn asc
	end
go

declare @Ssn			char(9)
declare @numberOfYears	int
exec uspDeptManager
	@ssn = @Ssn output,
	@nOfYears=@numberOfYears output
print @ssn
print @numberOfYears
go

-- (c) Construa  um  trigger  que  não  permita  que  determinado  funcionário  seja  definido como gestor de mais do que um departamento
drop trigger Company.OnlyOneDeptMgr

go
create trigger Company.OnlyOneDeptMgr on Company.Department
after insert, update
as
	begin
		set nocount on

		declare @mgrSsn char(9)
		declare @n int
		select @mgrSsn=Mgr_ssn from inserted;


		set @n = (	select count(Mgr_ssn)
					from Company.Department
					where Mgr_ssn=@mgrSsn
					)
		if (@n>1)
			begin
				raiserror ('Não podes ser mgr de mais que um dept', 16,1);
				rollback tran;
			end
	end
go

insert into Company.Department values ('My Dept1',8,null,'2018-01-01')
go


-- (d) Crie um trigger que não permita que determinado funcionário tenha um vencimento superior ao vencimento do gestor do seu departamento.
-- Nestes casos, o  trigger  deve  ajustar  o  salário  do  funcionário  para  um  valor  igual  ao  salário  do gestor menos uma unidade.
drop trigger Company.dontEarnMorethanDeptMgr

go
create trigger Company.dontEarnMorethanDeptMgr on Company.Employee
after insert, update
as
	begin
		set nocount on

		declare @Mgr_salary decimal(6,2)
		declare @Dno int
		declare @ssn char(9)
		declare @sal decimal(6,2)
		select @Dno=Dno, @sal=Salary, @ssn=Ssn from inserted;

		select @Mgr_salary=Salary
		from Company.Department join Company.Employee on Mgr_ssn=Ssn
		where Dnumber=@Dno

		if (@sal > @Mgr_salary)
		begin
			update Company.Employee
			set Salary=@Mgr_salary-1
			where Ssn=@ssn
		end
	end
go

insert into Company.Employee values ('Vasco', 'A', 'Ramos', '123456789', '1999-07-08', 'Rua ola', 'M', '2500', null, 2);
go


-- (e) Crie uma UDF que, para determinado funcionário (ssn), devolva o nome
-- e localização dos projetos em que trabalha.
drop function Company.EmplProjects
go

go
create function Company.EmplProjects (@ssn char(9)) returns Table
as
	return (select Pname, Plocation
			from (Company.Employee join Company.Works_on on Ssn=Essn) join Company.Project on Pno=Pnumber
			where Ssn=@ssn
			)
go

select *
from Company.EmplProjects ('342343434');
go


-- (f) Crie uma UDF que, para determinado departamento (dno),
-- retorne os funcionários com um vencimento superior à média dos vencimentos desse departamento;
drop function Company.EmpBestSalaries
go

go
create function Company.EmpBestSalaries (@dno int) returns Table
as
	return (select Ssn, Fname, Minit, Salary, Dno
			from Company.Employee
			where Dno=@dno and salary > (select avg(Salary)
							from Company.Employee
							where Dno=@dno
							)
			)
go

select * from Company.EmpBestSalaries (2)
go


-- (g) Crie uma UDF que, para determinado departamento, retorne um record-set com os projetos desse departamento.
-- Para cada projeto devemos ter um atributo com seu o orçamento mensal de mão de obra e outra coluna com o valor acumulado do orçamento.
drop function Company.employeeDeptHighAverage
go

go
create function Company.employeeDeptHighAverage (@dnumber int) returns @ProjBudget Table
	(pName varchar(30), pnumber int not null, plocation varchar(15), dnum int, budget decimal, totalbudget decimal)
as
	begin
		declare @pName as varchar(30), @pnumber as int, @prevPnumber as int, @plocation as varchar(15),
				@dnum as int, @budget as decimal, @totalbudget as decimal, @hours as decimal, @salary as decimal;
		
		declare c cursor fast_forward
		for select Pname, Pnumber, Plocation, Dnum, [Hours], Salary
		from (Company.Project join Works_on on Pnumber=Pno) join Company.Employee on Essn=Ssn
		where Dnum=@dnumber;

		open c;

		fetch c into @pName, @pnumber, @plocation, @dnum, @hours, @salary;

		select @prevPnumber = @pnumber, @budget = 0, @totalbudget = 0;

		while @@fetch_status = 0
			begin
				if @prevPnumber <> @pnumber
					begin
						insert @ProjBudget values (@pName,@prevPnumber,@plocation,@dnum,@budget,@totalbudget);
						select @prevPnumber = @pnumber, @budget = 0;
					end

					set @budget += @salary*@hours/40;
					set @totalbudget += @salary*@hours/40;

					fetch c into @pName, @pnumber, @plocation, @dnum, @hours, @salary;
			end

		close c;
		deallocate c;

		return;
	end
go

select * from Company.employeeDeptHighAverage (3);
go


-- (h) Pretende-se criar um trigger que, quando se elimina um departamento,
-- este passe para uma tabela department_deleted com a mesma  estrutura da department.
-- Caso esta tabela não exista então deve criar uma nova e só depois inserir o registo.
-- Implemente a solução com um trigger de cada tipo (after e instead of).
-- Discuta vantagens e desvantagem de cada implementação.

-- (h1) Usando after!
drop trigger Company.deleteDepartmentAfter
go

go
create trigger Company.deleteDepartmentAfter on Company.[Department]
after delete
as
begin
	-- begin transaction
	begin transaction
		
		-- get department number
		declare @dNumber int
		select @dNumber=Dnumber from deleted;

		--check if exists a table for the deleted departments
        --if not, create it
		if (not exists( select * from information_schema.tables where table_schema='Company' and table_name='Department_deleted'))
		begin
			create table Company.Department_deleted 
            (
                Dname			varchar(30) not null,
                Dnumber			int			not null,
                Mgr_ssn			char(9)			null,
                Mgr_start_date	date			null,
                
				primary key(Dnumber)
            )
			alter table Company.Department_deleted add constraint deptDeletedEmp foreign key (Mgr_ssn) references Company.Employee (Ssn);
		end

		begin try
			-- insert into the deleted department table
			insert into Company.Department_deleted 
			select * from deleted
		end try

        begin catch
            raiserror ('Error deleting department', 16, 1)   
        end catch

	commit transaction
end
go

select * from Company.Department_deleted
delete from Company.Department where Dnumber=8


-- (h2) Usando instead of!
drop trigger Company.deleteDepartment
go

go
create trigger Company.deleteDepartment on Company.[Department]
instead of delete
as
begin
	-- begin transaction
	begin transaction
		
		-- get department number
		declare @dNumber int
		select @dNumber=Dnumber from deleted;

		--check if exists a table for the deleted departments
        --if not, create it
		if (not exists( select * from information_schema.tables where table_schema='Company' and table_name='Department_deleted'))
		begin
			create table Company.Department_deleted 
            (
                Dname			varchar(30) not null,
                Dnumber			int			not null,
                Mgr_ssn			char(9)			null,
                Mgr_start_date	date			null,
                
				primary key(Dnumber)
            )
			alter table Company.Department_deleted add constraint deptDeletedEmp foreign key (Mgr_ssn) references Company.Employee (Ssn);
		end

		begin try
			-- insert into the deleted department table
			insert into Company.Department_deleted 
			select * from deleted

			-- delete the department
			delete from Company.Department where Dnumber=@dNumber;
		end try

        begin catch
            raiserror ('Error deleting department', 16, 1)   
        end catch

	commit transaction
end
go

select * from Company.Department_deleted
delete from Company.Department where Dnumber=8