-- 쿼리. 1

SELECT  
        ITM_NO
      , ITM_NM
      , ITM_CL_CD
      , CTG_NO
      , PTNR_NO
      , SHP_SPP_CYL_CD
      , INV_MNG_YN
      , SLE_YN
      , USE_YN
      , ITM_CAPA_QTY
      , CAPA_UNT_CD
FROM    CF01
WHERE   1 = 1
AND     SLE_YN = 'N'
ORDER BY
        ITM_NO
;

-- 쿼리. 2

SELECT  
        ITM_NO
      , ITM_NM
      , INV_MNG_YN
      , SLE_YN
      , USE_YN
      , ITM_CAPA_QTY
      , CAPA_UNT_CD
FROM    CF01
WHERE   1 = 1
AND     SLE_YN = 'Y'
AND     INV_MNG_YN = 'N'
AND     CTG_NO IN (110, 111)
ORDER BY
        ITM_NO
;

-- 쿼리. 3

SELECT  
        ITM_NO
      , ITM_NM
      , INV_MNG_YN
      , SLE_YN
      , USE_YN
      , ITM_CAPA_QTY
      , CAPA_UNT_CD
FROM    CF01
WHERE   1 = 1
AND     SLE_YN = 'Y'
AND     CTG_NO = 115
AND     INV_MNG_YN = 'Y'
ORDER BY
        ITM_NO
;

-- 쿼리. 4

SELECT
        SHP_NO
      , SHP_NM
      , SHP_TEL_NO
      , SHP_ADDR
FROM    CF07
ORDER BY
        SHP_NO
;

-- 쿼리. 5

SELECT  
        EMP_NO
      , EMP_NM
      , GRD_CD
      , DEPT_NO
      , MBL_NO
      , EML_ADDR
FROM    CF09
ORDER BY
        EMP_NO
;

-- 쿼리. 6

SELECT
        PTNR_NO
      , PTNR_NM
      , CEO_NM
      , STF_NM
      , STF_TEL_NO
      , STF_EML_ADDR
FROM    CF06
ORDER BY
        PTNR_NO
;

-- 쿼리. 7

SELECT  
        CTG_NO
      , CTG_NM
      , UP_CTG_NO
FROM    CF02
ORDER BY
        CTG_NO
;

-- 쿼리. 8

SELECT  
        DEPT_NO
      , DEPT_NM
      , UP_DEPT_NO
FROM    CF08
ORDER BY
        DEPT_NO
;

-- 쿼리. 9

SELECT  
        CLS_CD
      , CD
      , UNI_CD_NM
      , SCR_SEQ
      , CD_DESC
FROM    CF16
WHERE   CD = 'M'
ORDER BY
        CLS_CD
;

-- 쿼리. 10

SELECT  
        CLS_CD
      , CD
      , UNI_CD_NM
      , SCR_SEQ
      , CD_DESC
FROM    CF16
WHERE   CLS_CD = 'GRD_CD'
ORDER BY
        CD
;

-- 쿼리. 11

SELECT  
        CLS_CD
      , CD
      , UNI_CD_NM
      , SCR_SEQ
      , CD_DESC
FROM    CF16
ORDER BY
        CLS_CD
      , CD
;

-- 쿼리. 12

SELECT  
        A.ORD_NO
      , A.ORD_DT
      , A.PTNR_NO
      , A.ORD_EMP_NO
      , A.ORD_PRGS_CD
FROM    CF12    A
WHERE   1 = 1
AND     A.ORD_DT = '20230508'
ORDER BY
        A.ORD_NO
;

-- 쿼리. 13

SELECT  
        A.ORD_NO
      , A.ORD_DT
      , A.PTNR_NO
      , B.PTNR_NM
      , A.ORD_EMP_NO
      , C.EMP_NM
      , A.ORD_PRGS_CD
      , D.UNI_CD_NM
FROM    CF12    A
      , CF06    B
      , CF09    C
      , CF16    D
WHERE   1 = 1
AND     B.PTNR_NO = A.PTNR_NO
AND     C.EMP_NO = A.ORD_EMP_NO
AND     D.CLS_CD = 'ORD_PRGS_CD'
AND     D.CD = A.ORD_PRGS_CD
AND     A.ORD_DT = '20230508'
ORDER BY
        A.ORD_NO
;

-- 쿼리. 14

SELECT  
        A.ORD_NO
      , A.ORD_DT
      , A.PTNR_NO
      , A.ORD_EMP_NO
      , A.ORD_PRGS_CD
      , E.ITM_NO
      , E.ORD_QTY
      , E.ORD_UPRC
FROM    CF12    A
      , CF13    E
WHERE   1 = 1
AND     E.ORD_NO = A.ORD_NO
AND     A.ORD_DT = '20230508'
AND     A.PTNR_NO IN ('1000','1001')
ORDER BY
        A.ORD_NO
;

-- 쿼리. 15

SELECT  
        A.ORD_NO
      , A.ORD_DT
      , A.PTNR_NO
      , B.PTNR_NM
      , A.ORD_EMP_NO
      , C.EMP_NM
      , A.ORD_PRGS_CD
      , D.UNI_CD_NM
      , E.ITM_NO
      , F.ITM_NM
      , E.ORD_QTY
      , E.ORD_UPRC
      , E.ORD_QTY * E.ORD_UPRC  ORD_AMT
FROM    CF12    A
      , CF13    E
      , CF06    B
      , CF09    C
      , CF16    D
      , CF01    F
WHERE   1 = 1
AND     E.ORD_NO = A.ORD_NO
AND     B.PTNR_NO = A.PTNR_NO
AND     C.EMP_NO = A.ORD_EMP_NO
AND     D.CLS_CD = 'ORD_PRGS_CD'
AND     D.CD = A.ORD_PRGS_CD
AND     F.ITM_NO = E.ITM_NO
AND     A.ORD_DT = '20230508'
AND     A.PTNR_NO IN ('1000','1001')
ORDER BY
        A.ORD_NO
;

-- 쿼리. 16

SELECT  
        A.INOUT_NO
      , A.INOUT_DT
      , A.INOUT_TY_CD
      , A.CALC_PRGS_CD
      , A.ORD_NO
      , A.IN_SHP_NO
      , A.OUT_SHP_NO
FROM    CF14 A
WHERE   1 = 1
AND     A.ORD_NO BETWEEN '2023050801' AND '2023050807'
ORDER BY
        A.INOUT_NO
;

-- 쿼리. 17

SELECT  
        A.INOUT_NO
      , A.INOUT_DT
      , A.INOUT_TY_CD
      , C.UNI_CD_NM     INOUT_TY_NM
      , A.CALC_PRGS_CD
      , D.UNI_CD_NM     CALC_PRGS_NM
      , A.ORD_NO
      , B.ORD_DT
      , A.IN_SHP_NO
      , E.SHP_NM        IN_SHP_NM
FROM    CF14 A
      , CF12 B
      , CF16 C
      , CF16 D
      , CF07 E
WHERE   1 = 1
AND     B.ORD_NO = A.ORD_NO
AND     C.CLS_CD = 'INOUT_TY_CD'
AND     C.CD = A.INOUT_TY_CD
AND     D.CLS_CD = 'CALC_PRGS_CD'
AND     D.CD = A.CALC_PRGS_CD
AND     E.SHP_NO = A.IN_SHP_NO
AND     A.ORD_NO BETWEEN '2023050801' AND '2023050807'
ORDER BY
        A.INOUT_NO
;

-- 쿼리. 18

SELECT  
        A.INOUT_NO
      , A.INOUT_DT
      , A.INOUT_TY_CD
      , A.CALC_PRGS_CD
      , A.ORD_NO
      , A.IN_SHP_NO
      , F.ITM_NO
      , F.INOUT_QTY
FROM    CF14 A
      , CF15 F
WHERE   1 = 1
AND     F.INOUT_NO = A.INOUT_NO
AND     A.ORD_NO = '2023050801'
ORDER BY
        A.INOUT_NO
;

-- 쿼리. 19

SELECT  
        A.INOUT_NO
      , A.INOUT_DT
      , A.ORD_NO
      , B.ORD_DT
      , A.IN_SHP_NO
      , E.SHP_NM        IN_SHP_NM
      , F.ITM_NO
      , G.ITM_NM
      , H.ORD_QTY
      , F.INOUT_QTY
FROM    CF14 A
      , CF12 B
      , CF07 E
      , CF15 F
      , CF01 G
      , CF13 H
WHERE   1 = 1
AND     B.ORD_NO = A.ORD_NO
AND     E.SHP_NO = A.IN_SHP_NO
AND     F.INOUT_NO = A.INOUT_NO
AND     G.ITM_NO = F.ITM_NO
AND     H.ORD_NO = A.ORD_NO
AND     H.ITM_NO = F.ITM_NO
AND     A.ORD_NO = '2023050801'
ORDER BY
        A.INOUT_NO, F.ITM_NO
;

-- 쿼리. 20

SELECT  
        A.INOUT_NO
      , A.INOUT_DT
      , A.INOUT_TY_CD
      , A.CALC_PRGS_CD
      , A.ORD_NO
      , A.IN_SHP_NO
      , A.OUT_SHP_NO
FROM    CF14 A
WHERE   1 = 1
AND     A.INOUT_TY_CD = '11'
AND     A.INOUT_DT BETWEEN '20230508' AND '20230512'
ORDER BY
        A.INOUT_NO
;

-- 쿼리. 21

SELECT  
        A.INOUT_NO
      , A.INOUT_DT
      , A.INOUT_TY_CD
      , C.UNI_CD_NM     INOUT_TY_NM
      , A.CALC_PRGS_CD
      , D.UNI_CD_NM     CALC_PRGS_NM
      , A.IN_SHP_NO
      , E.SHP_NM        IN_SHP_NM
      , A.OUT_SHP_NO
      , F.SHP_NM        OUT_SHP_NM
FROM    CF14 A
      , CF16 C
      , CF16 D
      , CF07 E
      , CF07 F
WHERE   1 = 1
AND     C.CLS_CD = 'INOUT_TY_CD'
AND     C.CD = A.INOUT_TY_CD
AND     D.CLS_CD = 'CALC_PRGS_CD'
AND     D.CD = A.CALC_PRGS_CD
AND     E.SHP_NO = A.IN_SHP_NO
AND     F.SHP_NO = A.OUT_SHP_NO
AND     INOUT_TY_CD = '11'
AND     INOUT_DT BETWEEN '20230508' AND '20230512'
ORDER BY
        A.INOUT_NO
;

-- 쿼리. 22

SELECT  
        A.INOUT_NO
      , A.INOUT_DT
      , A.INOUT_TY_CD
      , A.CALC_PRGS_CD
      , A.IN_SHP_NO
      , A.OUT_SHP_NO
      , F.ITM_NO
      , F.INOUT_QTY
FROM    CF14 A
      , CF15 F
WHERE   1 = 1
AND     F.INOUT_NO = A.INOUT_NO
AND     A.INOUT_NO = '2023050801'
ORDER BY
        A.INOUT_NO
;

-- 쿼리. 23

SELECT  
        A.INOUT_NO
      , A.INOUT_DT
      , A.IN_SHP_NO
      , D.SHP_NM        IN_SHP_NM
      , A.OUT_SHP_NO
      , E.SHP_NM        OUT_SHP_NM
      , F.ITM_NO
      , G.ITM_NM
      , F.INOUT_QTY
FROM    CF14 A
      , CF07 D
      , CF07 E
      , CF15 F
      , CF01 G
WHERE   1 = 1
AND     D.SHP_NO = A.IN_SHP_NO
AND     E.SHP_NO = A.OUT_SHP_NO
AND     F.INOUT_NO = A.INOUT_NO
AND     G.ITM_NO = F.ITM_NO
AND     A.INOUT_NO = '2023050801'
ORDER BY
        A.INOUT_NO, F.ITM_NO
;

-- 쿼리. 24

SELECT  
        A.SLE_NO
      , A.SLE_DT
      , A.SLE_HMS
      , A.SLE_DOW
      , A.SHP_NO
      , A.SLE_TTL_AMT
FROM    CF10 A
WHERE   1 = 1
AND     A.SLE_NO BETWEEN '20230508-0001' AND '20230508-0010'
ORDER BY
        A.SLE_NO
;

-- 쿼리. 25

SELECT  
        A.SLE_NO
      , A.SLE_DT
      , A.SLE_HMS
      , CASE
            WHEN A.SLE_DOW = '1' THEN '일'
            WHEN A.SLE_DOW = '2' THEN '월'
            WHEN A.SLE_DOW = '3' THEN '화'
            WHEN A.SLE_DOW = '4' THEN '수'
            WHEN A.SLE_DOW = '5' THEN '목'
            WHEN A.SLE_DOW = '6' THEN '금'
            WHEN A.SLE_DOW = '7' THEN '토'
        END SLE_DOW
      , A.SHP_NO
      , B.SHP_NM
      , A.SLE_TTL_AMT
FROM    CF10 A
      , CF07 B
WHERE   1 = 1
AND     B.SHP_NO = A.SHP_NO
AND     A.SLE_NO BETWEEN '20230508-0001' AND '20230508-0010'
ORDER BY
        A.SLE_NO
;

-- 쿼리. 26

SELECT  
        A.SLE_NO
      , A.SLE_DT
      , A.SLE_HMS
      , CASE
            WHEN A.SLE_DOW = '1' THEN '일'
            WHEN A.SLE_DOW = '2' THEN '월'
            WHEN A.SLE_DOW = '3' THEN '화'
            WHEN A.SLE_DOW = '4' THEN '수'
            WHEN A.SLE_DOW = '5' THEN '목'
            WHEN A.SLE_DOW = '6' THEN '금'
            WHEN A.SLE_DOW = '7' THEN '토'
        END SLE_DOW
      , A.SHP_NO
      , B.ITM_NO
      , B.SLE_UPRC
      , B.SLE_QTY
      , B.SLE_UPRC * B.SLE_QTY  SLE_AMT
FROM    CF10 A
      , CF11 B
WHERE   1 = 1
AND     B.SLE_NO = A.SLE_NO
AND     A.SLE_NO BETWEEN '20230508-0001' AND '20230508-0010'
ORDER BY
        A.SLE_NO, B.ITM_NO
;

-- 쿼리. 27

SELECT  
        A.SLE_NO
      , A.SLE_DT
      , A.SLE_HMS
      , CASE
            WHEN A.SLE_DOW = '1' THEN '일'
            WHEN A.SLE_DOW = '2' THEN '월'
            WHEN A.SLE_DOW = '3' THEN '화'
            WHEN A.SLE_DOW = '4' THEN '수'
            WHEN A.SLE_DOW = '5' THEN '목'
            WHEN A.SLE_DOW = '6' THEN '금'
            WHEN A.SLE_DOW = '7' THEN '토'
        END SLE_DOW
      , A.SHP_NO
      , C.SHP_NM
      , B.ITM_NO
      , D.ITM_NM
      , B.SLE_UPRC
      , B.SLE_QTY
      , B.SLE_UPRC * B.SLE_QTY  SLE_AMT
FROM    CF10 A
      , CF11 B
      , CF07 C
      , CF01 D
WHERE   1 = 1
AND     B.SLE_NO = A.SLE_NO
AND     C.SHP_NO = A.SHP_NO
AND     D.ITM_NO = B.ITM_NO
AND     A.SLE_NO BETWEEN '20230508-0001' AND '20230508-0010'
ORDER BY
        A.SLE_NO, B.ITM_NO
;



-- 쿼리. 28

SELECT
        P.PTNR_NO
      , P.PTNR_NM
      , P.CEO_NM
      , P.STF_NM
      , P.STF_TEL_NO
      , P.STF_EML_ADDR
FROM    CF06    P
WHERE   1 = 1
ORDER BY
        P.PTNR_NO
;

-- 쿼리. 29

SELECT
        SH.SHP_NO
      , SH.SHP_NM
      , SH.SHP_TEL_NO
      , SH.SHP_ADDR
FROM    CF07    SH
WHERE   1 = 1
ORDER BY
        SH.SHP_NO
;

-- 쿼리. 30

SELECT  
        E.EMP_NO
      , E.EMP_NM
      , CD.UNI_CD_NM    GRD_NM
      , D.DEPT_NM
      , E.MBL_NO
      , E.EML_ADDR
FROM    CF09    E
      , CF08    D
      , CF16    CD
WHERE   1 = 1
AND     D.DEPT_NO = E.DEPT_NO
AND     CD.CD = E.GRD_CD
AND     CD.CLS_CD = 'GRD_CD'
ORDER BY
        E.EMP_NO
;

-- 쿼리. 31

SELECT  
        CD.CLS_CD
      , CD.CD
      , CD.UNI_CD_NM
      , CD.SCR_SEQ
      , CD.CD_DESC
FROM    CF16    CD
WHERE   1 = 1
ORDER BY
        CD.CLS_CD
      , CD.CD
;

-- 쿼리. 32

SELECT  
        CD.CLS_CD
      , CD.CD
      , CD.UNI_CD_NM
      , CD.SCR_SEQ
      , CD.CD_DESC
FROM    CF16    CD
WHERE   1 = 1
ORDER BY
        CD.CLS_CD 
      , CD.SCR_SEQ
      , CASE WHEN CD.CD = 'M' THEN '00' ELSE CD END
;

-- 쿼리. 33

SELECT  
        D.DEPT_NO
      , LPAD (' ', 2 * LEVEL - 2, ' ') || D.DEPT_NM AS DEPT_NM
      , D.UP_DEPT_NO
      , LEVEL   LV
FROM    CF08    D
START WITH D.UP_DEPT_NO IS NULL
CONNECT BY D.UP_DEPT_NO = PRIOR D.DEPT_NO
ORDER SIBLINGS BY D.DEPT_NO
;

-- 쿼리. 34

WITH DEPTS (DEPT_NO,DEPT_NM,UP_DEPT_NO,LV) AS (
    SELECT  
            D.DEPT_NO
          , D.DEPT_NM
          , D.UP_DEPT_NO
          , 1   LV
    FROM    CF08    D
    WHERE   D.UP_DEPT_NO IS NULL                -- START WITH
    UNION ALL
    SELECT  
            D.DEPT_NO
          , D.DEPT_NM
          , D.UP_DEPT_NO
          , DS.LV + 1
    FROM    CF08    D
          , DEPTS   DS
    WHERE   1 = 1
    AND     D.UP_DEPT_NO = DS.DEPT_NO           -- CONNECT BY
)
SEARCH DEPTH FIRST BY DEPT_NO SET DEPT_SEQ      -- ORDER SIBLINGS BY
SELECT  
        DEPT_NO
      , LPAD(' ', 2 * LV - 2, ' ') || DEPT_NM AS DEPT_NM
      , UP_DEPT_NO
      , LV
FROM    DEPTS
ORDER BY DEPT_SEQ
;

-- 쿼리. 35

WITH DEPTS (DEPT_NO,DEPT_NM,UP_DEPT_NO,LV) AS (
    SELECT  
            D.DEPT_NO
          , D.DEPT_NM
          , D.UP_DEPT_NO
          , 1   LV
    FROM    CF08    D
    WHERE   D.UP_DEPT_NO IS NULL                -- START WITH
    UNION ALL
    SELECT  
            D.DEPT_NO
          , D.DEPT_NM
          , D.UP_DEPT_NO
          , DS.LV + 1
    FROM    CF08    D
          , DEPTS   DS
    WHERE   1 = 1
    AND     D.UP_DEPT_NO = DS.DEPT_NO           -- CONNECT BY
)
SEARCH BREADTH FIRST BY DEPT_NO SET DEPT_SEQ    -- DEPTH를 BREADTH로 변경
SELECT  
        DEPT_NO
      , LPAD(' ', 2 * LV - 2, ' ') || DEPT_NM AS DEPT_NM
      , UP_DEPT_NO
      , LV
FROM    DEPTS
ORDER BY DEPT_SEQ
;

-- 쿼리. 36

SELECT  
        D.DEPT_NO
      , LPAD (' ', 2 * LEVEL - 2, ' ') || D.DEPT_NM AS DEPT_NM
      , D.UP_DEPT_NO
      , LEVEL   LV
FROM    CF08    D
WHERE   1 = 1
AND     DEPT_NO != 11
START WITH D.UP_DEPT_NO IS NULL
CONNECT BY D.UP_DEPT_NO = PRIOR D.DEPT_NO
ORDER SIBLINGS BY D.DEPT_NO
;

-- 쿼리. 37

WITH DEPTS (DEPT_NO,DEPT_NM,UP_DEPT_NO,LV) AS (
    SELECT  
            D.DEPT_NO
          , D.DEPT_NM
          , D.UP_DEPT_NO
          , 1   LV
    FROM    CF08    D
    WHERE   D.UP_DEPT_NO IS NULL                -- START WITH
    UNION ALL
    SELECT  
            D.DEPT_NO
          , D.DEPT_NM
          , D.UP_DEPT_NO
          , DS.LV + 1
    FROM    CF08    D
          , DEPTS   DS
    WHERE   1 = 1
    AND     D.UP_DEPT_NO = DS.DEPT_NO           -- CONNECT BY
    AND     D.DEPT_NO != 11                     -- 조건추가
)
SEARCH DEPTH FIRST BY DEPT_NO SET DEPT_SEQ      -- ORDER SIBLINGS BY
SELECT  
        DEPT_NO
      , LPAD(' ', 2 * LV - 2, ' ') || DEPT_NM AS DEPT_NM
      , UP_DEPT_NO
      , LV
FROM    DEPTS
ORDER BY DEPT_SEQ
;

-- 쿼리. 38

SELECT  
        D.DEPT_NO
      , LPAD (' ', 2 * LEVEL - 2, ' ') || D.DEPT_NM AS DEPT_NM
      , D.UP_DEPT_NO
      , LEVEL   LV
FROM    CF08    D
WHERE   1 = 1
START WITH D.UP_DEPT_NO IS NULL
CONNECT BY D.UP_DEPT_NO = PRIOR D.DEPT_NO AND DEPT_NO != 11  -- 조건추가
ORDER SIBLINGS BY D.DEPT_NO
;

-- 쿼리. 39

SELECT  
        C.CTG_NO
      , LPAD (' ', 2 * LEVEL - 2, ' ') || C.CTG_NM  CTG_NM
      , C.UP_CTG_NO
      , LEVEL   LV
      , CONNECT_BY_ISLEAF                   IS_LEAF
      , CONNECT_BY_ROOT C.CTG_NM            ROOT
      , SYS_CONNECT_BY_PATH(C.CTG_NM, '->') PTH
FROM    CF02    C
START WITH C.UP_CTG_NO IS NULL
CONNECT BY C.UP_CTG_NO = PRIOR C.CTG_NO
ORDER SIBLINGS BY C.CTG_NO
;

-- 쿼리. 40

SELECT  
        C.CTG_NO
      , LPAD (' ', 2 * LEVEL - 2, ' ') || C.CTG_NM  CTG_NM
      , C.UP_CTG_NO
      , LEVEL   LV
      , CONNECT_BY_ISLEAF                   IS_LEAF
      , CONNECT_BY_ROOT C.CTG_NM            ROOT
      , SUBSTR(SYS_CONNECT_BY_PATH(C.CTG_NM, '->'), 3)  PTH     -- 앞 쪽 -> 표시 제거
FROM    CF02    C
START WITH C.UP_CTG_NO IS NULL
CONNECT BY C.UP_CTG_NO = PRIOR C.CTG_NO
ORDER SIBLINGS BY C.CTG_NO
;

-- 쿼리. 41

WITH CTGS (CTG_NO,CTG_NM,UP_CTG_NO,LV,ROOT,PTH) AS (
    SELECT  
            C.CTG_NO
          , C.CTG_NM
          , C.UP_CTG_NO
          , 1   LV
          , C.CTG_NM        ROOT
          , C.CTG_NM        PTH
    FROM    CF02    C
    WHERE   C.UP_CTG_NO IS NULL                 -- START WITH
    UNION ALL
    SELECT  
            C.CTG_NO
          , C.CTG_NM
          , C.UP_CTG_NO
          , CS.LV + 1
          , CS.ROOT                             -- CONNECT_BY_ROOT
          , CS.PTH || '->' || C.CTG_NM  PTH     -- SYS_CONNECT_BY_PATH
    FROM    CF02    C
          , CTGS    CS
    WHERE   1 = 1
    AND     C.UP_CTG_NO = CS.CTG_NO             -- CONNECT BY
)
SEARCH DEPTH FIRST BY CTG_NO SET CTG_SEQ        -- ORDER SIBLINGS BY
SELECT  
        CTG_NO
      , LPAD(' ', 2 * LV - 2, ' ') || CTG_NM AS CTG_NM
      , UP_CTG_NO
      , LV
      , ROOT
      , PTH
FROM    CTGS
ORDER BY CTG_SEQ
;

-- 쿼리. 42

WITH CTGS (CTG_NO,CTG_NM,UP_CTG_NO,LV,ROOT,PTH) AS (
    SELECT  
            C.CTG_NO
          , C.CTG_NM
          , C.UP_CTG_NO
          , 1   LV
          , C.CTG_NM        ROOT
          , C.CTG_NM        PTH
    FROM    CF02    C
    WHERE   C.UP_CTG_NO IS NULL                 -- START WITH
    UNION ALL
    SELECT  
            C.CTG_NO
          , C.CTG_NM
          , C.UP_CTG_NO
          , CS.LV + 1
          , CS.ROOT                             -- CONNECT_BY_ROOT
          , CS.PTH || '->' || C.CTG_NM  PTH     -- SYS_CONNECT_BY_PATH
    FROM    CF02    C
          , CTGS    CS
    WHERE   1 = 1
    AND     C.UP_CTG_NO = CS.CTG_NO             -- CONNECT BY
)
SEARCH DEPTH FIRST BY CTG_NO SET CTG_SEQ        -- ORDER SIBLINGS BY
SELECT  
        CTG_NO
      , LPAD(' ', 2 * LV - 2, ' ') || CTG_NM AS CTG_NM
      , UP_CTG_NO
      , LV
      , CASE
            WHEN INSTR(LEAD(PTH) OVER(ORDER BY CTG_SEQ), PTH) > 0 THEN 0
            ELSE 1
        END     IS_LEAF
      , ROOT
      , PTH
FROM    CTGS
ORDER BY CTG_SEQ
;

-- 쿼리. 43

SELECT  
        C.CTG_NO
      , LPAD (' ', 2 * LEVEL - 2, ' ') || C.CTG_NM  CTG_NM
      , C.UP_CTG_NO
      , LEVEL   LV
      , CONNECT_BY_ISLEAF                   IS_LEAF
      , CONNECT_BY_ROOT C.CTG_NM            ROOT
      , SUBSTR(SYS_CONNECT_BY_PATH(C.CTG_NM, '->'), 3)  PTH
FROM    CF02    C
WHERE   1 = 1
START WITH C.UP_CTG_NO IS NULL
CONNECT BY C.UP_CTG_NO = PRIOR C.CTG_NO AND C.CTG_NO != 900
ORDER SIBLINGS BY C.CTG_NO
;

-- 쿼리. 44

SELECT  
        I.ITM_NO
      , I.ITM_NM
      , IP.ITM_UPRC
      , I.ITM_CL_CD
      , I.CTG_NO
      , C.CTG_NM
      , I.PTNR_NO
      , P.PTNR_NM
      , I.SHP_SPP_CYL_CD
      , I.INV_MNG_YN
      , I.SLE_YN
      , I.USE_YN
      , I.ITM_CAPA_QTY
      , I.CAPA_UNT_CD
FROM    CF01    I
      , CF02    C
      , CF06    P
      , CF05    IP
WHERE   1 = 1
AND     C.CTG_NO = I.CTG_NO
AND     P.PTNR_NO(+) = I.PTNR_NO
AND     IP.ITM_NO(+) = I.ITM_NO
ORDER BY
        I.ITM_NO
;

-- 쿼리. 45

SELECT  
        I.ITM_NO
      , I.ITM_NM
      , I.ITM_CL_CD
      , I.CTG_NO
      , C.CTG_NM
      , I.PTNR_NO
      , P.PTNR_NM
      , I.SHP_SPP_CYL_CD
      , I.INV_MNG_YN
      , I.SLE_YN
      , I.USE_YN
      , I.ITM_CAPA_QTY
      , I.CAPA_UNT_CD
FROM    CF01    I
      , CF02    C
      , CF06    P
WHERE   1 = 1
AND     C.CTG_NO = I.CTG_NO
AND     P.PTNR_NO(+) = I.PTNR_NO
ORDER BY
        I.ITM_NO
;

-- 쿼리. 46

SELECT * FROM CF05;

-- 쿼리. 47

CREATE  TABLE CF05T1 AS
SELECT  
        IP.ITM_NO
      , IP.UPRC_KN_CD
      , IP.APL_DT
      , IP.SHP_DSP_YN
      , IP.ITM_UPRC
FROM    CF05    IP
WHERE   1 = 1
AND     ITM_NO BETWEEN 1000 AND 1004
AND     UPRC_KN_CD = '10'
;

INSERT  INTO CF05T1 
SELECT
        IP.ITM_NO
      , IP.UPRC_KN_CD
      , '20230601'  APL_DT
      , IP.SHP_DSP_YN
      , IP.ITM_UPRC + 300 ITM_UPRC
FROM    CF05    IP
WHERE   1 = 1
AND     ITM_NO BETWEEN 1000 AND 1004
AND     UPRC_KN_CD = '10'
;

COMMIT;

SELECT * FROM CF05T1 ORDER BY ITM_NO;

-- 쿼리. 48

SELECT  
        IP.ITM_NO
      , IP.UPRC_KN_CD
      , IP.APL_DT   ST_DT
      , LEAD(IP.APL_DT) OVER(PARTITION BY IP.ITM_NO, IP.UPRC_KN_CD ORDER BY APL_DT) ED_DT
      , IP.SHP_DSP_YN
      , IP.ITM_UPRC
FROM    CF05T1    IP
WHERE   1 = 1
;

-- 쿼리. 49

SELECT  
        IP.ITM_NO
      , IP.UPRC_KN_CD
      , IP.APL_DT   ST_DT
      , LEAD(IP.APL_DT, 1, '99991231')
        OVER(PARTITION BY IP.ITM_NO, IP.UPRC_KN_CD ORDER BY APL_DT) ED_DT
      , IP.SHP_DSP_YN
      , IP.ITM_UPRC
FROM    CF05T1    IP
WHERE   1 = 1
;

-- 쿼리. 50

SELECT
        IP.ITM_NO
      , IP.UPRC_KN_CD
      , IP.ST_DT
      , IP.ED_DT
      , IP.SHP_DSP_YN
      , IP.ITM_UPRC
FROM    (
        SELECT  
                IP.ITM_NO
              , IP.UPRC_KN_CD
              , IP.APL_DT   ST_DT
              , LEAD(IP.APL_DT, 1, '99991231')
                OVER(PARTITION BY IP.ITM_NO, IP.UPRC_KN_CD ORDER BY APL_DT) ED_DT
              , IP.SHP_DSP_YN
              , IP.ITM_UPRC
        FROM    CF05T1    IP
        WHERE   1 = 1
        )   IP
WHERE   1 = 1
AND     IP.ITM_NO = 1000
AND     '20220202' BETWEEN IP.ST_DT AND IP.ED_DT
;

-- 쿼리. 51

SELECT
        IP.ITM_NO
      , IP.UPRC_KN_CD
      , IP.ST_DT
      , IP.ED_DT
      , IP.SHP_DSP_YN
      , IP.ITM_UPRC
FROM    (
        SELECT  
                IP.ITM_NO
              , IP.UPRC_KN_CD
              , IP.APL_DT   ST_DT
              , LEAD(TO_CHAR(TO_DATE(IP.APL_DT) - 1, 'YYYYMMDD'), 1, '99991231')
                OVER(PARTITION BY IP.ITM_NO, IP.UPRC_KN_CD ORDER BY APL_DT) ED_DT
              , IP.SHP_DSP_YN
              , IP.ITM_UPRC
        FROM    CF05T1    IP
        WHERE   1 = 1
        )   IP
WHERE   1 = 1
AND     IP.ITM_NO = 1000
AND     '20230601' BETWEEN IP.ST_DT AND IP.ED_DT
;

-- 쿼리. 52

-- :tday = 20230618

SELECT  
        I.ITM_NO
      , I.ITM_NM
      , IP.ITM_UPRC
      , I.ITM_CL_CD
      , I.CTG_NO
      , C.CTG_NM
      , I.PTNR_NO
      , P.PTNR_NM
      , I.SHP_SPP_CYL_CD
      , I.INV_MNG_YN
      , I.SLE_YN
      , I.USE_YN
      , I.ITM_CAPA_QTY
      , I.CAPA_UNT_CD
FROM    CF01    I
      , CF02    C
      , CF06    P
      , (
        SELECT  
                IP.ITM_NO
              , IP.UPRC_KN_CD
              , IP.APL_DT   ST_DT
              , LEAD(TO_CHAR(TO_DATE(IP.APL_DT) - 1, 'YYYYMMDD'), 1, '99991231')
                OVER(PARTITION BY IP.ITM_NO, IP.UPRC_KN_CD ORDER BY APL_DT) ED_DT
              , IP.SHP_DSP_YN
              , IP.ITM_UPRC
        FROM    CF05T1    IP
        WHERE   1 = 1
        )   IP
WHERE   1 = 1
AND     C.CTG_NO = I.CTG_NO
AND     P.PTNR_NO(+) = I.PTNR_NO
AND     IP.ITM_NO = I.ITM_NO
AND     IP.UPRC_KN_CD = '10'
AND     :tday BETWEEN IP.ST_DT AND IP.ED_DT
ORDER BY
        I.ITM_NO
;

-- 쿼리. 53

-- :tday = 20230618

SELECT  
        I.ITM_NO
      , I.ITM_NM
      , IP.ITM_UPRC
      , I.ITM_CL_CD
      , I.CTG_NO
      , C.CTG_NM
      , I.PTNR_NO
      , P.PTNR_NM
      , I.SHP_SPP_CYL_CD
      , I.INV_MNG_YN
      , I.SLE_YN
      , I.USE_YN
      , I.ITM_CAPA_QTY
      , I.CAPA_UNT_CD
FROM    CF01    I
      , CF02    C
      , CF06    P
      , (
        SELECT  
                IP.ITM_NO
              , IP.UPRC_KN_CD
              , IP.APL_DT   ST_DT
              , LEAD(TO_CHAR(TO_DATE(IP.APL_DT) - 1, 'YYYYMMDD'), 1, '99991231')
                OVER(PARTITION BY IP.ITM_NO, IP.UPRC_KN_CD ORDER BY APL_DT) ED_DT
              , IP.SHP_DSP_YN
              , IP.ITM_UPRC
        FROM    CF05    IP
        WHERE   1 = 1
        )   IP
WHERE   1 = 1
AND     C.CTG_NO = I.CTG_NO
AND     P.PTNR_NO(+) = I.PTNR_NO
AND     IP.ITM_NO(+) = I.ITM_NO
AND     IP.UPRC_KN_CD(+) = '10'
AND     :tday BETWEEN IP.ST_DT(+) AND IP.ED_DT(+)
ORDER BY
        I.ITM_NO
;

-- 쿼리. 54

-- :tday = 20230618

SELECT  
        I.ITM_NO
      , I.ITM_NM
      , IP.ITM_UPRC
      , C1.UNI_CD_NM    ITM_CL_CD
      , I.CTG_NO
      , C.CTG_NM
      , I.PTNR_NO
      , P.PTNR_NM
      , C2.UNI_CD_NM    SHP_SPP_CYL_CD
      , I.INV_MNG_YN
      , I.SLE_YN
      , I.USE_YN
      , I.ITM_CAPA_QTY
      , I.CAPA_UNT_CD
FROM    CF01    I
      , CF02    C
      , CF06    P
      , (
        SELECT  
                IP.ITM_NO
              , IP.UPRC_KN_CD
              , IP.APL_DT   ST_DT
              , LEAD(TO_CHAR(TO_DATE(IP.APL_DT) - 1, 'YYYYMMDD'), 1, '99991231')
                OVER(PARTITION BY IP.ITM_NO, IP.UPRC_KN_CD ORDER BY APL_DT) ED_DT
              , IP.SHP_DSP_YN
              , IP.ITM_UPRC
        FROM    CF05    IP
        WHERE   1 = 1
        )   IP
      , CF16    C1
      , CF16    C2
WHERE   1 = 1
AND     C.CTG_NO = I.CTG_NO
AND     C1.CLS_CD = 'ITM_CL_CD'
AND     C1.CD = I.ITM_CL_CD
AND     C2.CLS_CD = 'SHP_SPP_CYL_CD'
AND     C2.CD = I.SHP_SPP_CYL_CD
AND     P.PTNR_NO(+) = I.PTNR_NO
AND     IP.ITM_NO(+) = I.ITM_NO
AND     IP.UPRC_KN_CD(+) = '10'
AND     :tday BETWEEN IP.ST_DT(+) AND IP.ED_DT(+)
ORDER BY
        I.ITM_NO
;

-- 쿼리. 55

SELECT  
        O.ORD_NO
      , O.ORD_DT
      , O.PTNR_NO
      , P.PTNR_NM
      , O.ORD_EMP_NO
      , E.EMP_NM
      , O.ORD_PRGS_CD
      , OI.ITM_NO
      , I.ITM_NM
      , OI.ORD_QTY
      , OI.ORD_QTY * OI.ORD_QTY    ORD_AMT
FROM    CF12    O
      , CF13    OI
      , CF06    P
      , CF01    I
      , CF09    E
WHERE   1 = 1
AND     OI.ORD_NO = O.ORD_NO
AND     P.PTNR_NO = O.PTNR_NO
AND     E.EMP_NO = O.ORD_EMP_NO
AND     I.ITM_NO = OI.ITM_NO
AND     O.ORD_NO = '2023062601'     -- 임의로 넣은 변수
;

-- 쿼리. 56

SELECT  
        O.ORD_NO
      , O.ORD_DT
      , O.PTNR_NO
      , P.PTNR_NM
      , O.ORD_EMP_NO
      , E.EMP_NM
      , O.ORD_PRGS_CD
      , MAX(OI.ITM_NO)      ITM_NO
      , MAX(I.ITM_NM)       ITM_NM
      , COUNT(*)            ORD_CNT
      , SUM(OI.ORD_QTY * OI.ORD_QTY)    ORD_AMT
FROM    CF12    O
      , CF13    OI
      , CF06    P
      , CF01    I
      , CF09    E
WHERE   1 = 1
AND     OI.ORD_NO = O.ORD_NO
AND     P.PTNR_NO = O.PTNR_NO
AND     E.EMP_NO = O.ORD_EMP_NO
AND     I.ITM_NO = OI.ITM_NO
AND     O.ORD_NO = '2023062601'     -- 임의로 넣은 변수
GROUP BY
        O.ORD_NO
      , O.ORD_DT
      , O.PTNR_NO
      , P.PTNR_NM
      , O.ORD_EMP_NO
      , E.EMP_NM
      , O.ORD_PRGS_CD
;

-- 쿼리. 57

SELECT  
        O.ORD_NO
      , O.ORD_DT
      , O.PTNR_NO
      , P.PTNR_NM
      , O.ORD_EMP_NO
      , E.EMP_NM
      , O.ORD_PRGS_CD
      , OI.ITM_NO
      , I.ITM_NM
      , OI.ORD_QTY
      , OI.ORD_QTY * OI.ORD_UPRC    ORD_AMT
FROM    CF12    O
      , CF13    OI
      , CF06    P
      , CF01    I
      , CF09    E
WHERE   1 = 1
AND     OI.ORD_NO = O.ORD_NO
AND     P.PTNR_NO = O.PTNR_NO
AND     E.EMP_NO = O.ORD_EMP_NO
AND     I.ITM_NO = OI.ITM_NO
AND     O.ORD_NO = '2023062602'     -- 임의로 넣은 변수
;

-- 쿼리. 58

SELECT  
        O.ORD_NO
      , O.ORD_DT
      , O.PTNR_NO
      , P.PTNR_NM
      , O.ORD_EMP_NO
      , E.EMP_NM
      , O.ORD_PRGS_CD
      , MAX(OI.ITM_NO)      ITM_NO
      , MAX(I.ITM_NM)       ITM_NM
      , COUNT(*)            ORD_CNT
      , SUM(OI.ORD_QTY * OI.ORD_UPRC)    ORD_AMT
FROM    CF12    O
      , CF13    OI
      , CF06    P
      , CF01    I
      , CF09    E
WHERE   1 = 1
AND     OI.ORD_NO = O.ORD_NO
AND     P.PTNR_NO = O.PTNR_NO
AND     E.EMP_NO = O.ORD_EMP_NO
AND     I.ITM_NO = OI.ITM_NO
AND     O.ORD_NO = '2023062602'     -- 임의로 넣은 변수
GROUP BY
        O.ORD_NO
      , O.ORD_DT
      , O.PTNR_NO
      , P.PTNR_NM
      , O.ORD_EMP_NO
      , E.EMP_NM
      , O.ORD_PRGS_CD
;

-- 쿼리. 59

SELECT  
        O.ORD_NO
      , O.ORD_DT
      , O.PTNR_NO
      , P.PTNR_NM
      , O.ORD_EMP_NO
      , E.EMP_NM
      , O.ORD_PRGS_CD
      , OI.ITM_NO
      , I.ITM_NM || 
        CASE WHEN OI.ORD_CNT > 1 THEN ' 외 ' || (OI.ORD_CNT - 1) END     ITM_NM
      , OI.ORD_QTY
      , OI.ORD_AMT
FROM    CF12    O
      , CF06    P
      , CF01    I
      , CF09    E
      , (
            SELECT  
                    OI.ORD_NO
                  , COUNT(*)            ORD_CNT
                  , MAX(OI.ITM_NO)      ITM_NO
                  , SUM(OI.ORD_QTY)     ORD_QTY
                  , SUM(OI.ORD_QTY * ORD_UPRC)   ORD_AMT
            FROM    CF13    OI
            WHERE   1 = 1
            GROUP BY
                    OI.ORD_NO
        )   OI
WHERE   1 = 1
AND     OI.ORD_NO = O.ORD_NO
AND     P.PTNR_NO = O.PTNR_NO
AND     E.EMP_NO = O.ORD_EMP_NO
AND     I.ITM_NO = OI.ITM_NO
AND     O.ORD_NO = '2023062602'
;

-- 쿼리. 60

SELECT  
        O.ORD_NO
      , O.ORD_DT
      , O.PTNR_NO
      , P.PTNR_NM
      , O.ORD_EMP_NO
      , E.EMP_NM
      , O.ORD_PRGS_CD
      , O.ITM_NO
      , I.ITM_NM || 
CASE WHEN O.ORD_CNT > 1 THEN ' 외 ' || (O.ORD_CNT - 1) END     ITM_NM
      , O.ORD_QTY
      , O.ORD_AMT
FROM    CF06    P
      , CF01    I
      , CF09    E
      , (
            SELECT  
                    O.ORD_NO
                  , O.ORD_DT
                  , O.PTNR_NO
                  , O.ORD_EMP_NO
                  , O.ORD_PRGS_CD
                  , COUNT(*)            ORD_CNT
                  , MAX(OI.ITM_NO)      ITM_NO
                  , SUM(OI.ORD_QTY)     ORD_QTY
                  , SUM(OI.ORD_QTY * ORD_UPRC)   ORD_AMT
            FROM    CF12    O
                  , CF13    OI
            WHERE   1 = 1
            AND     OI.ORD_NO = O.ORD_NO
            AND     O.ORD_NO = '2023062602'
            GROUP BY
                    O.ORD_NO
                  , O.ORD_DT
                  , O.PTNR_NO
                  , O.ORD_EMP_NO
                  , O.ORD_PRGS_CD
        )   O
WHERE   1 = 1
AND     P.PTNR_NO = O.PTNR_NO
AND     E.EMP_NO = O.ORD_EMP_NO
AND     I.ITM_NO = O.ITM_NO
;

-- 쿼리. 61

-- :stDt = 20230528
-- :edDt = 20230627
-- :pageNo = 1
-- :pageSize = 10

SELECT  
        O.ORD_NO
      , O.ORD_DT
      , P.PTNR_NM
      , E.EMP_NM
      , CD.UNI_CD_NM    ORD_PRGS_NM
      , I.ITM_NM || 
        CASE WHEN OI.ORD_CNT > 1 THEN ' 외 ' || (OI.ORD_CNT - 1) END     ITM_NM
      , OI.ORD_QTY
      , OI.ORD_AMT
FROM    (
        SELECT  
                O.RN
              , O.ORD_NO
              , O.ORD_DT
              , O.PTNR_NO
              , O.ORD_EMP_NO
              , O.ORD_PRGS_CD
        FROM    (
                SELECT  
                        ROWNUM  RN
                      , O.ORD_NO
                      , O.ORD_DT
                      , O.PTNR_NO
                      , O.ORD_EMP_NO
                      , O.ORD_PRGS_CD
                FROM    (
                        SELECT  
                                O.ORD_NO
                              , O.ORD_DT
                              , O.PTNR_NO
                              , O.ORD_EMP_NO
                              , O.ORD_PRGS_CD
                        FROM    CF12    O
                        WHERE   1 = 1
                        AND     O.ORD_DT BETWEEN :stDt AND :edDt
                        ORDER BY
                                O.ORD_NO DESC
                        )   O
                WHERE   1 = 1
                AND     ROWNUM <= :pageNo * :pageSize       -- 페이지종료조건
                )   O
        WHERE   1 = 1
        AND     O.RN >= (:pageNo - 1) * :pageSize + 1       -- 페이지시작조건
        )    O
      , CF06    P
      , CF01    I
      , CF09    E
      , CF16    CD
      , (
        SELECT  
                OI.ORD_NO
              , COUNT(*)            ORD_CNT
              , MAX(OI.ITM_NO)      ITM_NO
              , SUM(OI.ORD_QTY)     ORD_QTY
              , SUM(OI.ORD_QTY * ORD_UPRC)   ORD_AMT
        FROM    CF13    OI
        WHERE   1 = 1
        GROUP BY
                OI.ORD_NO
        )   OI
WHERE   1 = 1
AND     OI.ORD_NO = O.ORD_NO
AND     P.PTNR_NO = O.PTNR_NO
AND     E.EMP_NO = O.ORD_EMP_NO
AND     I.ITM_NO = OI.ITM_NO
AND     CD.CLS_CD = 'ORD_PRGS_CD'
AND     CD.CD = O.ORD_PRGS_CD
ORDER BY
        O.ORD_NO DESC
;

-- 쿼리. 62

SELECT  컬럼
FROM    (
        SELECT  컬럼
        FROM    (
                SELECT  ROWNUM  RN
                      , 컬럼
                FROM    (
                        SELECT  컬럼
                        FROM    테이블목록
                        WHERE   조건
                        ORDER BY
                                기준컬럼 DESC
                        )   X
                WHERE   ROWNUM <= 페이지종료지점
                )   Y
        WHERE   Y.RN >= 페이지시작지점
        )   Z
      , 조인이 필요한 테이블
WHERE   조인조건
ORDER BY
        정렬조건
;

-- 쿼리. 63

-- :stDt = 20230528
-- :edDt = 20230627
-- :pageNo = 1
-- :pageSize = 10

SELECT  
        O.ORD_NO
      , O.ORD_DT
      , P.PTNR_NM
      , E.EMP_NM
      , CD.UNI_CD_NM    ORD_PRGS_NM
      , I.ITM_NM || 
        CASE WHEN OI.ORD_CNT > 1 THEN ' 외 ' || (OI.ORD_CNT - 1) END     ITM_NM
      , OI.ORD_QTY
      , OI.ORD_AMT
      , O.TOT_CNT
FROM    (
        SELECT  
                ROWNUM  RN
              , O.ORD_NO
              , O.ORD_DT
              , O.PTNR_NO
              , O.ORD_EMP_NO
              , O.ORD_PRGS_CD
              , O.TOT_CNT
        FROM    (
                SELECT  
                        ROWNUM  RN
                      , O.ORD_NO
                      , O.ORD_DT
                      , O.PTNR_NO
                      , O.ORD_EMP_NO
                      , O.ORD_PRGS_CD
                      , O.TOT_CNT
                FROM    (
                        SELECT  
                                O.ORD_NO
                              , O.ORD_DT
                              , O.PTNR_NO
                              , O.ORD_EMP_NO
                              , O.ORD_PRGS_CD
                              , COUNT(*) OVER()     TOT_CNT     -- 전체건수
                        FROM    CF12    O
                        WHERE   1 = 1
                        AND     O.ORD_DT BETWEEN :stDt AND :edDt
                        ORDER BY
                                O.ORD_NO DESC
                        )   O
                WHERE   1 = 1
                AND     ROWNUM <= :pageNo * :pageSize       -- 페이지종료조건
                )   O
        WHERE   1 = 1
        AND     O.RN >= (:pageNo - 1) * :pageSize + 1       -- 페이지시작조건
        )    O
      , CF06    P
      , CF01    I
      , CF09    E
      , CF16    CD
      , (
        SELECT  
                OI.ORD_NO
              , COUNT(*)            ORD_CNT
              , MAX(OI.ITM_NO)      ITM_NO
              , SUM(OI.ORD_QTY)     ORD_QTY
              , SUM(OI.ORD_QTY * ORD_UPRC)   ORD_AMT
        FROM    CF13    OI
        WHERE   1 = 1
        GROUP BY
                OI.ORD_NO
        )   OI
WHERE   1 = 1
AND     OI.ORD_NO = O.ORD_NO
AND     P.PTNR_NO = O.PTNR_NO
AND     E.EMP_NO = O.ORD_EMP_NO
AND     I.ITM_NO = OI.ITM_NO
AND     CD.CLS_CD = 'ORD_PRGS_CD'
AND     CD.CD = O.ORD_PRGS_CD
ORDER BY
        O.ORD_NO DESC
;

-- 쿼리. 64

-- :stDt = 20230528
-- :edDt = 20230627
-- :pageNo = 1
-- :pageSize = 10
-- :ordOpt = 2

SELECT  
        O.ORD_NO
      , O.ORD_DT
      , P.PTNR_NM
      , E.EMP_NM
      , CD.UNI_CD_NM    ORD_PRGS_NM
      , I.ITM_NM || 
        CASE WHEN OI.ORD_CNT > 1 THEN ' 외 ' || (OI.ORD_CNT - 1) END     ITM_NM
      , OI.ORD_QTY
      , OI.ORD_AMT
      , O.TOT_CNT
FROM    (
        SELECT  
                ROWNUM  RN
              , O.ORD_NO
              , O.ORD_DT
              , O.PTNR_NO
              , O.ORD_EMP_NO
              , O.ORD_PRGS_CD
              , O.TOT_CNT
        FROM    (
                SELECT  
                        ROWNUM  RN
                      , O.ORD_NO
                      , O.ORD_DT
                      , O.PTNR_NO
                      , O.ORD_EMP_NO
                      , O.ORD_PRGS_CD
                      , O.TOT_CNT
                FROM    (
                        SELECT  
                                O.ORD_NO
                              , O.ORD_DT
                              , O.PTNR_NO
                              , O.ORD_EMP_NO
                              , O.ORD_PRGS_CD
                              , COUNT(*) OVER()     TOT_CNT     -- 전체건수
                        FROM    CF12    O
                        WHERE   1 = 1
                        AND     O.ORD_DT BETWEEN :stDt AND :edDt
                        ORDER BY
                                O.ORD_NO DESC
                        )   O
                WHERE   1 = 1
                AND     ROWNUM <= :pageNo * :pageSize       -- 페이지종료조건
                )   O
        WHERE   1 = 1
        AND     O.RN >= (:pageNo - 1) * :pageSize + 1       -- 페이지시작조건
        )    O
      , CF06    P
      , CF01    I
      , CF09    E
      , CF16    CD
      , (
        SELECT  
                OI.ORD_NO
              , COUNT(*)            ORD_CNT
              , MAX(OI.ITM_NO)      ITM_NO
              , SUM(OI.ORD_QTY)     ORD_QTY
              , SUM(OI.ORD_QTY * ORD_UPRC)   ORD_AMT
        FROM    CF13    OI
        WHERE   1 = 1
        GROUP BY
                OI.ORD_NO
        )   OI
WHERE   1 = 1
AND     OI.ORD_NO = O.ORD_NO
AND     P.PTNR_NO = O.PTNR_NO
AND     E.EMP_NO = O.ORD_EMP_NO
AND     I.ITM_NO = OI.ITM_NO
AND     CD.CLS_CD = 'ORD_PRGS_CD'
AND     CD.CD = O.ORD_PRGS_CD
ORDER BY
        CASE WHEN :ordOpt = 1 THEN O.ORD_NO END DESC
      , CASE WHEN :ordOpt = 2 THEN O.ORD_PRGS_CD END
      , CASE WHEN :ordOpt = 3 THEN OI.ORD_QTY END DESC
      , CASE WHEN :ordOpt = 4 THEN OI.ORD_AMT END DESC
;

-- 쿼리. 65

-- :stDt = 20230528
-- :edDt = 20230627
-- :pageNo = 1
-- :pageSize = 10
-- :ordOpt = 2

SELECT  
        O.ORD_NO
      , O.ORD_DT
      , P.PTNR_NM
      , E.EMP_NM
      , CD.UNI_CD_NM    ORD_PRGS_NM
      , I.ITM_NM || 
        CASE WHEN OI.ORD_CNT > 1 THEN ' 외 ' || (OI.ORD_CNT - 1) END     ITM_NM
      , OI.ORD_QTY
      , OI.ORD_AMT
      , O.TOT_CNT
FROM    (
        SELECT  
                ROWNUM  RN
              , O.ORD_NO
              , O.ORD_DT
              , O.PTNR_NO
              , O.ORD_EMP_NO
              , O.ORD_PRGS_CD
              , O.TOT_CNT
        FROM    (
                SELECT  
                        ROWNUM  RN
                      , O.ORD_NO
                      , O.ORD_DT
                      , O.PTNR_NO
                      , O.ORD_EMP_NO
                      , O.ORD_PRGS_CD
                      , O.TOT_CNT
                FROM    (
                        SELECT  
                                O.ORD_NO
                              , O.ORD_DT
                              , O.PTNR_NO
                              , O.ORD_EMP_NO
                              , O.ORD_PRGS_CD
                              , COUNT(*) OVER()     TOT_CNT     -- 전체건수
                        FROM    CF12    O
                        WHERE   1 = 1
                        AND     O.ORD_DT BETWEEN :stDt AND :edDt
                        ORDER BY
                                O.ORD_NO DESC
                        )   O
                WHERE   1 = 1
                AND     ROWNUM <= :pageNo * :pageSize       -- 페이지종료조건
                )   O
        WHERE   1 = 1
        AND     O.RN >= (:pageNo - 1) * :pageSize + 1       -- 페이지시작조건
        )    O
      , CF06    P
      , CF01    I
      , CF09    E
      , CF16    CD
      , (
        SELECT  
                OI.ORD_NO
              , COUNT(*)            ORD_CNT
              , MAX(OI.ITM_NO)      ITM_NO
              , SUM(OI.ORD_QTY)     ORD_QTY
              , SUM(OI.ORD_QTY * ORD_UPRC)   ORD_AMT
        FROM    CF13    OI
        WHERE   1 = 1
        GROUP BY
                OI.ORD_NO
        )   OI
WHERE   1 = 1
AND     OI.ORD_NO = O.ORD_NO
AND     P.PTNR_NO = O.PTNR_NO
AND     E.EMP_NO = O.ORD_EMP_NO
AND     I.ITM_NO = OI.ITM_NO
AND     CD.CLS_CD = 'ORD_PRGS_CD'
AND     CD.CD = O.ORD_PRGS_CD
ORDER BY
        CASE WHEN :ordOpt = 1 THEN O.ORD_NO END DESC
      , CASE WHEN :ordOpt = 2 THEN O.ORD_PRGS_CD END
      , CASE WHEN :ordOpt = 2 THEN O.ORD_NO END DESC
      , CASE WHEN :ordOpt = 3 THEN OI.ORD_QTY END DESC
      , CASE WHEN :ordOpt = 4 THEN OI.ORD_AMT END DESC
;

-- 쿼리. 66

-- :stDt = 20230528
-- :edDt = 20230627
-- :pageNo = 1
-- :pageSize = 10
-- :ordOpt = 1
-- :selOpt = 1

SELECT  
        O.ORD_NO
      , O.ORD_DT
      , P.PTNR_NM
      , E.EMP_NM
      , CD.UNI_CD_NM    ORD_PRGS_NM
      , I.ITM_NM || 
        CASE WHEN OI.ORD_CNT > 1 THEN ' 외 ' || (OI.ORD_CNT - 1) END     ITM_NM
      , OI.ORD_QTY
      , OI.ORD_AMT
      , O.TOT_CNT
FROM    (
        SELECT  
                ROWNUM  RN
              , O.ORD_NO
              , O.ORD_DT
              , O.PTNR_NO
              , O.ORD_EMP_NO
              , O.ORD_PRGS_CD
              , O.TOT_CNT
        FROM    (
                SELECT  
                        ROWNUM  RN
                      , O.ORD_NO
                      , O.ORD_DT
                      , O.PTNR_NO
                      , O.ORD_EMP_NO
                      , O.ORD_PRGS_CD
                      , O.TOT_CNT
                FROM    (
                        SELECT  
                                O.ORD_NO
                              , O.ORD_DT
                              , O.PTNR_NO
                              , O.ORD_EMP_NO
                              , O.ORD_PRGS_CD
                              , COUNT(*) OVER()     TOT_CNT     -- 전체건수
                        FROM    CF12    O
                        WHERE   1 = 1
                        AND     O.ORD_DT BETWEEN :stDt AND :edDt
                        ORDER BY
                                O.ORD_NO DESC
                        )   O
                WHERE   1 = 1
                AND     ROWNUM <= :pageNo * :pageSize       -- 페이지종료조건
                )   O
        WHERE   1 = 1
        AND     O.RN >= (:pageNo - 1) * :pageSize + 1       -- 페이지시작조건
        )    O
      , CF06    P
      , CF01    I
      , CF09    E
      , CF16    CD
      , (
        SELECT  
                OI.ORD_NO
              , OI.ITM_NO
              , OI.ORD_CNT
              , OI.ORD_QTY
              , OI.ORD_AMT
              , OI.RN
        FROM    (
                SELECT  
                        OI.ORD_NO
                      , OI.ITM_NO
                      , COUNT(*) OVER(PARTITION BY OI.ORD_NO)           ORD_CNT
                      , SUM(OI.ORD_QTY) OVER(PARTITION BY OI.ORD_NO)    ORD_QTY
                      , SUM(OI.ORD_QTY * OI.ORD_UPRC)
                        OVER(PARTITION BY OI.ORD_NO) ORD_AMT
                      , ROW_NUMBER()
                        OVER(
                            PARTITION BY OI.ORD_NO
                            ORDER BY
                                  CASE WHEN :selOpt = 1 THEN OI.ITM_NO END
                                , CASE WHEN :selOpt = 2 THEN OI.ITM_NO END DESC
                                , CASE WHEN :selOpt = 3 THEN OI.ORD_QTY END DESC
                                , CASE WHEN :selOpt = 3 THEN OI.ORD_UPRC END DESC
                                , CASE WHEN :selOpt = 4 THEN OI.ORD_QTY END
                                , CASE WHEN :selOpt = 4 THEN OI.ORD_UPRC END DESC
                                , CASE WHEN :selOpt = 5 THEN OI.ORD_UPRC END DESC
                                , CASE WHEN :selOpt = 6 THEN OI.ORD_UPRC END
                                , CASE WHEN :selOpt = 7 THEN NULL END
                            )   RN
                FROM    CF13    OI
                WHERE   1 = 1
                )   OI
        WHERE   1 = 1
        AND     OI.RN = 1
        )   OI
WHERE   1 = 1
AND     OI.ORD_NO = O.ORD_NO
AND     P.PTNR_NO = O.PTNR_NO
AND     E.EMP_NO = O.ORD_EMP_NO
AND     I.ITM_NO = OI.ITM_NO
AND     CD.CLS_CD = 'ORD_PRGS_CD'
AND     CD.CD = O.ORD_PRGS_CD
ORDER BY
        CASE WHEN :ordOpt = 1 THEN O.ORD_NO END DESC
      , CASE WHEN :ordOpt = 2 THEN O.ORD_PRGS_CD END
      , CASE WHEN :ordOpt = 2 THEN O.ORD_NO END DESC
      , CASE WHEN :ordOpt = 3 THEN OI.ORD_QTY END DESC
      , CASE WHEN :ordOpt = 4 THEN OI.ORD_AMT END DESC
;

-- 쿼리. 67

-- :stDt = 20230528
-- :edDt = 20230627

SELECT  
        COUNT(*)    TOT_CNT
FROM    (
        SELECT  
                ROWNUM  RN
              , O.ORD_NO
              , O.ORD_DT
              , O.PTNR_NO
              , O.ORD_EMP_NO
              , O.ORD_PRGS_CD
        FROM    (
                SELECT  
                        ROWNUM  RN
                      , O.ORD_NO
                      , O.ORD_DT
                      , O.PTNR_NO
                      , O.ORD_EMP_NO
                      , O.ORD_PRGS_CD
                FROM    (
                        SELECT  
                                O.ORD_NO
                              , O.ORD_DT
                              , O.PTNR_NO
                              , O.ORD_EMP_NO
                              , O.ORD_PRGS_CD
                        FROM    CF12    O
                        WHERE   1 = 1
                        AND     O.ORD_DT BETWEEN :stDt AND :edDt
                        ORDER BY
                                O.ORD_NO DESC
                        )   O
                WHERE   1 = 1
                )   O
        WHERE   1 = 1
        )    O
      , CF06    P
      , CF01    I
      , CF09    E
      , CF16    CD
      , (
        SELECT  
                OI.ORD_NO
              , COUNT(*)            ORD_CNT
              , MAX(OI.ITM_NO)      ITM_NO
              , SUM(OI.ORD_QTY)     ORD_QTY
              , SUM(OI.ORD_QTY * ORD_UPRC)   ORD_AMT
        FROM    CF13    OI
        WHERE   1 = 1
        GROUP BY
                OI.ORD_NO
        )   OI
WHERE   1 = 1
AND     OI.ORD_NO = O.ORD_NO
AND     P.PTNR_NO = O.PTNR_NO
AND     E.EMP_NO = O.ORD_EMP_NO
AND     I.ITM_NO = OI.ITM_NO
AND     CD.CLS_CD = 'ORD_PRGS_CD'
AND     CD.CD = O.ORD_PRGS_CD
;

-- 쿼리. 68

-- :stDt = 20230528
-- :edDt = 20230627

SELECT  
        COUNT(*)    TOT_CNT
FROM    CF12    O
WHERE   1 = 1
AND     ORD_DT BETWEEN :stDt AND :edDt
;

-- 쿼리. 69

-- :stDt = 20230528
-- :edDt = 20230627
-- :pageNo = 1
-- :pageSize = 10

SELECT  
        X.ORD_NO
      , X.ORD_DT
      , P.PTNR_NM
      , E.EMP_NM
      , CD.UNI_CD_NM
      , X.ITM_NO
      , I.ITM_NM
      , X.ORD_UPRC
      , X.ORD_QTY
      , X.ORD_AMT
FROM    (
        SELECT  
                X.ORD_NO
              , X.ORD_DT
              , X.PTNR_NO
              , X.ORD_EMP_NO
              , X.ORD_PRGS_CD
              , X.ITM_NO
              , X.ORD_UPRC
              , X.ORD_QTY
              , X.ORD_AMT
        FROM    (
                SELECT  
                        ROWNUM  RN
                      , X.ORD_NO
                      , X.ORD_DT
                      , X.PTNR_NO
                      , X.ORD_EMP_NO
                      , X.ORD_PRGS_CD
                      , X.ITM_NO
                      , X.ORD_UPRC
                      , X.ORD_QTY
                      , X.ORD_AMT
                FROM    (
                        SELECT  
                                O.ORD_NO
                              , O.ORD_DT
                              , O.PTNR_NO
                              , O.ORD_EMP_NO
                              , O.ORD_PRGS_CD
                              , OI.ITM_NO
                              , OI.ORD_UPRC
                              , OI.ORD_QTY
                              , OI.ORD_QTY * OI.ORD_UPRC    ORD_AMT
                        FROM    CF12    O
                              , CF13    OI
                        WHERE   1 = 1
                        AND     OI.ORD_NO = O.ORD_NO
                        AND     O.ORD_DT BETWEEN :stDt AND :edDt
                        ORDER BY
                                O.ORD_NO    DESC
                              , OI.ITM_NO
                        )   X
                WHERE   1 = 1
                AND     ROWNUM <= :pageNo * :pageSize       -- 페이지종료조건
                )   X
        WHERE   1 = 1
        AND     X.RN >= (:pageNo - 1) * :pageSize + 1       -- 페이지시작조건
        )   X
      , CF06    P
      , CF01    I
      , CF09    E
      , CF16    CD
WHERE   1 = 1
AND     P.PTNR_NO = X.PTNR_NO
AND     E.EMP_NO = X.ORD_EMP_NO
AND     I.ITM_NO = X.ITM_NO
AND     CD.CLS_CD = 'ORD_PRGS_CD'
AND     CD.CD = X.ORD_PRGS_CD
ORDER BY
        X.ORD_NO
      , X.ITM_NO
;

-- 쿼리. 70

-- :stDt = 20230528
-- :edDt = 20230627
-- :pageNo = 1
-- :pageSize = 10

SELECT  
        X.ORD_NO
      , X.ORD_DT
      , P.PTNR_NM
      , E.EMP_NM
      , CD.UNI_CD_NM
      , X.ITM_NO
      , I.ITM_NM
      , X.ORD_UPRC
      , X.ORD_QTY
      , X.ORD_AMT
      , X.TOT_CNT
FROM    (
        SELECT  
                X.ORD_NO
              , X.ORD_DT
              , X.PTNR_NO
              , X.ORD_EMP_NO
              , X.ORD_PRGS_CD
              , X.ITM_NO
              , X.ORD_UPRC
              , X.ORD_QTY
              , X.ORD_AMT
              , X.TOT_CNT
        FROM    (
                SELECT  
                        ROWNUM  RN
                      , X.ORD_NO
                      , X.ORD_DT
                      , X.PTNR_NO
                      , X.ORD_EMP_NO
                      , X.ORD_PRGS_CD
                      , X.ITM_NO
                      , X.ORD_UPRC
                      , X.ORD_QTY
                      , X.ORD_AMT
                      , X.TOT_CNT
                FROM    (
                        SELECT  
                                O.ORD_NO
                              , O.ORD_DT
                              , O.PTNR_NO
                              , O.ORD_EMP_NO
                              , O.ORD_PRGS_CD
                              , OI.ITM_NO
                              , OI.ORD_UPRC
                              , OI.ORD_QTY
                              , OI.ORD_QTY * OI.ORD_UPRC    ORD_AMT
                              , COUNT(*) OVER()             TOT_CNT     -- 전체건수
                        FROM    CF12    O
                              , CF13    OI
                        WHERE   1 = 1
                        AND     OI.ORD_NO = O.ORD_NO
                        AND     O.ORD_DT BETWEEN :stDt AND :edDt
                        ORDER BY
                                O.ORD_NO    DESC
                              , OI.ITM_NO
                        )   X
                WHERE   1 = 1
                AND     ROWNUM <= :pageNo * :pageSize       -- 페이지종료조건
                )   X
        WHERE   1 = 1
        AND     X.RN >= (:pageNo - 1) * :pageSize + 1       -- 페이지시작조건
        )   X
      , CF06    P
      , CF01    I
      , CF09    E
      , CF16    CD
WHERE   1 = 1
AND     P.PTNR_NO = X.PTNR_NO
AND     E.EMP_NO = X.ORD_EMP_NO
AND     I.ITM_NO = X.ITM_NO
AND     CD.CLS_CD = 'ORD_PRGS_CD'
AND     CD.CD = X.ORD_PRGS_CD
ORDER BY
        X.ORD_NO
      , X.ITM_NO
;

-- 쿼리. 71

-- :stDt = 20230528
-- :edDt = 20230627

SELECT  
        COUNT(*)           TOT_CNT     -- 전체건수
FROM    CF12    O
      , CF13    OI
WHERE   1 = 1
AND     OI.ORD_NO = O.ORD_NO
AND     ORD_DT BETWEEN :stDt AND :edDt
;

-- 쿼리. 72

SELECT  
        IO.INOUT_NO
      , IO.INOUT_DT
      , IO.INOUT_TY_CD
      , IO.CALC_PRGS_CD
      , IO.ORD_NO
      , IO.IN_SHP_NO
      , IO.OUT_SHP_NO
FROM    CF14    IO
WHERE   1 = 1
AND     IO.INOUT_TY_CD  = '10'     -- 입고
AND     IO.INOUT_DT = '20230627'   -- 입고일자
ORDER BY
        IO.INOUT_NO
;

-- 쿼리. 73

SELECT  
        IO.INOUT_NO
      , IO.INOUT_DT
      , IO.INOUT_TY_CD
      , IO.CALC_PRGS_CD
      , IO.ORD_NO
      , IO.IN_SHP_NO
      , IOI.ITM_NO
      , IOI.INOUT_QTY
FROM    CF14    IO
      , CF15    IOI
WHERE   1 = 1
AND     IOI.INOUT_NO = IO.INOUT_NO
AND     IO.INOUT_TY_CD  = '10'          -- 입고
AND     IO.INOUT_NO = '2023062705'      -- 입출고번호
ORDER BY
        IO.INOUT_NO
      , IOI.ITM_NO
;

-- 쿼리. 74

SELECT  
        IO.INOUT_NO
      , IO.INOUT_DT
      , IO.INOUT_TY_CD
      , IO.CALC_PRGS_CD
      , IO.ORD_NO
      , IO.IN_SHP_NO
      , MAX(IOI.ITM_NO)     ITM_NO
      , SUM(IOI.INOUT_QTY)  INOUT_QTY
      , COUNT(*)            INOUT_CNT
FROM    CF14    IO
      , CF15    IOI
WHERE   1 = 1
AND     IOI.INOUT_NO = IO.INOUT_NO
AND     IO.INOUT_TY_CD  = '10'          -- 입고
AND     IO.INOUT_NO = '2023062705'      -- 입출고번호
GROUP BY
        IO.INOUT_NO
      , IO.INOUT_DT
      , IO.INOUT_TY_CD
      , IO.CALC_PRGS_CD
      , IO.ORD_NO
      , IO.IN_SHP_NO
;

-- 쿼리. 75

SELECT  
        IO.INOUT_NO
      , IO.INOUT_DT
      , IO.INOUT_TY_CD
      , IO.CALC_PRGS_CD
      , IO.ORD_NO
      , IO.IN_SHP_NO
      , MAX(IOI.ITM_NO)     ITM_NO
      , SUM(IOI.INOUT_QTY)  INOUT_QTY
      , COUNT(*)            INOUT_CNT
FROM    CF14    IO
      , CF15    IOI
WHERE   1 = 1
AND     IOI.INOUT_NO = IO.INOUT_NO
AND     IO.INOUT_TY_CD  = '10'          -- 입고
AND     IO.INOUT_DT = '20230627'        -- 입고일자
GROUP BY
        IO.INOUT_NO
      , IO.INOUT_DT
      , IO.INOUT_TY_CD
      , IO.CALC_PRGS_CD
      , IO.ORD_NO
      , IO.IN_SHP_NO
ORDER BY
        IO.INOUT_NO
;

-- 쿼리. 76

SELECT  
        컬럼목록
FROM    (
        )       IO
      , CF12    O
      , CF06    P
      , CF01    I
      , CF07    S
WHERE   1 = 1
AND     O.ORD_NO = IO.ORD_NO
AND     P.PTNR_NO = O.PTNR_NO
AND     I.ITM_NO = IO.ITM_NO
AND     S.SHP_NO = IO.IN_SHP_NO
;

-- 쿼리. 77

SELECT  
        IO.INOUT_NO
      , O.ORD_DT
      , IO.INOUT_DT
      , IO.INOUT_TY_CD
      , IO.CALC_PRGS_CD
      , IO.ORD_NO
      , O.PTNR_NO
      , P.PTNR_NM
      , IO.IN_SHP_NO
      , S.SHP_NM
      , IO.ITM_NO
      , I.ITM_NM
      , IO.INOUT_QTY
      , IO.INOUT_CNT
FROM    (
        SELECT  
                IO.INOUT_NO
              , IO.INOUT_DT
              , IO.INOUT_TY_CD
              , IO.CALC_PRGS_CD
              , IO.ORD_NO
              , IO.IN_SHP_NO
              , MAX(IOI.ITM_NO)     ITM_NO
              , SUM(IOI.INOUT_QTY)  INOUT_QTY
              , COUNT(*)            INOUT_CNT
        FROM    CF14    IO
              , CF15    IOI
        WHERE   1 = 1
        AND     IOI.INOUT_NO = IO.INOUT_NO
        AND     IO.INOUT_TY_CD  = '10'          -- 입고
        AND     IO.INOUT_DT = '20230627'        -- 입고일자
        GROUP BY
                IO.INOUT_NO
              , IO.INOUT_DT
              , IO.INOUT_TY_CD
              , IO.CALC_PRGS_CD
              , IO.ORD_NO
              , IO.IN_SHP_NO
        )   IO
      , CF12    O
      , CF06    P
      , CF01    I
      , CF07    S
WHERE   1 = 1
AND     O.ORD_NO = IO.ORD_NO
AND     P.PTNR_NO = O.PTNR_NO
AND     I.ITM_NO = IO.ITM_NO
AND     S.SHP_NO = IO.IN_SHP_NO
ORDER BY
        IO.INOUT_NO
;

-- 쿼리. 78

SELECT  
        IO.INOUT_NO
      , O.ORD_DT
      , IO.INOUT_DT
      , CD.UNI_CD_NM    CALC_PRGS
      , IO.ORD_NO
      , O.PTNR_NO
      , P.PTNR_NM
, S.SHP_NM
      , IO.ITM_NO
      , I.ITM_NM || 
        CASE WHEN IO.INOUT_CNT > 1 THEN ' 외 ' || (IO.INOUT_CNT - 1) END     ITM_NM
      , IO.INOUT_QTY
FROM    (
        SELECT  
                IO.INOUT_NO
              , IO.INOUT_DT
              , IO.INOUT_TY_CD
              , IO.CALC_PRGS_CD
              , IO.ORD_NO
              , IO.IN_SHP_NO
              , MAX(IOI.ITM_NO)     ITM_NO
              , SUM(IOI.INOUT_QTY)  INOUT_QTY
              , COUNT(*)            INOUT_CNT
        FROM    CF14    IO
              , CF15    IOI
        WHERE   1 = 1
        AND     IOI.INOUT_NO = IO.INOUT_NO
        AND     IO.INOUT_TY_CD  = '10'          -- 입고
        AND     IO.INOUT_DT = '20230627'        -- 입고일자
        GROUP BY
                IO.INOUT_NO
              , IO.INOUT_DT
              , IO.INOUT_TY_CD
              , IO.CALC_PRGS_CD
              , IO.ORD_NO
              , IO.IN_SHP_NO
        )   IO
      , CF12    O
      , CF06    P
      , CF01    I
      , CF07    S
      , CF16    CD      -- 코드테이블 추가
WHERE   1 = 1
AND     O.ORD_NO = IO.ORD_NO
AND     P.PTNR_NO = O.PTNR_NO
AND     I.ITM_NO = IO.ITM_NO
AND     S.SHP_NO = IO.IN_SHP_NO
AND     CD.CLS_CD = 'CALC_PRGS_CD'
AND     CD.CD = IO.CALC_PRGS_CD
ORDER BY
        IO.INOUT_NO
;

-- 쿼리. 79

-- :stDt = 20230530
-- :edDt = 20230629
-- :pageNo = 1
-- :pageSize = 10

SELECT  
        IO.RN
      , IO.INOUT_NO
      , IO.INOUT_DT
      , IO.CALC_PRGS_CD
      , IO.ORD_NO
      , IO.IN_SHP_NO
      , IO.ITM_NO
      , IO.INOUT_QTY
      , IO.INOUT_CNT
FROM    (
        SELECT  
                ROWNUM      RN
              , IO.INOUT_NO
              , IO.INOUT_DT
              , IO.CALC_PRGS_CD
              , IO.ORD_NO
              , IO.IN_SHP_NO
              , IO.ITM_NO
              , IO.INOUT_QTY
              , IO.INOUT_CNT
        FROM    (
                SELECT  
                        IO.INOUT_NO
                      , IO.INOUT_DT
                      , IO.INOUT_TY_CD
                      , IO.CALC_PRGS_CD
                      , IO.ORD_NO
                      , IO.IN_SHP_NO
                      , MAX(IOI.ITM_NO)     ITM_NO
                      , SUM(IOI.INOUT_QTY)  INOUT_QTY
                      , COUNT(*)            INOUT_CNT
                FROM    CF14    IO
                      , CF15    IOI
                WHERE   1 = 1
                AND     IOI.INOUT_NO = IO.INOUT_NO
                AND     IO.INOUT_TY_CD  = '10'          -- 입고
                AND     IO.INOUT_DT BETWEEN :stDt AND :edDt
                GROUP BY
                        IO.INOUT_NO
                      , IO.INOUT_DT
                      , IO.INOUT_TY_CD
                      , IO.CALC_PRGS_CD
                      , IO.ORD_NO
                      , IO.IN_SHP_NO
                ORDER BY
                        IO.INOUT_NO DESC
                )   IO
        WHERE   1 = 1
        AND     ROWNUM <= :pageNo * :pageSize       -- 페이지종료조건
        )   IO
WHERE   1 = 1
AND     IO.RN >= (:pageNo - 1) * :pageSize + 1      -- 페이지시작조건
;

-- 쿼리. 80

-- :stDt = 20230530
-- :edDt = 20230629
-- :pageNo = 1
-- :pageSize = 10

SELECT  
        IO.INOUT_NO
      , O.ORD_DT
      , IO.INOUT_DT
      , CD.UNI_CD_NM    CALC_PRGS
      , IO.ORD_NO
      , O.PTNR_NO
      , P.PTNR_NM
, S.SHP_NM
      , IO.ITM_NO
      , I.ITM_NM || 
        CASE WHEN IO.INOUT_CNT > 1 THEN ' 외 ' || (IO.INOUT_CNT - 1) END     ITM_NM
      , IO.INOUT_QTY
FROM    (
        SELECT  
                IO.RN
              , IO.INOUT_NO
              , IO.INOUT_DT
              , IO.CALC_PRGS_CD
              , IO.ORD_NO
              , IO.IN_SHP_NO
              , IO.ITM_NO
              , IO.INOUT_QTY
              , IO.INOUT_CNT
        FROM    (
                SELECT  
                        ROWNUM      RN
                      , IO.INOUT_NO
                      , IO.INOUT_DT
                      , IO.CALC_PRGS_CD
                      , IO.ORD_NO
                      , IO.IN_SHP_NO
                      , IO.ITM_NO
                      , IO.INOUT_QTY
                      , IO.INOUT_CNT
                FROM    (
                        SELECT  
                                IO.INOUT_NO
                              , IO.INOUT_DT
                              , IO.INOUT_TY_CD
                              , IO.CALC_PRGS_CD
                              , IO.ORD_NO
                              , IO.IN_SHP_NO
                              , MAX(IOI.ITM_NO)     ITM_NO
                              , SUM(IOI.INOUT_QTY)  INOUT_QTY
                              , COUNT(*)            INOUT_CNT
                        FROM    CF14    IO
                              , CF15    IOI
                        WHERE   1 = 1
                        AND     IOI.INOUT_NO = IO.INOUT_NO
                        AND     IO.INOUT_TY_CD  = '10'          -- 입고
                        AND     IO.INOUT_DT BETWEEN :stDt AND :edDt
                        GROUP BY
                                IO.INOUT_NO
                              , IO.INOUT_DT
                              , IO.INOUT_TY_CD
                              , IO.CALC_PRGS_CD
                              , IO.ORD_NO
                              , IO.IN_SHP_NO
                        ORDER BY
                                IO.INOUT_NO DESC
                        )   IO
                WHERE   1 = 1
                AND     ROWNUM <= :pageNo * :pageSize       -- 페이지종료조건
                )   IO
        WHERE   1 = 1
        AND     IO.RN >= (:pageNo - 1) * :pageSize + 1      -- 페이지시작조건
                )   IO
      , CF12    O
      , CF06    P
      , CF01    I
      , CF07    S
      , CF16    CD      -- 코드테이블 추가
WHERE   1 = 1
AND     O.ORD_NO = IO.ORD_NO
AND     P.PTNR_NO = O.PTNR_NO
AND     I.ITM_NO = IO.ITM_NO
AND     S.SHP_NO = IO.IN_SHP_NO
AND     CD.CLS_CD = 'CALC_PRGS_CD'
AND     CD.CD = IO.CALC_PRGS_CD
ORDER BY
        IO.INOUT_NO DESC
;

-- 쿼리. 81

-- :stDt = 20230530
-- :edDt = 20230629

SELECT  
        COUNT(*)    TOT_CNT
FROM    CF14    IO
WHERE   1 = 1
AND     IO.INOUT_TY_CD  = '10'          -- 입고
AND     IO.INOUT_DT BETWEEN :stDt AND :edDt
;

-- 쿼리. 82

SELECT  
        IO.INOUT_NO
      , IO.INOUT_DT
      , IO.CALC_PRGS_CD
      , IO.ORD_NO
      , IO.IN_SHP_NO
      , IOI.ITM_NO
      , IOI.INOUT_QTY
FROM    CF14    IO
      , CF15    IOI
WHERE   1 = 1
AND     IOI.INOUT_NO = IO.INOUT_NO
AND     IO.INOUT_TY_CD = '10'
AND     IO.INOUT_NO = '2023062707'
ORDER BY
        IO.INOUT_NO DESC
      , IOI.ITM_NO
;

-- 쿼리. 83

-- :pageNo = 1
-- :pageSize = 10

SELECT  
        IO.RN
      , IO.INOUT_NO
      , IO.INOUT_DT
      , IO.CALC_PRGS_CD
      , IO.ORD_NO
      , IO.IN_SHP_NO
      , IO.ITM_NO
      , IO.INOUT_QTY
FROM    (
        SELECT  
                ROWNUM  RN
              , IO.INOUT_NO
              , IO.INOUT_DT
              , IO.CALC_PRGS_CD
              , IO.ORD_NO
              , IO.IN_SHP_NO
              , IO.ITM_NO
              , IO.INOUT_QTY
        FROM    (
                SELECT  
                        IO.INOUT_NO
                      , IO.INOUT_DT
                      , IO.CALC_PRGS_CD
                      , IO.ORD_NO
                      , IO.IN_SHP_NO
                      , IOI.ITM_NO
                      , IOI.INOUT_QTY
                FROM    CF14    IO
                      , CF15    IOI
                WHERE   1 = 1
                AND     IOI.INOUT_NO = IO.INOUT_NO
                AND     IO.INOUT_TY_CD = '10'
                AND     IO.INOUT_NO = '2023062707'
                ORDER BY
                        IO.INOUT_NO DESC
                      , IOI.ITM_NO
                )   IO
        WHERE   1 = 1
        AND     ROWNUM <= :pageNo * :pageSize       -- 페이지종료조건
        )   IO
WHERE   1 = 1
AND     IO.RN >= (:pageNo - 1) * :pageSize + 1      -- 페이지시작조건
;

-- 쿼리. 84

-- :pageNo = 1
-- :pageSize = 10

SELECT  
        IO.INOUT_NO
      , O.ORD_DT
      , IO.INOUT_DT
      , CD.UNI_CD_NM    CALC_PRGS
      , IO.ORD_NO
      , O.PTNR_NO
      , P.PTNR_NM
      , S.SHP_NM
      , IO.ITM_NO
      , I.ITM_NM
      , OI.ORD_QTY
      , IO.INOUT_QTY
FROM    (
        SELECT  
                IO.RN
              , IO.INOUT_NO
              , IO.INOUT_DT
              , IO.CALC_PRGS_CD
              , IO.ORD_NO
              , IO.IN_SHP_NO
              , IO.ITM_NO
              , IO.INOUT_QTY
        FROM    (
                SELECT  
                        ROWNUM  RN
                      , IO.INOUT_NO
                      , IO.INOUT_DT
                      , IO.CALC_PRGS_CD
                      , IO.ORD_NO
                      , IO.IN_SHP_NO
                      , IO.ITM_NO
                      , IO.INOUT_QTY
                FROM    (
                        SELECT  
                                IO.INOUT_NO
                              , IO.INOUT_DT
                              , IO.CALC_PRGS_CD
                              , IO.ORD_NO
                              , IO.IN_SHP_NO
                              , IOI.ITM_NO
                              , IOI.INOUT_QTY
                        FROM    CF14    IO
                              , CF15    IOI
                        WHERE   1 = 1
                        AND     IOI.INOUT_NO = IO.INOUT_NO
                        AND     IO.INOUT_TY_CD = '10'
                        AND     IO.INOUT_NO = '2023062707'
                        ORDER BY
                                IO.INOUT_NO DESC
                              , IOI.ITM_NO
                        )   IO
                WHERE   1 = 1
                AND     ROWNUM <= :pageNo * :pageSize       -- 페이지종료조건
                )   IO
        WHERE   1 = 1
        AND     IO.RN >= (:pageNo - 1) * :pageSize + 1      -- 페이지시작조건
        )   IO
      , CF12    O
      , CF13    OI
      , CF06    P
      , CF01    I
      , CF07    S
      , CF16    CD      -- 코드테이블 추가
WHERE   1 = 1
AND     O.ORD_NO = IO.ORD_NO
AND     OI.ORD_NO = IO.ORD_NO
AND     OI.ITM_NO = IO.ITM_NO
AND     P.PTNR_NO = O.PTNR_NO
AND     I.ITM_NO = IO.ITM_NO
AND     S.SHP_NO = IO.IN_SHP_NO
AND     CD.CLS_CD = 'CALC_PRGS_CD'
AND     CD.CD = IO.CALC_PRGS_CD
ORDER BY
        IO.INOUT_NO DESC
      , IO.ITM_NO
;

-- 쿼리. 85

-- :stDt = 20230530
-- :edDt = 20230629
-- :pageNo = 1
-- :pageSize = 10

SELECT  
        IO.INOUT_NO
      , O.ORD_DT
      , IO.INOUT_DT
      , CD.UNI_CD_NM    CALC_PRGS
      , IO.ORD_NO
      , O.PTNR_NO
      , P.PTNR_NM
      , S.SHP_NM
      , IO.ITM_NO
      , I.ITM_NM
      , OI.ORD_QTY
      , IO.INOUT_QTY
FROM    (
        SELECT  
                IO.RN
              , IO.INOUT_NO
              , IO.INOUT_DT
              , IO.CALC_PRGS_CD
              , IO.ORD_NO
              , IO.IN_SHP_NO
              , IO.ITM_NO
              , IO.INOUT_QTY
        FROM    (
                SELECT  
                        ROWNUM  RN
                      , IO.INOUT_NO
                      , IO.INOUT_DT
                      , IO.CALC_PRGS_CD
                      , IO.ORD_NO
                      , IO.IN_SHP_NO
                      , IO.ITM_NO
                      , IO.INOUT_QTY
                FROM    (
                        SELECT  
                                IO.INOUT_NO
                              , IO.INOUT_DT
                              , IO.CALC_PRGS_CD
                              , IO.ORD_NO
                              , IO.IN_SHP_NO
                              , IOI.ITM_NO
                              , IOI.INOUT_QTY
                        FROM    CF14    IO
                              , CF15    IOI
                        WHERE   1 = 1
                        AND     IOI.INOUT_NO = IO.INOUT_NO
                        AND     IO.INOUT_TY_CD = '10'
                        AND     IO.INOUT_DT BETWEEN :stDt AND :edDt
                        ORDER BY
                                IO.INOUT_NO DESC
                              , IOI.ITM_NO
                        )   IO
                WHERE   1 = 1
                AND     ROWNUM <= :pageNo * :pageSize       -- 페이지종료조건
                )   IO
        WHERE   1 = 1
        AND     IO.RN >= (:pageNo - 1) * :pageSize + 1      -- 페이지시작조건
        )   IO
      , CF12    O
      , CF13    OI
      , CF06    P
      , CF01    I
      , CF07    S
      , CF16    CD      -- 코드테이블 추가
WHERE   1 = 1
AND     O.ORD_NO = IO.ORD_NO
AND     OI.ORD_NO = IO.ORD_NO
AND     OI.ITM_NO = IO.ITM_NO
AND     P.PTNR_NO = O.PTNR_NO
AND     I.ITM_NO = IO.ITM_NO
AND     S.SHP_NO = IO.IN_SHP_NO
AND     CD.CLS_CD = 'CALC_PRGS_CD'
AND     CD.CD = IO.CALC_PRGS_CD
ORDER BY
        IO.INOUT_NO DESC
      , IO.ITM_NO
;

-- 쿼리. 86

-- :stDt = 20230530
-- :edDt = 20230629

SELECT  
        COUNT(*)    TOT_CNT
FROM    CF14    IO
      , CF15    IOI
WHERE   1 = 1
AND     IOI.INOUT_NO = IO.INOUT_NO
AND     IO.INOUT_TY_CD = '10'
AND     IO.INOUT_DT BETWEEN :stDt AND :edDt
;

-- 쿼리. 87

SELECT  
        IO.INOUT_NO
      , IO.INOUT_DT
      , IO.INOUT_TY_CD
      , IO.CALC_PRGS_CD
      , IO.ORD_NO
      , IO.IN_SHP_NO
      , IO.OUT_SHP_NO
FROM    CF14    IO
WHERE   1 = 1
AND     IO.INOUT_TY_CD  = '11'     -- 출고
AND     IO.INOUT_DT = '20230626'   -- 출고일자
ORDER BY
        IO.INOUT_NO
;

-- 쿼리. 88

-- :stDt = 20230603
-- :edDt = 20230702

SELECT  
        IO.INOUT_NO
      , IO.INOUT_DT
      , IO.INOUT_TY_CD
      , IO.CALC_PRGS_CD
      , IO.ORD_NO
      , IO.IN_SHP_NO
      , IO.OUT_SHP_NO
FROM    CF14    IO
WHERE   1 = 1
AND     IO.INOUT_TY_CD  = '11'
AND     IO.INOUT_DT BETWEEN :stDt AND :edDt
ORDER BY
        IO.INOUT_NO DESC
;

-- 쿼리. 89

-- :stDt = 20230603
-- :edDt = 20230702
-- :pageNo = 1
-- :pageSize = 10

SELECT  
        IO.INOUT_NO
      , IO.INOUT_DT
      , IO.INOUT_TY_CD
      , IO.CALC_PRGS_CD
      , IO.ORD_NO
      , IO.IN_SHP_NO
      , IO.OUT_SHP_NO
FROM    (
        SELECT  
                ROWNUM  RN
              , IO.INOUT_NO
              , IO.INOUT_DT
              , IO.INOUT_TY_CD
              , IO.CALC_PRGS_CD
              , IO.ORD_NO
              , IO.IN_SHP_NO
              , IO.OUT_SHP_NO
        FROM    (
                SELECT  
                        IO.INOUT_NO
                      , IO.INOUT_DT
                      , IO.INOUT_TY_CD
                      , IO.CALC_PRGS_CD
                      , IO.ORD_NO
                      , IO.IN_SHP_NO
                      , IO.OUT_SHP_NO
                FROM    CF14    IO
                WHERE   1 = 1
                AND     IO.INOUT_TY_CD  = '11'
                AND     IO.INOUT_DT BETWEEN :stDt AND :edDt
                ORDER BY
                        IO.INOUT_NO DESC
                )   IO
        WHERE   1 = 1
        )   IO
WHERE   1 = 1
AND     IO.RN BETWEEN (:pageNo - 1) * :pageSize + 1     -- 페이지시작조건
              AND :pageNo * :pageSize                   -- 페이지종료조건
;

-- 쿼리. 90

-- :stDt = 20230603
-- :edDt = 20230702
-- :pageNo = 1
-- :pageSize = 10

SELECT  
        IO.INOUT_NO
      , IO.INOUT_DT
      , IO.CALC_PRGS_CD
      , IO.IN_SHP_NO
      , IO.OUT_SHP_NO
FROM    (
        SELECT  
                ROWNUM  RN
              , IO.INOUT_NO
              , IO.INOUT_DT
              , IO.CALC_PRGS_CD
              , IO.IN_SHP_NO
              , IO.OUT_SHP_NO
        FROM    (
                SELECT  
                        IO.INOUT_NO
                      , IO.INOUT_DT
                      , IO.CALC_PRGS_CD
                      , IO.IN_SHP_NO
                      , IO.OUT_SHP_NO
                FROM    CF14    IO
                WHERE   1 = 1
                AND     IO.INOUT_TY_CD  = '11'
                AND     IO.INOUT_DT BETWEEN :stDt AND :edDt
                ORDER BY
                        IO.INOUT_NO DESC
                )   IO
        WHERE   1 = 1
        AND     ROWNUM <= :pageNo * :pageSize           -- 페이지종료조건
        )   IO
WHERE   1 = 1
AND     IO.RN >= (:pageNo - 1) * :pageSize + 1          -- 페이지시작조건
;

-- 쿼리. 91

SELECT  
        IOI.INOUT_NO
      , IOI.ITM_NO
      , IOI.INOUT_QTY
FROM    CF15    IOI
WHERE   1 = 1
AND     IOI.INOUT_NO = '2023062905'
;

-- 쿼리. 92

SELECT  
        IOI.INOUT_NO
      , MAX(IOI.ITM_NO)     ITM_NO
      , SUM(IOI.INOUT_QTY)  INOUT_QTY
      , COUNT(*)            INOUT_CNT
FROM    CF15    IOI
WHERE   1 = 1
AND     IOI.INOUT_NO = '2023062905'
GROUP BY
        IOI.INOUT_NO
;

-- 쿼리. 93

-- :stDt = 20230603
-- :edDt = 20230702
-- :pageNo = 1
-- :pageSize = 10

SELECT  
        IO.INOUT_NO
      , IO.INOUT_DT
      , IO.CALC_PRGS_CD
      , IO.IN_SHP_NO
      , IO.OUT_SHP_NO
      , IOI.ITM_NO
      , IOI.INOUT_QTY
      , IOI.INOUT_CNT
FROM    (
        SELECT  
                IO.INOUT_NO
              , IO.INOUT_DT
              , IO.CALC_PRGS_CD
              , IO.IN_SHP_NO
              , IO.OUT_SHP_NO
        FROM    (
                SELECT  
                        ROWNUM  RN
                      , IO.INOUT_NO
                      , IO.INOUT_DT
                      , IO.CALC_PRGS_CD
                      , IO.IN_SHP_NO
                      , IO.OUT_SHP_NO
                FROM    (
                        SELECT  
                                IO.INOUT_NO
                              , IO.INOUT_DT
                              , IO.CALC_PRGS_CD
                              , IO.IN_SHP_NO
                              , IO.OUT_SHP_NO
                        FROM    CF14    IO
                        WHERE   1 = 1
                        AND     IO.INOUT_TY_CD  = '11'
                        AND     IO.INOUT_DT BETWEEN :stDt AND :edDt
                        ORDER BY
                                IO.INOUT_NO DESC
                        )   IO
                WHERE   1 = 1
                AND     ROWNUM <= :pageNo * :pageSize           -- 페이지종료조건
                )   IO
        WHERE   1 = 1
        AND     IO.RN >= (:pageNo - 1) * :pageSize + 1          -- 페이지시작조건
        )   IO
      , (
        SELECT  
                IOI.INOUT_NO
              , MAX(IOI.ITM_NO)     ITM_NO
              , SUM(IOI.INOUT_QTY)  INOUT_QTY
              , COUNT(*)            INOUT_CNT
        FROM    CF15    IOI
        WHERE   1 = 1
        GROUP BY
                IOI.INOUT_NO
        )   IOI
      , CF01    I
      , CF07    S1
      , CF07    S2
      , CF16    CD
WHERE   1 = 1
AND     IOI.INOUT_NO = IO.INOUT_NO
AND     I.ITM_NO = IOI.ITM_NO
AND     S1.SHP_NO = IO.IN_SHP_NO
AND     S2.SHP_NO = IO.OUT_SHP_NO
AND     CD.CLS_CD = 'CALC_PRGS_CD'
AND     CD.CD = IO.CALC_PRGS_CD
ORDER BY
        IO.INOUT_NO DESC
;

-- 쿼리. 94

-- :stDt = 20230603
-- :edDt = 20230702
-- :pageNo = 1
-- :pageSize = 10

SELECT  
        IO.INOUT_NO
      , IO.INOUT_DT
      , CD.UNI_CD_NM
      , IO.OUT_SHP_NO
      , S2.SHP_NM       OUT_SHP_NO
      , IO.IN_SHP_NO
      , S1.SHP_NM       IN_SHP_NO
      , IOI.ITM_NO
      , I.ITM_NM || 
        CASE WHEN IOI.INOUT_CNT > 1 THEN ' 외 ' || (IOI.INOUT_CNT - 1) END   ITM_NM
      , IOI.INOUT_QTY
FROM    (
        SELECT  
                IO.INOUT_NO
              , IO.INOUT_DT
              , IO.CALC_PRGS_CD
              , IO.OUT_SHP_NO
              , IO.IN_SHP_NO
        FROM    (
                SELECT  
                        ROWNUM  RN
                      , IO.INOUT_NO
                      , IO.INOUT_DT
                      , IO.CALC_PRGS_CD
                      , IO.OUT_SHP_NO
                      , IO.IN_SHP_NO
                FROM    (
                        SELECT  
                                IO.INOUT_NO
                              , IO.INOUT_DT
                              , IO.CALC_PRGS_CD
                              , IO.OUT_SHP_NO
                              , IO.IN_SHP_NO
                        FROM    CF14    IO
                        WHERE   1 = 1
                        AND     IO.INOUT_TY_CD  = '11'
                        AND     IO.INOUT_DT BETWEEN :stDt AND :edDt
                        ORDER BY
                                IO.INOUT_NO DESC
                        )   IO
                WHERE   1 = 1
                AND     ROWNUM <= :pageNo * :pageSize           -- 페이지종료조건
                )   IO
        WHERE   1 = 1
        AND     IO.RN >= (:pageNo - 1) * :pageSize + 1          -- 페이지시작조건
        )   IO
      , (
        SELECT  
                IOI.INOUT_NO
              , MAX(IOI.ITM_NO)     ITM_NO
              , SUM(IOI.INOUT_QTY)  INOUT_QTY
              , COUNT(*)            INOUT_CNT
        FROM    CF15    IOI
        WHERE   1 = 1
        GROUP BY
                IOI.INOUT_NO
        )   IOI
      , CF01    I
      , CF07    S1
      , CF07    S2
      , CF16    CD
WHERE   1 = 1
AND     IOI.INOUT_NO = IO.INOUT_NO
AND     I.ITM_NO = IOI.ITM_NO
AND     S1.SHP_NO = IO.IN_SHP_NO
AND     S2.SHP_NO = IO.OUT_SHP_NO
AND     CD.CLS_CD = 'CALC_PRGS_CD'
AND     CD.CD = IO.CALC_PRGS_CD
ORDER BY
        IO.INOUT_NO DESC
;

-- 쿼리. 95

-- :stDt = 20230603
-- :edDt = 20230702

SELECT  
        COUNT(*)        TOT_CNT
FROM    CF14    IO
WHERE   1 = 1
AND     IO.INOUT_TY_CD  = '11'
AND     IO.INOUT_DT  BETWEEN :stDt AND :edDt
;

-- 쿼리. 96

SELECT  
        IO.INOUT_NO
      , IO.INOUT_DT
      , IO.CALC_PRGS_CD
      , IO.OUT_SHP_NO
      , IO.IN_SHP_NO
      , IOI.ITM_NO
      , IOI.INOUT_QTY
FROM    CF14    IO
      , CF15    IOI
WHERE   1 = 1
AND     IOI.INOUT_NO = IO.INOUT_NO
AND     IO.INOUT_TY_CD  = '11'          -- 출고
AND     IO.INOUT_NO = '2023062905'      -- 출고번호
ORDER BY
        IO.INOUT_NO DESC
      , IOI.ITM_NO
;

-- 쿼리. 97

-- :pageNo = 1
-- :pageSize = 10

SELECT  
        IO.RN
      , IO.INOUT_NO
      , IO.INOUT_DT
      , IO.CALC_PRGS_CD
      , IO.OUT_SHP_NO
      , IO.IN_SHP_NO
      , IO.ITM_NO
      , IO.INOUT_QTY
FROM    (
        SELECT  
                ROWNUM  RN
              , IO.INOUT_NO
              , IO.INOUT_DT
              , IO.CALC_PRGS_CD
              , IO.OUT_SHP_NO
              , IO.IN_SHP_NO
              , IO.ITM_NO
              , IO.INOUT_QTY
        FROM    (
                SELECT  
                        IO.INOUT_NO
                      , IO.INOUT_DT
                      , IO.CALC_PRGS_CD
                      , IO.OUT_SHP_NO
                      , IO.IN_SHP_NO
                      , IOI.ITM_NO
                      , IOI.INOUT_QTY
                FROM    CF14    IO
                      , CF15    IOI
                WHERE   1 = 1
                AND     IOI.INOUT_NO = IO.INOUT_NO
                AND     IO.INOUT_TY_CD  = '11'          -- 출고
                AND     IO.INOUT_NO = '2023062905'      -- 출고번호
                ORDER BY
                        IO.INOUT_NO DESC
                      , IOI.ITM_NO
                )   IO
        WHERE   1 = 1
        AND     ROWNUM <= :pageNo * :pageSize           -- 페이지종료조건
        )   IO
WHERE   1 = 1
AND     IO.RN >= (:pageNo - 1) * :pageSize + 1          -- 페이지시작조건
;

-- 쿼리. 98

-- :pageNo = 1
-- :pageSize = 10

SELECT  
        IO.INOUT_NO
      , IO.INOUT_DT
      , CD.UNI_CD_NM    CALC_PRGS_NM
      , IO.OUT_SHP_NO
      , S2.SHP_NM       OUT_SHP_NM
      , IO.IN_SHP_NO
      , S1.SHP_NM       IN_SHP_NM
      , IO.ITM_NO
      , I.ITM_NM
      , IO.INOUT_QTY
FROM    (
        SELECT  
                IO.RN
              , IO.INOUT_NO
              , IO.INOUT_DT
              , IO.CALC_PRGS_CD
              , IO.OUT_SHP_NO
              , IO.IN_SHP_NO
              , IO.ITM_NO
              , IO.INOUT_QTY
        FROM    (
                SELECT  
                        ROWNUM  RN
                      , IO.INOUT_NO
                      , IO.INOUT_DT
                      , IO.CALC_PRGS_CD
                      , IO.OUT_SHP_NO
                      , IO.IN_SHP_NO
                      , IO.ITM_NO
                      , IO.INOUT_QTY
                FROM    (
                        SELECT  
                                IO.INOUT_NO
                              , IO.INOUT_DT
                              , IO.CALC_PRGS_CD
                              , IO.OUT_SHP_NO
                              , IO.IN_SHP_NO
                              , IOI.ITM_NO
                              , IOI.INOUT_QTY
                        FROM    CF14    IO
                              , CF15    IOI
                        WHERE   1 = 1
                        AND     IOI.INOUT_NO = IO.INOUT_NO
                        AND     IO.INOUT_TY_CD  = '11'          -- 출고
                        AND     IO.INOUT_NO = '2023062905'      -- 출고번호
                        ORDER BY
                                IO.INOUT_NO DESC
                              , IOI.ITM_NO
                        )   IO
                WHERE   1 = 1
                AND     ROWNUM <= :pageNo * :pageSize           -- 페이지종료조건
                )   IO
        WHERE   1 = 1
        AND     IO.RN >= (:pageNo - 1) * :pageSize + 1          -- 페이지시작조건
        )   IO
      , CF01    I
      , CF07    S1
      , CF07    S2
      , CF16    CD
WHERE   1 = 1
AND     I.ITM_NO = IO.ITM_NO
AND     S1.SHP_NO = IO.IN_SHP_NO
AND     S2.SHP_NO = IO.OUT_SHP_NO
AND     CD.CLS_CD = 'CALC_PRGS_CD'
AND     CD.CD = IO.CALC_PRGS_CD
ORDER BY
        IO.INOUT_NO DESC
      , IO.ITM_NO
;

-- 쿼리. 99

-- :stDt = 20230603
-- :edDt = 20230702
-- :pageNo = 1
-- :pageSize = 10

SELECT  
        IO.INOUT_NO
      , IO.INOUT_DT
      , CD.UNI_CD_NM    CALC_PRGS_NM
      , IO.OUT_SHP_NO
      , S2.SHP_NM       OUT_SHP_NM
      , IO.IN_SHP_NO
      , S1.SHP_NM       IN_SHP_NM
      , IO.ITM_NO
      , I.ITM_NM
      , IO.INOUT_QTY
FROM    (
        SELECT  
                IO.RN
              , IO.INOUT_NO
              , IO.INOUT_DT
              , IO.CALC_PRGS_CD
              , IO.OUT_SHP_NO
              , IO.IN_SHP_NO
              , IO.ITM_NO
              , IO.INOUT_QTY
        FROM    (
                SELECT  
                        ROWNUM  RN
                      , IO.INOUT_NO
                      , IO.INOUT_DT
                      , IO.CALC_PRGS_CD
                      , IO.OUT_SHP_NO
                      , IO.IN_SHP_NO
                      , IO.ITM_NO
                      , IO.INOUT_QTY
                FROM    (
                        SELECT  
                                IO.INOUT_NO
                              , IO.INOUT_DT
                              , IO.CALC_PRGS_CD
                              , IO.OUT_SHP_NO
                              , IO.IN_SHP_NO
                              , IOI.ITM_NO
                              , IOI.INOUT_QTY
                        FROM    CF14    IO
                              , CF15    IOI
                        WHERE   1 = 1
                        AND     IOI.INOUT_NO = IO.INOUT_NO
                        AND     IO.INOUT_TY_CD  = '11'
                        AND     IO.INOUT_DT BETWEEN :stDt AND :edDt    -- 최종변수처리
                        ORDER BY
                                IO.INOUT_NO DESC
                              , IOI.ITM_NO
                        )   IO
                WHERE   1 = 1
                AND     ROWNUM <= :pageNo * :pageSize           -- 페이지종료조건
                )   IO
        WHERE   1 = 1
        AND     IO.RN >= (:pageNo - 1) * :pageSize + 1          -- 페이지시작조건
        )   IO
      , CF01    I
      , CF07    S1
      , CF07    S2
      , CF16    CD
WHERE   1 = 1
AND     I.ITM_NO = IO.ITM_NO
AND     S1.SHP_NO = IO.IN_SHP_NO
AND     S2.SHP_NO = IO.OUT_SHP_NO
AND     CD.CLS_CD = 'CALC_PRGS_CD'
AND     CD.CD = IO.CALC_PRGS_CD
ORDER BY
        IO.INOUT_NO DESC
      , IO.ITM_NO
;

-- 쿼리. 100

-- :stDt = 20230603
-- :edDt = 20230702

SELECT  
        COUNT(*)    TOT_CNT
FROM    CF14    IO
      , CF15    IOI
WHERE   1 = 1
AND     IOI.INOUT_NO = IO.INOUT_NO
AND     IO.INOUT_TY_CD  = '11'
AND     IO.INOUT_DT  BETWEEN :stDt AND :edDt
;

-- 쿼리. 101

SELECT  
        S.SLE_NO
      , S.SLE_DT
      , S.SLE_HMS
      , S.SLE_DOW
      , S.SHP_NO
FROM    CF10    S
WHERE   1 = 1
AND     SLE_DT = '20230702'
AND     SLE_HMS LIKE '10%'
ORDER BY
        S.SLE_NO DESC
;

-- 쿼리. 102

-- :pageNo = 1
-- :pageSize = 10

SELECT  
        S.SLE_NO
      , S.SLE_DT
      , S.SLE_HMS
      , S.SLE_DOW
      , S.SHP_NO
FROM    CF10    S
WHERE   1 = 1
AND     SLE_DT = '20230702'
AND     SLE_HMS LIKE '10%'
ORDER BY
        S.SLE_NO DESC
OFFSET (:pageNo - 1) * :pageSize ROWS      -- 페이지시작조건
FETCH NEXT :pageSize ROWS ONLY             -- 페이지종료조건
;

-- 쿼리. 103

SELECT  
        SI.SLE_NO
      , MAX(SI.ITM_NO)      ITM_NO
      , SUM(SI.SLE_QTY)     SLE_QTY
      , SUM(SI.SLE_QTY * SI.SLE_UPRC)   SLE_AMT
      , COUNT(*)            SLE_CNT
FROM    CF11    SI
WHERE   1 = 1
AND     SLE_NO = '20230702-0070'
GROUP BY
        SI.SLE_NO
;

-- 쿼리. 104

SELECT  
        컬럼목록
FROM    (
        페이징쿼리
        )    S
      , (
        그룹바이쿼리
        )    SI
      , CF01    I
      , CF07    SH
WHERE   1 = 1
AND     SI.SLE_NO = S.SLE_NO
AND     I.ITM_NO = SI.ITM_NO
AND     SH.SHP_NO = S.SHP_NO
;

-- 쿼리. 105

SELECT
        S.SLE_NO
      , S.SLE_DT
      , S.SLE_HMS
      , CASE
            WHEN S.SLE_DOW = '1' THEN '일'
            WHEN S.SLE_DOW = '2' THEN '월'
            WHEN S.SLE_DOW = '3' THEN '화'
            WHEN S.SLE_DOW = '4' THEN '수'
            WHEN S.SLE_DOW = '5' THEN '목'
            WHEN S.SLE_DOW = '6' THEN '금'
            WHEN S.SLE_DOW = '7' THEN '토'
        END     SLE_DOW
      , S.SHP_NO
      , SH.SHP_NM
      , SI.ITM_NO
      , I.ITM_NM ||
        CASE WHEN SI.SLE_CNT > 1 THEN '외 ' || (SI.SLE_CNT - 1) END  ITM_NM
      , SI.SLE_QTY
      , SI.SLE_AMT
FROM    (
        SELECT  
                S.SLE_NO
              , S.SLE_DT
              , S.SLE_HMS
              , S.SLE_DOW
              , S.SHP_NO
        FROM    CF10    S
        WHERE   1 = 1
        AND     SLE_DT = '20230702'
        AND     SLE_HMS LIKE '10%'
        ORDER BY
                S.SLE_NO DESC
        OFFSET  (:pageNo - 1) * :pageSize ROWS      -- 페이지시작조건
        FETCH NEXT :pageSize ROWS ONLY              -- 페이지종료조건
        )   S
      , (
        SELECT  
                SI.SLE_NO
              , MAX(SI.ITM_NO)      ITM_NO
              , SUM(SI.SLE_QTY)     SLE_QTY
              , SUM(SI.SLE_QTY * SI.SLE_UPRC)   SLE_AMT
              , COUNT(*)            SLE_CNT
        FROM    CF11    SI
        WHERE   1 = 1
        GROUP BY
                SI.SLE_NO
        )   SI
      , CF01    I
      , CF07    SH
WHERE   1 = 1
AND     SI.SLE_NO = S.SLE_NO
AND     I.ITM_NO = SI.ITM_NO
AND     SH.SHP_NO = S.SHP_NO
ORDER BY
        S.SLE_NO DESC
;

-- 쿼리. 106

-- :stDt = 20230603
-- :edDt = 20230702
-- :pageNo = 1
-- :pageSize = 10

SELECT
        S.SLE_NO
      , S.SLE_DT
      , S.SLE_HMS
      , CASE
            WHEN S.SLE_DOW = '1' THEN '일'
            WHEN S.SLE_DOW = '2' THEN '월'
            WHEN S.SLE_DOW = '3' THEN '화'
            WHEN S.SLE_DOW = '4' THEN '수'
            WHEN S.SLE_DOW = '5' THEN '목'
            WHEN S.SLE_DOW = '6' THEN '금'
            WHEN S.SLE_DOW = '7' THEN '토'
        END     SLE_DOW
      , S.SHP_NO
      , SH.SHP_NM
      , SI.ITM_NO
      , I.ITM_NM ||
        CASE WHEN SI.SLE_CNT > 1 THEN '외 ' || (SI.SLE_CNT - 1) END  ITM_NM
      , SI.SLE_QTY
      , SI.SLE_AMT
FROM    (
        SELECT  
                S.SLE_NO
              , S.SLE_DT
              , S.SLE_HMS
              , S.SLE_DOW
              , S.SHP_NO
        FROM    CF10    S
        WHERE   1 = 1
        AND     S.SLE_DT BETWEEN :stDt AND :edDt    -- 최종변수처리
        ORDER BY
                S.SLE_NO DESC
        OFFSET  (:pageNo - 1) * :pageSize ROWS      -- 페이지시작조건
        FETCH NEXT :pageSize ROWS ONLY              -- 페이지종료조건
        )   S
      , (
        SELECT  
                SI.SLE_NO
              , MAX(SI.ITM_NO)      ITM_NO
              , SUM(SI.SLE_QTY)     SLE_QTY
              , SUM(SI.SLE_QTY * SI.SLE_UPRC)   SLE_AMT
              , COUNT(*)            SLE_CNT
        FROM    CF11    SI
        WHERE   1 = 1
        GROUP BY
                SI.SLE_NO
        )   SI
      , CF01    I
      , CF07    SH
WHERE   1 = 1
AND     SI.SLE_NO = S.SLE_NO
AND     I.ITM_NO = SI.ITM_NO
AND     SH.SHP_NO = S.SHP_NO
ORDER BY
        S.SLE_NO DESC
;

-- 쿼리. 107

-- :stDt = 20230603
-- :edDt = 20230702

SELECT  
        COUNT(*)    TOT_CNT
FROM    CF10    S
WHERE   1 = 1
AND     S.SLE_DT BETWEEN :stDt AND :edDt
;

-- 쿼리. 108

SELECT  
        S.SLE_NO
      , S.SLE_DT
      , S.SLE_HMS
      , S.SLE_DOW
      , S.SHP_NO
      , SI.ITM_NO
      , SI.SLE_QTY
      , SI.SLE_UPRC
      , SI.SLE_QTY * SLE_UPRC   SLE_AMT
FROM    CF10    S
      , CF11    SI
WHERE   1 = 1
AND     SI.SLE_NO = S.SLE_NO
AND     SLE_DT = '20230702'
AND     SLE_HMS LIKE '10%'
ORDER BY
        S.SLE_NO DESC
      , SI.ITM_NO
;

-- 쿼리. 109

-- :pageNo = 1
-- :pageSize = 10

SELECT  
        S.SLE_NO
      , S.SLE_DT
      , S.SLE_HMS
      , S.SLE_DOW
      , S.SHP_NO
      , SI.ITM_NO
      , SI.SLE_QTY
      , SI.SLE_UPRC
      , SI.SLE_QTY * SLE_UPRC   SLE_AMT
FROM    CF10    S
      , CF11    SI
WHERE   1 = 1
AND     SI.SLE_NO = S.SLE_NO
AND     SLE_DT = '20230702'
AND     SLE_HMS LIKE '10%'
ORDER BY
        S.SLE_NO DESC
      , SI.ITM_NO
OFFSET (:pageNo - 1) * :pageSize ROWS       -- 페이지시작조건
FETCH NEXT :pageSize ROWS ONLY              -- 페이지종료조건
;

-- 쿼리. 110

SELECT  
        컬럼목록
FROM    (
        페이징쿼리
        )   S
      , CF01    I
      , CF07    SH
WHERE   1 = 1
AND     I.ITM_NO = SI.ITM_NO
AND     SH.SHP_NO = S.SHP_NO
;

-- 쿼리. 111

-- :pageNo = 1
-- :pageSize = 10

SELECT  
        S.SLE_NO
      , S.SLE_DT
      , S.SLE_HMS
      , CASE
            WHEN S.SLE_DOW = '1' THEN '일'
            WHEN S.SLE_DOW = '2' THEN '월'
            WHEN S.SLE_DOW = '3' THEN '화'
            WHEN S.SLE_DOW = '4' THEN '수'
            WHEN S.SLE_DOW = '5' THEN '목'
            WHEN S.SLE_DOW = '6' THEN '금'
            WHEN S.SLE_DOW = '7' THEN '토'
        END     SLE_DOW
      , S.SHP_NO
      , SH.SHP_NM
      , S.ITM_NO
      , I.ITM_NM
      , S.SLE_QTY
      , S.SLE_UPRC
      , S.SLE_AMT
FROM    (
        SELECT  
                S.SLE_NO
              , S.SLE_DT
              , S.SLE_HMS
              , S.SLE_DOW
              , S.SHP_NO
              , SI.ITM_NO
              , SI.SLE_QTY
              , SI.SLE_UPRC
              , SI.SLE_QTY * SLE_UPRC   SLE_AMT
        FROM    CF10    S
              , CF11    SI
        WHERE   1 = 1
        AND     SI.SLE_NO = S.SLE_NO
        AND     SLE_DT = '20230702'
        AND     SLE_HMS LIKE '10%'
        ORDER BY
                S.SLE_NO DESC
              , SI.ITM_NO
        OFFSET  (:pageNo - 1) * :pageSize ROWS      -- 페이지시작조건
        FETCH NEXT :pageSize ROWS ONLY              -- 페이지종료조건
        )    S
      , CF01    I
      , CF07    SH
WHERE   1 = 1
AND     I.ITM_NO = S.ITM_NO
AND     SH.SHP_NO = S.SHP_NO
;

-- 쿼리. 112

-- :stDt = 20230603
-- :edDt = 20230702
-- :pageNo = 1
-- :pageSize = 10

SELECT  
        S.SLE_NO
      , S.SLE_DT
      , S.SLE_HMS
      , CASE
            WHEN S.SLE_DOW = '1' THEN '일'
            WHEN S.SLE_DOW = '2' THEN '월'
            WHEN S.SLE_DOW = '3' THEN '화'
            WHEN S.SLE_DOW = '4' THEN '수'
            WHEN S.SLE_DOW = '5' THEN '목'
            WHEN S.SLE_DOW = '6' THEN '금'
            WHEN S.SLE_DOW = '7' THEN '토'
        END     SLE_DOW
      , S.SHP_NO
      , SH.SHP_NM
      , S.ITM_NO
      , I.ITM_NM
      , S.SLE_QTY
      , S.SLE_UPRC
      , S.SLE_AMT
FROM    (
        SELECT  
                S.SLE_NO
              , S.SLE_DT
              , S.SLE_HMS
              , S.SLE_DOW
              , S.SHP_NO
              , SI.ITM_NO
              , SI.SLE_QTY
              , SI.SLE_UPRC
              , SI.SLE_QTY * SLE_UPRC   SLE_AMT
        FROM    CF10    S
              , CF11    SI
        WHERE   1 = 1
        AND     SI.SLE_NO = S.SLE_NO
        AND     S.SLE_DT BETWEEN :stDt AND :edDt    -- 최종변수처리
        ORDER BY
                S.SLE_NO DESC
              , SI.ITM_NO
        OFFSET  (:pageNo - 1) * :pageSize ROWS      -- 페이지시작조건
        FETCH NEXT :pageSize ROWS ONLY              -- 페이지종료조건
        )    S
      , CF01    I
      , CF07    SH
WHERE   1 = 1
AND     I.ITM_NO = S.ITM_NO
AND     SH.SHP_NO = S.SHP_NO
;

-- 쿼리. 113

-- :stDt = 20230603
-- :edDt = 20230702

SELECT  
        COUNT(*)    TOT_CNT
FROM    CF10    S
      , CF11    SI
WHERE   1 = 1
AND     SI.SLE_NO = S.SLE_NO
AND     S.SLE_DT BETWEEN :stDt AND :edDt
;

-- 쿼리. 114

-- :stDt = 20230601
-- :edDt = 20230630

SELECT  
        O.PTNR_NO
      , SUM(OI.ORD_QTY) SUM_QTY
      , SUM(OI.ORD_QTY * OI.ORD_UPRC)   SUM_AMT
FROM    CF12    O
      , CF13    OI
WHERE   1 = 1
AND     O.ORD_NO = OI.ORD_NO
AND     O.ORD_DT BETWEEN :stDt AND :edDt
GROUP BY
        O.PTNR_NO
ORDER BY
        O.PTNR_NO
;

-- 쿼리. 115

-- :stDt = 20230601
-- :edDt = 20230630

SELECT  
        O.PTNR_NO
      , P.PTNR_NM
      , O.SUM_QTY
      , O.SUM_AMT
FROM    (
        SELECT  
                O.PTNR_NO
              , SUM(OI.ORD_QTY) SUM_QTY
              , SUM(OI.ORD_QTY * OI.ORD_UPRC)   SUM_AMT
        FROM    CF12    O
              , CF13    OI
        WHERE   1 = 1
        AND     O.ORD_NO = OI.ORD_NO
        AND     O.ORD_DT BETWEEN :stDt AND :edDt
        GROUP BY
                O.PTNR_NO
        )   O
      , CF06    P
WHERE   1 = 1
AND     P.PTNR_NO = O.PTNR_NO
ORDER BY
        O.PTNR_NO
;

-- 쿼리. 116

-- :stDt = 20230601
-- :edDt = 20230630

SELECT  
        S.SHP_NO
      , SUM(SI.SLE_QTY) SUM_QTY
      , SUM(SI.SLE_QTY * SI.SLE_UPRC)   SUM_AMT
FROM    CF10    S
      , CF11    SI
WHERE   1 = 1
AND     S.SLE_NO = SI.SLE_NO
AND     S.SLE_DT BETWEEN :stDt AND :edDt
GROUP BY
        S.SHP_NO
ORDER BY
        S.SHP_NO
;

-- 쿼리. 117

-- :stDt = 20230601
-- :edDt = 20230630

SELECT  
        S.SHP_NO
      , SH.SHP_NM
      , S.SUM_QTY
      , S.SUM_AMT
FROM    (
        SELECT  
                S.SHP_NO
              , SUM(SI.SLE_QTY) SUM_QTY
              , SUM(SI.SLE_QTY * SI.SLE_UPRC)   SUM_AMT
        FROM    CF10    S
              , CF11    SI
        WHERE   1 = 1
        AND     S.SLE_NO = SI.SLE_NO
        AND     S.SLE_DT BETWEEN :stDt AND :edDt
        GROUP BY
                S.SHP_NO
        )   S
      , CF07    SH
WHERE   1 = 1
AND     SH.SHP_NO = S.SHP_NO
ORDER BY
        S.SHP_NO
;

-- 쿼리. 118

-- :stDt = 20230601
-- :edDt = 20230630

SELECT  
        O.ORD_DT
      , OI.ITM_NO
      , SUM(OI.ORD_QTY) SUM_QTY
      , SUM(OI.ORD_QTY * OI.ORD_UPRC)   SUM_AMT
FROM    CF12    O
      , CF13    OI
WHERE   1 = 1
AND     O.ORD_NO = OI.ORD_NO
AND     O.ORD_DT BETWEEN :stDt AND :edDt
AND     O.PTNR_NO = 1000            -- 결과건수 제어를 위한 변수
GROUP BY
        O.ORD_DT
      , OI.ITM_NO
ORDER BY
        O.ORD_DT
      , OI.ITM_NO
;

-- 쿼리. 119

-- :stDt = 20230601
-- :edDt = 20230630

SELECT  
        O.ORD_DT
      , O.ITM_NO
      , I.ITM_NM
      , O.SUM_QTY
      , O.SUM_AMT
FROM    (
        SELECT  
                O.ORD_DT
              , OI.ITM_NO
              , SUM(OI.ORD_QTY) SUM_QTY
              , SUM(OI.ORD_QTY * OI.ORD_UPRC)   SUM_AMT
        FROM    CF12    O
              , CF13    OI
        WHERE   1 = 1
        AND     O.ORD_NO = OI.ORD_NO
        AND     O.ORD_DT BETWEEN :stDt AND :edDt
        AND     O.PTNR_NO = 1000        -- 결과건수 제어를 위한 변수
        GROUP BY
                O.ORD_DT
              , OI.ITM_NO
        )   O
      , CF01    I
WHERE   1 = 1
AND     I.ITM_NO = O.ITM_NO
ORDER BY
        O.ORD_DT
      , O.ITM_NO
;

-- 쿼리. 120

-- :stDt = 20230601
-- :edDt = 20230630

SELECT  
        O.ORD_DT
      , O.ITM_NO
      , I.ITM_NM
      , O.SUM_QTY
      , O.SUM_AMT
FROM    (
        SELECT  
                O.ORD_DT
              , OI.ITM_NO
              , SUM(OI.ORD_QTY) SUM_QTY
              , SUM(OI.ORD_QTY * OI.ORD_UPRC)   SUM_AMT
        FROM    CF12    O
              , CF13    OI
        WHERE   1 = 1
        AND     O.ORD_NO = OI.ORD_NO
        AND     O.ORD_DT BETWEEN :stDt AND :edDt
        AND     O.PTNR_NO = 1000        -- 결과건수 제어를 위한 변수
        GROUP BY ROLLUP (
                O.ORD_DT
              , OI.ITM_NO
                )
        )   O
      , CF01    I
WHERE   1 = 1
AND     I.ITM_NO(+) = O.ITM_NO
ORDER BY
        O.ORD_DT
      , O.ITM_NO
;

-- 쿼리. 121

-- :stDt = 20230601
-- :edDt = 20230630

SELECT  
        CASE
            WHEN O.GDT_NO = 1 AND O.GITM_NO = 1 THEN SUBSTR(:stDt,1,6)
            ELSE O.ORD_DT
        END     ORD_DT
      , O.ITM_NO
      , CASE
            WHEN O.GDT_NO = 0 AND O.GITM_NO = 1 THEN '소계'
            WHEN O.GDT_NO = 1 AND O.GITM_NO = 1 THEN '합계'
            ELSE I.ITM_NM
        END     ITM_NM
      , O.SUM_QTY
      , O.SUM_AMT
FROM    (
        SELECT  
                O.ORD_DT
              , OI.ITM_NO
              , SUM(OI.ORD_QTY) SUM_QTY
              , SUM(OI.ORD_QTY * OI.ORD_UPRC)   SUM_AMT
              , GROUPING(ORD_DT) GDT_NO
              , GROUPING(ITM_NO) GITM_NO
        FROM    CF12    O
              , CF13    OI
        WHERE   1 = 1
        AND     O.ORD_NO = OI.ORD_NO
        AND     O.ORD_DT BETWEEN :stDt AND :edDt
        AND     O.PTNR_NO = 1000        -- 결과건수 제어를 위한 변수
        GROUP BY ROLLUP (
                O.ORD_DT
              , OI.ITM_NO
                )
        )   O
      , CF01    I
WHERE   1 = 1
AND     I.ITM_NO(+) = O.ITM_NO
ORDER BY
        O.ORD_DT
      , O.ITM_NO
;

-- 쿼리. 122

-- :stDt = 20230601
-- :edDt = 20230630

SELECT  
        CASE
            WHEN O.GDT_NO = 1 AND O.GITM_NO = 1 THEN SUBSTR(:stDt,1,6)
            ELSE O.ORD_DT
        END     ORD_DT
      , O.ITM_NO
      , CASE
            WHEN O.GDT_NO = 0 AND O.GITM_NO = 1 THEN '소계'
            WHEN O.GDT_NO = 1 AND O.GITM_NO = 1 THEN '합계'
            ELSE I.ITM_NM
        END     ITM_NM
      , O.SUM_QTY
      , O.SUM_AMT
FROM    (
        SELECT  
                O.ORD_DT
              , OI.ITM_NO
              , SUM(OI.ORD_QTY) SUM_QTY
              , SUM(OI.ORD_QTY * OI.ORD_UPRC)   SUM_AMT
              , GROUPING(ORD_DT) GDT_NO
              , GROUPING(ITM_NO) GITM_NO
        FROM    CF12    O
              , CF13    OI
        WHERE   1 = 1
        AND     O.ORD_NO = OI.ORD_NO
        AND     O.ORD_DT BETWEEN :stDt AND :edDt
        AND     O.PTNR_NO = 1000        -- 결과건수 제어를 위한 변수
        GROUP BY ROLLUP ((
                O.ORD_DT
              , OI.ITM_NO
                ))
        )   O
      , CF01    I
WHERE   1 = 1
AND     I.ITM_NO(+) = O.ITM_NO
ORDER BY
        O.ORD_DT
      , O.ITM_NO
;

-- 쿼리. 123

-- :stDt = 20230601
-- :edDt = 20230630

SELECT  
        IO.INOUT_DT
      , IOI.ITM_NO
      , SUM(IOI.INOUT_QTY) SUM_QTY
FROM    CF14    IO
      , CF15    IOI
WHERE   1 = 1
AND     IO.INOUT_NO = IOI.INOUT_NO
AND     IO.INOUT_TY_CD = '10'
AND     IO.INOUT_DT BETWEEN :stDt AND :edDt
GROUP BY
        IO.INOUT_DT
      , IOI.ITM_NO
ORDER BY
        IO.INOUT_DT
      , IOI.ITM_NO
;

-- 쿼리. 124

-- :stDt = 20230601
-- :edDt = 20230630

SELECT  
        IO.INOUT_DT
      , IO.ITM_NO
      , I.ITM_NM
      , IO.SUM_QTY
FROM    (
        SELECT  
                IO.INOUT_DT
              , IOI.ITM_NO
              , SUM(IOI.INOUT_QTY) SUM_QTY
        FROM    CF14    IO
              , CF15    IOI
        WHERE   1 = 1
        AND     IO.INOUT_NO = IOI.INOUT_NO
        AND     IO.INOUT_TY_CD = '10'
        AND     IO.INOUT_DT BETWEEN :stDt AND :edDt
        GROUP BY
                IO.INOUT_DT
              , IOI.ITM_NO
        )   IO
      , CF01    I
WHERE   1 = 1
AND     I.ITM_NO = IO.ITM_NO
ORDER BY
        IO.INOUT_DT
      , IO.ITM_NO
;

-- 쿼리. 125

-- :stDt = 20230601
-- :edDt = 20230630

SELECT  
        CASE
            WHEN IO.GDT_NO = 1 AND IO.GITM_NO = 1 THEN SUBSTR(:stDt,1,6)
            ELSE IO.INOUT_DT
        END     INOUT_DT
      , IO.ITM_NO
      , CASE
            WHEN IO.GDT_NO = 0 AND IO.GITM_NO = 1 THEN '소계'
            WHEN IO.GDT_NO = 1 AND IO.GITM_NO = 1 THEN '합계'
            ELSE I.ITM_NM
        END     ITM_NM
      , IO.SUM_QTY
FROM    (
        SELECT  
                IO.INOUT_DT
              , IOI.ITM_NO
              , SUM(IOI.INOUT_QTY) SUM_QTY
              , GROUPING(IO.INOUT_DT) GDT_NO
              , GROUPING(IOI.ITM_NO) GITM_NO
        FROM    CF14    IO
              , CF15    IOI
        WHERE   1 = 1
        AND     IO.INOUT_NO = IOI.INOUT_NO
        AND     IO.INOUT_TY_CD = '10'
        AND     IO.INOUT_DT BETWEEN :stDt AND :edDt
        GROUP BY ROLLUP ((
                IO.INOUT_DT
              , IOI.ITM_NO
                ))
        )   IO
      , CF01    I
WHERE   1 = 1
AND     I.ITM_NO(+) = IO.ITM_NO
ORDER BY
        IO.INOUT_DT
      , IO.ITM_NO
;

-- 쿼리. 126

-- :stDt = 20230601
-- :edDt = 20230602

SELECT  
        S.SLE_DT
      , SI.ITM_NO
      , SUM(SI.SLE_QTY) SUM_QTY
      , SUM(SI.SLE_QTY * SI.SLE_UPRC)   SUM_AMT
FROM    CF10    S
      , CF11    SI
WHERE   1 = 1
AND     S.SLE_NO = SI.SLE_NO
AND     S.SLE_DT BETWEEN :stDt AND :edDt
GROUP BY
        S.SLE_DT
      , SI.ITM_NO
ORDER BY
        S.SLE_DT
      , SI.ITM_NO
;

-- 쿼리. 127

-- :stDt = 20230601
-- :edDt = 20230602

SELECT
        S.SLE_DT
      , S.ITM_NO
      , I.ITM_NM
      , S.SUM_QTY
      , S.SUM_AMT
FROM    (
        SELECT  
                S.SLE_DT
              , SI.ITM_NO
              , SUM(SI.SLE_QTY) SUM_QTY
              , SUM(SI.SLE_QTY * SI.SLE_UPRC)   SUM_AMT
        FROM    CF10    S
              , CF11    SI
        WHERE   1 = 1
        AND     S.SLE_NO = SI.SLE_NO
        AND     S.SLE_DT BETWEEN :stDt AND :edDt
        GROUP BY
                S.SLE_DT
              , SI.ITM_NO
        )   S
      , CF01    I
WHERE   1 = 1
AND     I.ITM_NO = S.ITM_NO
ORDER BY
        S.SLE_DT
      , S.ITM_NO
;

-- 쿼리. 128

-- :stDt = 20230601
-- :edDt = 20230602

SELECT
        CASE
            WHEN S.GDT_NO = 1 AND S.GITM_NO = 1 THEN SUBSTR(:stDt,1,6)
            ELSE S.SLE_DT
        END     SLE_DT
      , S.ITM_NO
      , CASE
            WHEN S.GDT_NO = 0 AND S.GITM_NO = 1 THEN '소계'
            WHEN S.GDT_NO = 1 AND S.GITM_NO = 1 THEN '합계'
            ELSE I.ITM_NM
        END     ITM_NM
      , S.SUM_QTY
      , S.SUM_AMT
FROM    (
        SELECT  
                S.SLE_DT
              , SI.ITM_NO
              , SUM(SI.SLE_QTY) SUM_QTY
              , SUM(SI.SLE_QTY * SI.SLE_UPRC)   SUM_AMT
              , GROUPING(S.SLE_DT) GDT_NO
              , GROUPING(SI.ITM_NO) GITM_NO
        FROM    CF10    S
              , CF11    SI
        WHERE   1 = 1
        AND     S.SLE_NO = SI.SLE_NO
        AND     S.SLE_DT BETWEEN :stDt AND :edDt
        GROUP BY ROLLUP ((
                S.SLE_DT
              , SI.ITM_NO
                ))
        )   S
      , CF01    I
WHERE   1 = 1
AND     I.ITM_NO(+) = S.ITM_NO
ORDER BY
        S.SLE_DT
      , S.ITM_NO
;

-- 쿼리. 129

-- :stDt = 20230601
-- :edDt = 20230602

SELECT
        CASE
            WHEN S.GDT_NO = 1 AND S.GITM_NO = 1 THEN SUBSTR(:stDt,1,6)
            ELSE S.SLE_DT
        END     SLE_DT
      , S.ITM_NO
      , CASE
            WHEN S.GDT_NO = 0 AND S.GITM_NO = 1 THEN '소계'
            WHEN S.GDT_NO = 1 AND S.GITM_NO = 1 THEN '합계'
            ELSE I.ITM_NM
        END     ITM_NM
      , S.SUM_QTY
      , S.SUM_AMT
      , S.QTY_RNK
      , S.AMT_RNK
FROM    (
        SELECT  
                S.SLE_DT
              , SI.ITM_NO
              , SUM(SI.SLE_QTY) SUM_QTY
              , SUM(SI.SLE_QTY * SI.SLE_UPRC)   SUM_AMT
              , GROUPING(S.SLE_DT) GDT_NO
              , GROUPING(SI.ITM_NO) GITM_NO
              , RANK() OVER(PARTITION BY S.SLE_DT ORDER BY SUM(SI.SLE_QTY) DESC) QTY_RNK
              , RANK() OVER(PARTITION BY S.SLE_DT 
                            ORDER BY SUM(SI.SLE_QTY * SI.SLE_UPRC) DESC) AMT_RNK
        FROM    CF10    S
              , CF11    SI
        WHERE   1 = 1
        AND     S.SLE_NO = SI.SLE_NO
        AND     S.SLE_DT BETWEEN :stDt AND :edDt
        GROUP BY ROLLUP (
                S.SLE_DT
              , SI.ITM_NO
                )
        )   S
      , CF01    I
WHERE   1 = 1
AND     I.ITM_NO(+) = S.ITM_NO
ORDER BY
        S.SLE_DT
      , S.ITM_NO
;

-- 쿼리. 130

-- :stDt = 20230601
-- :edDt = 20230602

SELECT
        CASE
            WHEN S.GDT_NO = 1 AND S.GITM_NO = 1 THEN SUBSTR(:stDt,1,6)
            ELSE S.SLE_DT
        END     SLE_DT
      , S.ITM_NO
      , CASE
            WHEN S.GDT_NO = 0 AND S.GITM_NO = 1 THEN '소계'
            WHEN S.GDT_NO = 1 AND S.GITM_NO = 1 THEN '합계'
            ELSE I.ITM_NM
        END     ITM_NM
      , S.SUM_QTY
      , S.SUM_AMT
      , CASE
            WHEN S.GITM_NO = 0
                THEN RANK() OVER(PARTITION BY S.SLE_DT ORDER BY SUM_QTY DESC)
        END   QTY_RNK
      , CASE
            WHEN S.GITM_NO = 0
                THEN RANK() OVER(PARTITION BY S.SLE_DT ORDER BY SUM_AMT DESC)
        END   AMT_RNK
FROM    (
        SELECT  
                S.SLE_DT
              , SI.ITM_NO
              , SUM(SI.SLE_QTY) SUM_QTY
              , SUM(SI.SLE_QTY * SI.SLE_UPRC)   SUM_AMT
              , GROUPING(S.SLE_DT) GDT_NO
              , GROUPING(SI.ITM_NO) GITM_NO
        FROM    CF10    S
              , CF11    SI
        WHERE   1 = 1
        AND     S.SLE_NO = SI.SLE_NO
        AND     S.SLE_DT BETWEEN :stDt AND :edDt
        GROUP BY ROLLUP (
                S.SLE_DT
              , SI.ITM_NO
                )
        )   S
      , CF01    I
WHERE   1 = 1
AND     I.ITM_NO(+) = S.ITM_NO
ORDER BY
        S.SLE_DT
      , S.ITM_NO
;

-- 쿼리. 131

-- :stDt = 20230601
-- :edDt = 20230602

SELECT
        CASE
            WHEN S.GDT_NO = 1 AND S.GITM_NO = 1 THEN SUBSTR(:stDt,1,6)
            ELSE S.SLE_DT
        END     SLE_DT
      , S.ITM_NO
      , CASE
            WHEN S.GDT_NO = 0 AND S.GITM_NO = 1 THEN '소계'
            WHEN S.GDT_NO = 1 AND S.GITM_NO = 1 THEN '합계'
            ELSE I.ITM_NM
        END     ITM_NM
      , S.SUM_QTY
      , S.SUM_AMT
      , S.QTY_RNK
      , S.AMT_RNK
      , S.GDT_NO
      , S.GITM_NO
FROM    (
        SELECT  
                S.SLE_DT
              , SI.ITM_NO
              , SUM(SI.SLE_QTY) SUM_QTY
              , SUM(SI.SLE_QTY * SI.SLE_UPRC)   SUM_AMT
              , GROUPING(S.SLE_DT) GDT_NO
              , GROUPING(SI.ITM_NO) GITM_NO
              , RANK() OVER(PARTITION BY S.SLE_DT, GROUPING(SI.ITM_NO)      -- 항목추가
                            ORDER BY SUM(SI.SLE_QTY) DESC) QTY_RNK
              , RANK() OVER(PARTITION BY S.SLE_DT, GROUPING(SI.ITM_NO)      -- 항목추가
                            ORDER BY SUM(SI.SLE_QTY * SI.SLE_UPRC) DESC) AMT_RNK
        FROM    CF10    S
              , CF11    SI
        WHERE   1 = 1
        AND     S.SLE_NO = SI.SLE_NO
        AND     S.SLE_DT BETWEEN :stDt AND :edDt
        GROUP BY ROLLUP (
                S.SLE_DT
              , SI.ITM_NO
                )
        )   S
      , CF01    I
WHERE   1 = 1
AND     I.ITM_NO(+) = S.ITM_NO
ORDER BY
        S.SLE_DT
      , S.ITM_NO
;

-- 쿼리. 132

-- :stDt = 20230601
-- :edDt = 20230602

SELECT
        CASE
            WHEN S.GDT_NO = 1 AND S.GITM_NO = 1 THEN SUBSTR(:stDt,1,6)
            ELSE S.SLE_DT
        END     SLE_DT
      , S.ITM_NO
      , CASE
            WHEN S.GDT_NO = 0 AND S.GITM_NO = 1 THEN '소계'
            WHEN S.GDT_NO = 1 AND S.GITM_NO = 1 THEN '합계'
            ELSE I.ITM_NM
        END     ITM_NM
      , S.SUM_QTY
      , S.SUM_AMT
      , CASE
            WHEN S.GITM_NO = 0
                THEN RANK() OVER(PARTITION BY S.SLE_DT, GITM_NO ORDER BY SUM_QTY DESC)
        END   QTY_RNK
      , CASE
            WHEN S.GITM_NO = 0
                THEN RANK() OVER(PARTITION BY S.SLE_DT, GITM_NO ORDER BY SUM_AMT DESC)
        END   AMT_RNK
FROM    (
        SELECT  
                S.SLE_DT
              , SI.ITM_NO
              , SUM(SI.SLE_QTY) SUM_QTY
              , SUM(SI.SLE_QTY * SI.SLE_UPRC)   SUM_AMT
              , GROUPING(S.SLE_DT) GDT_NO
              , GROUPING(SI.ITM_NO) GITM_NO
        FROM    CF10    S
              , CF11    SI
        WHERE   1 = 1
        AND     S.SLE_NO = SI.SLE_NO
        AND     S.SLE_DT BETWEEN :stDt AND :edDt
        GROUP BY ROLLUP (
                S.SLE_DT
              , SI.ITM_NO
                )
        )   S
      , CF01    I
WHERE   1 = 1
AND     I.ITM_NO(+) = S.ITM_NO
ORDER BY
        S.SLE_DT
      , S.ITM_NO
;

-- 쿼리. 133

-- :stDt = 20230601
-- :edDt = 20230630

SELECT  
        CASE
            WHEN O.GDT_NO = 1 AND O.GPTNR_NO = 1 THEN SUBSTR(:stDt,1,6)
            ELSE O.ORD_DT
        END     ORD_DT
      , O.PTNR_NO
      , CASE
            WHEN O.GDT_NO = 0 AND O.GPTNR_NO = 1 THEN '소계'
            WHEN O.GDT_NO = 1 AND O.GPTNR_NO = 1 THEN '합계'
            ELSE P.PTNR_NM
        END     PTNR_NM
      , O.SUM_QTY
      , O.SUM_AMT
FROM    (
        SELECT  
                O.ORD_DT
              , O.PTNR_NO
              , SUM(OI.ORD_QTY) SUM_QTY
              , SUM(OI.ORD_QTY * OI.ORD_UPRC)   SUM_AMT
              , GROUPING(ORD_DT) GDT_NO
              , GROUPING(PTNR_NO) GPTNR_NO
        FROM    CF12    O
              , CF13    OI
        WHERE   1 = 1
        AND     O.ORD_NO = OI.ORD_NO
        AND     O.ORD_DT BETWEEN :stDt AND :edDt
        GROUP BY ROLLUP ((
                O.ORD_DT
              , O.PTNR_NO
                ))
        )   O
      , CF06    P
WHERE   1 = 1
AND     P.PTNR_NO(+) = O.PTNR_NO
ORDER BY
        O.ORD_DT
      , O.PTNR_NO
;

-- 쿼리. 134

-- :stDt = 20230601
-- :edDt = 20230602

SELECT
        CASE
            WHEN S.GDT_NO = 1 AND S.GSHP_NO = 1 THEN SUBSTR(:stDt,1,6)
            ELSE S.SLE_DT
        END     SLE_DT
      , S.SHP_NO
      , CASE
            WHEN S.GDT_NO = 0 AND S.GSHP_NO = 1 THEN '소계'
            WHEN S.GDT_NO = 1 AND S.GSHP_NO = 1 THEN '합계'
            ELSE SH.SHP_NM
        END     SHP_NM
      , S.SUM_QTY
      , S.SUM_AMT
      , CASE
            WHEN S.GSHP_NO = 0
                THEN RANK() OVER(PARTITION BY S.SLE_DT, GSHP_NO ORDER BY SUM_QTY DESC)
        END   QTY_RNK
      , CASE
            WHEN S.GSHP_NO = 0
                THEN RANK() OVER(PARTITION BY S.SLE_DT, GSHP_NO ORDER BY SUM_AMT DESC)
        END   AMT_RNK
FROM    (
        SELECT  
                S.SLE_DT
              , S.SHP_NO
              , SUM(SI.SLE_QTY) SUM_QTY
              , SUM(SI.SLE_QTY * SI.SLE_UPRC)   SUM_AMT
              , GROUPING(S.SLE_DT) GDT_NO
              , GROUPING(S.SHP_NO) GSHP_NO
        FROM    CF10    S
              , CF11    SI
        WHERE   1 = 1
        AND     S.SLE_NO = SI.SLE_NO
        AND     S.SLE_DT BETWEEN :stDt AND :edDt
        GROUP BY ROLLUP (
                S.SLE_DT
              , S.SHP_NO
                )
        )   S
      , CF07    SH
WHERE   1 = 1
AND     SH.SHP_NO(+) = S.SHP_NO
ORDER BY
        S.SLE_DT
      , S.SHP_NO
;

-- 쿼리. 135

-- :stDt = 20230601
-- :edDt = 20230602

SELECT  
        OI.ITM_NO
      , SUM(OI.ORD_QTY)     ORD_QTY
      , SUM(OI.ORD_QTY * OI.ORD_UPRC)   ORD_AMT
      , SUM(IOI.INOUT_QTY)  INOUT_QTY
FROM    CF12    O
      , CF13    OI
      , CF14    IO
      , CF15    IOI
WHERE   1 = 1
AND     O.ORD_NO = OI.ORD_NO
AND     IO.ORD_NO = O.ORD_NO
AND     IOI.INOUT_NO = IO.INOUT_NO
AND     O.ORD_DT BETWEEN :stDt AND :edDt
GROUP BY
        OI.ITM_NO
ORDER BY
        OI.ITM_NO
;

-- 쿼리. 136

-- :stDt = 20230601
-- :edDt = 20230602

SELECT
        O.ITM_NO
      , O.ORD_QTY
      , O.ORD_AMT
      , IO.INOUT_QTY
FROM    (
        SELECT  
                OI.ITM_NO
              , SUM(OI.ORD_QTY) ORD_QTY
              , SUM(OI.ORD_QTY * OI.ORD_UPRC)   ORD_AMT
        FROM    CF12    O
              , CF13    OI
        WHERE   1 = 1
        AND     O.ORD_NO = OI.ORD_NO
        AND     O.ORD_DT BETWEEN :stDt AND :edDt
        GROUP BY
                OI.ITM_NO
        )   O
      , (
        SELECT  
                OI.ITM_NO
              , SUM(OI.INOUT_QTY) INOUT_QTY
        FROM    CF14    O
              , CF15    OI
        WHERE   1 = 1
        AND     O.INOUT_NO = OI.INOUT_NO
        AND     O.INOUT_TY_CD = '10'
        AND     O.INOUT_DT BETWEEN :stDt AND :edDt
        GROUP BY
                OI.ITM_NO
        )   IO
WHERE   1 = 1
AND     IO.ITM_NO = O.ITM_NO
ORDER BY
        O.ITM_NO
;

-- 쿼리. 137

-- :stDt = 20230601
-- :edDt = 20230602

SELECT  
        OI.ITM_NO
      , SUM(OI.ORD_QTY) ORD_QTY
      , SUM(OI.ORD_QTY * OI.ORD_UPRC)   ORD_AMT
      , 0   INOUT_QTY       -- 입고 데이터가 없으니 0으로 초기화
FROM    CF12    O
      , CF13    OI
WHERE   1 = 1
AND     O.ORD_NO = OI.ORD_NO
AND     O.ORD_DT BETWEEN :stDt AND :edDt
GROUP BY
        OI.ITM_NO
UNION ALL
SELECT  
        IOI.ITM_NO
      , 0   ORD_QTY         -- 발주 데이터가 없으니 0으로 초기화
      , 0   ORD_AMT         -- 발주 데이터가 없으니 0으로 초기화
      , SUM(IOI.INOUT_QTY) INOUT_QTY
FROM    CF14    IO
      , CF15    IOI
WHERE   1 = 1
AND     IOI.INOUT_NO = IO.INOUT_NO
AND     IO.INOUT_TY_CD = '10'
AND     IO.INOUT_DT BETWEEN :stDt AND :edDt
GROUP BY
        IOI.ITM_NO
ORDER BY
        ITM_NO
;

-- 쿼리. 138

-- :stDt = 20230601
-- :edDt = 20230602

SELECT
        A.ITM_NO
      , SUM(A.ORD_QTY)      ORD_QTY
      , SUM(A.ORD_AMT)      ORD_AMT
      , SUM(A.INOUT_QTY)    INOUT_QTY
FROM    (
        SELECT  
                OI.ITM_NO
              , SUM(OI.ORD_QTY) ORD_QTY
              , SUM(OI.ORD_QTY * OI.ORD_UPRC)   ORD_AMT
              , 0   INOUT_QTY       -- 입고 데이터가 없으니 0으로 초기화
        FROM    CF12    O
              , CF13    OI
        WHERE   1 = 1
        AND     O.ORD_NO = OI.ORD_NO
        AND     O.ORD_DT BETWEEN :stDt AND :edDt
        GROUP BY
                OI.ITM_NO
        UNION ALL
        SELECT  
                IOI.ITM_NO
              , 0   ORD_QTY         -- 발주 데이터가 없으니 0으로 초기화
              , 0   ORD_AMT         -- 발주 데이터가 없으니 0으로 초기화
              , SUM(IOI.INOUT_QTY) INOUT_QTY
        FROM    CF14    IO
              , CF15    IOI
        WHERE   1 = 1
        AND     IOI.INOUT_NO = IO.INOUT_NO
        AND     IO.INOUT_TY_CD = '10'
        AND     IO.INOUT_DT BETWEEN :stDt AND :edDt
        GROUP BY
                IOI.ITM_NO
        )   A
WHERE   1 = 1
GROUP BY
        A.ITM_NO
ORDER BY
        A.ITM_NO
;

-- 쿼리. 139

-- :stDt = 20230601
-- :edDt = 20230602

SELECT
        A.ITM_NO
      , I.ITM_NM
      , A.ORD_QTY
      , A.ORD_AMT
      , A.INOUT_QTY
FROM    (
        SELECT
                A.ITM_NO
              , SUM(A.ORD_QTY)      ORD_QTY
              , SUM(A.ORD_AMT)      ORD_AMT
              , SUM(A.INOUT_QTY)    INOUT_QTY
        FROM    (
                SELECT  
                        OI.ITM_NO
                      , SUM(OI.ORD_QTY) ORD_QTY
                      , SUM(OI.ORD_QTY * OI.ORD_UPRC)   ORD_AMT
                      , 0   INOUT_QTY       -- 입고 데이터가 없으니 0으로 초기화
                FROM    CF12    O
                      , CF13    OI
                WHERE   1 = 1
                AND     O.ORD_NO = OI.ORD_NO
                AND     O.ORD_DT BETWEEN :stDt AND :edDt
                GROUP BY
                        OI.ITM_NO
                UNION ALL
                SELECT  
                        IOI.ITM_NO
                      , 0   ORD_QTY         -- 발주 데이터가 없으니 0으로 초기화
                      , 0   ORD_AMT         -- 발주 데이터가 없으니 0으로 초기화
                      , SUM(IOI.INOUT_QTY) INOUT_QTY
                FROM    CF14    IO
                      , CF15    IOI
                WHERE   1 = 1
                AND     IOI.INOUT_NO = IO.INOUT_NO
                AND     IO.INOUT_TY_CD = '10'
                AND     IO.INOUT_DT BETWEEN :stDt AND :edDt
                GROUP BY
                        IOI.ITM_NO
                )   A
        WHERE   1 = 1
        GROUP BY
                A.ITM_NO
        )   A
      , CF01    I
WHERE   1 = 1
AND     I.ITM_NO = A.ITM_NO
ORDER BY
        A.ITM_NO
;

-- 쿼리. 140

-- :stDt = 20230601
-- :edDt = 20230602
-- :ordOpt = 4

SELECT
        A.ITM_NO
      , CASE WHEN GITM_NO = 1 THEN '합계' ELSE I.ITM_NM END ITM_NM
      , A.ORD_QTY
      , A.ORD_AMT
      , A.INOUT_QTY
FROM    (
        SELECT
                A.ITM_NO
              , SUM(A.ORD_QTY)      ORD_QTY
              , SUM(A.ORD_AMT)      ORD_AMT
              , SUM(A.INOUT_QTY)    INOUT_QTY
              , GROUPING(A.ITM_NO)  GITM_NO
        FROM    (
                SELECT  
                        OI.ITM_NO
                      , SUM(OI.ORD_QTY) ORD_QTY
                      , SUM(OI.ORD_QTY * OI.ORD_UPRC)   ORD_AMT
                      , 0   INOUT_QTY       -- 입고 데이터가 없으니 0으로 초기화
                FROM    CF12    O
                      , CF13    OI
                WHERE   1 = 1
                AND     O.ORD_NO = OI.ORD_NO
                AND     O.ORD_DT BETWEEN :stDt AND :edDt
                GROUP BY
                        OI.ITM_NO
                UNION ALL
                SELECT  
                        IOI.ITM_NO
                      , 0   ORD_QTY         -- 발주 데이터가 없으니 0으로 초기화
                      , 0   ORD_AMT         -- 발주 데이터가 없으니 0으로 초기화
                      , SUM(IOI.INOUT_QTY) INOUT_QTY
                FROM    CF14    IO
                      , CF15    IOI
                WHERE   1 = 1
                AND     IOI.INOUT_NO = IO.INOUT_NO
                AND     IO.INOUT_TY_CD = '10'
                AND     IO.INOUT_DT BETWEEN :stDt AND :edDt
                GROUP BY
                        IOI.ITM_NO
                )   A
        WHERE   1 = 1
        GROUP BY ROLLUP (
                A.ITM_NO
                )
        )   A
      , CF01    I
WHERE   1 = 1
AND     I.ITM_NO(+) = A.ITM_NO
ORDER BY
        CASE WHEN :ordOpt = 1 THEN A.ITM_NO END
      , CASE WHEN :ordOpt = 2 THEN A.ITM_NO END DESC
      , CASE WHEN :ordOpt = 3 THEN A.ORD_QTY END
      , CASE WHEN :ordOpt = 4 THEN A.ORD_QTY END DESC
      , CASE WHEN :ordOpt = 5 THEN A.INOUT_QTY END
      , CASE WHEN :ordOpt = 6 THEN A.INOUT_QTY END DESC
      , CASE WHEN :ordOpt = 7 THEN A.ORD_AMT END
      , CASE WHEN :ordOpt = 8 THEN A.ORD_AMT END DESC
;

-- 쿼리. 141

-- :stDt = 20230601
-- :edDt = 20230602
-- :ordOpt = 4

SELECT
        A.ITM_NO
      , CASE WHEN GITM_NO = 1 THEN '합계' ELSE I.ITM_NM END ITM_NM
      , A.ORD_QTY
      , A.ORD_AMT
      , A.INOUT_QTY
      , A.GITM_NO
FROM    (
        SELECT
                A.ITM_NO
              , SUM(A.ORD_QTY)      ORD_QTY
              , SUM(A.ORD_AMT)      ORD_AMT
              , SUM(A.INOUT_QTY)    INOUT_QTY
              , GROUPING(A.ITM_NO)  GITM_NO
        FROM    (
                SELECT  
                        OI.ITM_NO
                      , SUM(OI.ORD_QTY) ORD_QTY
                      , SUM(OI.ORD_QTY * OI.ORD_UPRC)   ORD_AMT
                      , 0   INOUT_QTY       -- 입고 데이터가 없으니 0으로 초기화
                FROM    CF12    O
                      , CF13    OI
                WHERE   1 = 1
                AND     O.ORD_NO = OI.ORD_NO
                AND     O.ORD_DT BETWEEN :stDt AND :edDt
                GROUP BY
                        OI.ITM_NO
                UNION ALL
                SELECT  
                        IOI.ITM_NO
                      , 0   ORD_QTY         -- 발주 데이터가 없으니 0으로 초기화
                      , 0   ORD_AMT         -- 발주 데이터가 없으니 0으로 초기화
                      , SUM(IOI.INOUT_QTY) INOUT_QTY
                FROM    CF14    IO
                      , CF15    IOI
                WHERE   1 = 1
                AND     IOI.INOUT_NO = IO.INOUT_NO
                AND     IO.INOUT_TY_CD = '10'
                AND     IO.INOUT_DT BETWEEN :stDt AND :edDt
                GROUP BY
                        IOI.ITM_NO
                )   A
        WHERE   1 = 1
        GROUP BY ROLLUP (
                A.ITM_NO
                )
        )   A
      , CF01    I
WHERE   1 = 1
AND     I.ITM_NO(+) = A.ITM_NO
ORDER BY
        CASE WHEN :ordOpt = 1 THEN A.ITM_NO END
      , CASE WHEN :ordOpt = 2 THEN A.ITM_NO END DESC
      , CASE WHEN :ordOpt = 3 THEN A.ORD_QTY END
      , CASE WHEN :ordOpt = 4 THEN A.ORD_QTY END DESC
      , CASE WHEN :ordOpt = 5 THEN A.INOUT_QTY END
      , CASE WHEN :ordOpt = 6 THEN A.INOUT_QTY END DESC
      , CASE WHEN :ordOpt = 7 THEN A.ORD_AMT END
      , CASE WHEN :ordOpt = 8 THEN A.ORD_AMT END DESC
;

-- 쿼리. 142

-- :stDt = 20230601
-- :edDt = 20230602
-- :ordOpt = 4

SELECT
        A.ITM_NO
      , CASE WHEN GITM_NO = 1 THEN '합계' ELSE I.ITM_NM END ITM_NM
      , A.ORD_QTY
      , A.ORD_AMT
      , A.INOUT_QTY
FROM    (
        SELECT
                A.ITM_NO
              , SUM(A.ORD_QTY)      ORD_QTY
              , SUM(A.ORD_AMT)      ORD_AMT
              , SUM(A.INOUT_QTY)    INOUT_QTY
              , GROUPING(A.ITM_NO)  GITM_NO
        FROM    (
                SELECT  
                        OI.ITM_NO
                      , SUM(OI.ORD_QTY) ORD_QTY
                      , SUM(OI.ORD_QTY * OI.ORD_UPRC)   ORD_AMT
                      , 0   INOUT_QTY       -- 입고 데이터가 없으니 0으로 초기화
                FROM    CF12    O
                      , CF13    OI
                WHERE   1 = 1
                AND     O.ORD_NO = OI.ORD_NO
                AND     O.ORD_DT BETWEEN :stDt AND :edDt
                GROUP BY
                        OI.ITM_NO
                UNION ALL
                SELECT  
                        IOI.ITM_NO
                      , 0   ORD_QTY         -- 발주 데이터가 없으니 0으로 초기화
                      , 0   ORD_AMT         -- 발주 데이터가 없으니 0으로 초기화
                      , SUM(IOI.INOUT_QTY) INOUT_QTY
                FROM    CF14    IO
                      , CF15    IOI
                WHERE   1 = 1
                AND     IOI.INOUT_NO = IO.INOUT_NO
                AND     IO.INOUT_TY_CD = '10'
                AND     IO.INOUT_DT BETWEEN :stDt AND :edDt
                GROUP BY
                        IOI.ITM_NO
                )   A
        WHERE   1 = 1
        GROUP BY ROLLUP (
                A.ITM_NO
                )
        )   A
      , CF01    I
WHERE   1 = 1
AND     I.ITM_NO(+) = A.ITM_NO
ORDER BY
        A.GITM_NO
      , CASE WHEN :ordOpt = 1 THEN A.ITM_NO END
      , CASE WHEN :ordOpt = 2 THEN A.ITM_NO END DESC
      , CASE WHEN :ordOpt = 3 THEN A.ORD_QTY END
      , CASE WHEN :ordOpt = 4 THEN A.ORD_QTY END DESC
      , CASE WHEN :ordOpt = 5 THEN A.INOUT_QTY END
      , CASE WHEN :ordOpt = 6 THEN A.INOUT_QTY END DESC
      , CASE WHEN :ordOpt = 7 THEN A.ORD_AMT END
      , CASE WHEN :ordOpt = 8 THEN A.ORD_AMT END DESC
;

-- 쿼리. 143

-- :stDt = 20230601
-- :edDt = 20230602

SELECT  
        OI.ITM_NO
      , SUM(OI.ORD_QTY) ORD_QTY
      , SUM(OI.ORD_QTY * OI.ORD_UPRC)   ORD_AMT
      , 0   SLE_QTY
      , 0   SLE_AMT
FROM    CF12    O
      , CF13    OI
WHERE   1 = 1
AND     O.ORD_NO = OI.ORD_NO
AND     O.ORD_DT BETWEEN :stDt AND :edDt
GROUP BY
        OI.ITM_NO
UNION ALL
SELECT  
        SI.ITM_NO
      , 0   ORD_QTY
      , 0   ORD_AMT
      , SUM(SI.SLE_QTY) SLE_QTY
      , SUM(SI.SLE_QTY * SI.SLE_UPRC)   SLE_AMT
FROM    CF10    S
      , CF11    SI
WHERE   1 = 1
AND     S.SLE_NO = SI.SLE_NO
AND     S.SLE_DT BETWEEN :stDt AND :edDt
GROUP BY
        SI.ITM_NO
ORDER BY
        ITM_NO
;

-- 쿼리. 144

-- :stDt = 20230601
-- :edDt = 20230602

SELECT  
        NVL(IM.MTRL_ITM_NO, SI.ITM_NO)  ITM_NO
      , SUM(SI.SLE_QTY) SLE_QTY
      , SUM(SI.SLE_QTY * SI.SLE_UPRC)   SLE_AMT
FROM    CF10    S
      , CF11    SI
      , CF03    IM
WHERE   1 = 1
AND     S.SLE_NO = SI.SLE_NO
AND     SI.ITM_NO = IM.ITM_NO(+)
AND     S.SLE_DT BETWEEN :stDt AND :edDt
GROUP BY
        NVL(IM.MTRL_ITM_NO, SI.ITM_NO)
ORDER BY
        ITM_NO
;

-- 쿼리. 145

-- :stDt = 20230601
-- :edDt = 20230602
-- :ordOpt = 6

SELECT
        A.ITM_NO
      , CASE WHEN GITM_NO = 1 THEN '합계' ELSE I.ITM_NM END ITM_NM
      , A.ORD_QTY
      , A.SLE_QTY
      , A.ORD_AMT
      , A.SLE_AMT
FROM    (
        SELECT
                A.ITM_NO
              , SUM(A.ORD_QTY)      ORD_QTY
              , SUM(A.SLE_QTY)      SLE_QTY
              , SUM(A.ORD_AMT)      ORD_AMT
              , SUM(A.SLE_AMT)      SLE_AMT
              , GROUPING(A.ITM_NO)  GITM_NO
        FROM    (
                SELECT  
                        OI.ITM_NO
                      , SUM(OI.ORD_QTY) ORD_QTY
                      , SUM(OI.ORD_QTY * OI.ORD_UPRC)   ORD_AMT
                      , 0   SLE_QTY
                      , 0   SLE_AMT
                FROM    CF12    O
                      , CF13    OI
                WHERE   1 = 1
                AND     O.ORD_NO = OI.ORD_NO
                AND     O.ORD_DT BETWEEN :stDt AND :edDt
                GROUP BY
                        OI.ITM_NO
                UNION ALL
                SELECT  
                        NVL(IM.MTRL_ITM_NO, SI.ITM_NO)  ITM_NO
                      , 0   ORD_QTY
                      , 0   ORD_AMT
                      , SUM(SI.SLE_QTY) SLE_QTY
                      , SUM(SI.SLE_QTY * SI.SLE_UPRC)   SLE_AMT
                FROM    CF10    S
                      , CF11    SI
                      , CF03    IM
                WHERE   1 = 1
                AND     S.SLE_NO = SI.SLE_NO
                AND     SI.ITM_NO = IM.ITM_NO(+)
                AND     S.SLE_DT BETWEEN :stDt AND :edDt
                GROUP BY
                        NVL(IM.MTRL_ITM_NO, SI.ITM_NO)
                )   A
        WHERE   1 = 1
        GROUP BY
                ROLLUP(A.ITM_NO)
        )   A
      , CF01    I
WHERE   1 = 1
AND     A.ITM_NO = I.ITM_NO(+)
ORDER BY
        A.GITM_NO
      , CASE WHEN :ordOpt = 1 THEN A.ITM_NO END
      , CASE WHEN :ordOpt = 2 THEN A.ITM_NO END DESC
      , CASE WHEN :ordOpt = 3 THEN A.ORD_QTY END
      , CASE WHEN :ordOpt = 4 THEN A.ORD_QTY END DESC
      , CASE WHEN :ordOpt = 5 THEN A.SLE_QTY END
      , CASE WHEN :ordOpt = 6 THEN A.SLE_QTY END DESC
      , CASE WHEN :ordOpt = 7 THEN A.ORD_AMT END
      , CASE WHEN :ordOpt = 8 THEN A.ORD_AMT END DESC
      , CASE WHEN :ordOpt = 9 THEN A.SLE_AMT END
      , CASE WHEN :ordOpt = 10 THEN A.SLE_AMT END DESC
;

-- 쿼리. 146

SELECT
        T.SHP_NO
      , T.SLE_AMT
      , M1.M01
      , M2.M02
FROM    (
        SELECT  
                S.SHP_NO
              , SUM(SI.SLE_QTY * SI.SLE_UPRC)   SLE_AMT
        FROM    CF10    S
              , CF11    SI
        WHERE   1 = 1
        AND     S.SLE_NO = SI.SLE_NO
        AND     S.SLE_DT BETWEEN '20220101' AND '20221231'
        GROUP BY
                S.SHP_NO
        )   T
      , (
        SELECT  
                S.SHP_NO
              , SUM(SI.SLE_QTY * SI.SLE_UPRC)   M01
        FROM    CF10    S
              , CF11    SI
        WHERE   1 = 1
        AND     S.SLE_NO = SI.SLE_NO
        AND     S.SLE_DT BETWEEN '20220101' AND '20220131'
        GROUP BY
                S.SHP_NO
        )   M1
      , (
        SELECT  
                S.SHP_NO
              , SUM(SI.SLE_QTY * SI.SLE_UPRC)   M02
        FROM    CF10    S
              , CF11    SI
        WHERE   1 = 1
        AND     S.SLE_NO = SI.SLE_NO
        AND     S.SLE_DT BETWEEN '20220201' AND '20220228'
        GROUP BY
                S.SHP_NO
        )   M2
WHERE   1 = 1
AND     M1.SHP_NO = T.SHP_NO
AND     M2.SHP_NO = T.SHP_NO
ORDER BY
        T.SHP_NO
;

-- 쿼리. 147

-- :sMM = 202201
-- :eMM = 202212

SELECT  
        S.SHP_NO
      , SUM(SI.SLE_QTY * SI.SLE_UPRC)   SLE_AMT
      , SUM(CASE WHEN SUBSTR(S.SLE_DT,5,2) = '01' THEN SI.SLE_QTY * SI.SLE_UPRC END) M01
      , SUM(CASE WHEN SUBSTR(S.SLE_DT,5,2) = '02' THEN SI.SLE_QTY * SI.SLE_UPRC END) M02
FROM    CF10    S
      , CF11    SI
WHERE   1 = 1
AND     S.SLE_NO = SI.SLE_NO
AND     S.SLE_DT BETWEEN :Smm || '01' AND TO_CHAR(LAST_DAY(:eMM || '01'), 'YYYYMMDD')
GROUP BY
        S.SHP_NO
ORDER BY
        S.SHP_NO
;

-- 쿼리. 148

-- :sMM = 202201
-- :eMM = 202301

SELECT  
        S.SHP_NO
      , SUM(SI.SLE_QTY * SI.SLE_UPRC)   SUM_AMT
      , SUM(CASE WHEN SUBSTR(S.SLE_DT,5,2) = '01' THEN SI.SLE_QTY * SI.SLE_UPRC END) M01
      , SUM(CASE WHEN SUBSTR(S.SLE_DT,5,2) = '02' THEN SI.SLE_QTY * SI.SLE_UPRC END) M02
      , SUM(CASE WHEN SUBSTR(S.SLE_DT,5,2) = '03' THEN SI.SLE_QTY * SI.SLE_UPRC END) M03
      , SUM(CASE WHEN SUBSTR(S.SLE_DT,5,2) = '04' THEN SI.SLE_QTY * SI.SLE_UPRC END) M04
      , SUM(CASE WHEN SUBSTR(S.SLE_DT,5,2) = '05' THEN SI.SLE_QTY * SI.SLE_UPRC END) M05
      , SUM(CASE WHEN SUBSTR(S.SLE_DT,5,2) = '06' THEN SI.SLE_QTY * SI.SLE_UPRC END) M06
      , SUM(CASE WHEN SUBSTR(S.SLE_DT,5,2) = '07' THEN SI.SLE_QTY * SI.SLE_UPRC END) M07
      , SUM(CASE WHEN SUBSTR(S.SLE_DT,5,2) = '08' THEN SI.SLE_QTY * SI.SLE_UPRC END) M08
      , SUM(CASE WHEN SUBSTR(S.SLE_DT,5,2) = '09' THEN SI.SLE_QTY * SI.SLE_UPRC END) M09
      , SUM(CASE WHEN SUBSTR(S.SLE_DT,5,2) = '10' THEN SI.SLE_QTY * SI.SLE_UPRC END) M10
      , SUM(CASE WHEN SUBSTR(S.SLE_DT,5,2) = '11' THEN SI.SLE_QTY * SI.SLE_UPRC END) M11
      , SUM(CASE WHEN SUBSTR(S.SLE_DT,5,2) = '12' THEN SI.SLE_QTY * SI.SLE_UPRC END) M12
FROM    CF10    S
      , CF11    SI
WHERE   1 = 1
AND     S.SLE_NO = SI.SLE_NO
AND     S.SLE_DT BETWEEN :sMM AND :eMM
GROUP BY
        S.SHP_NO
ORDER BY
        S.SHP_NO
;

-- 쿼리. 149

-- :sMM = 202201
-- :eMM = 202301

SELECT
        A.SHP_NO
      , SH.SHP_NM
      , A.SUM_AMT
      , A.M01
      , A.M02
      , A.M03
      , A.M04
      , A.M05
      , A.M06
      , A.M07
      , A.M08
      , A.M09
      , A.M10
      , A.M11
      , A.M12
FROM    (
        SELECT  
                S.SHP_NO
              , SUM(SI.SLE_QTY * SI.SLE_UPRC)   SUM_AMT
              , SUM(CASE WHEN SUBSTR(S.SLE_DT,5,2) = '01' THEN SI.SLE_QTY * SI.SLE_UPRC END) M01
              , SUM(CASE WHEN SUBSTR(S.SLE_DT,5,2) = '02' THEN SI.SLE_QTY * SI.SLE_UPRC END) M02
              , SUM(CASE WHEN SUBSTR(S.SLE_DT,5,2) = '03' THEN SI.SLE_QTY * SI.SLE_UPRC END) M03
              , SUM(CASE WHEN SUBSTR(S.SLE_DT,5,2) = '04' THEN SI.SLE_QTY * SI.SLE_UPRC END) M04
              , SUM(CASE WHEN SUBSTR(S.SLE_DT,5,2) = '05' THEN SI.SLE_QTY * SI.SLE_UPRC END) M05
              , SUM(CASE WHEN SUBSTR(S.SLE_DT,5,2) = '06' THEN SI.SLE_QTY * SI.SLE_UPRC END) M06
              , SUM(CASE WHEN SUBSTR(S.SLE_DT,5,2) = '07' THEN SI.SLE_QTY * SI.SLE_UPRC END) M07
              , SUM(CASE WHEN SUBSTR(S.SLE_DT,5,2) = '08' THEN SI.SLE_QTY * SI.SLE_UPRC END) M08
              , SUM(CASE WHEN SUBSTR(S.SLE_DT,5,2) = '09' THEN SI.SLE_QTY * SI.SLE_UPRC END) M09
              , SUM(CASE WHEN SUBSTR(S.SLE_DT,5,2) = '10' THEN SI.SLE_QTY * SI.SLE_UPRC END) M10
              , SUM(CASE WHEN SUBSTR(S.SLE_DT,5,2) = '11' THEN SI.SLE_QTY * SI.SLE_UPRC END) M11
              , SUM(CASE WHEN SUBSTR(S.SLE_DT,5,2) = '12' THEN SI.SLE_QTY * SI.SLE_UPRC END) M12
        FROM    CF10    S
              , CF11    SI
        WHERE   1 = 1
        AND     S.SLE_NO = SI.SLE_NO
        AND     S.SLE_DT BETWEEN :sMM AND :eMM
        GROUP BY
                S.SHP_NO
        )   A
      , CF07 SH
WHERE   1 = 1
AND     SH.SHP_NO = A.SHP_NO
ORDER BY
        A.SHP_NO
;

-- 쿼리. 150

SELECT  A.*
FROM    (
        SELECT
                COL1
              , COL2
              , COL3
        FROM    TBL
        )   X
PIVOT   (
        SUM(COL3)
        FOR COL2
        IN(10 X, 20 Y 30 Z)
        )   A
WHERE   조건
;

-- 쿼리. 151

-- :sMM = 202201
-- :eMM = 202301

SELECT  
        A.SHP_NO
      , (A.M01 + A.M02 + A.M03 + A.M04 + A.M05 + A.M06 + 
         A.M07 + A.M08 + A.M09 + A.M10 + A.M11 + A.M12) SUM_AMT
      , A.M01
      , A.M02
      , A.M03
      , A.M04
      , A.M05
      , A.M06
      , A.M07
      , A.M08
      , A.M09
      , A.M10
      , A.M11
      , A.M12
FROM    (
        SELECT  
                S.SHP_NO
              , SUBSTR(S.SLE_DT,5,2)    MM
              , SI.SLE_QTY * SI.SLE_UPRC   SLE_AMT
        FROM    CF10    S
              , CF11    SI
        WHERE   1 = 1
        AND     S.SLE_NO = SI.SLE_NO
        AND     S.SLE_DT BETWEEN :sMM AND :eMM
        )   X
PIVOT   (
            SUM(X.SLE_AMT)
            FOR MM
            IN  ('01' M01,'02' M02,'03' M03,'04' M04,'05' M05,'06' M06
                ,'07' M07,'08' M08,'09' M09,'10' M10,'11' M11,'12' M12)
        )   A
WHERE   1 = 1
ORDER BY
        A.SHP_NO
;

-- 쿼리. 152

-- :sMM = 202201
-- :eMM = 202301

SELECT  
        A.SHP_NO
      , SH.SHP_NM
      , (A.M01 + A.M02 + A.M03 + A.M04 + A.M05 + A.M06 + 
         A.M07 + A.M08 + A.M09 + A.M10 + A.M11 + A.M12) SUM_AMT
      , A.M01
      , A.M02
      , A.M03
      , A.M04
      , A.M05
      , A.M06
      , A.M07
      , A.M08
      , A.M09
      , A.M10
      , A.M11
      , A.M12
FROM    (
        SELECT  
                S.SHP_NO
              , SUBSTR(S.SLE_DT,5,2)    MM
              , SI.SLE_QTY * SI.SLE_UPRC   SLE_AMT
        FROM    CF10    S
              , CF11    SI
        WHERE   1 = 1
        AND     S.SLE_NO = SI.SLE_NO
        AND     S.SLE_DT BETWEEN :sMM AND :eMM
        )
PIVOT   (
            SUM(SLE_AMT)
            FOR MM
            IN  ('01' M01,'02' M02,'03' M03,'04' M04,'05' M05,'06' M06
                ,'07' M07,'08' M08,'09' M09,'10' M10,'11' M11,'12' M12)
        )   A
      , CF07 SH
WHERE   1 = 1
AND     SH.SHP_NO = A.SHP_NO
ORDER BY
        A.SHP_NO
;

-- 쿼리. 153

-- :sMM = 202201
-- :eMM = 202301

SELECT  
        A.SHP_NO
      , (A.M01_CNT + A.M02_CNT + A.M03_CNT + A.M04_CNT + A.M05_CNT + A.M06_CNT + 
         A.M07_CNT + A.M08_CNT + A.M09_CNT + A.M10_CNT + A.M11_CNT + A.M12_CNT) SUM_CNT
      , (A.M01 + A.M02 + A.M03 + A.M04 + A.M05 + A.M06 + 
         A.M07 + A.M08 + A.M09 + A.M10 + A.M11 + A.M12) SUM_AMT
      , A.M01_CNT
      , A.M01
      , A.M02_CNT
      , A.M02
      , A.M03_CNT
      , A.M03
      , A.M04_CNT
      , A.M04
      , A.M05_CNT
      , A.M05
      , A.M06_CNT
      , A.M06
      , A.M07_CNT
      , A.M07
      , A.M08_CNT
      , A.M08
      , A.M09_CNT
      , A.M09
      , A.M10_CNT
      , A.M10
      , A.M11_CNT
      , A.M11
      , A.M12_CNT
      , A.M12
FROM    (
        SELECT  
                S.SHP_NO
              , SUBSTR(S.SLE_DT,5,2)    MM
              , SI.SLE_QTY              -- 추가 작업
              , SI.SLE_QTY * SI.SLE_UPRC   SLE_AMT
        FROM    CF10    S
              , CF11    SI
        WHERE   1 = 1
        AND     S.SLE_NO = SI.SLE_NO
        AND     S.SLE_DT BETWEEN :sMM AND :eMM
        )   X
PIVOT   (
            SUM(X.SLE_AMT)
          , SUM(X.SLE_QTY) CNT  -- 추가 작업
            FOR MM
            IN  ('01' M01,'02' M02,'03' M03,'04' M04,'05' M05,'06' M06
                ,'07' M07,'08' M08,'09' M09,'10' M10,'11' M11,'12' M12)
        )   A
WHERE   1 = 1
ORDER BY
        A.SHP_NO
;

-- 쿼리. 154

-- :sMM = 202201
-- :eMM = 202301

SELECT  
        A.SHP_NO
      , SH.SHP_NM
      , (A.M01_CNT + A.M02_CNT + A.M03_CNT + A.M04_CNT + A.M05_CNT + A.M06_CNT + 
         A.M07_CNT + A.M08_CNT + A.M09_CNT + A.M10_CNT + A.M11_CNT + A.M12_CNT) SUM_CNT
      , (A.M01 + A.M02 + A.M03 + A.M04 + A.M05 + A.M06 + 
         A.M07 + A.M08 + A.M09 + A.M10 + A.M11 + A.M12) SUM_AMT
      , A.M01_CNT
      , A.M01
      , A.M02_CNT
      , A.M02
      , A.M03_CNT
      , A.M03
      , A.M04_CNT
      , A.M04
      , A.M05_CNT
      , A.M05
      , A.M06_CNT
      , A.M06
      , A.M07_CNT
      , A.M07
      , A.M08_CNT
      , A.M08
      , A.M09_CNT
      , A.M09
      , A.M10_CNT
      , A.M10
      , A.M11_CNT
      , A.M11
      , A.M12_CNT
      , A.M12
FROM    (
        SELECT  
                S.SHP_NO
              , SUBSTR(S.SLE_DT,5,2)    MM
              , SI.SLE_QTY
              , SI.SLE_QTY * SI.SLE_UPRC   SLE_AMT
        FROM    CF10    S
              , CF11    SI
        WHERE   1 = 1
        AND     S.SLE_NO = SI.SLE_NO
        AND     S.SLE_DT BETWEEN :sMM AND :eMM
        )   X
PIVOT   (
            SUM(X.SLE_AMT)
          , SUM(X.SLE_QTY) CNT
            FOR MM
            IN  ('01' M01,'02' M02,'03' M03,'04' M04,'05' M05,'06' M06
                ,'07' M07,'08' M08,'09' M09,'10' M10,'11' M11,'12' M12)
        )   A
      , CF07    SH
WHERE   1 = 1
AND     SH.SHP_NO = A.SHP_NO
ORDER BY
        A.SHP_NO
;

-- 쿼리. 155

-- :tday = 20220108

SELECT  
        '재고집계'  WRK
      , :tday       INV_BS_DT
      , IVD.SHP_NO
      , IVD.ITM_NO
      , IVD.INV_QTY
FROM    (
        SELECT  MAX(INV_BS_DT)  INV_BS_DT
        FROM    CF17
        )   IV
      , CF18    IVD
WHERE   1 = 1
AND     IVD.INV_BS_DT = IV.INV_BS_DT
AND     IVD.ITM_NO = 1089
ORDER BY
        IVD.SHP_NO
;

-- 쿼리. 156

-- :tday = 20220108

SELECT  
        '입고'      WRK
      , :tday       INV_BS_DT
      , IO.IN_SHP_NO
      , IOI.ITM_NO
      , SUM(IOI.INOUT_QTY)   INOUT_QTY
FROM    (
        SELECT  TO_CHAR(TO_DATE(MAX(INV_BS_DT)) + 1, 'YYYYMMDD')    INV_BS_DT
        FROM    CF17
        )   IV
      , CF14    IO
      , CF15    IOI
WHERE   1 = 1
AND     IOI.INOUT_NO = IO.INOUT_NO
AND     IO.INOUT_DT BETWEEN IV.INV_BS_DT AND :tday
AND     IO.INOUT_TY_CD = '10'
AND     IOI.ITM_NO = 1089
GROUP BY
        IO.IN_SHP_NO
      , IOI.ITM_NO
ORDER BY
        IO.IN_SHP_NO
      , IOI.ITM_NO
;

-- 쿼리. 157

-- :tday = 20220108

SELECT  
        '출고'      WRK
      , :tday       INV_BS_DT
      , CASE
            WHEN LV = 1 THEN IO.IN_SHP_NO   /* 매장으로 입고 */
            WHEN LV = 2 THEN IO.OUT_SHP_NO  /* 본사에서 출고 */
        END SHP_NO
      , IOI.ITM_NO
      , CASE
            WHEN LV = 1 THEN SUM(IOI.INOUT_QTY)
            ELSE -SUM(IOI.INOUT_QTY)
        END     INOUT_QTY
FROM    (
        SELECT  TO_CHAR(TO_DATE(MAX(INV_BS_DT)) + 1, 'YYYYMMDD')    INV_BS_DT
        FROM    CF17
        )   IV
      , CF14    IO
      , CF15    IOI
      , (SELECT LEVEL LV FROM DUAL CONNECT BY LEVEL <= 2)   /* 데이터 복제 */
WHERE   1 = 1
AND     IO.INOUT_NO = IOI.INOUT_NO
AND     IO.INOUT_DT BETWEEN IV.INV_BS_DT AND :tday
AND     IO.INOUT_TY_CD = '11'
AND     IOI.ITM_NO = 1089
GROUP BY
        LV
      , CASE
            WHEN LV = 1 THEN IO.IN_SHP_NO
            WHEN LV = 2 THEN IO.OUT_SHP_NO
        END
      , IOI.ITM_NO
ORDER BY
        LV
      , SHP_NO
;

-- 쿼리. 158

-- :tday = 20220108

SELECT
        WRK
      , INV_BS_DT
      , SHP_NO
      , ITM_NO
      , -SUM(SLE_QTY)/D     SLE_QTY
FROM    (
        SELECT  
                '판매'      WRK
              , :tday       INV_BS_DT
              , S.SHP_NO
              , NVL(IM.MTRL_ITM_NO, SI.ITM_NO)  ITM_NO
              , SI.SLE_QTY
              , CASE
                    WHEN IM.MTRL_ITM_NO IS NULL THEN 1
                    ELSE I.ITM_CAPA_QTY / IM.USE_CAPA_QTY 
                END    D
        FROM    (
                SELECT  TO_CHAR(TO_DATE(MAX(INV_BS_DT)) + 1, 'YYYYMMDD')   INV_BS_DT
                FROM    CF17
                )   IV
              , CF10    S
              , CF11    SI
              , CF03    IM
              , CF01    I
        WHERE   1 = 1
        AND     SI.SLE_NO = S.SLE_NO
        AND     IM.ITM_NO(+) = SI.ITM_NO
        AND     I.ITM_NO(+) = IM.MTRL_ITM_NO
        AND     S.SLE_DT BETWEEN IV.INV_BS_DT AND :tday
        AND     SI.ITM_NO IN (1000,1001,1002,1009,1010) -- 1089를 원재료로 사용하는 상품
        )   A
GROUP BY
        WRK
      , INV_BS_DT
      , SHP_NO
      , ITM_NO
      , D
ORDER BY
        SHP_NO
;

-- 쿼리. 159

-- :tday = 20220108

SELECT  
        '재고'  WRK
      , :tday       INV_BS_DT
      , IVD.SHP_NO
      , IVD.ITM_NO
      , IVD.INV_QTY
FROM    (
        SELECT  MAX(INV_BS_DT)  INV_BS_DT
        FROM    CF17
        )   IV
      , CF18    IVD
WHERE   1 = 1
AND     IVD.INV_BS_DT = IV.INV_BS_DT
AND     IVD.ITM_NO = 1089
UNION ALL
SELECT  
        '입고'      WRK
      , :tday       INV_BS_DT
      , IO.IN_SHP_NO
      , IOI.ITM_NO
      , SUM(IOI.INOUT_QTY)   INOUT_QTY
FROM    (
            SELECT  TO_CHAR(TO_DATE(MAX(INV_BS_DT)) + 1, 'YYYYMMDD')    INV_BS_DT
            FROM    CF17
        )   IV
      , CF14    IO
      , CF15    IOI
WHERE   1 = 1
AND     IOI.INOUT_NO = IO.INOUT_NO
AND     IO.INOUT_DT BETWEEN IV.INV_BS_DT AND :tday
AND     IO.INOUT_TY_CD = '10'
AND     IOI.ITM_NO = 1089
GROUP BY
        IO.IN_SHP_NO
      , IOI.ITM_NO
UNION ALL
SELECT  
        '출고'      WRK
      , :tday       INV_BS_DT
      , CASE
            WHEN LV = 1 THEN IO.IN_SHP_NO   /* 매장으로 입고 */
            WHEN LV = 2 THEN IO.OUT_SHP_NO  /* 본사에서 출고 */
        END SHP_NO
      , IOI.ITM_NO
      , CASE
            WHEN LV = 1 THEN SUM(IOI.INOUT_QTY)
            ELSE -SUM(IOI.INOUT_QTY)
        END     INOUT_QTY
FROM    (
        SELECT  TO_CHAR(TO_DATE(MAX(INV_BS_DT)) + 1, 'YYYYMMDD')    INV_BS_DT
        FROM    CF17
        )   IV
      , CF14    IO
      , CF15    IOI
      , (SELECT LEVEL LV FROM DUAL CONNECT BY LEVEL <= 2)   /* 데이터 복제 */
WHERE   1 = 1
AND     IO.INOUT_NO = IOI.INOUT_NO
AND     IO.INOUT_DT BETWEEN IV.INV_BS_DT AND :tday
AND     IO.INOUT_TY_CD = '11'
AND     IOI.ITM_NO = 1089
GROUP BY
        LV
      , CASE
            WHEN LV = 1 THEN IO.IN_SHP_NO
            WHEN LV = 2 THEN IO.OUT_SHP_NO
        END
      , IOI.ITM_NO
UNION ALL
SELECT
        WRK
      , INV_BS_DT
      , SHP_NO
      , ITM_NO
      , -SUM(SLE_QTY)/D     SLE_QTY
FROM    (
        SELECT  
                '판매'      WRK
              , :tday       INV_BS_DT
              , S.SHP_NO
              , NVL(IM.MTRL_ITM_NO, SI.ITM_NO)  ITM_NO
              , SI.SLE_QTY
              , CASE
                    WHEN IM.MTRL_ITM_NO IS NULL THEN 1
                    ELSE I.ITM_CAPA_QTY / IM.USE_CAPA_QTY 
                END    D
        FROM    (
                SELECT  TO_CHAR(TO_DATE(MAX(INV_BS_DT)) + 1, 'YYYYMMDD')   INV_BS_DT
                FROM    CF17
                )   IV
              , CF10    S
              , CF11    SI
              , CF03    IM
              , CF01    I
        WHERE   1 = 1
        AND     SI.SLE_NO = S.SLE_NO
        AND     IM.ITM_NO(+) = SI.ITM_NO
        AND     I.ITM_NO(+) = IM.MTRL_ITM_NO
        AND     S.SLE_DT BETWEEN IV.INV_BS_DT AND :tday
        AND     SI.ITM_NO IN (1000,1001,1002,1009,1010) -- 1089를 원재료로 사용하는 상품
        )   A
GROUP BY
        WRK
      , INV_BS_DT
      , SHP_NO
      , ITM_NO
      , D
;

-- 쿼리. 160

-- :tday = 20220108

SELECT  
        A.INV_BS_DT
      , A.SHP_NO
      , A.ITM_NO
      , SUM(A.INV_QTY)      INV_QTY
FROM    (
        SELECT  
                '재고'  WRK
              , :tday       INV_BS_DT
              , IVD.SHP_NO
              , IVD.ITM_NO
              , IVD.INV_QTY
        FROM    (
                SELECT  MAX(INV_BS_DT)  INV_BS_DT
                FROM    CF17
                )   IV
              , CF18    IVD
        WHERE   1 = 1
        AND     IVD.INV_BS_DT = IV.INV_BS_DT
        AND     IVD.ITM_NO = 1089
        UNION ALL
        SELECT  
                '입고'      WRK
              , :tday       INV_BS_DT
              , IO.IN_SHP_NO
              , IOI.ITM_NO
              , SUM(IOI.INOUT_QTY)   INOUT_QTY
        FROM    (
                SELECT  TO_CHAR(TO_DATE(MAX(INV_BS_DT)) + 1, 'YYYYMMDD')    INV_BS_DT
                FROM    CF17
                )   IV
              , CF14    IO
              , CF15    IOI
        WHERE   1 = 1
        AND     IOI.INOUT_NO = IO.INOUT_NO
        AND     IO.INOUT_DT BETWEEN IV.INV_BS_DT AND :tday
        AND     IO.INOUT_TY_CD = '10'
        AND     IOI.ITM_NO = 1089
        GROUP BY
                IO.IN_SHP_NO
              , IOI.ITM_NO
        UNION ALL
        SELECT  
                '출고'      WRK
              , :tday       INV_BS_DT
              , CASE
                    WHEN LV = 1 THEN IO.IN_SHP_NO   /* 매장으로 입고 */
                    WHEN LV = 2 THEN IO.OUT_SHP_NO  /* 본사에서 출고 */
                END SHP_NO
              , IOI.ITM_NO
              , CASE
                    WHEN LV = 1 THEN SUM(IOI.INOUT_QTY)
                    ELSE -SUM(IOI.INOUT_QTY)
                END     INOUT_QTY
        FROM    (
                SELECT  TO_CHAR(TO_DATE(MAX(INV_BS_DT)) + 1, 'YYYYMMDD')    INV_BS_DT
                FROM    CF17
                )   IV
              , CF14    IO
              , CF15    IOI
              , (SELECT LEVEL LV FROM DUAL CONNECT BY LEVEL <= 2)   /* 데이터 복제 */
        WHERE   1 = 1
        AND     IO.INOUT_NO = IOI.INOUT_NO
        AND     IO.INOUT_DT BETWEEN IV.INV_BS_DT AND :tday
        AND     IO.INOUT_TY_CD = '11'
        AND     IOI.ITM_NO = 1089
        GROUP BY
                LV
              , CASE
                    WHEN LV = 1 THEN IO.IN_SHP_NO
                    WHEN LV = 2 THEN IO.OUT_SHP_NO
                END
              , IOI.ITM_NO
        UNION ALL
        SELECT
                WRK
              , INV_BS_DT
              , SHP_NO
              , ITM_NO
              , -SUM(SLE_QTY)/D     SLE_QTY
        FROM    (
                SELECT  
                        '판매'      WRK
                      , :tday       INV_BS_DT
                      , S.SHP_NO
                      , NVL(IM.MTRL_ITM_NO, SI.ITM_NO)  ITM_NO
                      , SI.SLE_QTY
                      , CASE
                            WHEN IM.MTRL_ITM_NO IS NULL THEN 1
                            ELSE I.ITM_CAPA_QTY / IM.USE_CAPA_QTY 
                        END    D
                FROM    (
                        SELECT  TO_CHAR(TO_DATE(MAX(INV_BS_DT))+1, 'YYYYMMDD') INV_BS_DT
                        FROM    CF17
                        )   IV
                      , CF10    S
                      , CF11    SI
                      , CF03    IM
                      , CF01    I
                WHERE   1 = 1
                AND     SI.SLE_NO = S.SLE_NO
                AND     IM.ITM_NO(+) = SI.ITM_NO
                AND     I.ITM_NO(+) = IM.MTRL_ITM_NO
                AND     S.SLE_DT BETWEEN IV.INV_BS_DT AND :tday
                AND     SI.ITM_NO IN (1000,1001,1002,1009,1010)
                )   A
        GROUP BY
                WRK
              , INV_BS_DT
              , SHP_NO
              , ITM_NO
              , D
        )   A
WHERE   1 = 1
GROUP BY
        A.INV_BS_DT
      , A.SHP_NO
      , A.ITM_NO
ORDER BY
        A.INV_BS_DT
      , A.SHP_NO
      , A.ITM_NO
;

-- 쿼리. 161

-- :tday = 20220108

SELECT  
        A.INV_BS_DT
      , A.SHP_NO
      , (SELECT SHP_NM FROM CF07 SH WHERE SH.SHP_NO = A.SHP_NO)     SHP_NM
      , A.ITM_NO
      , (SELECT ITM_NM FROM CF01 I WHERE I.ITM_NO = A.ITM_NO)       ITM_NM
      , SUM(A.INV_QTY)      INV_QTY
FROM    (
        SELECT  
                '재고'  WRK
              , :tday       INV_BS_DT
              , IVD.SHP_NO
              , IVD.ITM_NO
              , IVD.INV_QTY
        FROM    (
                SELECT  MAX(INV_BS_DT)  INV_BS_DT
                FROM    CF17
                )   IV
              , CF18    IVD
        WHERE   1 = 1
        AND     IVD.INV_BS_DT = IV.INV_BS_DT
        UNION ALL
        SELECT  
                '입고'      WRK
              , :tday       INV_BS_DT
              , IO.IN_SHP_NO
              , IOI.ITM_NO
              , SUM(IOI.INOUT_QTY)   INOUT_QTY
        FROM    (
                SELECT  TO_CHAR(TO_DATE(MAX(INV_BS_DT)) + 1, 'YYYYMMDD')    INV_BS_DT
                FROM    CF17
                )   IV
              , CF14    IO
              , CF15    IOI
        WHERE   1 = 1
        AND     IOI.INOUT_NO = IO.INOUT_NO
        AND     IO.INOUT_DT BETWEEN IV.INV_BS_DT AND :tday
        AND     IO.INOUT_TY_CD = '10'
        GROUP BY
                IO.IN_SHP_NO
              , IOI.ITM_NO
        UNION ALL
        SELECT  
                '출고'      WRK
              , :tday       INV_BS_DT
              , CASE
                    WHEN LV = 1 THEN IO.IN_SHP_NO   /* 매장으로 입고 */
                    WHEN LV = 2 THEN IO.OUT_SHP_NO  /* 본사에서 출고 */
                END SHP_NO
              , IOI.ITM_NO
              , CASE
                    WHEN LV = 1 THEN SUM(IOI.INOUT_QTY)
                    ELSE -SUM(IOI.INOUT_QTY)
                END     INOUT_QTY
        FROM    (
                SELECT  TO_CHAR(TO_DATE(MAX(INV_BS_DT)) + 1, 'YYYYMMDD')    INV_BS_DT
                FROM    CF17
                )   IV
              , CF14    IO
              , CF15    IOI
              , (SELECT LEVEL LV FROM DUAL CONNECT BY LEVEL <= 2)   /* 데이터 복제 */
        WHERE   1 = 1
        AND     IO.INOUT_NO = IOI.INOUT_NO
        AND     IO.INOUT_DT BETWEEN IV.INV_BS_DT AND :tday
        AND     IO.INOUT_TY_CD = '11'
        GROUP BY
                LV
              , CASE
                    WHEN LV = 1 THEN IO.IN_SHP_NO
                    WHEN LV = 2 THEN IO.OUT_SHP_NO
                END
              , IOI.ITM_NO
        UNION ALL
        SELECT
                WRK
              , INV_BS_DT
              , SHP_NO
              , ITM_NO
              , -SUM(SLE_QTY)/D     SLE_QTY
        FROM    (
                SELECT  
                        '판매'      WRK
                      , :tday       INV_BS_DT
                      , S.SHP_NO
                      , NVL(IM.MTRL_ITM_NO, SI.ITM_NO)  ITM_NO
                      , SI.SLE_QTY
                      , CASE
                            WHEN IM.MTRL_ITM_NO IS NULL THEN 1
                            ELSE I.ITM_CAPA_QTY / IM.USE_CAPA_QTY 
                        END    D
                FROM    (
                        SELECT  TO_CHAR(TO_DATE(MAX(INV_BS_DT))+1, 'YYYYMMDD') INV_BS_DT
                        FROM    CF17
                        )   IV
                      , CF10    S
                      , CF11    SI
                      , CF03    IM
                      , CF01    I
                WHERE   1 = 1
                AND     SI.SLE_NO = S.SLE_NO
                AND     IM.ITM_NO(+) = SI.ITM_NO
                AND     I.ITM_NO(+) = IM.MTRL_ITM_NO
                AND     S.SLE_DT BETWEEN IV.INV_BS_DT AND :tday
                )   A
        GROUP BY
                WRK
              , INV_BS_DT
              , SHP_NO
              , ITM_NO
              , D
        )   A
WHERE   1 = 1
GROUP BY
        A.INV_BS_DT
      , A.SHP_NO
      , A.ITM_NO
ORDER BY
        A.INV_BS_DT
      , A.SHP_NO
      , A.ITM_NO
;

-- 쿼리. 162

SELECT  
        '재고'    WRK
      , TO_CHAR(TO_DATE(IV.INV_BS_DT) + 1, 'YYYYMMDD')      INV_BS_DT   -- 수정
      , IVD.SHP_NO
      , IVD.ITM_NO
      , IVD.INV_QTY
FROM    (
        SELECT  MAX(INV_BS_DT)  INV_BS_DT
        FROM    CF17
        )   IV
      , CF18    IVD
WHERE   1 = 1
AND     IVD.INV_BS_DT = IV.INV_BS_DT
UNION ALL
SELECT  
        '입고'    WRK
      , IV.INV_BS_DT        INV_BS_DT       -- 수정
      , IO.IN_SHP_NO
      , IOI.ITM_NO
      , SUM(IOI.INOUT_QTY)  INOUT_QTY
FROM    (
        SELECT  TO_CHAR(TO_DATE(MAX(INV_BS_DT)) + 1, 'YYYYMMDD')    INV_BS_DT
        FROM    CF17
        )   IV
      , CF14    IO
      , CF15    IOI
WHERE   1 = 1
AND     IOI.INOUT_NO = IO.INOUT_NO
AND     IO.INOUT_DT = IV.INV_BS_DT          -- 수정
AND     IO.INOUT_TY_CD = '10'
GROUP BY
        IV.INV_BS_DT                        -- 추가
      , IO.IN_SHP_NO
      , IOI.ITM_NO
UNION ALL
SELECT  
        '출고'    WRK
      , IV.INV_BS_DT        INV_BS_DT       -- 수정
      , CASE
            WHEN LV = 1 THEN IO.IN_SHP_NO   /* 매장으로 입고 */
            WHEN LV = 2 THEN IO.OUT_SHP_NO  /* 본사에서 출고 */
        END SHP_NO
      , IOI.ITM_NO
      , CASE
            WHEN LV = 1 THEN SUM(IOI.INOUT_QTY)
            ELSE -SUM(IOI.INOUT_QTY)
        END     INOUT_QTY
FROM    (
        SELECT  TO_CHAR(TO_DATE(MAX(INV_BS_DT)) + 1, 'YYYYMMDD')    INV_BS_DT
        FROM    CF17
        )   IV
      , CF14    IO
      , CF15    IOI
      , (SELECT LEVEL LV FROM DUAL CONNECT BY LEVEL <= 2)   /* 데이터 복제 */
WHERE   1 = 1
AND     IO.INOUT_NO = IOI.INOUT_NO
AND     IO.INOUT_DT = IV.INV_BS_DT          -- 수정
AND     IO.INOUT_TY_CD = '11'
GROUP BY
        IV.INV_BS_DT                        -- 추가
      , LV
      , CASE
            WHEN LV = 1 THEN IO.IN_SHP_NO
            WHEN LV = 2 THEN IO.OUT_SHP_NO
        END
      , IOI.ITM_NO
UNION ALL
SELECT
        WRK
      , INV_BS_DT
      , SHP_NO
      , ITM_NO
      , -SUM(SLE_QTY)/D     SLE_QTY
FROM    (
        SELECT  
                '판매'      WRK
              , IV.INV_BS_DT        INV_BS_DT       -- 수정
              , S.SHP_NO
              , NVL(IM.MTRL_ITM_NO, SI.ITM_NO)  ITM_NO
              , SI.SLE_QTY
              , CASE
                    WHEN IM.MTRL_ITM_NO IS NULL THEN 1
                    ELSE I.ITM_CAPA_QTY / IM.USE_CAPA_QTY 
                END    D
        FROM    (
                SELECT  TO_CHAR(TO_DATE(MAX(INV_BS_DT))+1, 'YYYYMMDD') INV_BS_DT
                FROM    CF17
                )   IV
              , CF10    S
              , CF11    SI
              , CF03    IM
              , CF01    I
        WHERE   1 = 1
        AND     SI.SLE_NO = S.SLE_NO
        AND     IM.ITM_NO(+) = SI.ITM_NO
        AND     I.ITM_NO(+) = IM.MTRL_ITM_NO
        AND     S.SLE_DT = IV.INV_BS_DT             -- 수정
        )   A
GROUP BY
        WRK
      , INV_BS_DT
      , SHP_NO
      , ITM_NO
      , D
;

-- 쿼리. 163

SELECT  
        A.INV_BS_DT
      , A.SHP_NO
      , A.ITM_NO
      , SUM(A.INV_QTY)      INV_QTY
FROM    (
        SELECT  
                '재고'    WRK
              , TO_CHAR(TO_DATE(IV.INV_BS_DT) + 1, 'YYYYMMDD')      INV_BS_DT   -- 수정
              , IVD.SHP_NO
              , IVD.ITM_NO
              , IVD.INV_QTY
        FROM    (
                SELECT  MAX(INV_BS_DT)  INV_BS_DT
                FROM    CF17
                )   IV
              , CF18    IVD
        WHERE   1 = 1
        AND     IVD.INV_BS_DT = IV.INV_BS_DT
        UNION ALL
        SELECT  
                '입고'    WRK
              , IV.INV_BS_DT        INV_BS_DT       -- 수정
              , IO.IN_SHP_NO
              , IOI.ITM_NO
              , SUM(IOI.INOUT_QTY)  INOUT_QTY
        FROM    (
                SELECT  TO_CHAR(TO_DATE(MAX(INV_BS_DT)) + 1, 'YYYYMMDD')    INV_BS_DT
                FROM    CF17
                )   IV
              , CF14    IO
              , CF15    IOI
        WHERE   1 = 1
        AND     IOI.INOUT_NO = IO.INOUT_NO
        AND     IO.INOUT_DT = IV.INV_BS_DT          -- 수정
        AND     IO.INOUT_TY_CD = '10'
        GROUP BY
                IV.INV_BS_DT                        -- 추가
              , IO.IN_SHP_NO
              , IOI.ITM_NO
        UNION ALL
        SELECT  
                '출고'    WRK
              , IV.INV_BS_DT        INV_BS_DT       -- 수정
              , CASE
                    WHEN LV = 1 THEN IO.IN_SHP_NO   /* 매장으로 입고 */
                    WHEN LV = 2 THEN IO.OUT_SHP_NO  /* 본사에서 출고 */
                END SHP_NO
              , IOI.ITM_NO
              , CASE
                    WHEN LV = 1 THEN SUM(IOI.INOUT_QTY)
                    ELSE -SUM(IOI.INOUT_QTY)
                END     INOUT_QTY
        FROM    (
                SELECT  TO_CHAR(TO_DATE(MAX(INV_BS_DT)) + 1, 'YYYYMMDD')    INV_BS_DT
                FROM    CF17
                )   IV
              , CF14    IO
              , CF15    IOI
              , (SELECT LEVEL LV FROM DUAL CONNECT BY LEVEL <= 2)   /* 데이터 복제 */
        WHERE   1 = 1
        AND     IO.INOUT_NO = IOI.INOUT_NO
        AND     IO.INOUT_DT = IV.INV_BS_DT          -- 수정
        AND     IO.INOUT_TY_CD = '11'
        GROUP BY
                IV.INV_BS_DT                        -- 추가
              , LV
              , CASE
                    WHEN LV = 1 THEN IO.IN_SHP_NO
                    WHEN LV = 2 THEN IO.OUT_SHP_NO
                END
              , IOI.ITM_NO
        UNION ALL
        SELECT
                WRK
              , INV_BS_DT
              , SHP_NO
              , ITM_NO
              , -SUM(SLE_QTY)/D     SLE_QTY
        FROM    (
                SELECT  
                        '판매'      WRK
                      , IV.INV_BS_DT        INV_BS_DT       -- 수정
                      , S.SHP_NO
                      , NVL(IM.MTRL_ITM_NO, SI.ITM_NO)  ITM_NO
                      , SI.SLE_QTY
                      , CASE
                            WHEN IM.MTRL_ITM_NO IS NULL THEN 1
                            ELSE I.ITM_CAPA_QTY / IM.USE_CAPA_QTY 
                        END    D
                FROM    (
                        SELECT  TO_CHAR(TO_DATE(MAX(INV_BS_DT))+1, 'YYYYMMDD') INV_BS_DT
                        FROM    CF17
                        )   IV
                      , CF10    S
                      , CF11    SI
                      , CF03    IM
                      , CF01    I
                WHERE   1 = 1
                AND     SI.SLE_NO = S.SLE_NO
                AND     IM.ITM_NO(+) = SI.ITM_NO
                AND     I.ITM_NO(+) = IM.MTRL_ITM_NO
                AND     S.SLE_DT = IV.INV_BS_DT             -- 수정
                )   A
        GROUP BY
                WRK
              , INV_BS_DT
              , SHP_NO
              , ITM_NO
              , D
        )   A
WHERE   1 = 1
GROUP BY
        A.INV_BS_DT
      , A.SHP_NO
      , A.ITM_NO
ORDER BY
        A.INV_BS_DT
      , A.SHP_NO
      , A.ITM_NO
;

-- 쿼리. 164

INSERT  INTO    CF18 (
        INV_BS_DT
      , SHP_NO
      , ITM_NO
      , INV_QTY
      , REG_EMP_NO
      , MOD_EMP_NO
)
SELECT  
        A.INV_BS_DT
      , A.SHP_NO
      , A.ITM_NO
      , SUM(A.INV_QTY)      INV_QTY
      , :empNo              REG_EMP_NO
      , :empNo              MOD_EMP_NO
FROM    (
        SELECT  
                '재고'    WRK
              , TO_CHAR(TO_DATE(IV.INV_BS_DT) + 1, 'YYYYMMDD')      INV_BS_DT   -- 수정
              , IVD.SHP_NO
              , IVD.ITM_NO
              , IVD.INV_QTY
        FROM    (
                SELECT  MAX(INV_BS_DT)  INV_BS_DT
                FROM    CF17
                )   IV
              , CF18    IVD
        WHERE   1 = 1
        AND     IVD.INV_BS_DT = IV.INV_BS_DT
        UNION ALL
        SELECT  
                '입고'    WRK
              , IV.INV_BS_DT        INV_BS_DT       -- 수정
              , IO.IN_SHP_NO
              , IOI.ITM_NO
              , SUM(IOI.INOUT_QTY)  INOUT_QTY
        FROM    (
                SELECT  TO_CHAR(TO_DATE(MAX(INV_BS_DT)) + 1, 'YYYYMMDD')    INV_BS_DT
                FROM    CF17
                )   IV
              , CF14    IO
              , CF15    IOI
        WHERE   1 = 1
        AND     IOI.INOUT_NO = IO.INOUT_NO
        AND     IO.INOUT_DT = IV.INV_BS_DT          -- 수정
        AND     IO.INOUT_TY_CD = '10'
        GROUP BY
                IV.INV_BS_DT                        -- 추가
              , IO.IN_SHP_NO
              , IOI.ITM_NO
        UNION ALL
        SELECT  
                '출고'    WRK
              , IV.INV_BS_DT        INV_BS_DT       -- 수정
              , CASE
                    WHEN LV = 1 THEN IO.IN_SHP_NO   /* 매장으로 입고 */
                    WHEN LV = 2 THEN IO.OUT_SHP_NO  /* 본사에서 출고 */
                END SHP_NO
              , IOI.ITM_NO
              , CASE
                    WHEN LV = 1 THEN SUM(IOI.INOUT_QTY)
                    ELSE -SUM(IOI.INOUT_QTY)
                END     INOUT_QTY
        FROM    (
                SELECT  TO_CHAR(TO_DATE(MAX(INV_BS_DT)) + 1, 'YYYYMMDD')    INV_BS_DT
                FROM    CF17
                )   IV
              , CF14    IO
              , CF15    IOI
              , (SELECT LEVEL LV FROM DUAL CONNECT BY LEVEL <= 2)   /* 데이터 복제 */
        WHERE   1 = 1
        AND     IO.INOUT_NO = IOI.INOUT_NO
        AND     IO.INOUT_DT = IV.INV_BS_DT          -- 수정
        AND     IO.INOUT_TY_CD = '11'
        GROUP BY
                IV.INV_BS_DT                        -- 추가
              , LV
              , CASE
                    WHEN LV = 1 THEN IO.IN_SHP_NO
                    WHEN LV = 2 THEN IO.OUT_SHP_NO
                END
              , IOI.ITM_NO
        UNION ALL
        SELECT
                WRK
              , INV_BS_DT
              , SHP_NO
              , ITM_NO
              , -SUM(SLE_QTY)/D     SLE_QTY
        FROM    (
                SELECT  
                        '판매'      WRK
                      , IV.INV_BS_DT        INV_BS_DT       -- 수정
                      , S.SHP_NO
                      , NVL(IM.MTRL_ITM_NO, SI.ITM_NO)  ITM_NO
                      , SI.SLE_QTY
                      , CASE
                            WHEN IM.MTRL_ITM_NO IS NULL THEN 1
                            ELSE I.ITM_CAPA_QTY / IM.USE_CAPA_QTY 
                        END    D
                FROM    (
                        SELECT  TO_CHAR(TO_DATE(MAX(INV_BS_DT))+1, 'YYYYMMDD') INV_BS_DT
                        FROM    CF17
                        )   IV
                      , CF10    S
                      , CF11    SI
                      , CF03    IM
                      , CF01    I
                WHERE   1 = 1
                AND     SI.SLE_NO = S.SLE_NO
                AND     IM.ITM_NO(+) = SI.ITM_NO
                AND     I.ITM_NO(+) = IM.MTRL_ITM_NO
                AND     S.SLE_DT = IV.INV_BS_DT             -- 수정
                )   A
        GROUP BY
                WRK
              , INV_BS_DT
              , SHP_NO
              , ITM_NO
              , D
        )   A
WHERE   1 = 1
GROUP BY
        A.INV_BS_DT
      , A.SHP_NO
      , A.ITM_NO
;

-- 쿼리. 165

INSERT  INTO CF17 (
        INV_BS_DT
      , SUM_CP_DTT
      , REG_EMP_NO
      , MOD_EMP_NO
)
SELECT  
        TO_CHAR(TO_DATE(MAX(INV_BS_DT)) + 1, 'YYYYMMDD')    INV_BS_DT
      , SYSDATE         SUM_CP_DTT
      , :empNo          REG_EMP_NO
      , :empNo          MOD_EMP_NO
FROM    CF17
;

