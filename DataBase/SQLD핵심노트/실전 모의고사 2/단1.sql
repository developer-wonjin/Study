DROP TABLE 고객예치금 PURGE;

CREATE TABLE 고객예치금(고객번호 NUMBER, 예치금액 NUMBER);

INSERT INTO 고객예치금(고객번호, 예치금액) VALUES (1, 15000);
INSERT INTO 고객예치금(고객번호, 예치금액) VALUES (2, 40000);
INSERT INTO 고객예치금(고객번호, 예치금액) VALUES (3, 23850);

COMMIT;

SELECT 고객번호
     , TRUNC (예치금액 / 2000) AS 최대주문가능개수
     , MOD (예치금액, 2000)    AS 예치금잔액
  FROM 고객예치금;
