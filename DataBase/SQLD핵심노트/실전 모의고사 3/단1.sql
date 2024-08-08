DROP TABLE 주문;

CREATE TABLE 주문 (주문번호 NUMBER PRIMARY KEY, 주문일시 DATE, 주문금액 NUMBER);

INSERT INTO 주문 (주문번호, 주문일시, 주문금액) VALUES (1, TO_DATE ('2019-12-01', 'YYYY-MM-DD'), 20000);
INSERT INTO 주문 (주문번호, 주문일시, 주문금액) VALUES (2, TO_DATE ('2019-12-30', 'YYYY-MM-DD'), 30000);
INSERT INTO 주문 (주문번호, 주문일시, 주문금액) VALUES (3, TO_DATE ('2020-01-02', 'YYYY-MM-DD'), 15000);
INSERT INTO 주문 (주문번호, 주문일시, 주문금액) VALUES (4, TO_DATE ('2020-01-15', 'YYYY-MM-DD'), 60000);

COMMIT;

SELECT 주문년월, SUM (주문금액) AS 주문합계금액
  FROM (SELECT TO_CHAR (주문일시, 'YYYY-MM') AS 주문년월, 주문금액
          FROM 주문)
 GROUP BY 주문년월;
