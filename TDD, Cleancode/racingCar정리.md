

왜 우승자를 구하기 어려운 설계인가?



# 전체 프레임

```java
//Controller(View와 Domain을 연결)
public class RacingMain {
    public static void main(String[] args) {

		//View
        String carsText = InputView.writeCarNames();
        int tryNo = InputView.writeTryNo();

        //Domain
        RacingGame racingGame = new RacingGame(carsText, tryNo);

        while(racingGame.racing()){
            racingGame.race();
            ResultView.printCars(racingGame.getCars());
        }
        
        //ResultView.printCars 가 while문 밖에 있는 것은 부적절....
        //모든 car들의 history를 저장해야하기 때문

        //View
        ResultView.printWinners();
    }
}
```



# 테스트하기 힘든코드를 테스트가능한 구조로 변경

1. 상수값은 `static final int` 로 추출한다.

2. 인자수가 많은 생성자에서 해야할 일

   - 초기화
   - 유효성검사

3. 인자수가 적은 생성자

   - this( ) 를 이용하여 인자수가 많은 생성자호출하여 코드중복없애기

   - ```java
         public Car(String name, int position) {
             StringUtils.checkBlank(name, "자동차 이름은 값이 존재해야 한다");
             this.name = name;
             this.position = position;
         }
     
     	public Car(String name) {
             this(name, 0);
         }
     ```

4. `getter메소드` 를 보았다 하면 도메인 안으로 숨겨라(메소드 새로 정의해서)

5. 접근제어자의 접근 레벨

   - 간단할 때 default 
   - 공개할 때 public

6. blankLine 앞뒤로 각각 메소드추출이 가능함

   **리펙토링 전**

   ```java
   public static List<Car> findWinners(List<Car> cars) {
       int maxPosition = 0;
       for (Car car : cars) {
           if(maxPosition < car.getPosition()){
               maxPosition = car.getPosition();
           }
       }
   
       //blankLine 앞뒤로 각각 메소드추출이 가능함
   
       List<Car> winners = new ArrayList<>();
       for (Car car : cars) {
           if(car.getPosition() == maxPosition){
               winners.add(car);
           }
       }
       return winners;
   }
   ```

   **리펙토링 후**

   ```java
   public static List<Car> findWinners(List<Car> cars) {
           return findWinners(cars, maxPostion(cars));
   }
   ```

   

7. 객체 비교를 위한 equals , hashcode 재정의

8. 레거시코드가 많은 소스들에 포진돼있을 때 꿀팁

   **Car.java 클래스**

   ```java
   public class Car{
       
       public void move(int randomNo){
           if(randomNo >= FORWARD_NUM)
               this.position++;
       }
       
       public void move(){
           int randomNo = getRandomNo();
           if(randomNo >= FORWARD_NUM)
               this.position++;
       }
       
       protected int getRandomNo() {        //protected접근제어자로 변경 
           Random random = new Random();
           return random.nextInt(MAX_BOUND);
       }
   }
   ```

   **CarTest.java**

   ```java
   // 테스트코드
   Car car = new Car("pobi"){
       @Override
       protected int getRandomNo() {
           return 4; //경계값으로 변경
       }
   };
   ```

9. 테스트데이터는 경계값을 사용할 것

10. `Car.java` 클래스의 `move()` 메소드의 비즈니스 요구가 자주 바뀔 경우

    ```java
    public void move(int randomNo){
        if(randomNo >= FORWARD_NUM)
            this.position++;
    }
    ```

    을 아래와 같이 인터페이스 도입으로 확장시킬 수 있다.

    ```java
    public void move(MovingStrategy movingStrategy){
        if(movingStrategy.movable())
            this.position++;
    }
    ```

    ```java
     //사용예1 - 테스트코드
    	@Test
        void 이동() {
            Car car = new Car("pobi");
            car.move(new MovingStrategy() {
                @Override
                public boolean movable() {
                    return true;
                }
            });
            assertThat(car.getPosition()).isEqualTo(1);
        }
    
        @Test
        void 정지() {
            Car car = new Car("pobi");
            car.move(() -> false);    //람다로 간략하게 ~~
            assertThat(car.getPosition()).isEqualTo(0);
        }
    ```

    ```java
    //사용예2 - 프로덕션코드 RacingGame.java
    private void moveCars() {
        for (Car car : cars) {
            car.move(new RandomMovingStrategy());
        }
    }
    ```

    



# 모든 원시값과문자열을 포장

- 도메인의 하위 기능을  테스트하기 정말 편해진다.
- 메세지를 보내는 것이 가능하다
- 비즈니스로직들이 도메인안으로 따라간다(숨는다)
- 서비스의 코드가 깔끔해진다.
  - 서비스는 도메인에게 메세지를 주는 역할
  - 로직의 흐름을 결정하는 레이어
- 유효성검사 중복을 해결

```java
//리펙토링 전: 원시값 비교
@Test
void create_bad() {
    Position position = new Position(3);
    assertThat(position.getPosition()).isEqualTo(3);
}

//리펙토링 후: 객체 equal, hashcode 비교
@Test
void create_good() {
    assertThat(new Position(3)).isEqualTo(new Position(3));
}
```

```java
//리펙토링 전: 객체의 geetter호출, 절차지향적
if(car.getPosition() == maxPosition){
    winners.add(car);
}

//리펙토링 후: 객체로 메세지 전달, 객체지향적
if(car.isWinner(maxPosition){
    winners.add(car);
}

```

```java
//리펙토링 전: 객체의 geetter호출, 절차지향적
for (Car car : cars) {
    if(maxPosition < car.getPosition())
        maxPosition = car.getPosition();
}
   
//리펙토링 후: 객체로 메세지 전달
for (Car car : cars) {
    maxPosition = car.biggerPosition(maxPosition);
}
```

```java
//리팩토링 전 CarTest
@Test
void 더_먼_이동거리_구하기() {
    Car car = new Car("pobi", 3);
    assertThat(car.fartherPosition(new Position(2))).isEqualTo(new Position(3));
    assertThat(car.fartherPosition(new Position(5))).isEqualTo(new Position(5));
}

//리펙토링 후 CarTest 위 테스트 제거하고
//PositionTest로 이동시키고 Position을 위한 테스트로 코드 수정
@Test
void 최대값_구하기() {    
    Position position = new Position(3);//"pobi"이름을 고려하지 않고 오직 position만
    assertThat(position.fartherPosition(new Position(2))).isEqualTo(new Position(3));
    assertThat(position.fartherPosition(new Position(5))).isEqualTo(new Position(5));
}	
```



# 일급콜렉션으로 포장

- 유효성검사 중복을 해결
- 일급콜렉션을 초기화하는 생성자를 더 추가한다.(생성자를 풍성하게 한다)

```java
public class Cars {
    private final List<Car> cars;

 	...

    public List<Car> findWinners() {
        //반환형이 Cars 가 아님에 주목!
        //List<Car>를 해야 테스트코드에서 containsXXX메소드를 사용할 수 있다.
        return null;
    }
}
```

```java
//Cars의 findWinners()를 통해 Winners를 얻을 수 있게함.
//Cars가 winnerList를 갖는 것은 책임을 너무 많이 갖음. 오직 경주 참가자들만 대표하는 도메인으로 봐야함.
//Winners가 우승자들만 대표한는 도메인이다.
public class Winners {
    List<Car> cars;

    public Winners(List<Car> cars) {
        this.cars = cars;
    }

    ...
        
}
```



# 인스턴스 변수는 최소화하라(정규화하라)

- 적은 인스턴스 변수를 설계하면 메소드는 적은 인스턴스 변수만 사용한다.
- 많은 인스턴스 변수가 있을 경우, 메소드는 인스턴스 변수를 모두 활용하지 못하는데
  - 응집도가 낮은 예가 됨.
  - 책임을 분리시켜야함

**안좋은 예**

```java
public class RacingGame {
    private List<Car> cars;
 	private List<String> winners;   // 안 좋은 코드
    private int topDistance;        // 안 좋은 코드
    private int tryNo;

    public RacingGame(String carNames, int tryNo) {
        this.cars = initCars(carNames);
        this.tryNo = tryNo;
    }

    private List<Car> initCars(String carNames) {
        ...
    }
}
```

위 `private final List<String> winners;` 는 `private final List<Car> cars` 의 내용이 update될 때 마다 

winners도 업데이트해줘야함. 따라서, cars 의 메소드를 통해 winners를 구할 수 있도록 하고 

winners 멤버변수는 RacingGame클래스의 설계에서 뺀다.



# 뷰로 전달할 데이터를 좀 신경써야함

```java
public Car getCars(){
    return this.cars;//immutable(불변성)이 보장되면 그대로 리턴가능
}

//하지만 List<Car>의 Car요소는 Position이 변경가능하기 때문에 mutable임.
//따라서 Cars는 mutable임
```

- `Collections.unmodifiableList()` 
  - 완전한 immutable을 만들 수 없다. 
  - List에 add, remove를 못하게 할 뿐이지
  - 요소인 Car의 변경을 막진 못한다.

- 시스템이 커질 수록, 다른 사람의 코드에서 내가 사용하는 객체의 상태를 변경시킬 수 있음
  - 버그찾아내기 매우 힘듬



# 출력시

```java
public class ResultView {
    public static void printCars(List<Car> cars) {
        System.out.println("실행 결과");
        for (Car car : cars) {
            //System.out.printf("%s : %s\n", car.getName(), StringUtils.repeat("-", car.getPosition()));
            
            //Car 의 toString메소드에게 맡겨부려~~
            System.out.println(car);
        }
    }
}
```

```java
public class RacingMain {
    public static void main(String[] args) {

        ....
        //ResultView.printWinners(racingGame.getCars());  
            
        //printWinners 워딩에 적절한 파라미터는 winners다!
        ResultView.printWinners(racingGame.getWinners());

    }
}
```



# 코드리뷰

**안 좋은 예**

```java
@Test
public void 랜덤숫자가_4이상일떄만_움직인다(){
    Car car = new Car();
    
    assertFalse(car.shouldMove(0));
    assertFalse(car.shouldMove(1));
    assertFalse(car.shouldMove(2));
    assertFalse(car.shouldMove(3));
    
    assertTrue(car.shouldMove(4));
    assertTrue(car.shouldMove(5));
    assertTrue(car.shouldMove(6));
    assertTrue(car.shouldMove(7));
    assertTrue(car.shouldMove(8));
    assertTrue(car.shouldMove(9));
}
```

**좋은 예**

```java
@Test
public void 랜덤숫자가_4이상일떄만_움직인다(){
    Car car = new Car();
    //경계값만 테스트하기
    assertFalse(car.shouldMove(3));    
    assertTrue(car.shouldMove(4));
}
```



- - 



# Getter / Setter

## 도메인설계할 때 

- Setter 무조건 필요없다.
- Getter 거의 필요없다.(최종 View에 전달할 때 getter필요하다)



# 단순 위임을 하는 경우

```java
//Car.java 가 Position.java에게 단순 위임하는 상황
Position fartherPosition(Position maxPosition) {
    return position.fartherPosition(maxPosition);
}
```

- Car에 작성된 `fartherPosition` 메소드 테스트코드를 삭제하고
- Position에 `fartherPosition` 메소드 테스트를 작성한다.

# 서비스 Layer의 역할

- 도메인객체로 메세지를 보내 일을 함
- 도매인객체에 대한 Persade 역할을 함.







# 네이밍컨벤션

https://remotty.github.io/blog/2014/03/01/hyogwajeogin-ireumjisgi/#:~:text=%EB%B3%80%EC%88%98%EC%9D%98%20%EC%9D%B4%EB%A6%84%EC%9D%84%20%EC%A7%93%EB%8A%94%EB%8D%B0,%EC%9D%80%20%EA%B0%80%EB%8A%A5%ED%95%9C%20%EA%B5%AC%EC%B2%B4%EC%A0%81%EC%9D%B4%EC%96%B4%EC%95%BC%20%ED%95%9C%EB%8B%A4.

## 네이밍에 대한 일반적인 고려사항

- 변수가 표현하고자 하는 것을 이름이 완벽하고 정확하게 설명하는가?
- 변수가 프로그래밍 언어의 해결책보다는 실세계의 문제를 참조하고 있는가?
- 고민할 필요가 없을 만큼 긴가?
- 계산 값 한정자가 이름의 마지막에 있는가?
- Num 대신 Count나 Index를 사용하는가?

## 특정 종류의 데이터에 대한 네이밍

- 루프 인덱스의 이름이 의미가 있는가(루프가 한 줄 이상이거나 중첩되어 있다면 i,j,k가 아닌 다른 것)?
- 모든 ‘임시’ 변수가 보다 의미 있는 이름으로 다시 명명되었는가?
- 불린 변수가 참일 때 그 의미가 분명하도록 명명되었는가?



## 좋은 루틴의 이름

다음은 효과적인 루틴 이름을 만들기 위한 지침이다.

`1. 루틴이 하는 모든 것을 표현하라`
ComputeReportTotals()는 무엇을 하는지 모호하기 때문에 적절한 이름이 아니다. ComputeReportTotalAndOpenOutputFile()은 적절한 이름이겠지만, 너무 길고 우스꽝스럽다. 이에 대한 해결책은 부수적인 효과를 갖기보다는 직접적인 효과를 유발시키도록 프로그램을 작성하고 그에 맞는 새로운 이름을 짓는 것이다.

`2. 의미가 없거나 모호하거나 뚜렷한 특징이 없는 동사들을 피하라.`
HandleCalculation(), PerformServices(), OutputUser(), ProcessInput(), DealWithOutput()과 같은 이름들은 그 루틴이 무엇을 하는지 말해 주지 않는다. 실제로 루틴은 잘 설계되었지만, 루틴의 이름에 뚜렷한 특징이 없기 때문에 문제가 되기도 한다. 만약 HandleOutput()이 FormatAndPrintOutput()으로 대체된다면, 루틴이 무엇을 하는지 상당히 정확하게 이해할 수 있다.
때론 루틴이 처리하는 연산 자체가 모호하기 때문에 이름이 모호해지는 경우도 있다. 루틴의 목적이 취약하다는 것이 문제이고, 서투른 이름은 그로인한 증상이다. 이런 경우 해당 루틴을 적절하게 리팩토링하여 명확한 처리를 하도록 해야 한다.(리팩토링에 대해서는 다음에 포스팅을 하도록 하겠다.)

`3. 루틴 이름을 숫자만으로 구분하지 말라.`
Part1(), Part2() 또는 OutputUser1(), OutputUser2()와 같은 이름은 좋은 이름은 잘못된 이름이다. 루틴의 이름 끝에 있는 숫자는 루틴이 표현하는 서로 다른 추상화에 대해서 아무런 정보도 제공하지 않는다.

`4. 함수의 이름을 지을 때, 리턴 값에 대한 설명을 사용하라.`
리턴 값을 따서 이름을 작성하는 것은 좋은 방법이다. cos(), customerId.Next(), print.IsReady(), pen.CurrentColor()는 함수가 리턴하는 것을 정확하게 보여주고 있기 때문에 모두 좋은 이름이다.

`5. 프로시저의 이름을 지을 때, 확실한 의미를 갖는 동사 다음에 객체를 사용하라.`
프로시저의 이름은 프로시저가 무엇을 하는지를 반영해야 하기 때문에, 객체에 대한 연산은 동사+객체 형태의 이름을 갖는다. PrintDocument(), CalcMonthlyRevenues(), CheckOrderInfo(), RepaginateDocument()는 모두 좋은 프로시저 이름이다.

```
6. 공통적인 연산을 위한 규약을 만들어라.
employee.id.Get() dependent.GetId() supervisor() candidate.id()
```

위 코드는 모두 특정 객체의 식별자를 얻기 위한 코드이다. Employee 클래스는 자신의 id 객체를 노출하고, id 객체는 Get() 루틴을 노출했으며, Dependent 클래스는 GetId() 루틴을 노출했다. Supervisor 클래스는 id를 기본 리턴캆으로 만들었고, Candidate 클래스는 id 객체의 기본 리턴 값이 id라는 사실을 이용하여 id 객체를 노출시켰다.
id를 가져오는 이름 규칙이 있었다면 이러한 난잡한 코드가 생성되는 현상은 막을 수 있을 것이다.



