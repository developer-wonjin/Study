SELECT   C1, COUNT (*) AS C2
    FROM (SELECT NTILE (2) OVER (ORDER BY SAL) AS C1
            FROM EMP
           WHERE DEPTNO = 20)
GROUP BY C1;
