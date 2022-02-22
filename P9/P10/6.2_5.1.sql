-- ex 6.2 -> 5.1
-- a) criacao das tabelas
create schema Company;

create table Company.Department(
	Dname			varchar(30)		not null,
	Dnumber			int				not null	CHECK(Dnumber> 0),
	Mgr_Ssn			char(9)					,
	Mgr_start_date	date,

	primary key (Dnumber)
);

create table Company.Employee (
	Fname		varchar(15)		not null,
	Minit		char(1)					,
	Lname		varchar(15)		not null,
	Ssn			char(9)			not null,
	Bdate		date,
	e_Address	varchar(30),	
	Sex			char(1)			not null,
	Salary		decimal(6,2)	not null	CHECK(Salary >= 0),
	Super_ssn	char(9),
	Dno			int				not null
	
	primary key (Ssn),			
	foreign key (Dno) references Company.Department (Dnumber)
);

create table Company.Dept_locations(
	Dnumber		int			not null,
	Dlocation	varchar(15)	not null

	primary key (Dnumber,Dlocation),
	foreign key (Dnumber) references Company.Department(Dnumber)
);

create table Company.Project(
	Pname		varchar(30)		not null,
	Pnumber		int				not null		CHECK(Pnumber> 0),
	Plocation	varchar(15)		not null,
	Dnum		int				not null,

	primary key (Pnumber),
	foreign key (Dnum) references Company.Department (Dnumber)
);

create table Company.Works_on(
	Essn	char(9)			not null,
	Pno		int				not null,
	[Hours]	decimal(3,1)	not null,

	primary key (Essn,Pno),
	foreign key (Pno) references Company.Project (Pnumber),
	foreign key (Essn) references Company.Employee (Ssn)
);

--note q [] serve para usar palavras reservadas
create table Company.[Dependent](
	Essn			char(9)		not null,
	Dependent_name	varchar(30)	not null,
	Sex				char(1)		not null,
	Bdate			date				,
	Relationship	varchar(15)	not null

	primary key (Essn,Dependent_name),
	foreign key (Essn) references Company.Employee (Ssn)
);

alter table Company.Employee add constraint employeeSuper foreign key (Super_ssn) references Company.Employee (Ssn);

-- #############################################################
-- b) introducao de dados

INSERT INTO COMPANY.EMPLOYEE(Fname,Minit,Lname,Ssn,Bdate,e_Address,Sex,Salary,Super_ssn,Dno)VALUES('Paula','A','Sousa',183623612,'2001-08-11','Rua da FRENTE','F',1450.00,NULL,3)
INSERT INTO COMPANY.EMPLOYEE(Fname,Minit,Lname,Ssn,Bdate,e_Address,Sex,Salary,Super_ssn,Dno)VALUES('Carlos','D','Gomes',21312332,'2000-01-01','Rua XPTO','M',1200.00,NULL,1)
INSERT INTO COMPANY.EMPLOYEE(Fname,Minit,Lname,Ssn,Bdate,e_Address,Sex,Salary,Super_ssn,Dno)VALUES('Juliana','A','Amaral',321233765,'1980-08-11','Rua BZZZZ','F',1350.00,NULL,3)
INSERT INTO COMPANY.EMPLOYEE(Fname,Minit,Lname,Ssn,Bdate,e_Address,Sex,Salary,Super_ssn,Dno)VALUES('Maria','I','Pereira',342343434,'2001-05-01','Rua JANOTA','F',1250.00,21312332,2)
INSERT INTO COMPANY.EMPLOYEE(Fname,Minit,Lname,Ssn,Bdate,e_Address,Sex,Salary,Super_ssn,Dno)VALUES('Joao','G','Costa',41124234,'2001-01-01','Rua YGZ','M',1300.00,21312332,2)
INSERT INTO COMPANY.EMPLOYEE(Fname,Minit,Lname,Ssn,Bdate,e_Address,Sex,Salary,Super_ssn,Dno)VALUES('Ana','L','Silva',12652121,'1990-03-03','Rua ZIG ZAG','F',1400.00,21312332,2)
INSERT INTO COMPANY.DEPARTMENT(Dname,Dnumber,Mgr_ssn,Mgr_start_date)VALUES('Investigacao',1,21312332,'2010-08-02')
INSERT INTO COMPANY.DEPARTMENT(Dname,Dnumber,Mgr_ssn,Mgr_start_date)VALUES('Comercial',2,321233765,'2013-05-16')
INSERT INTO COMPANY.DEPARTMENT(Dname,Dnumber,Mgr_ssn,Mgr_start_date)VALUES('Logistica',3,41124234,'2013-05-16')
INSERT INTO COMPANY.DEPARTMENT(Dname,Dnumber,Mgr_ssn,Mgr_start_date)VALUES('Recursos Humanos',4,12652121,'2014-04-02')
INSERT INTO COMPANY.DEPARTMENT(Dname,Dnumber,Mgr_ssn,Mgr_start_date)VALUES('Desporto',5,NULL,NULL)
INSERT INTO COMPANY.DEPENDENT(Essn,Dependent_name,Sex,Bdate,Relationship)VALUES(21312332,'Joana Costa','F','2008-04-01','Filho')
INSERT INTO COMPANY.DEPENDENT(Essn,Dependent_name,Sex,Bdate,Relationship)VALUES(21312332,'Maria Costa','F','1990-10-05','Neto')
INSERT INTO COMPANY.DEPENDENT(Essn,Dependent_name,Sex,Bdate,Relationship)VALUES(21312332,'Rui Costa','M','2000-08-04','Neto')
INSERT INTO COMPANY.DEPENDENT(Essn,Dependent_name,Sex,Bdate,Relationship)VALUES(321233765,'Filho Lindo','M','2001-02-22','Filho')
INSERT INTO COMPANY.DEPENDENT(Essn,Dependent_name,Sex,Bdate,Relationship)VALUES(342343434,'Rosa Lima','F','2006-03-11','Filho')
INSERT INTO COMPANY.DEPENDENT(Essn,Dependent_name,Sex,Bdate,Relationship)VALUES(41124234,'Ana Sousa','F','2007-04-13','Neto')
INSERT INTO COMPANY.DEPENDENT(Essn,Dependent_name,Sex,Bdate,Relationship)VALUES(41124234,'Gaspar Pinto','M','2006-02-08','Sobrinho')
INSERT INTO COMPANY.PROJECT(Pname,Pnumber,Plocation,Dnum)VALUES('Aveiro Digital',1,'Aveiro',3)
INSERT INTO COMPANY.PROJECT(Pname,Pnumber,Plocation,Dnum)VALUES('BD Open Day',2,'Espinho',2)
INSERT INTO COMPANY.PROJECT(Pname,Pnumber,Plocation,Dnum)VALUES('Dicoogle',3,'Aveiro',3)
INSERT INTO COMPANY.PROJECT(Pname,Pnumber,Plocation,Dnum)VALUES('GOPACS',4,'Aveiro',3)
INSERT INTO COMPANY.WORKS_ON(Essn,Pno,w_Hours)VALUES(183623612,1,20.0)
INSERT INTO COMPANY.WORKS_ON(Essn,Pno,w_Hours)VALUES(183623612,3,10.0)
INSERT INTO COMPANY.WORKS_ON(Essn,Pno,w_Hours)VALUES(21312332,1,20.0)
INSERT INTO COMPANY.WORKS_ON(Essn,Pno,w_Hours)VALUES(321233765,1,25.0)
INSERT INTO COMPANY.WORKS_ON(Essn,Pno,w_Hours)VALUES(342343434,1,20.0)
INSERT INTO COMPANY.WORKS_ON(Essn,Pno,w_Hours)VALUES(342343434,4,25.0)
INSERT INTO COMPANY.WORKS_ON(Essn,Pno,w_Hours)VALUES(41124234,2,20.0)
INSERT INTO COMPANY.WORKS_ON(Essn,Pno,w_Hours)VALUES(41124234,3,30.0)

-- ###############################################################
-- c) traducao de AR pra SQL 

-- a)
SELECT Ssn, Fname, Minit, Lname, Pno FROM (Company.Employee JOIN Company.Works_on ON Ssn=Essn);

-- b) 
SELECT E.Fname, E.Minit, E.Lname
FROM (Company.Employee as E JOIN Company.Employee as S ON E.Super_ssn=S.Ssn)
WHERE S.Fname='Carlos' AND S.Minit='D' AND S.Lname='Gomes';

-- c)
SELECT Pname, sum(w_Hours) as TotalH
FROM (Company.Project JOIN Company.Works_on ON Pnumber=Pno)
GROUP BY Pname;

-- d)
SELECT Fname,Minit,Lname
FROM ((Company.Project JOIN Company.Works_on ON Pnumber=Pno) JOIN Company.Employee ON Ssn=Essn)
WHERE w_Hours>20 AND Dno=3 AND Pname='Aveiro Digital';

-- e)
SELECT Fname,Minit,Lname
FROM (Company.Employee left outer JOIN Company.Works_on ON Ssn=Essn)
WHERE Essn is null

-- f)
SELECT Dname, avg(Salary) as Avg_salary
FROM (Company.Department JOIN Company.Employee ON Dno=Dnumber)
WHERE Sex='F'
GROUP BY Dname;

-- g)
SELECT Fname, Minit, Lname, count(Dependent_name) as DepNumb
FROM (Company.Employee JOIN [Company.Dependent] ON Ssn=Essn)
GROUP BY  Fname, Minit, Lname
HAVING count(Dependent_name) > 2;

-- h)
SELECT Fname, Minit, Lname
FROM ((Company.Employee JOIN Company.Department ON Ssn=Mgr_ssn) LEFT OUTER JOIN [Company.Dependent] ON Ssn=Essn)
WHERE Essn is NULL

-- i)
SELECT DISTINCT Fname, Minit,Lname,[Address]
FROM (((Company.Works_on JOIN Company.Employee ON Ssn=Essn) JOIN Company.Project ON Pno=Pnumber) JOIN Company.Dept_locations ON Dno=Dnumber)
WHERE Plocation='Aveiro' AND Dlocation!='Aveiro'