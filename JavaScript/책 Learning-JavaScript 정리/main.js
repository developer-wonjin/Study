var Foo = (function () {
  //1-1. 비공개 static변수, 소속: 함수표현식
  var j = 0; //함수표현식이 외부로 부터 직접접근못하도록 보호함.

  /*생성자함수를 정의하면 생기는 일
    a. Foo1 함수객체가 만들어짐. 
    b. Foo1 Prototype Object (prototype객체)가 생성됨.*/
  function Foo1(name, prop) {
    j++; //staic이라 인스턴스만들때마다 증가함.
    
    let test = 0; //생성자Foo1의 단순한 지역변수임.

    //Foo1()나 new Foo1로 호출될 때 실행되고 블록{ }벗어나면 소멸되는게 맞지만
    //아래 코드처럼 인스턴스의 메소드에서 사용되면 클로저를 형성해서 계속 살아있음.
    
    //2. instance 필드
    this.instanceProp = prop;
    this.instanceName = name;

    console.log("-----생성자함수 호출-----")
    //this.printAll()호출 불가능 // 현재 코드줄에서 인스턴스가 printAll메소드를 갖추고 있지 않음
    console.log("------------------------------\n")

    

    this.printAll = function () {
        console.log(`==instance ${name}의printTest호출====`)
        console.log(`비공개 static변수 j: ${j}`);
        console.log(`생성자 지역변수 test : ${test}`)//
        console.log(`instanceProp       : ${this.instanceProp}`)
        console.log(`instanceName       : ${this.instanceName}`)
        console.log("================================\n")

    };
    this.nextTest = function () {
        test++;
        console.log(`==instance ${name}의next호출==\n`);
        this.printAll();
    };
    this.addProp = function () {
      //주석처리 되어 메소드가 정의되지 않았다면 prototype의 sum을 찾아서 실행함.
      //this는 새로만들어진 인스턴스를 가르킴
        this.prop++;
        console.log(`==instance ${name}의add호출,  prop 1증가==\n`);
        this.printAll();
    };
  } //Foo1 함수정의끝.

  //2. 프로토0타입 필드를 정의 (생성자함수 Foo1객체는 prototype객체에 접근할 수 있는 속성을 지님. )
  //Instance에서 접근할 순 있으나, hasOwnProperty()에서는 false가 나옴.
    Foo1.prototype.x = 2; // 아래 Foo1.X = 1; static 변수와 구별할 것.
    Foo1.prototype.Jvalue = function () {
        console.log("J: ", j);
    };
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
        console.log("======prototype의 add========")
        console.log("this",this);
        console.log("=============================\n")
    };
    Foo1.prototype.sub = function () {
        console.log("======prototype의 sub========")
        console.log("this",this);
        console.log("=============================\n")
    };
    Foo1.prototype.mul = function () {
        console.log("======prototype의 mul========")
        console.log("this",this);
        console.log("=============================\n")
    };
    

    //1-2. 공개 Static필드정의 - 소속은 Foo1(생성자함수, 클래스)정의자체임, 객체에 소속되지 않음.
    Foo1.s = 1;
    Foo1.staticAdd = function () {
        //console.log(this);       //this는 위 "생성자Foo1정의","클래스" 자체임.
        //console.log(this.prop);  //인스턴스생성없이 사용하는 static에서 인스턴스의 속성 prop는 당연히 undefined 임.
        //Static메소드는 static 필드의 값만 사용이 가능하다.
        this.prop++; //인스턴스필드에 대해 수행안됨.

        console.log("======static의 sum========")
        console.log("this",this);
        console.log("=============================\n")
    };
    /*
    (Java개념) 
    [Static 메소드 특징]
    Util(유틸리티) 범용기능에 많이 사용됨.
    static 변수만 사용가능
    인스턴스에서 호출은 가능 
    (참고, javaScript는 prototype에 static메소드의 주소를 
    등록하고 call로 객체와 바인딩을 해주면 강제로 인스턴스를 통해 호출가능하게, 인스턴스변수를 사용가능하게 만들 수 있다. https://webclub.tistory.com/526)

    [static 변수특징]
    클래스 메소드정의에서 static변수 사용가능함. 따라서 인스턴스에서 메소드호출로 사용가능.
    단, 인스턴스에서 직접사용 불가.

    */
    return Foo1;
})();

Foo.staticAdd()
Foo.staticAdd()

