DROP TABLE T1 PURGE;

CREATE TABLE T1 (C1 DATE);

INSERT INTO T1 (C1) VALUES (TO_DATE ('2020-06-30', 'YYYY-MM-DD'));

COMMIT;

SELECT TO_CHAR (C1, 'YYYY-MM') AS R1 FROM T1;

SELECT EXTRACT (YEAR FROM C1) || '-' || TO_CHAR (C1, 'MM') AS R1 FROM T1;

SELECT TO_CHAR (C1, 'YYYY') || '-' || TO_CHAR (C1, 'MM') AS R1 FROM T1;

SELECT SUBSTR (TO_CHAR (C1, 'YYYY-MM-DD'), 1, 7) AS R1 FROM T1;

SELECT EXTRACT (YEAR FROM C1) || '-' || EXTRACT (MONTH FROM C1) AS R1 FROM T1;
