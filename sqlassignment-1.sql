-- q2.a
SELECT W.employee_name
From employee E, manages M,works W
WHERE E.employee_name = M.employee_name AND W.company_name = 'First Bank Corporation' ;

-- q2.b
SELECT employee_name, city FROM employee WHERE employee_name IN
(SELECT employee_name FROM works WHERE company_name = 'First Bank Corporation'); 

-- q2.c

select employee_name,city,street FROM employee WHERE employee_name IN 
(SELECT employee_name FROM works Where company_name ="First Bank Corporation" and salary>= 10000);

-- q2.d

SELECT E.employee_name 
From employee E, works W, company C
where E.employee_name = W.employee_name AND C.city = E.city And C.company_name = W.company_name;

-- q2.e

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

-- q2.f
SELECT W.employee_name 
from works W 
where W.company_name != "First Bank Corporation" ; 

-- q2.g(Copied because could not understand how to find out max salary from small corporation and compare it with other company employee salary)
SELECT @maxsal := Max(salary) 
FROM works Where company_name = 'Small Bank Corporation';
SELECT employee_name from works where salary > @maxsal;

--q2.h(output comes as both small bank corporation and first bank corporation)
Select company_name
from company
where city in
(SELECT city from company 
where company_name = "Small Bank Corporation");

-- q2.i
select @avgsal := AVG(salary) 
from works;
Select employee_name, company_name 
From  works W
where w.salary>@avgsal;

--q2.k
SELECT company_name
FROM works
WHERE salary = (SELECT MIN(salary) FROM works);

--q2.l
select @avgsal := AVG(salary) 
from works;
Select employee_name, company_name 
From  works W
where w.salary>@avgsal and w.company_name = "First Bank Corporation";

-- q3.a

Update employee
set city = 'NEWTON'
 WHERE employee_name = 'JOHN'

--q3.b
UPDATE works W,employee E, manages M
SET W.salary = 1.1 * W.salary
WHERE W.company_name = 'First Bank Corporation' AND E.employee_name =  M.employee_name;

--q3.c

UPDATE works W,employee E, manages M
SET W.salary = 1.1 * W.salary
WHERE W.company_name ='First Bank Corporation' AND E.employee_name =  M.manager_name;

--q3.d

UPDATE works, manages
SET salary = 
    CASE 
        WHEN salary * 1.1 <= 100000 THEN salary * 1.1 
        ELSE salary * 1.03 
    END
WHERE works.employee_name = manages.employee_name
AND works.company_name = 'First Bank Corporation';

--q3.e did not understand.


