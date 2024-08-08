DROP TABLE 고객 PURGE;
DROP TABLE 주문 PURGE;

CREATE TABLE 고객 (고객번호 NUMBER, 고객명   VARCHAR2(100));
CREATE TABLE 주문 (주문번호 NUMBER, 고객번호 NUMBER, 주문금액 NUMBER);

INSERT INTO 고객 (고객번호, 고객명) VALUES (1, '김대원');
INSERT INTO 고객 (고객번호, 고객명) VALUES (2, '노영미');
INSERT INTO 고객 (고객번호, 고객명) VALUES (3, '김경진');
INSERT INTO 고객 (고객번호, 고객명) VALUES (4, '박하연');

INSERT INTO 주문 (주문번호, 고객번호, 주문금액) VALUES (2001, 1, 40000);
INSERT INTO 주문 (주문번호, 고객번호, 주문금액) VALUES (2002, 2, 15000);
INSERT INTO 주문 (주문번호, 고객번호, 주문금액) VALUES (2003, 2, 7000);
INSERT INTO 주문 (주문번호, 고객번호, 주문금액) VALUES (2004, 2, 8000);
INSERT INTO 주문 (주문번호, 고객번호, 주문금액) VALUES (2005, 2, 20000);
INSERT INTO 주문 (주문번호, 고객번호, 주문금액) VALUES (2006, 3, 5000);
INSERT INTO 주문 (주문번호, 고객번호, 주문금액) VALUES (2007, 3, 9000);

COMMIT;

SELECT A.고객번호
     , (SELECT SUM (X.주문금액)
          FROM 주문 X
         WHERE X.고객번호 = A.고객번호) AS 주문합계금액
  FROM 고객 A
 WHERE A.고객번호 IN (3, 4);

SELECT A.고객번호
     , SUM (B.주문금액) AS 주문합계금액
  FROM 고객 A
       LEFT OUTER JOIN
       주문 B
    ON B.고객번호 = A.고객번호
 WHERE A.고객번호 IN (3, 4)
 GROUP BY A.고객번호;
