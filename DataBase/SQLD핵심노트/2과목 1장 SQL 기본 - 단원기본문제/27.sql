DROP TABLE �� PURGE;
DROP TABLE �ֹ� PURGE;

CREATE TABLE �� (����ȣ NUMBER, ���� VARCHAR2(100));
CREATE TABLE �ֹ� (�ֹ���ȣ NUMBER, ����ȣ NUMBER, �ֹ��ݾ� NUMBER);

INSERT INTO �� (����ȣ, ����) VALUES (1, '����');
INSERT INTO �� (����ȣ, ����) VALUES (2, '�뿵��');
INSERT INTO �� (����ȣ, ����) VALUES (3, '�����');
INSERT INTO �� (����ȣ, ����) VALUES (4, '���Ͽ�');

INSERT INTO �ֹ� (�ֹ���ȣ, ����ȣ, �ֹ��ݾ�) VALUES (2001, 1, 40000);
INSERT INTO �ֹ� (�ֹ���ȣ, ����ȣ, �ֹ��ݾ�) VALUES (2002, 2, 15000);
INSERT INTO �ֹ� (�ֹ���ȣ, ����ȣ, �ֹ��ݾ�) VALUES (2003, 2,  7000);
INSERT INTO �ֹ� (�ֹ���ȣ, ����ȣ, �ֹ��ݾ�) VALUES (2004, 2,  8000);
INSERT INTO �ֹ� (�ֹ���ȣ, ����ȣ, �ֹ��ݾ�) VALUES (2005, 2, 20000);
INSERT INTO �ֹ� (�ֹ���ȣ, ����ȣ, �ֹ��ݾ�) VALUES (2006, 3,  5000);
INSERT INTO �ֹ� (�ֹ���ȣ, ����ȣ, �ֹ��ݾ�) VALUES (2007, 3,  9000);

COMMIT;

SELECT SUM (B.�ֹ��ݾ�) / COUNT (DISTINCT A.����ȣ) AS R1
  FROM �� A, �ֹ� B
 WHERE B.����ȣ(+) = A.����ȣ
   AND B.�ֹ��ݾ�(+) > 10000;
