DROP TABLE ���� PURGE;

CREATE TABLE ���� (���¹�ȣ NUMBER, �ܾ� NUMBER);

INSERT INTO ���� VALUES (100, 10000);
INSERT INTO ���� VALUES (200,     0);

COMMIT;

UPDATE ���� SET �ܾ� = �ܾ� - 10000 WHERE ���¹�ȣ = 100;
COMMIT;
UPDATE ���� SET �ܾ� = �ܾ� + 10000 WHERE ���¹�ȣ = 200;
-- ���� ���� ����

SELECT * FROM ����;
