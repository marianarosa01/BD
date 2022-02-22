-- A)
CREATE PROCEDURE Company.delEmployee @issn char(9)
AS
    BEGIN
        --Delete dependent
        DELETE FROM Company.Dependent where Essn=@issn;

        --delete de works_on
        DELETE FROM Company.Works_on where Essn=@issn;

        -- apagar registos de manager
        update department set Mgr_ssn=null where Mgr_ssn=@issn;

        -- apaga registos de supervisor 
        update Company.Employee 
            set Company.Employee.Super_ssn  = null where Super_ssn = @issn

        -- apaga o funcionario
        DELETE FROM Company.Employee WHERE Ssn = @issn


    END

EXEC Company.delEmployee '12652121'

-- B)
DROP PROCEDURE getGestores;
GO
CREATE PROC getGestores (@g CHAR(9) OUTPUT, @ssnout INT OUTPUT)
AS
	BEGIN
		SELECT * FROM (Company.EMPLOYEE JOIN Company.DEPARTMENT ON Ssn = Mgr_ssn);

		(SELECT TOP 1 @anosout = MAX(DATEDIFF(year,Company.DEPARTMENT.Mgr_start_date,getDate())), @ssnout = Company.DEPARTMENT.Mgr_ssn
		FROM Company.EMPLOYEE JOIN Company.DEPARTMENT ON Ssn = Mgr_ssn
		GROUP BY Company.DEPARTMENT.Mgr_start_date, Company.DEPARTMENT.Mgr_Ssn)
	END



DECLARE @anosout CHAR(9);
DECLARE @ssnout INT;
EXEC getGestores @anosout = @anosout OUTPUT, @ssnout = @ssnout OUTPUT; 
PRINT @anosout;
PRINT @ssnout;

-- C)


DROP TRIGGER Company.funcAvoid; 
GO
CREATE Trigger Company.funcAvoid ON Company.DEPARTMENT 
AFTER INSERT, UPDATE
AS
	SET NOCOUNT ON;
	DECLARE @mSSN CHAR(9);
	SELECT @mSSN=Mgr_ssn FROM inserted;

	IF EXISTS( SELECT Mgr_ssn FROM Company.DEPARTMENT WHERE Mgr_ssn=@mSSN )
	BEGIN
		RAISERROR ('Ha manager de departamento!', 16,1);
		ROLLBACK TRAN;
	END
 GO

 -- D)
DROP TRIGGER Company.checkMoney;
GO
CREATE TRIGGER Company.checkMoney on Company.EMPLOYEE
AFTER INSERT, UPDATE
AS
	BEGIN
		SET NOCOUNT ON;

		DECLARE @Msalario DECIMAL(6,2)
		DECLARE @Dno INT
		DECLARE @ssn CHAR(9)
		DECLARE @salario DECIMAL(6,2)
		SELECT @Dno=Dno, @salario=Salary, @ssn=Ssn FROM inserted;

		SELECT @Msalario=Salary
		FROM Company.DEPARTMENT JOIN Company.EMPLOYEE ON Mgr_ssn=Ssn
		WHERE Dnumber=@Dno

		IF (@salario > @MSalario)
		BEGIN
			UPDATE Company.EMPLOYEE
			SET Salary=@MSalario - 1
			WHERE Ssn=@ssn
		END
	END
GO

-- E)
DROP FUNCTION Company.EProj;
GO

GO
CREATE FUNCTION Company.EProj (@ssn CHAR(9)) RETURNS TABLE
AS
RETURN (SELECT Pname, Plocation FROM ((Company.EMPLOYEE JOIN Company.Works_on ON Ssn = Essn) JOIN Company.Project ON Pno = Pnumber) WHERE Ssn = @ssn)
GO

SELECT Pname FROM Company.EProj('125564878');
GO

-- F)

DROP FUNCTION Company.Dnov;
GO

GO
CREATE FUNCTION Company.Dnov (@dno INT) RETURNS TABLE
AS
	BEGIN
		DECLARE @avgSalary DECIMAL(10,2);
		SET @avgSalary = SELECT(AVG(Salary) FROM Company.EMPLOYEE WHERE Dno=@dno);
		RETURN SELECT Fname, Lname, Ssn FROM Company.EMPLOYEE WHERE Dno=@dno AND Salary > @avgSalary;
	END
GO

-- G)

DROP FUNCTION Company.employeeDeptHighAverage
GO

GO
CREATE FUNCTION Company.employeeDeptHighAverage(@dno int) RETURNS @projtable TABLE (pname varchar(15), number int, plocation varchar(15), dnum int, budget decimal(10,2), totalbudget decimal(10,2))
AS
BEGIN

	DECLARE @pname as varchar(15), @number as int, @plocation as varchar(15), @dnum as int, @budget as decimal(10,2), @totalbudget as decimal(10,2);

	DECLARE C CURSOR FAST_FORWARD
	FOR SELECT Pname, Pnumber, Plocation, Dnumber, Sum(Salary*[Hours]/(40*4))
		FROM	Company.DEPARTMENT 
				JOIN Company.PROJECT ON Dnumber=Dnum
				JOIN Company.Works_on ON Pnumber=Pno
				JOIN Company.EMPLOYEE ON Essn=Ssn
		WHERE Dnumber=@dno
		GROUP BY Pname, Pnumber, Plocation, Dnumber;

	OPEN C;

	FETCH C INTO @pname, @number, @plocation, @dnum, @budget;
	SELECT @totalbudget = 0;

	WHILE @@FETCH_STATUS = 0
	BEGIN
		SET @totalbudget += @budget;
		INSERT INTO @projtable VALUES (@pname, @number, @plocation, @dnum, @budget, @totalbudget)
		FETCH C INTO @pname, @number, @plocation, @dnum, @budget;
	END

	CLOSE C;

	DEALLOCATE C;

	return;
END
GO

-- H)

CREATE TRIGGER Company.delDepInst ON Company.DEPARTMENT
INSTEAD OF DELETE
AS
		BEGIN
			DECLARE @Dname VARCHAR(30);
			DECLARE @Dnumber int;
			DECLARE @Mgr_ssn int;
			DECLARE @Mgr_start_date date;

			SELECT @Dname = Dname FROM deleted;
			SELECT @Dnumber = Dnumber FROM deleted;
			SELECT @Mgr_ssn = Mgr_ssn FROM deleted;
			SELECT @Mgr_start_date = Mgr_start_date FROM deleted;

			IF (NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES
				WHERE TABLE_SCHEMA = 'Company' AND TABLE_NAME = 'DEPARTMENT_DELETED'))
				CREATE TABLE Company.DEPARTMENT_DELETED (Dname VARCHAR(30), Dnumber int, Mgr_ssn int NULL, Mgr_start_date date NULL);
			INSERT INTO Company.DEPARTMENT_DELETED VALUES (@Dname, @Dnumber, @Mgr_ssn, @Mgr_start_date);
			DELETE FROM Company.DEPARTMENT WHERE Dnumber = @Dnumber; 
		END		

GO

CREATE TRIGGER Company.delDepAfter ON Company.DEPARTMENT
AFTER DELETE
AS
		BEGIN
			DECLARE @Dname VARCHAR(30);
			DECLARE @Dnumber int;
			DECLARE @Mgr_ssn int;
			DECLARE @Mgr_start_date date;

			SELECT @Dname = Dname FROM deleted;
			SELECT @Dnumber = Dnumber FROM deleted;
			SELECT @Mgr_ssn = Mgr_ssn FROM deleted;
			SELECT @Mgr_start_date = Mgr_start_date FROM deleted;

			IF (NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES
				WHERE TABLE_SCHEMA = 'Company' AND TABLE_NAME = 'DEPARTMENT_DELETED'))
				CREATE TABLE Company.DEPARTMENT_DELETED (Dname VARCHAR(30), Dnumber int, Mgr_ssn int NULL, Mgr_start_date date NULL);
			INSERT INTO Company.DEPARTMENT_DELETED VALUES (@Dname, @Dnumber, @Mgr_ssn, @Mgr_start_date);
		END			

GO	