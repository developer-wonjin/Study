DROP TABLE ����ġ�� PURGE;

CREATE TABLE ����ġ��(
    ����ȣ   NUMBER PRIMARY KEY
  , ��ġ�ݾ�   NUMBER
  , ��������Ʈ NUMBER
);

INSERT INTO ����ġ�� (����ȣ, ��ġ�ݾ�, ��������Ʈ) VALUES (1, 15000,  5000);
INSERT INTO ����ġ�� (����ȣ, ��ġ�ݾ�, ��������Ʈ) VALUES (2,  NULL, 25000);
INSERT INTO ����ġ�� (����ȣ, ��ġ�ݾ�, ��������Ʈ) VALUES (3, 30000,  NULL);
INSERT INTO ����ġ�� (����ȣ, ��ġ�ݾ�, ��������Ʈ) VALUES (4, 20000,     0);

COMMIT;

SELECT COUNT (*) AS R1
  FROM ����ġ��
 WHERE ��ġ�ݾ� + NVL (��������Ʈ, 0) >= 20000;
