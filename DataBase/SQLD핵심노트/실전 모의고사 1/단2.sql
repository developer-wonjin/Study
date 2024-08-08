DROP TABLE 쿠폰 PURGE;

CREATE TABLE 쿠폰 (쿠폰번호 NUMBER PRIMARY KEY, 할인내용 VARCHAR2(50));

INSERT INTO 쿠폰 (쿠폰번호, 할인내용) VALUES (1000, '10% 할인');
INSERT INTO 쿠폰 (쿠폰번호, 할인내용) VALUES (2000, '10만원 DISCOUNT');
INSERT INTO 쿠폰 (쿠폰번호, 할인내용) VALUES (3000, '15% DISCOUNT');
INSERT INTO 쿠폰 (쿠폰번호, 할인내용) VALUES (4000, '12만원 가격 할인');
INSERT INTO 쿠폰 (쿠폰번호, 할인내용) VALUES (5000, '5% 할인');

COMMIT;

SELECT 쿠폰번호, 할인내용
  FROM 쿠폰
 WHERE 할인내용 LIKE '1_\%%' ESCAPE '\';
