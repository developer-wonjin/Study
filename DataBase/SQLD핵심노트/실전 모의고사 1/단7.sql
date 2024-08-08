SELECT *
  FROM (SELECT TO_CHAR (HIREDATE, 'YYYY') AS YYYY, DEPTNO, JOB, SAL
          FROM EMP
         WHERE DEPTNO IN (10, 30))
 PIVOT (SUM (SAL) AS SAL
        FOR (DEPTNO, JOB) IN ((10, 'CLERK'   ) AS D10C
                            , (10, 'SALESMAN') AS D10S
                            , (30, 'CLERK'   ) AS D30C
                            , (30, 'SALESMAN') AS D30S))
 ORDER BY YYYY;
