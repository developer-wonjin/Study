/*
url: https://medium.com/@bluesh55/javascript-prototype-%EC%9D%B4%ED%95%B4%ED%95%98%EA%B8%B0-f8e67c286b67
블로그의 글과 사진을 이해한 것을 바탕으로 정리해봤어 
JavaScript의 필드는 3개가 있다.

1. 클래스(Static 필드)
    -ES6이전
        a. 클래스없음, 생성자함수로 흉내냄
        b. 생성자 함수를 정의해 놓으면 함수객체가 생성되고 함수명을 객체의 변수로 간주하여
            생성자함수명.proper = value/func 로 static 필드를 갖을 수 있다.
        
        c. this.proper = value로 아래2번의 인스턴스 필드를 초기화할 수 있다.

    -ES6부터(클래스방식, 더욱 편리해짐)
        클래스를 작성할 때, 메소드나 프로퍼티 앞에 키워드 "Static" 붙여줌.
    
    참고)static 프로퍼티/메소드는 모든 인스턴스에서 사용못함!!
    
    -보충설명(아래 3번 프로토타입에 해당하는 프로토타입 메소드를 클래스정의하는 코드에서 정의)
        쉽게말해, Java에서 클래스내부의 메소드가 이에 해당함.
        -ES6이전
            생성자함수를 정의하면 생성자함수객체가 생기는데 기본적으로
            prototype속성을 갖음. 이 속성의 속성값은 3번의 Prototype Object임.
            따라서, "생성자함수명.prototype.속성 = func "으로 prototype 메소드를 등록한다.
        -ES6부터인 경우 
            아래 3번의 Prototype Object 영역에 해당하는 메소드를 여기 클래스에서 등록함.
            그렇다고 해서 클래스 필드(Static)라고 오해하면 안됨.    
            바로 메소드등록(키워드 "Static" 없이)하면 됨.

2. 인스턴스(프로토타입 메소드보다 객체가 고유하게 가지고 있는 인스턴스메소드를 우선탐색함.)
    1번의 생성자함수내부에서 " this.proper = value/func "로 지정가능
    또는, obj.proer = value/func 으로 인스턴스를 개별적으로 수정가능.
     아래 예시 코드에서 인스턴스메소드 add가 인스턴스에 없다면 __proto__속성값이 지정한 
    프로토타입으로 가서 프로토타입메소드 add를 실행 

3. Prototype Object 
    a) 개발자가 건드릴것없이 1번에서 정의한대로 자동 생성됨.
    b) 인스턴스를 만들어야 사용할 수 있는 메소드들 (Java에서 클래스내부의 메소드가 이에 해당함)
      객체마다 개별적으로/동일하게 가지고 있는 메소드가 아님. prototype영역에 하나 만들어놓고 공유해서 이용함.
      (자원을 절약할 수 있다)
    
    ★★★★Static메소드 와 prototype메소드 차이 구별할 것★★★
    static메소드는 클래스에 소속된 메소드로 인스턴스생성없이 사용가능함.

    
*/


var Foo = (function () {
    //1-1. 비공개 static변수, 소속: 함수표현식
    var j = 0; //함수표현식이 외부로 부터 직접접근못하도록 보호함.

    /*생성자함수를 정의하면 생기는 일
    a. Foo1 함수객체가 만들어짐. 
    b. Foo1 Prototype Object (prototype객체)가 생성됨.*/
    function Foo1(prop) {
      j++;//staic이라 인스턴스만들때마다 증가함.
      let test = 0;//생성자함수 Foo1의 단순한 지역변수임.
      //Foo1()나 new Foo1로 호출될 때 실행되고 블록{ }벗어나면 소멸되는게 맞지만
      //아래 코드처럼 인스턴스의 메소드에서 사용되면 클로저를 형성해서 계속 살아있음.
      //2. instance 필드
      this.prop = prop;
      this.printTest = function(){
          console.log(`test: ${test}`);
      }
      this.next = function(){
          test++;
      }
      this.add = function(){//주석처리 되어 메소드가 정의되지 않았다면 prototype의 sum을 찾아서 실행함.
        //this는 새로만들어진 인스턴스를 가르킴
        this.prop ++;
        return "instance의 add";
      }
    }//Foo1 함수정의끝. 
  
    //2. 프로토타입 필드를 정의 (생성자함수 Foo1객체는 prototype객체에 접근할 수 있는 속성을 지님. )
    //Instance에서 접근할 순 있으나, hasOwnProperty()에서는 false가 나옴.
    Foo1.prototype.x = 2; // 아래 Foo1.X = 1; static 변수와 구별할 것.
    Foo1.prototype.Jvalue = function(){
        console.log("J: ",j);
    }
    Foo1.prototype.add = function () {
        /*
        this는 인스턴스가 될 수도 prototype객체가 될 수도 있다.
        a. (올바른 사용)인스턴스를 가르키는 경우 : 인스턴스 메소드 add가 정의돼있지 않을 때,
         인스턴스 obj에서 add를 호출하면 prototype의 add가 대신 호출되고 그 add내부의 this는
         인스턴스 obj를 가르킴.
        b. (비추) prototype Object를 가르키는 경우 : 클래스명.prototype.메소드() 방식으로
         인스턴스없이 호출시, prototype의 add가 호출되고  add내부의 this는 prototype Object을
         가르킴.
        */
        //console.log("this",this); 
        return "prototype의 add"; 
    };
    Foo1.prototype.sub = function(){
        //console.log("this",this); 
        return "prototype의 sub";
    };
    Foo1.prototype.mul = function(){
        //console.log("this",this); 
        return "prototype의 mul";
    };
    //1-2. 공개 Static필드정의 - 소속은 Foo1(생성자함수, 클래스)정의자체임, 객체에 소속되지 않음.
    Foo1.s = 1;
    Foo1.sum = function () {
      //console.log(this);       //this는 위 "생성자Foo1정의","클래스" 자체임.
      //console.log(this.prop);  //인스턴스생성없이 사용하는 static에서 인스턴스의 속성 prop는 당연히 undefined 임.
      //Static메소드는 static 필드의 값만 사용이 가능하다.
      this.prop++;//수행안됨.
      return "static의 sum";
    };
    /*
    (Java개념) 
    [Static 메소드 특징]
    Util(유틸리티) 범용기능에 많이 사용됨.
    static 변수만 사용가능
    인스턴스에서 호출불가, 인스턴스 변수 사용불가 (javaScript는 prototype에 static메소드의 주소를 
    등록하고 call로 객체와 바인딩을 해주면 강제로 인스턴스를 통해 호출가능하게, 인스턴스변수를 사용가능하게 만들 수 있다. https://webclub.tistory.com/526)

    [static 변수특징]
    클래스 메소드정의에서 static변수 사용가능함. 따라서 인스턴스에서 메소드호출로 사용가능.
    단, 인스턴스에서 직접사용 불가.

    */
    return Foo1;
  }());

/*  
//생성자함수의 변수 test가 무엇인지 살펴보는 코드
const f1 = new Foo();
f1.printTest();
f1.next();
f1.printTest();
const f2 = new Foo();
console.log(f2);
f2.printTest();
*/

//var man = new Foo(7);
//console.log("man Instance:\t",man);
//console.log("Foo.prototype:\t",Foo.prototype);
//console.log("공개 static변수(생성자함수객체 즉, 클래스에 종속된 변수)\nFoo.s:\t", Foo.s);
//console.log("비공개 static 변수(함수표현식으로 부터 보호를 받기 때문에 접근할 수 없다.)\nFoo.j: ",Foo.j);
// console.log("man.add():\t",man.add());//instance 메소드 혹은 prototype메소드
// console.log("man.x :\t\t",man.x);//prototype의 올바른 사용법.

/*prototype 메소드 잘못된 사용법,
객체생성 없이 클래스로 접근했기에 권장하지 않음.*/
// console.log("Foo.prototype.add(): ",Foo.prototype.add());
// console.log("man.sub():\t",man.sub());//prototype의 올바른 사용법.
// console.log("man.mul():\t",man.mul());//prototype의 올바른 사용법.
// console.log();

//let x in obj를 하면 인스턴스뿐만 아니라 프로토타입에 있는 속성도 표시됨.
//console.log("man.hasOwnProperty(x): ",man.hasOwnProperty(x)); 에러남
// for(let el in man){
//      console.log(`el: ${el},\thasOwnProperty: ${man.hasOwnProperty(el)}`);
// }
//인스턴스에 있는 프로퍼티만 나열함.
//console.log(Object.keys(man));

// Static변수
// console.log("Foo의 static변수 Foo.s:\t", Foo.s);
// console.log("Foo.add():\t",Foo.add());//static 메소드

//ES6 클래스 도입
class Vehicle{}

class Car extends Vehicle{
    static nextVin = 0;
    constructor(make, model) {
    //인스턴스
        super();
        let test = 0;//생성자 함수의 지역변수, 아래 인스턴스메소드들에서 사용되면 클로저를 형성해 계속 살아있음.
        this.make = make;
        this.model = model;
        this.vin = Car.getNextVin();
    }

    //protoType
    getTime(){
        return Date();
    }

    //static
    static getNextVin() {
        return Car.nextVin++; // this.nextVin++ 라고 써도 되지만,
                              // Car를 앞에 쓰면 정적 메서드라는 점을 상기하기 쉽습니다.
    }

    static areSimilar(car1, car2) {
        return car1.make === car2.make && car1.model === car2.model;
    }
    static areSame(car1, car2) {
        return car1.vin === car2.vin;
    }
}
//Car.nextVin = 0;

const car = new Car("samsung", "T800");
const car2 = new Car("samsung", "T800");
console.log(car);
console.log(car2);
console.log(car instanceof Vehicle);

// 9.2.8 문자열 표현
class Car {
    toString() {
        return `${this.make} ${this.model}: ${this.vin}`;
    }
    // ...
}

// 9.3 다중 상속, 믹스인, 인터페이스
class InsurancePolicy {}
function makeInsurable(o) {
    o.addInsurancePolicy = function(p) {this.InsurancePolicy = p;}
    o.getInsurancePolicy = function() {return this.InsurancePolicy; }
    o.isInsured = function() {return !this.InsurancePolicy; }
}

makeInsurable(Car);

const car1 = new Car();
car1.addInsurancePolicy(new InsurancePolicy()); // error

// error 수정버전
const car1 = new Car();
makeInsurable(car1);
car1.addInsurancePolicy(new InsurancePolicy()); // works


