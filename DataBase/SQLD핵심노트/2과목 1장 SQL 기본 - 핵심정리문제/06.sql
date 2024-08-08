DROP TABLE 고객예치금 PURGE;

CREATE TABLE 고객예치금(
    고객번호   NUMBER PRIMARY KEY
  , 예치금액   NUMBER
  , 적립포인트 NUMBER
);

INSERT INTO 고객예치금 (고객번호, 예치금액, 적립포인트) VALUES (1, 15000,  5000);
INSERT INTO 고객예치금 (고객번호, 예치금액, 적립포인트) VALUES (2,  NULL, 25000);
INSERT INTO 고객예치금 (고객번호, 예치금액, 적립포인트) VALUES (3, 30000,  NULL);
INSERT INTO 고객예치금 (고객번호, 예치금액, 적립포인트) VALUES (4, 20000,     0);

COMMIT;

SELECT COUNT (*) AS R1
  FROM 고객예치금
 WHERE 예치금액 + NVL (적립포인트, 0) >= 20000;
