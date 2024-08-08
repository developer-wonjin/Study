SELECT REGEXP_INSTR ('010-1234-5678', '(\d+)-(\d+)-(\d+)', 1, 1, 0, 'i', 2) AS C1
  FROM DUAL;
