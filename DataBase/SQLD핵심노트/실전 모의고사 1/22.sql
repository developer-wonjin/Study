DROP TABLE ���� PURGE;
DROP TABLE ���� PURGE;

CREATE TABLE ���� (
    ������ȣ NUMBER PRIMARY KEY
  , ������   VARCHAR2(100)
);

CREATE TABLE ���� (
    ������ȣ     NUMBER PRIMARY KEY
  , ������ȣ     NUMBER
  , �����Ͻ�     DATE
  , ������ǰ�ڵ� VARCHAR2(4)
);

INSERT INTO ���� VALUES (1, '������');
INSERT INTO ���� VALUES (2, '�����');
INSERT INTO ���� VALUES (3, '�̼���');
INSERT INTO ���� VALUES (4, '�����');
INSERT INTO ���� VALUES (5, '�����');

INSERT INTO ���� VALUES (2001, 1, TO_DATE ('2020-06-01', 'YYYY-MM-DD'), 'A001');
INSERT INTO ���� VALUES (2002, 1, TO_DATE ('2020-06-11', 'YYYY-MM-DD'), 'A002');
INSERT INTO ���� VALUES (2003, 1, TO_DATE ('2020-06-15', 'YYYY-MM-DD'), 'B002');
INSERT INTO ���� VALUES (2004, 3, TO_DATE ('2020-04-08', 'YYYY-MM-DD'), 'A102');
INSERT INTO ���� VALUES (2005, 3, TO_DATE ('2020-06-12', 'YYYY-MM-DD'), 'A102');
INSERT INTO ���� VALUES (2006, 3, TO_DATE ('2020-06-28', 'YYYY-MM-DD'), 'C104');
INSERT INTO ���� VALUES (2007, 4, TO_DATE ('2020-07-13', 'YYYY-MM-DD'), 'B305');

COMMIT;

SELECT A.������ȣ, COUNT (DISTINCT B.������ǰ�ڵ�) AS ��ǰ������
  FROM ���� A INNER JOIN ���� B
    ON B.������ȣ = A.������ȣ
 GROUP BY A.������ȣ;
