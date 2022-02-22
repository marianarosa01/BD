-- a) 

use p3g1
go
--DROP PROCEDURE Company.delete_Employee
CREATE PROCEDURE Company.delete_Employee @issn char(9)
AS
BEGIN

		-- 1. Delete de dependent
		delete from dependent where Essn=@issn;

		-- 2. Delete de Works_on	
		delete from works_on where Essn=@issn;

		-- 3. Tratar do MGR_SSN
		update Department set Mgr_Ssn = null where Mgr_ssn = @issn;

		-- 4. Tratar do super SSN
		update employee set super_ssn=null where super_ssn=@issn;

		-- 5. Delete da tabela employee
		delete from employee where Ssn=@issn
end

exec Company.delete_Employee 2312
go

-- b)


--DROP PROCEDURE Company.getManagers
GO
CREATE PROCEDURE Company.getManagers  (@ssn_olders char(12) OUTPUT, @years_older_ int OUTPUT)
AS
	BEGIN
		SELECT * 
		FROM (Company.Employee LEFT OUTER JOIN Company.Department ON Ssn = Mgr_ssn)
		WHERE Mgr_ssn IS NOT NULL
		ORDER BY Mgr_start_date;
		
		SELECT @years_older_=min(DATEDIFF(year,Company.Department.Mgr_start_date,getDate())), @ssn_olders = Company.Department.Mgr_ssn
		FROM Company.Department
		WHERE Mgr_ssn IS NOT NULL
		GROUP BY Company.Department.Mgr_start_date, Company.Department.Mgr_Ssn

	END

DECLARE @ssn_olders char(12);
DECLARE @years_older_ int;
EXEC Company.getManagers @ssn_olders = @snn_olders OUTPUT,
						@years_older = @years_older_ OUTPUT;
PRINT @ssn_olders
PRINT @years_older_








go
select getdate()


declare
select  @x=fname, @y=lname, @z=salary
from Company.employee
order by Lname desc

--guardar resultado, selecionar o tuplo que vamos ver

select * from Company.Employee

-- NOTA: datediff(YEAR,d1,d2) 
-- este metodo retorna a diferenca


------------
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


