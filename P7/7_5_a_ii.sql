CREATE VIEW Publishers_Employee AS
SELECT fname, minit, lname, pub_name
FROM publishers JOIN employee ON publishers.pub_id=employee.pub_id