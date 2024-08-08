SELECT A.DEPTNO, A.DNAME
     , NVL ((SELECT 'Y'
               FROM EMP X
              WHERE X.DEPTNO = A.DEPTNO
                AND ROWNUM = 1), 'N') AS YN
  FROM DEPT A;

SELECT A.DEPTNO, A.DNAME
     , CASE
           WHEN EXISTS (
             SELECT 1
               FROM EMP X
              WHERE X.DEPTNO = A.DEPTNO)
           THEN 'Y'
           ELSE 'N'
       END AS YN
  FROM DEPT A;

SELECT A.DEPTNO, A.DNAME
     , CASE
           WHEN (SELECT COUNT (*)
                    FROM EMP X
                   WHERE X.DEPTNO = A.DEPTNO) >= 1
           THEN 'Y'
           ELSE 'N'
       END AS YN
  FROM DEPT A;
