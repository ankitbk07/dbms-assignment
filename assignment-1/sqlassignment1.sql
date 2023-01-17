-- q2.a
---using subquery
SELECT W.employee_name
From employee E, manages M,works W
WHERE E.employee_name = M.employee_name AND W.company_name = 'First Bank Corporation' ;

--using join
select * from tbl_employee natural join tbl_works where company_name = 'First Bank Corporation';

-- q2.b
---using subquery
SELECT employee_name, city FROM employee WHERE employee_name IN
(SELECT employee_name FROM works WHERE company_name = 'First Bank Corporation'); 

--using join
select employee_name , city from tbl_employee natural join tbl_works where company_name = 'First Bank Corporation';


-- q2.c
---using subquery
select employee_name,city,street FROM employee WHERE employee_name IN 
(SELECT employee_name FROM works Where company_name ="First Bank Corporation" and salary>= 10000);

--using join
select * from tbl_employee natural join tbl_works where company_name = 'First Bank Corporation'AND salary > 10000;


-- q2.d
---using subquery
SELECT E.employee_name 
From employee E, works W, company C
where E.employee_name = W.employee_name AND C.city = E.city And C.company_name = W.company_name;

--using join
select employee_name from tbl_works natural join tbl_company NATURAL join tbl_employee where tbl_employee.city= tbl_company.city;


-- q2.e
---using subquery
SELECT employee_name
FROM employee e
WHERE EXISTS (
	SELECT 1
    FROM manages
    WHERE manages.employee_name = e.employee_name
		AND EXISTS (
			SELECT 1
            FROM employee e2
            WHERE e2.employee_name = manages.manager_name
				AND e.city = e2.city
                AND e.street = e2.street
        )
);

--using join
SELECT m.employee_name 
FROM employee e1,employee e2 
  INNER JOIN manages m ON (
    (
      m.employee_name = e2.employee_name
    )
  ) 
WHERE 
  (
    e1.employee_name <> e2.employee_name
  ) 
  AND (e1.city = e2.city) 
  AND (e1.street = e2.street);

-- q2.f
---using subquery
SELECT W.employee_name 
from works W 
where W.company_name != "First Bank Corporation" ; 

--using join


-- q2.g
---using subquery
SELECT @maxsal := Max(salary) 
FROM works Where company_name = 'Small Bank Corporation';
SELECT employee_name from works where salary > @maxsal;

--q2.h(output comes as both small bank corporation and first bank corporation)
---using subquery
Select company_name
from company
where city in
(SELECT city from company 
where company_name = "Small Bank Corporation");

-- q2.i
---using subquery
select @avgsal := AVG(salary) 
from works;
Select employee_name, company_name 
From  works W
where w.salary>@avgsal;

--q2.k
---using subquery
SELECT company_name
FROM works
WHERE salary = (SELECT MIN(salary) FROM works);

--q2.l
---using subquery
select @avgsal := AVG(salary) 
from works;
Select employee_name, company_name 
From  works W
where w.salary>@avgsal and w.company_name = "First Bank Corporation";

-- q3.a
---using subquery
Update employee
set city = 'NEWTON'
 WHERE employee_name = 'JOHN'

--q3.b
---using subquery
UPDATE works W,employee E, manages M
SET W.salary = 1.1 * W.salary
WHERE W.company_name = 'First Bank Corporation' AND E.employee_name =  M.employee_name;

--q3.c
---using subquery
UPDATE works W,employee E, manages M
SET W.salary = 1.1 * W.salary
WHERE W.company_name ='First Bank Corporation' AND E.employee_name =  M.manager_name;

--q3.d
---using subquery
UPDATE works, manages
SET salary = 
    CASE 
        WHEN salary * 1.1 <= 100000 THEN salary * 1.1 
        ELSE salary * 1.03 
    END
WHERE works.employee_name = manages.employee_name
AND works.company_name = 'First Bank Corporation';

--q3.e 
--using join
delete E,M,W  
FROM 
  works W
  INNER JOIN employee E ON W.employee_name = E.employee_name 
  INNER JOIN manages M ON M.employee_name = W.employee_name 
WHERE 
  W.company_name = "small bank corporation";



