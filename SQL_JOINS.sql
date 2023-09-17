SELECT * FROM `sql-joins`.employees; 
#INNER JOINT 
SELECT employees.name, departments.name -- wybierz kolumne name z tabeli eployess oraz kolumne name z tabeli departments
FROM employees JOIN departments -- FROM pierwsza tabela JOIN tabela którą chcemy dołączyć do tabeli pierwszej
ON employees.department_id = departments.id; -- warunek po czym chcemy te tabele połączyć (w tym przypadku departments.id)
# zostało wyświetlonych 5 pracowników ponieważ 2 z nich niemiało podanego departamentu
#a inner JOIN działa w tens sposób, że kryterium musi zostać spelnione zarówno w pierwszej
#jak i w drugiej tabeli.

#Wyświetlanie wszystkich pracowników i departamenty nawet jeżeli dany pracownik nie jest 
#przypiasny do żadnego departamentu (LEFT JOIN):
SELECT employees.name, departments.name 
FROM employees LEFT JOIN departments 
ON employees.department_id = departments.id;
#teraz Jacek i Mateusz zostali wyświetleni, natomiast ich name z tabeli department zawiera
#pustą wartość null

#odwrócenie tej sytuacji i wyśweitlenie wszystkich departamentów (nawet tych w których
#nikt nie pracuje) 
SELECT employees.name, departments.name 
FROM employees RIGHT JOIN departments 
ON employees.department_id = departments.id;
#Został wyśweitlony także Very Secret Department do którego nie jest przypisany żaden pracownik

#Wyświetlenie wszystkich pracowników i wszystkie działy (FULL JOIN) bez względu na to 
#czy zostanie znaleziony rekord w drugiej kolumnie
#baza MySQL nie wspiera czegoś takiego jak FULL JOIN dlatego trzeba połączyć LEFT JOIN
# i RIGHT JOIN za pomocą słowa kluczowego UNION ALL
SELECT employees.name, departments.name 
FROM employees LEFT JOIN departments 
ON employees.department_id = departments.id
UNION ALL
SELECT employees.name, departments.name 
FROM employees RIGHT JOIN departments 
ON employees.department_id = departments.id;
#w tej wersji wystąpią duplikaty 

#usuwając ALL z UNION ALL pozbywamy się duplikatów 
SELECT employees.name, departments.name 
FROM employees LEFT JOIN departments 
ON employees.department_id = departments.id
UNION 
SELECT employees.name, departments.name 
FROM employees RIGHT JOIN departments 
ON employees.department_id = departments.id;

#LEFT JOIN bez części wspólnej
SELECT employees.name, departments.name 
FROM employees LEFT JOIN departments 
ON employees.department_id = departments.id
WHERE departments.id IS NULL; -- to powoduje, że nie zostanie wyświetlona część współna
# wyświetliliśmy tylko tych pracowników którzy nie są przypisani do żadnego działu


#RIGHT JOIN bez części wspólnej analogicznie:
SELECT employees.name, departments.name 
FROM employees RIGHT JOIN departments 
ON employees.department_id = departments.id
WHERE employees.department_id IS NULL; 
#wyświetlone zostaną pomieszczenia do których nie jest przypisany, żaden pracownik

#FULL JOIN bez części wspólnej
SELECT employees.name, departments.name 
FROM employees LEFT JOIN departments 
ON employees.department_id = departments.id
WHERE employees.department_id IS NULL OR department_id IS NULL
UNION ALL
SELECT employees.name, departments.name 
FROM employees RIGHT JOIN departments 
ON employees.department_id = departments.id
WHERE employees.department_id IS NULL OR department_id IS NULL;
#w ten sposób wyświetliliśmy pracowników któzy nie posiadają żadnego deportamentu i 
#departamenty nie posiadające żadnego przypisanego pracownika.

#FULL JOIN bez części wspólnej (mój sposób)
SELECT employees.name, departments.name 
FROM employees LEFT JOIN departments 
ON employees.department_id = departments.id
WHERE employees.department_id IS NULL
UNION ALL
SELECT employees.name, departments.name 
FROM employees RIGHT JOIN departments 
ON employees.department_id = departments.id
WHERE department_id IS NULL;
#też działa