SELECT DEPTNO, COUNT(*) AS R1
  FROM EMP
 GROUP BY DEPTNO;

SELECT MGR, MIN (SAL) AS R1
  FROM EMP
 GROUP BY MGR;

SELECT JOB, HIREDATE
  FROM EMP
 GROUP BY JOB;

SELECT DEPTNO, JOB
  FROM EMP
 GROUP BY DEPTNO, JOB;
