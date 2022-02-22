DROP TABLE mytemp

CREATE TABLE mytemp (
 rid BIGINT /*IDENTITY (1, 1)*/ NOT NULL,
 at1 INT NULL,
at2 INT NULL,
at3 INT NULL,
lixo varchar(100) NULL
);

-- Clustered Index a)
CREATE CLUSTERED INDEX rid_idx ON mytemp(rid);

---b ) 
-- Page fullness: 68.53%
-- Total fragmentation: 99.18%
-- OUTPUT 
-- Inserted      50000 total records
-- Milliseconds used: 105340


ALTER TABLE mytemp ADD CONSTRAINT PK_RID PRIMARY KEY CLUSTERED (rid) WITH (FILLFACTOR = 90);


-- Record the Start Time
DECLARE @start_time DATETIME, @end_time DATETIME;
SET @start_time = GETDATE();
PRINT @start_time
-- Generate random records
DECLARE @val as int = 1;
DECLARE @nelem as int = 50000;
SET nocount ON
WHILE @val <= @nelem
BEGIN
 DBCC DROPCLEANBUFFERS; -- need to be sysadmin
 INSERT mytemp (rid, at1, at2, at3, lixo)
 SELECT cast((RAND()*@nelem*40000) as int), cast((RAND()*@nelem) as int),
 cast((RAND()*@nelem) as int), cast((RAND()*@nelem) as int),
 'lixo...lixo...lixo...lixo...lixo...lixo...lixo...lixo...lixo';
 SET @val = @val + 1;
 END
 PRINT 'Inserted ' + str(@nelem) + ' total records'
 -- Duration of Insertion Process
 SET @end_time = GETDATE();
PRINT 'Milliseconds used: ' + CONVERT(VARCHAR(20), DATEDIFF(MILLISECOND,
@start_time, @end_time));


ALTER TABLE mytemp ADD CONSTRAINT PK_RID PRIMARY KEY CLUSTERED (rid) WITH (FILLFACTOR = 90);



--c) 
CREATE UNIQUE CLUSTERED INDEX  ridIndexC1 ON mytemp(rid) WITH (FILLFACTOR = 65, PAD_INDEX = ON)

-- Inserted      50000 total records
-- Milliseconds used: 105520

CREATE UNIQUE CLUSTERED INDEX  ridIndexC2 ON mytemp(rid) WITH (FILLFACTOR = 80, PAD_INDEX = ON)

--Inserted      50000 total records
-- Milliseconds used: 136600

CREATE UNIQUE CLUSTERED INDEX  ridIndexC3 ON mytemp(rid) WITH (FILLFACTOR = 90, PAD_INDEX = ON)
-- Inserted      50000 total records
-- Milliseconds used: 133960

 -- d)
 -- nao permite fazer isto: ALTER TABLE mytemp ALTER COLUMN rid IDENTITY (1, 1);

CREATE TABLE mytemp (
		rid BIGINT IDENTITY(1,1) NOT NULL,
		at1 INT NULL,
		at2 INT NULL,
		at3 INT NULL,
		lixo varchar(100) NULL
);

/*
Inserções começaram a dar o erro
Cannot insert explicit value for identity column in table 'mytemp' when IDENTITY_INSERT is set to OFF.
*/

-- e) criar apenas no final pra teste
CREATE NONCLUSTERED INDEX at1Index ON mytemp(at1);
CREATE NONCLUSTERED INDEX at2Index ON mytemp(at2);
CREATE NONCLUSTERED INDEX at3Index ON mytemp(at3);
CREATE NONCLUSTERED INDEX lixoIndex ON mytemp(lixo);

-- Tempos sem
--Inserted      50000 total records
--Milliseconds used: 178032

-- Tempos com
--Inserted      50000 total records
--Milliseconds used: 142220



