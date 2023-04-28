"alter session set statistics_level"은 Oracle 데이터베이스에서 성능 튜닝 및 진단을 위해 사용되는 명령문입니다.

이 명령문은 세션의 실행 계획 및 성능 통계 정보를 수집하는 수준을 설정합니다. "statistics_level" 매개 변수를 사용하여 성능 통계 정보의 수집 수준을 조정할 수 있습니다.

가능한 값은 다음과 같습니다.

BASIC : 오라클 데이터베이스의 기본 통계 정보를 수집합니다.
TYPICAL : 더 자세한 정보를 수집합니다. 예를 들어, 세션 병렬 실행, PGA 메모리 사용 등에 대한 정보를 수집합니다.
ALL : 가능한 모든 성능 통계 정보를 수집합니다.
기본적으로 Oracle 데이터베이스는 "BASIC" 모드로 설정되어 있습니다. 하지만, 성능 문제가 발생하는 경우, "TYPICAL" 또는 "ALL" 모드로 성능 통계 정보를 수집하여, 실행 계획을 분석하고 데이터베이스 성능을 향상시킬 수 있습니다.

다음은 "statistics_level"을 "TYPICAL"로 설정하는 예시입니다.

```sql
ALTER SESSION SET STATISTICS_LEVEL=TYPICAL;
```
