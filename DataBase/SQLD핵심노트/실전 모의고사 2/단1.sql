DROP TABLE ����ġ�� PURGE;

CREATE TABLE ����ġ��(����ȣ NUMBER, ��ġ�ݾ� NUMBER);

INSERT INTO ����ġ��(����ȣ, ��ġ�ݾ�) VALUES (1, 15000);
INSERT INTO ����ġ��(����ȣ, ��ġ�ݾ�) VALUES (2, 40000);
INSERT INTO ����ġ��(����ȣ, ��ġ�ݾ�) VALUES (3, 23850);

COMMIT;

SELECT ����ȣ
     , TRUNC (��ġ�ݾ� / 2000) AS �ִ��ֹ����ɰ���
     , MOD (��ġ�ݾ�, 2000)    AS ��ġ���ܾ�
  FROM ����ġ��;
