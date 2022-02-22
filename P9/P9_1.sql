DBCC FREEPROCCACHE;
DBCC DROPCLEANBUFFERS;
go
select * from Production.WorkOrder
go

DBCC FREEPROCCACHE;
DBCC DROPCLEANBUFFERS;
go
select * from Production.WorkOrder where WorkOrderID=1234
go

DBCC FREEPROCCACHE;
DBCC DROPCLEANBUFFERS;
go
SELECT * FROM Production.WorkOrder
WHERE WorkOrderID between 10000 and 10010

SELECT * FROM Production.WorkOrder
WHERE WorkOrderID between 1 and 72591

go

-- 9.1.6


DBCC FREEPROCCACHE;
DBCC DROPCLEANBUFFERS;
SELECT WorkOrderID, StartDate FROM Production.WorkOrder
 WHERE ProductID = 757
Query2: SELECT WorkOrderID, StartDate FROM Production.WorkOrder
 WHERE ProductID = 945
Query3: SELECT WorkOrderID FROM Production.WorkOrder
 WHERE ProductID = 945 AND StartDate = '2006-01-04'


 -- 8
DBCC FREEPROCCACHE;
DBCC DROPCLEANBUFFERS;
 SELECT WorkOrderID, StartDate FROM Production.WorkOrder
WHERE ProductID = 945 AND StartDate = '2006-01-04'