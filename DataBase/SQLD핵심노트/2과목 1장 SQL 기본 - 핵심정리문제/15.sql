DROP TABLE �� PURGE;
DROP TABLE �ֹ� PURGE;

CREATE TABLE �� (����ȣ NUMBER, ����   VARCHAR2(100));
CREATE TABLE �ֹ� (�ֹ���ȣ NUMBER, ����ȣ NUMBER, �ֹ��ݾ� NUMBER);

INSERT INTO �� (����ȣ, ����) VALUES (1, '����');
INSERT INTO �� (����ȣ, ����) VALUES (2, '�뿵��');
INSERT INTO �� (����ȣ, ����) VALUES (3, '�����');
INSERT INTO �� (����ȣ, ����) VALUES (4, '���Ͽ�');

INSERT INTO �ֹ� (�ֹ���ȣ, ����ȣ, �ֹ��ݾ�) VALUES (2001, 1, 40000);
INSERT INTO �ֹ� (�ֹ���ȣ, ����ȣ, �ֹ��ݾ�) VALUES (2002, 2, 15000);
INSERT INTO �ֹ� (�ֹ���ȣ, ����ȣ, �ֹ��ݾ�) VALUES (2003, 2, 7000);
INSERT INTO �ֹ� (�ֹ���ȣ, ����ȣ, �ֹ��ݾ�) VALUES (2004, 2, 8000);
INSERT INTO �ֹ� (�ֹ���ȣ, ����ȣ, �ֹ��ݾ�) VALUES (2005, 2, 20000);
INSERT INTO �ֹ� (�ֹ���ȣ, ����ȣ, �ֹ��ݾ�) VALUES (2006, 3, 5000);
INSERT INTO �ֹ� (�ֹ���ȣ, ����ȣ, �ֹ��ݾ�) VALUES (2007, 3, 9000);

COMMIT;

SELECT A.����ȣ
     , (SELECT SUM (X.�ֹ��ݾ�)
          FROM �ֹ� X
         WHERE X.����ȣ = A.����ȣ) AS �ֹ��հ�ݾ�
  FROM �� A
 WHERE A.����ȣ IN (3, 4);

SELECT A.����ȣ
     , SUM (B.�ֹ��ݾ�) AS �ֹ��հ�ݾ�
  FROM �� A
       LEFT OUTER JOIN
       �ֹ� B
    ON B.����ȣ = A.����ȣ
 WHERE A.����ȣ IN (3, 4)
 GROUP BY A.����ȣ;
