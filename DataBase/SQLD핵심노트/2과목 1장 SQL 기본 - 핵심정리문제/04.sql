DROP TABLE �ֹ� PURGE;

CREATE TABLE �ֹ� (�ֹ���ȣ NUMBER PRIMARY KEY, �ֹ��Ͻ� DATE, �ֹ��ݾ� NUMBER);

INSERT INTO �ֹ� (�ֹ���ȣ, �ֹ��Ͻ�, �ֹ��ݾ�) VALUES (1, TO_DATE ('2020-05-12 14:20:20', 'YYYY-MM-DD HH24:MI:SS'), 20000);
INSERT INTO �ֹ� (�ֹ���ȣ, �ֹ��Ͻ�, �ֹ��ݾ�) VALUES (2, TO_DATE ('2020-06-27 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 25000);
INSERT INTO �ֹ� (�ֹ���ȣ, �ֹ��Ͻ�, �ֹ��ݾ�) VALUES (3, TO_DATE ('2020-07-02 12:30:30', 'YYYY-MM-DD HH24:MI:SS'), 10000);
INSERT INTO �ֹ� (�ֹ���ȣ, �ֹ��Ͻ�, �ֹ��ݾ�) VALUES (4, TO_DATE ('2020-07-15 17:00:00', 'YYYY-MM-DD HH24:MI:SS'),  5000);
INSERT INTO �ֹ� (�ֹ���ȣ, �ֹ��Ͻ�, �ֹ��ݾ�) VALUES (5, TO_DATE ('2020-07-26 23:59:00', 'YYYY-MM-DD HH24:MI:SS'), 20000);
INSERT INTO �ֹ� (�ֹ���ȣ, �ֹ��Ͻ�, �ֹ��ݾ�) VALUES (6, TO_DATE ('2020-07-27 12:30:30', 'YYYY-MM-DD HH24:MI:SS'), 30000);
INSERT INTO �ֹ� (�ֹ���ȣ, �ֹ��Ͻ�, �ֹ��ݾ�) VALUES (7, TO_DATE ('2020-08-08 09:00:15', 'YYYY-MM-DD HH24:MI:SS'), 15000);

COMMIT;

SELECT SUM (�ֹ��ݾ�) AS �ֹ��ݾ�
  FROM �ֹ�
 WHERE �ֹ��Ͻ� BETWEEN TRUNC (ADD_MONTHS (SYSDATE, -1), 'DD')
                    AND TRUNC (SYSDATE, 'DD') - 1/24/60/60;

SELECT SUM (�ֹ��ݾ�) AS �ֹ��ݾ�
  FROM �ֹ�
 WHERE �ֹ��Ͻ� BETWEEN TRUNC (ADD_MONTHS (TO_DATE('2020-07-27 14:30:00', 'YYYY-MM-DD HH24:MI:SS'), -1), 'DD')
                    AND TRUNC (TO_DATE('2020-07-27 14:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'DD') - 1/24/60/60;
