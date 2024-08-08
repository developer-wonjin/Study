DROP TABLE 주문 PURGE;

CREATE TABLE 주문 (
    주문번호 NUMBER
  , 고객번호 NUMBER
  , 주문일자 VARCHAR2(8)
  , 주문금액 NUMBER
);

INSERT INTO 주문 VALUES (501, 1, '20190501', 20000);
INSERT INTO 주문 VALUES (612, 1, '20190523',  5000);
INSERT INTO 주문 VALUES (728, 1, '20200311', 25000);
INSERT INTO 주문 VALUES (904, 1, '20200715', 10000);
INSERT INTO 주문 VALUES (404, 2, '20191208',  7000);
INSERT INTO 주문 VALUES (603, 2, '20200428',  6000);
INSERT INTO 주문 VALUES (807, 2, '20200527', 17000);

COMMIT;

SELECT MIN (주문합계금액) AS 최저주문합계금액
  FROM (SELECT A.고객번호, A.주문일자, SUM(B.주문금액) AS 주문합계금액
          FROM 주문 A, 주문 B
         WHERE B.고객번호 = A.고객번호
           AND B.주문일자 <= A.주문일자
         GROUP BY A.고객번호, A.주문일자);
