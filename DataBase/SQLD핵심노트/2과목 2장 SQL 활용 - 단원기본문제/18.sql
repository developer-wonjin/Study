SELECT *
  FROM (SELECT A.*, ROWNUM AS RN
          FROM (SELECT EMPNO, ENAME, SAL
                  FROM EMP
                 ORDER BY SAL DESC) A
         WHERE ROWNUM <= 10)
 WHERE RN >= 6;
