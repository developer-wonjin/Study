DROP TABLE �ֹ� PURGE;

CREATE TABLE �ֹ� (
    �ֹ���ȣ NUMBER
  , ����ȣ NUMBER
  , �ֹ����� VARCHAR2(8)
  , �ֹ��ݾ� NUMBER
);

INSERT INTO �ֹ� VALUES (501, 1, '20190501', 20000);
INSERT INTO �ֹ� VALUES (612, 1, '20190523',  5000);
INSERT INTO �ֹ� VALUES (728, 1, '20200311', 25000);
INSERT INTO �ֹ� VALUES (904, 1, '20200715', 10000);
INSERT INTO �ֹ� VALUES (404, 2, '20191208',  7000);
INSERT INTO �ֹ� VALUES (603, 2, '20200428',  6000);
INSERT INTO �ֹ� VALUES (807, 2, '20200527', 17000);

COMMIT;

SELECT MIN (�ֹ��հ�ݾ�) AS �����ֹ��հ�ݾ�
  FROM (SELECT A.����ȣ, A.�ֹ�����, SUM(B.�ֹ��ݾ�) AS �ֹ��հ�ݾ�
          FROM �ֹ� A, �ֹ� B
         WHERE B.����ȣ = A.����ȣ
           AND B.�ֹ����� <= A.�ֹ�����
         GROUP BY A.����ȣ, A.�ֹ�����);
