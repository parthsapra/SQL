--1
SELECT LocationId, StreetName, City, StateProvince,CountryName FROM Locations NATURAL JOIN Countries;

--2
SELECT FirstName, LastName, DepartmentId, DepartmentName FROM Employees JOIN Departments USING (DepartmentId);

--3
SELECT E.FirstName, E.LastName, E.JobId, E.DepartmentId, D.DepartmentName FROM Employees E JOIN Departments D ON (E.DepartmentId= D.DepartmentId) JOIN Locations L ON (D.LocationId= L.LocationId) WHERE LOWER(L.City) = 'London';

--4
SELECT E.EmployeeId 'Employee_Id', E.LastName 'Employee_Name', 
M.EmployeeId 'Manager_Id', M.LastName 'ManagerName' 
FROM Employees E
join Employees M
ON (E.ManagerId = M.EmployeeId);

--5
SELECT E.FirstName, E.LastName, E.HireDate 
FROM Employees E 
JOIN Employees Davies 
ON (Davies.LastName = 'Jones') 
WHERE Davies.HireDate < E.HireDate;

--6
SELECT DepartmentName AS 'Department Name', 
COUNT(*) AS 'No of Employees' 
FROM Departments 
INNER JOIN Employees 
ON Employees.DepartmentId = Departments.DepartmentId 
GROUP BY Departments.DepartmentId, DepartmentName 
ORDER BY DepartmentName;

--7
SELECT EmployeeId, JobTitle, EndDate-start_date Days FROM JobHistory 
NATURAL JOIN Jobs 
WHERE DepartmentId=90;

--8
SELECT D.DepartmentId, D.DepartmentName, D.ManagerId, E.FirstName 
FROM Departments D 
INNER JOIN Employees E 
ON (D.ManagerId = E.EmployeeId);

--9
SELECT D.DepartmentName, E.FirstName, L.City 
FROM Departments D 
JOIN Employees E
ON (D.ManagerId = E.EmployeeId) 
JOIN Locations L USING (LocationId);

--10
SELECT JobTitle, AVG(Salary) 
FROM Employees 
NATURAL JOIN Jobs 
GROUP BY JobTitle;

--11
SELECT JobTitle, FirstName, SalaryMinSalary 'Salary - Min_Salary' 
FROM Employees 
NATURAL JOIN Jobs;

--12
SELECT JH.* FROM JobHistory JH
JOIN Employees E
ON (JH.EmployeeId = E.EmployeeId) 
WHERE Salary > 10000;

--13
SELECT FirstName, LastName, HireDate, Salary, 
(DATEDIFF(now(), HireDate))/365 Experience 
FROM Departments D JOIN Employees E 
ON (D.ManagerId = E.EmployeeId) 
WHERE (DATEDIFF(now(), HireDate))/365>15;
