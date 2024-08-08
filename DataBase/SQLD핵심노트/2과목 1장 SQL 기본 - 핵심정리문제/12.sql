DROP TABLE 조직 PURGE;
DROP TABLE 영업고객 PURGE;

CREATE TABLE 조직 (
    조직ID VARCHAR2(4) PRIMARY KEY
  , 조직명 VARCHAR2(100)
);

CREATE TABLE 영업고객 (
    고객번호     NUMBER PRIMARY KEY
  , 고객구분코드 VARCHAR2(2)
  , 담당조직ID   VARCHAR2(4)
);

INSERT INTO 조직 (조직ID, 조직명) VALUES ('0tjq', '강남 본점');
INSERT INTO 조직 (조직ID, 조직명) VALUES ('wzqf', '영등포 지점');
INSERT INTO 조직 (조직ID, 조직명) VALUES ('m1gk', '신촌 지점');
INSERT INTO 조직 (조직ID, 조직명) VALUES ('hyao', '을지로 지점');

INSERT INTO 영업고객 (고객번호, 고객구분코드, 담당조직ID) VALUES (1, 'A1', '0tjq');
INSERT INTO 영업고객 (고객번호, 고객구분코드, 담당조직ID) VALUES (2, 'A1', 'wzqf');
INSERT INTO 영업고객 (고객번호, 고객구분코드, 담당조직ID) VALUES (3, 'A1', 'wzqf');
INSERT INTO 영업고객 (고객번호, 고객구분코드, 담당조직ID) VALUES (4, 'B1', 'm1gk');
INSERT INTO 영업고객 (고객번호, 고객구분코드, 담당조직ID) VALUES (5, 'B1', NULL);
INSERT INTO 영업고객 (고객번호, 고객구분코드, 담당조직ID) VALUES (6, 'A1', NULL);

COMMIT;

SELECT A.고객번호, A.고객구분코드, B.조직명
  FROM 영업고객 A, 조직 B
 WHERE B.조직ID = DECODE(A.고객구분코드, 'B1', '0tjq', A.담당조직ID)
 ORDER BY A.고객번호;
