DROP TABLE ���� PURGE;

CREATE TABLE ���� (������ȣ NUMBER PRIMARY KEY, ���γ��� VARCHAR2(50));

INSERT INTO ���� (������ȣ, ���γ���) VALUES (1000, '10% ����');
INSERT INTO ���� (������ȣ, ���γ���) VALUES (2000, '10���� DISCOUNT');
INSERT INTO ���� (������ȣ, ���γ���) VALUES (3000, '15% DISCOUNT');
INSERT INTO ���� (������ȣ, ���γ���) VALUES (4000, '12���� ���� ����');
INSERT INTO ���� (������ȣ, ���γ���) VALUES (5000, '5% ����');

COMMIT;

SELECT ������ȣ, ���γ���
  FROM ����
 WHERE ���γ��� LIKE '1_\%%' ESCAPE '\';
