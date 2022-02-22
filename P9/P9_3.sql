-- i
CREATE UNIQUE CLUSTERED INDEX idxSnn ON dbo.Company.Employee(ssn);

-- ii
CREATE NONCLUSTERED INDEX idxNames ON Employee(Fname,Lname);

-- iii
CREATE NONCLUSTERED INDEX idxEmpDep ON Employee(Dno);
CREATE CLUSTERED INDEX idxDep ON Department(Dnumber);

-- iv
CREATE CLUSTERED INDEX idxSsn ON Employee(ssn);
CREATE CLUSTERED INDEX idxWorksOn ON Works_on(Essn,Pno);
CREATE NONCLUSTERED INDEX idxProj ON Project(Pnumber);

-- v
CREATE UNIQUE CLUSTERED INDEX IdxDep ON Dependent(Essn,Dependent_name);

-- vi
CREATE NONCLUSTERED INDEX idxProj ON Project(Dnum);
CREATE UNIQUE CLUSTERED INDEX idcDep ON Department(Dnumber);
