# sqlplus로 sys계정 접근하는 방법

방법1

```sql
-- CDB SYS계정으로 접속
OS> sqlplus "/as sysdba" -- 네트워크 안탐
OS> sqlplus  sys/1234@orcl as sysdba -- 네트워크 탐
```

방법2

```sql
-- CDB SYS계정으로 접속
OS> sqlplus /nolog
SQL> connect /as sysdba

SQL>  show con_name

CON_NAME
------------------------------
CDB$ROOT
```



# pdb open방법

```sql
-- CDB SYS계정으로 접속
OS> sqlplus "/as sysdba"

-- 현재 접속중인 계정
SELECT USER FROM DUAL;

USER
-----
SYS

-- 현재 접속중인 테넌트(YES=>CDB, NO=>PDB)
SELECT CDB FROM V$DATABASE;

CDB
---
YES

-- 컨테이너의 상태 조회
select con_id, name, open_mode from v$containers;

CON_ID  NAME        OPEN_MODE
------- ----------- ----------
1       CDB$ROOT    READ WRITE
2       PDB$SEED    READ ONLY
3       ORCLPDB     MOUNTED

-- PDB를 OPEN시키자
-- (ORA-01109 : 데이터베이스가 개방되지 않았습니다의 해결책이다)
alter pluggable database orclpdb open; -- MOUNTED => READ WRITE

select con_id, name, open_mode from v$containers;

CON_ID  NAME        OPEN_MODE
------- ----------- ----------
     1  CDB$ROOT    READ WRITE
     2  PDB$SEED    READ ONLY
     3  ORCLPDB     READ WRITE

-- pdb전체조회
select con_id, name, open_mode from v$pdbs;

CON_ID NAME         OPEN_MODE
------ ------------ ----------
     2 PDB$SEED     READ ONLY
     3 ORCLPDB      READ WRITE

-- 계정만들기
create user edu01 identified by 1234

```



# PDB 접속방법

## 방법1. SQLDeveloper에서 PDB로 접속하기

```
사용자이름: SYSTEM
비밀번호: 1234
롤: 기본값

서비스이름: orclpdb
```

```sql
-- pdb전체조회
select con_id, name, open_mode from v$pdbs;


```

## 방법2. SQLPlus에서 PDB접속하기

2-1.

```sql
OS> sqlplus /nolog
SQL> connect /as sysdba;
SQL> show con_name
CON_NAME
------------------------------
CDB$ROOT

SQL> alter session set container=orclpdb;
SQL> show con_name
CON_NAME
--------
ORCLPDB
```

2-2.

```sql
OS> sqlplus sys@orclpdb as sysdba
SQL> show con_name
CON_NAME
--------
ORCLPDB
```



