SELECT REGEXP_SUBSTR ('ABBBC', 'AB{3}'  ) AS C1 FROM DUAL;
SELECT REGEXP_SUBSTR ('ABBBC', 'AB{1,}' ) AS C1 FROM DUAL;
SELECT REGEXP_SUBSTR ('ABBBC', 'AB{,1}' ) AS C1 FROM DUAL;
SELECT REGEXP_SUBSTR ('ABBBC', 'AB{1,3}') AS C1 FROM DUAL;
