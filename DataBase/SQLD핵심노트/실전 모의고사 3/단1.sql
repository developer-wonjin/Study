DROP TABLE �ֹ�;

CREATE TABLE �ֹ� (�ֹ���ȣ NUMBER PRIMARY KEY, �ֹ��Ͻ� DATE, �ֹ��ݾ� NUMBER);

INSERT INTO �ֹ� (�ֹ���ȣ, �ֹ��Ͻ�, �ֹ��ݾ�) VALUES (1, TO_DATE ('2019-12-01', 'YYYY-MM-DD'), 20000);
INSERT INTO �ֹ� (�ֹ���ȣ, �ֹ��Ͻ�, �ֹ��ݾ�) VALUES (2, TO_DATE ('2019-12-30', 'YYYY-MM-DD'), 30000);
INSERT INTO �ֹ� (�ֹ���ȣ, �ֹ��Ͻ�, �ֹ��ݾ�) VALUES (3, TO_DATE ('2020-01-02', 'YYYY-MM-DD'), 15000);
INSERT INTO �ֹ� (�ֹ���ȣ, �ֹ��Ͻ�, �ֹ��ݾ�) VALUES (4, TO_DATE ('2020-01-15', 'YYYY-MM-DD'), 60000);

COMMIT;

SELECT �ֹ����, SUM (�ֹ��ݾ�) AS �ֹ��հ�ݾ�
  FROM (SELECT TO_CHAR (�ֹ��Ͻ�, 'YYYY-MM') AS �ֹ����, �ֹ��ݾ�
          FROM �ֹ�)
 GROUP BY �ֹ����;
