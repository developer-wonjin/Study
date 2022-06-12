```sql
여러프로세스들이 사용하는 가장많이 접근하는 블록 = Hot Block
HotBlock이 있는 대표적인 예(가장많이 조회,변경이 일어나는 블록)
==> 디스크I/O가 없더라도 메모리상에서 프로세스간 경합이 발생하여 성능저하가 발생할 수 있음. 
  예)
  1. Right-Growing-Index
    : 일련번호/입력일시 컬럼에 인덱스가 있고 그 인덱스 리프블럭 중 맨 오른쪽블록
  2. dual테이블
  3. 입력일시/변경일시 컬럼이 있는 테이블
  4. 채번테이블

1. Right-Growing-Index의 해결책: 해시파티션
- 인덱스를 파티셔닝함
- 세그먼트를 여러개만듬
- 인덱스를 4개의 서브파티션으로 나누면 동시엑세스가 4개의 블록으로 분산됨

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


4. 채번테이블에 대한 해결책

`경합이 많이 발생하는 빈도`: 채번테이블의 블럭이 관리하는 테이블이 A~C일 떄 < 블럭이 관리하는 테이블이 A~Z일 떄
(
  여러 프로세스들이 같은 테이블을 채번하려는 경우, 프로세스들이 같은 블록>같은레코드에 접근하므로 RowLock이 걸리는 것이 어쩔 수 없다.
  RowLock은 사용자의 commit & rollback에 의해 결정되므로 해결할 방법이 없다.
  따라서, 채번테이블은 rowLock 경합때문에 동일 테이블에 대한 채번 `동시 INSERT`가 많은 경우 사용불가능함
)
  반면,
  여러 프로세스들이 다른 테이블을 채번하려는 경우, 블록이 관리하고 있는 테이블종류가 많을 수록 더 많은 프로세스들이 접근하려하므로 프로세스들을 래치,버퍼락에 의해 기다려야 한다.
  이렇게 관리하는 테이블이 많은 블록은 프로세스들의 대기가 많아 HotBlock이 된다.
  `동시 INSERT`(동일 레코드에 대한 접근)은 없으나 즉, 다른 레코드에 대한 접근을 하긴하나 같은 블록에 대한 접근을 하는 경우 HotBlock이 발생함. => PCTFree로 해결가능

[채번테이블의 HotBlock을 해결하는 방법] 
 1. PCTFree를 10% => 90%로 늘리기 
   - PCTFree를 이용해 블록의 90%는 여분의 공간을 마련해준다.
   - 10%가 기본값임(추후 있을 update에 대비하기 위해)
  ※pctFree를 사용하지 않았을 때는 RowMigration을 통해 다른 빈 블록을 생성하고 그곳에 업데이트를 쳤음.
   
 2. 블록사이즈를 줄여서 수용가능한 레코드 수를 줄여라
   - 2k, 4k, 8k, 16k, 32k의 블록사이즈를 설정할 수 있음.
   - 하지만, 용량을 줄이는 대신 더 많은 블록이 필요하기 때문에 테이블스페이스를 별도로 만들어야함.
   - 더 작은 블록을 갖는 버퍼캐시를 따로 만들어야함.

```