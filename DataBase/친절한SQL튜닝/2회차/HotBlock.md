```sql
여러프로세스들이 사용하는 가장많이 접근하는 블록 = Hot Block
HotBlock이 있는 대표적인 예(가장많이 조회,변경이 일어나는 블록)
==> 디스크I/O가 없더라도 메모리상에서 프로세스간 경합이 발생하여 성능저하가 발생할 수 있음. 
  예)
  1. 일련번호/입력일시 컬럼에 인덱스가 있고 그 인덱스 리프블럭 중 맨 오른쪽블록(Right-Growing-Index)
  2. dual테이블
  3. 입력일시/변경일시 컬럼이 있는 테이블
  4. 채번테이블

1. Right-Growing-Index의 해결책: 해시파티션
- 인덱스를 파티셔닝함.
- 세그먼트를 여러개만듬
- 예를들어, 인덱스를 4개의 서브파티션으로 나누면 동시엑세스가 4개의 블록으로 분산됨

2. dual테이블에 대한 자세한 설명

SQL> SELECT dummy FROM dual;

Execution Plan
----------------------------------------------------------
Plan hash value: 272002086

--------------------------------------------------------------------------
| Id  | Operation         | Name | Rows  | Bytes | Cost (%CPU)| Time     |
--------------------------------------------------------------------------
|   0 | SELECT STATEMENT  |      |     1 |     2 |     2   (0)| 00:00:01 |
|   1 |  TABLE ACCESS FULL| DUAL |     1 |     2 |     2   (0)| 00:00:01 |
--------------------------------------------------------------------------


Statistics
----------------------------------------------------------
          0  recursive calls
          0  db block gets
          3  consistent gets
          0  physical reads
          0  redo size
        371  bytes sent via SQL*Net to client
        344  bytes received via SQL*Net from client
          2  SQL*Net roundtrips to/from client
          0  sorts (memory)
          0  sorts (disk)
          1  rows processed


[★★★★★]
==> 메모리에서 I/O해옴.
==> WAS, sqlClient는 conn이 살아있는지 확인하기 위해 dual테이블을 몇초단위로 조회한다.   
DUAL 테이블의 블록이 소속된 해시체인의 다른 블록들에게 경합문제를 발생시킬 수 있다.


-- SELECT절에 컬럼/ * 을 명시하면
-- 실제 값을 읽기 때문에 I/O 발생함.
select dummy from dual
select * from dual

-- consistent gets: 0, I/O 발생안함.
-- fast dual 실제로 데이터 안 읽음
-- I/O가 발생하지 않음 그러나 DBCall이 발생하는 것이기에 너무 dual을 남발하지 말것.
-- 개발언어단에서 가능하면 DBCall을 줄여라(날짜, 형변환)
select 1 from dual
select sysdate from dual

```