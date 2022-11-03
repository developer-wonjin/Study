질문)

- match메소드, match2메소드가 과도기적인 단계에서는 공존해야함
- 데이터베이스에 중복데이터가 있어야지 안전한 리펙토링을 할 수 있다.

# 클래스 분리 방법

- 원시타입을 클래스로 포장
- 일급콜렉션 포장
- 메서드 파라미터를 클래스로 포장

# 테스트작성 순서

- create
  - isEqualTo
  - `Name`, `Position`, `Lotto`, `WinningLotto`
- 상태변화후 최종값 생성자
  - isEqualTo
  - `Car 커스텀 생성자`
- invalid
  - illgealArgumentException
  - `Lotto 생성자`, `WinningLotto 생성자`, 
- 메소드의 리턴형 검사
  - List
    - containExactly
    - `Cars의 findWinners`, `Winners의 findWinners`
  - int
    - `Lotto의 match메소드`
  - enum
    - `LottoGame의 matchByRankEnum`
    - `Rank의 rank`

# 일급컬렉션

## 상속은 비추천

```java
//ArrayList의 모든 메소드를 공개하는 셈이라 부적격 
public class Lottos extends ArrayList<Lotto>{
    public LottoResults match(Lotto winningLotto){
        LottoResults match(Lotto winningLotto){
            LottoResults lottoResults = new LottoResults();
            this.stream()
                .map(lotto -> new LottoResult(lotto.getCorrectCount(winningLotto.getNumbers())))
                .forEach(lottoResults::add);
            return lottoResults;
        }
    }
}
```

```java
//match메소드만 공개함
public class Lottos{
    private List<Lotto> lottos;
    
    public Lottos(List<Lotto> lottos){
        this.lottos = lottos;
    }
    
    public LottoResults match(Lotto winningLotto){
        LottoResults lottoResults = new LottoResults();
        lottos.stream()
               .map(lotto -> new LottoResult(lotto.getCorrectCount(winningLotto.getNumbers())))
               .forEach(lottoResults::add);
        return lottoResults;
    }
}
```



**리펙토링 전**

```java
//Layered Architecture에서 service layer에 해당함
public class LottoGame{
    public static int match(List<Integer> userLotto, List<Integer> winnningLotto, int bonusNo){
        //유효성체크가 있다고 가정
        //로또 1장에 6개 번호만 있어야하는 유효성 체크
        //각 숫자는 1 ~ 45값 유효성
        //각 숫자는 중복되면 안되는 유효성
        //보너는 숫자도 1 ~ 45 값이며, 당첨번호와 중복되면 안됨 유효성
        
        int matchCount = match(userLotto, winningLotto);
        if(matchCount == 6){
            return 1;
        }
        
        boolean matchBonus = userLotto.contain(bonusNo);
        if(matchCount == 5 && matchBonus){
            return 2;
        }
        
        if(matchCount > 2){
            return 6 - matchCount - 2;
        }
        
        return 0;
    }
}
```

- 위 코드의 문제점

  - early return은 잘 써줌

  - 상수처리를 안함(Enum으로 상수를 모아줄 수 있음)

    

**리펙토링 1단계**

```java
public class LottoGame{
    public static int match(List<Integer> userLotto, List<Integer> winningLotto, int bonusNo){
        //유효성검사 로직이 Lotto클래스로 숨어짐
        Lotto newUserLotto = new Lotto(userLotto);
        
        //static 메소드 match가 Lotto클래스로 숨어짐
        int matchCount = newUserLotto.match(new Lotto(winningLotto));
        boolean matchBonus = newUserLotto.contains(bonusNo);

        if(matchCount == 6){
            return 1;
        }

        if(matchCount == 5 && matchBonus){
            return 2;
        }

        if(matchCount > 2){
            return 6 - matchCount + 2;
        }

        return 0;
    }
}
```

```java
public class Lotto {
    public static final int LOTTO_SIZE = 6;

    private final Set<Integer> lotto;

    public Lotto(List<Integer> before) {
        this.lotto = new HashSet<>(before);
        if(lotto.size() != LOTTO_SIZE){
            throw new IllegalArgumentException("로또는 6개 번호여야 합니다.");
        }
    }

    public int match(Lotto winningLotto) {
        int count = 0;
        for (Integer lottoNumber : lotto) {
            if(winningLotto.contains(lottoNumber)){
                count++;
            }
        }
        return count;
    }

    public boolean contains(Integer lottoNumber) {
        return lotto.contains(lottoNumber);
    }
}
```



**리펙토링 2단계** `private method` 를 테스트해야 할까?

```java
public class LottoGame{
    public static int match(List<Integer> userLotto, List<Integer> winningLotto, int bonusNo){
        Lotto newUserLotto = new Lotto(userLotto);
        int matchCount = newUserLotto.match(new Lotto(winningLotto));
        boolean matchBonus = newUserLotto.contains(bonusNo);
		
        //순위 계산하는 로직을 메소드 추출함.
        return rank(matchCount, matchBonus);
    }
	
    //추출하고 보니까 private method를 테스트하고 싶은 유혹에 빠짐
    private static int rank(int matchCount, boolean matchBonus) {
        if(matchCount == 6){
            return 1;
        }

        if(matchCount == 5 && matchBonus){
            return 2;
        }

        if(matchCount > 2){
            return 6 - matchCount + 2;
        }

        return 0;
    }
}
```

```java
//LottoGame의 match메소드를 테스트하는 것은 어렵다.
class LottoGameTest {

    private List<Integer> winningLotto;
    private int bonusNo;

    @BeforeEach
    void setUp() {
        winningLotto = Arrays.asList(1, 2, 3, 4, 5, 6);
        bonusNo = 7;
    }

    @Test
    void match_1등() {
        List<Integer> userLotto = Arrays.asList(1, 2, 3, 4, 5, 6);//최종상태를 만들기 번거롭다
        assertThat(LottoGame.match(userLotto, winningLotto, bonusNo)).isEqualTo(1);
    }

    @Test
    void match_2등() {
        List<Integer> userLotto = Arrays.asList(1, 2, 3, 4, 5, 7);
        assertThat(LottoGame.match(userLotto, winningLotto, bonusNo)).isEqualTo(2);
    }

    @Test
    void match_3등() {
        List<Integer> userLotto = Arrays.asList(1, 2, 3, 4, 5, 8);
        assertThat(LottoGame.match(userLotto, winningLotto, bonusNo)).isEqualTo(3);
    }

    @Test
    void match_4등() {
        List<Integer> userLotto = Arrays.asList(1, 2, 3, 4, 7, 8);
        assertThat(LottoGame.match(userLotto, winningLotto, bonusNo)).isEqualTo(4);
    }

    @Test
    void match_5등() {
        List<Integer> userLotto = Arrays.asList(1, 2, 3, 7, 8, 9 );
        assertThat(LottoGame.match(userLotto, winningLotto, bonusNo)).isEqualTo(5);
    }

    @Test
    void match_꽝() {
        List<Integer> userLotto = Arrays.asList(1, 2, 7, 8, 9, 10);
        assertThat(LottoGame.match(userLotto, winningLotto, bonusNo)).isEqualTo(0);
    }

}
```



**리펙토링 3단계**

```java
public class LottoGame{
    public static Rank matchByRankEnum(List<Integer> userLotto, List<Integer> winningLotto, int bonusNo){
        Lotto newUserLotto = new Lotto(userLotto);
        int matchCount = newUserLotto.match(new Lotto(winningLotto));
        boolean matchBonus = newUserLotto.contains(bonusNo);

        return Rank.rank(matchCount, matchBonus);
    }
}
```



```java
public enum Rank {
    FIRST(6, 2_000_000_000),
    SECOND(5, 30_000_000),
    THIRD(5, 1_500_000),
    FOURTH(4, 50_000),
    FIFTH(3, 5_000),
    NO_MATCH(2, 0);

    private int matchCount;
    private int money;

    Rank(int matchCount, int money) {
        this.matchCount = matchCount;
        this.money = money;
    }

    public static Rank rank(int matchCount, boolean matchBonus) {

//        if(FIRST.matchCount == matchCount)return FIRST;
//        if(SECOND.matchCount == matchCount && matchBonus)return SECOND;
//        if(THIRD.matchCount == matchCount && !matchBonus)return THIRD;
//        if(FOURTH.matchCount == matchCount)return FOURTH;
//        if(FIFTH.matchCount == matchCount)return FIFTH;
//        if(NO_MATCH.matchCount == matchCount)return NO_MATCH;

        if(SECOND.isMatchCount(matchCount) && matchBonus)return SECOND;
        if(THIRD.isMatchCount(matchCount) && !matchBonus)return THIRD;

//        Rank[] ranks = Rank.values();
//        for (Rank rank : ranks) {
//            if(rank.matchCount == matchCount){
//                return rank;
//            }
//        }
//        throw new IllegalArgumentException();

        //람다식
        return Arrays.stream(Rank.values())
                . filter(rank -> rank.isMatchCount(matchCount))
                .findFirst()
                .orElseThrow(IllegalArgumentException::new);
    }

    private boolean isMatchCount(int matchCount) {
        return this.matchCount == matchCount;
    }
}
```

```java
//최종상태를 만들기 너무 편하다
class RankTest {
    @Test
    void rank_invalid() {
        assertThatThrownBy(()->{
            Rank.rank(7, false);
        }).isInstanceOf(IllegalArgumentException.class);
    }

    @Test
    void rank_꽝() {
        assertThat(Rank.rank(2, true)).isEqualTo(Rank.NO_MATCH);
        assertThat(Rank.rank(2, false)).isEqualTo(Rank.NO_MATCH);
    }

    @Test
    void rank_5등() {
        assertThat(Rank.rank(3, true)).isEqualTo(Rank.FIFTH);
        assertThat(Rank.rank(3, false)).isEqualTo(Rank.FIFTH);
    }

    @Test
    void rank_4등() {
        assertThat(Rank.rank(4, true)).isEqualTo(Rank.FOURTH);
        assertThat(Rank.rank(4, false)).isEqualTo(Rank.FOURTH);
    }

    @Test
    void rank_3등() {
        assertThat(Rank.rank(5, false)).isEqualTo(Rank.THIRD);
    }

    @Test
    void rank_2등() {
        assertThat(Rank.rank(5, true)).isEqualTo(Rank.SECOND);
    }

    @Test
    void rank_1등() {
        assertThat(Rank.rank(6, true)).isEqualTo(Rank.FIRST);
        assertThat(Rank.rank(6, false)).isEqualTo(Rank.FIRST);
    }
}
```



```java
//위 RankTest에서 모두 테스트해봤으므로 아래 테스트를 확 줄일 수 있다.
class LottoGameTest {

    private List<Integer> winningLotto;
    private int bonusNo;

    @BeforeEach
    void setUp() {
        winningLotto = Arrays.asList(1, 2, 3, 4, 5, 6);
        bonusNo = 7;
    }

    @Test
    void match_1등() {
        List<Integer> userLotto = Arrays.asList(1, 2, 3, 4, 5, 6);
        assertThat(LottoGame.matchByRankEnum(userLotto, winningLotto, bonusNo)).isEqualTo(1);
    }
}
```



# 메소드 인자를 클래스로 분리해라

**리펙토링 전**

```java
public class LottoGame{
    public static Rank matchByRankEnum(List<Integer> userLotto, List<Integer> winningLotto, int bonusNo){
        Lotto newUserLotto = new Lotto(userLotto);
        int matchCount = newUserLotto.match(new Lotto(winningLotto));
        boolean matchBonus = newUserLotto.contains(bonusNo);

        return Rank.rank(matchCount, matchBonus);
    }
}
```



**리펙토링 후**

```java
//WinningLotto클래스로 분리하고 WinningLotto클래스에 보낼 메세지 match(Lotto lotto)를 도출하는 것이 중요!!
//메소드 몸체가 훨씬 가벼워짐. 관련 로직이 WinningLotto로 숨음^^ 
public class LottoGame{
    public static Rank matchByRankEnum(List<Integer> userLotto, WinningLotto winningLotto){
        return winningLotto.match(userLotto);
    }
}
```

```java
//책임주도 : 인터페이스의 api정의 -> 구현
//TDD : WinningLotto먼저 구현 -> 인터페이스 도출
public class WinningLotto implements Matchable{
    private final Lotto winningLotto;
    private final int bonusNo;

    ...

    @Override
    public Rank match(List<Integer> userLottoList) {
        Lotto userLotto = new Lotto(userLottoList);
        int matchCount = userLotto.match(winningLotto);
        boolean matchBonus = userLotto.contains(bonusNo);
        return Rank.rank(matchCount, matchBonus);
    }
}
```

# 원시타입 포장

**리펙토링 전**

```java
public class Lotto {
    public static final int LOTTO_SIZE = 6;

    private final Set<Integer> lotto;

    public Lotto(List<Integer> before) {
        this.lotto = new HashSet<>(before);
        if(lotto.size() != LOTTO_SIZE){
            throw new IllegalArgumentException("로또는 6개 번호여야 합니다.");
        }
    }

    public int match(Lotto winningLotto) {
        int count = 0;
        for (Integer lottoNumber : lotto) {
            if(winningLotto.contains(lottoNumber)){
                count++;
            }
        }
        return count;
    }

    public boolean contains(Integer lottoNumber) {
        return lotto.contains(lottoNumber);
    }
}
```



**리펙토링 후**

```java
public class Lotto {
    public static final int LOTTO_SIZE = 6;

    private final Set<LottoNumber> lotto;

    public Lotto(List<Integer> before) {
        this(listToSet(before));
    }

    public Lotto(Set<LottoNumber> lotto) {
        this.lotto = lotto;
        if(lotto.size() != LOTTO_SIZE){
            System.out.println("로또는 6개 번호여야 합니다.");
            throw new IllegalArgumentException("로또는 6개 번호여야 합니다.");
        }
    }
    
    private static Set<LottoNumber> listToSet(List<Integer> before) {
        Set<LottoNumber> lotto = new HashSet<>();
        for (Integer num : before) {
            lotto.add(new LottoNumber(num));
        }
        if(lotto.size() != before.size()){
            System.out.println("로또는 중복된 숫자를 갖을 수 없습니다.");
            throw new IllegalArgumentException("로또는 중복된 숫자를 갖을 수 없습니다.");
        }
        return lotto;
    }
    
    ...
}    
```



# 정적팩토리 메서드

**인스턴스 캐싱전략 1단계** 

```java
public class LottoNumber {
    public static final int LOTTO_NUMBER_MIN = 1;
    public static final int LOTTO_NUMBER_MAX = 45;
    private final int number;

    private LottoNumber(int number) {
        if(number < LOTTO_NUMBER_MIN || number > LOTTO_NUMBER_MAX){
            throw new IllegalArgumentException("로또 범위를 벗어 났습니다.");
        }
        this.number = number;
    }

    public static LottoNumber of(String text) {
        return new LottoNumber(Integer.parseInt(text));
    }

    public static LottoNumber of(int num) {
        return new LottoNumber(num);
    }
    
    ...
}
```



**인스턴스 캐싱전략 2단계**

```java
public class LottoNumber {
    public static final int LOTTO_NUMBER_MIN = 1;
    public static final int LOTTO_NUMBER_MAX = 45;
    public static final Map<Integer, LottoNumber> lottoNumber = new HashMap<>();//캐시
    private final int number;

    //미리 생성
    static{
        for (int i = LOTTO_NUMBER_MIN; i <= LOTTO_NUMBER_MAX; i++) {
            lottoNumber.put(i, new LottoNumber(i));
        }
    }

    private LottoNumber(int number) {
        this.number = number; //유효성조건 of쪽으로 이동
    }

    public static LottoNumber of(String text) {
        return of(Integer.parseInt(text));
    }

    public static LottoNumber of(int num) {
        LottoNumber lottoNumber = LottoNumber.lottoNumber.get(num);
        if(lottoNumber == null){
            throw new IllegalArgumentException("로또 범위를 벗어 났습니다.");
        }
        return lottoNumber;
    }
}
```



# 생성자는 많을 수록, 메소드는 적을 수록

- 생성자가 많을 수록 유연해진다.
- 메소드가 많으면 SRP원칙을 위배할 가능성이 크다.

# 멤버필드 , 함수의 파라미터는 적을 수록 좋다

- 최선 : 0개
- 차선: 1개, 2개

## 생명주기가 같은 객체들 끼리 모아서 Wrapping한다.

```java
//리펙토링 전
public class MyLottoGame{
    private List<Integer> inputLotto;
    private List<Integer> winningLotto;
    private int bonusNo;
    
    public int match(){
        //...위 인스턴스 변수 3개를 활용하는 로직
        
        return result;
    }
}

//리펙토링 후
public class MyLottoGame{ //멤버갯수 감소 3 -> 2
    private List<Integer> inputLotto;
    private WinningLotto winningLotto;
}

public class WinningLotto{ //두 인스턴스변수를 모아놨다 good~
    private final List<Integer> winningLotto;
    private final int bonusNo;
    
    public int match(List<Integer> inputLotto){
                
        return result;
    }
}
```



# private 메소드 테스트 관련 논의

https://www.slipp.net/questions/253

- 최선) 원칙적으로 테스트하지 않음
  - private메소드를 테스트해야 될 것 같다는 생각이 들면 `클래스분리`를 의심할 것

```java
//리펙토링 전
public LottoGame{
    public int match(List<Integer> userLotto, List<Integer> winningLotto, int bonusNo){
        return rank(match(userLotto, winningLotto), userLotto.contains(bonusNo))
    }
    
    private static int rank(int matchCount, boolean matchBonus){
        if(matchCount == 6)return 1;
        if(matchCount == 5 && matchBonus)return 2;
        if(matchCount > 2)return 6 - matchCount + 2;
        return 0;
    }
    ...
}

@Test
public void match_2등(){
    List<Integer> userLotto = Arrays.asList(1, 2, 3, 4, 5, 7);
    assertThat(LottoGame.match(userLotto, winningLotto, bonusNo)).isEqualTo(2);
}

//리펙토링 후 LottoGame으로 부터 enum Rank추출
public enum Rank{
    FIRST(6, 200_000_000),
    SECOND(5, 1500000),
    THIRD(5, 50_000),
    FOURTH(4, 5_000),
    FIFTH(3, 0),
    NO_MATCH(0, 0);
    
    private final int matchCount;//enum은 멤버필드가 무조건final
    private final int money;     //enum은 멤버필드가 무조건final 
    
    Rank(int matchCount, int money){
        this.matchCount = matchCount;
        this.money      = money;
    }
    
    public static Rank of(int matchCount, boolean hasBonusNo){
        return Arrays.stream(Rank.values())
            	.filter(rank -> rank.isSameMatchCount(matchCount))
            	.filter(rank -> !rank.equals(SECOND) || hasBonusNo)
            	.findFirst()
            	.orElse(NO_MATCH);
    }
    
    private boolean isSameMatchCount(int matchCount){...}
    public int sumMoney(int totalMoney){return money + totalMoney;}
    ...
}

@Test // 테스트가 간결해졌다.
public void 당첨_1등(){
    Rank rank = Rank.of(6, false);
    assertThat(rank).isEqualTo(Rank.FIRST);
    
    Rank rank = Rank.of(6, true);
    assertThat(rank).isEqualTo(Rank.FIRST);
}
```





- 차선)

  - `src` 하위에 `main`과 `test`로 나뉘지만 하위 패키지 경로가 같다면 접근 가능함

  - 따라서, default 접근제어자로 변경하여 테스트가능하다
  - `파워목` 같은 테스트툴로 private메서드도 호출가능함(`자바 리플렉션`을 이용)



# Nameing Convention

## 클래스

- `What it does` 보다는 `What it is`
- `int dollar` 멤버필드를 갖는 클래스 `class Cash`

## 메소드

- **빌더**

  - 반환형

  - 내부 상태를 변경하지 않음

  - 명사형 명명

    - ```java
      int pow(int base, int power);
      float speed();
      Employee employee(int id);
      String parsedCell(int x, int y);
      
      //비권장
      Employee findEmployeeById(int id); //동사형
      ```

    

  - 형용사 명명 (반환형이 Boolean 일 경우)

    - ```java
      boolean emtpy();     //isEmpty() 보다 더 깔끔
      boolean readable();
      boolean negative();
      ```



- **조정자**

  - void형

  - 내부 상태를 변경

  - 동사형 명명

  - ```java
    void save(String content);
    void put(String key, float value);
    void remove(Employee emp);
    void quicklyPrint(int id);
    
    //비권장
    int save(String content);
    boolean put(String key, float value);
    ```

  

## 리펙토링

```java
//리펙토링 전
InputStream load(URL url);
String read(File file);
int add(int x, int y);

//리펙토링 후
InputStream stream(URL url);
String content(File file);
int sum(int x, int y);
```



```java
//리펙토링 전
boolean put(String key, float value);//빌더 + 조정자

//리펙토링 후
class PutOperation{
    int success();//빌더
    void save();  //조정자
}
```



```java
//리펙토링 전 : 주체적인 명명이 아님
class Bakery{
    Food cookBrownie();
    Drink brewCupOfCoffee(String flavor);
}

//리펙토링 후 : 동사적 표현을 제거한다
class Bakery{
    Food brownie();
    Drink coffee(String flavor);
}
```

```java
바텐더에게 음악을 틀어 달라고 요청할 때
    
//리펙토링 전
음악을 틀고 현재 볼륨 상태를 말해주세요.

//리펙토링 후
음악을 틀어주세요.
```

```java
//리펙토링 전
class Document{
    int write(InputStream content); //조정자 + 빌더
}

//리펙토링 후
class Document{
    OutputPipe output(); // 빌더
}

class OutputPipe{ //조정자
    void write(InputStream content);
    int bytes();
    long time();
}
```



# Service Layer의 역할

1. 도메인 객체에게 메세지를 보낸다.
2. DAO나 외부API를 이용해서 `도메인객체`를 생성
3. `도메인객체`에 메세지를 보내서 `도메인객체`의 상태가 변경되면 DAO를 통해 DB에 상태를 저장
4. 다른 서비스 클래스를 호출
5. 트랜잭션





