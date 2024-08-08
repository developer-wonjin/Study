DROP TABLE ฐ่มย PURGE;

CREATE TABLE ฐ่มย (ฐ่มยน๘ศฃ NUMBER, ภÜพื NUMBER);

INSERT INTO ฐ่มย VALUES (100, 10000);
INSERT INTO ฐ่มย VALUES (200,     0);

COMMIT;

UPDATE ฐ่มย SET ภÜพื = ภÜพื - 10000 WHERE ฐ่มยน๘ศฃ = 100;
COMMIT;
UPDATE ฐ่มย SET ภÜพื = ภÜพื + 10000 WHERE ฐ่มยน๘ศฃ = 200;
-- ผผผว ฐญมฆ มพทแ

SELECT * FROM ฐ่มย;
