DROP TABLE ���� PURGE;
DROP TABLE ������ PURGE;

CREATE TABLE ���� (
    ����ID VARCHAR2(4) PRIMARY KEY
  , ������ VARCHAR2(100)
);

CREATE TABLE ������ (
    ����ȣ     NUMBER PRIMARY KEY
  , �������ڵ� VARCHAR2(2)
  , �������ID   VARCHAR2(4)
);

INSERT INTO ���� (����ID, ������) VALUES ('0tjq', '���� ����');
INSERT INTO ���� (����ID, ������) VALUES ('wzqf', '������ ����');
INSERT INTO ���� (����ID, ������) VALUES ('m1gk', '���� ����');
INSERT INTO ���� (����ID, ������) VALUES ('hyao', '������ ����');

INSERT INTO ������ (����ȣ, �������ڵ�, �������ID) VALUES (1, 'A1', '0tjq');
INSERT INTO ������ (����ȣ, �������ڵ�, �������ID) VALUES (2, 'A1', 'wzqf');
INSERT INTO ������ (����ȣ, �������ڵ�, �������ID) VALUES (3, 'A1', 'wzqf');
INSERT INTO ������ (����ȣ, �������ڵ�, �������ID) VALUES (4, 'B1', 'm1gk');
INSERT INTO ������ (����ȣ, �������ڵ�, �������ID) VALUES (5, 'B1', NULL);
INSERT INTO ������ (����ȣ, �������ڵ�, �������ID) VALUES (6, 'A1', NULL);

COMMIT;

SELECT A.����ȣ, A.�������ڵ�, B.������
  FROM ������ A, ���� B
 WHERE B.����ID = DECODE(A.�������ڵ�, 'B1', '0tjq', A.�������ID)
 ORDER BY A.����ȣ;
