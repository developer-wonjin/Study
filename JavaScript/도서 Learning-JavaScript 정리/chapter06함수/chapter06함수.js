
function getGreeting(){
    console.log("Hello");
}
//함수명을 바꿀 수 있다
const f = getGreeting;
f();


//객체의 key에 function을 연결할 수 있다.
const o = {};
o.key = getGreeting;//key와 value관계가 아닌 key자체가 function 객체를 가리킴
/*
o = {
    key : getGreeting
}
*/
o.key();



//배열요소에도 할당가능
const arr = [1,2,3];
arr[1] = getGreeting;
arr[1]();

/*
p.172 아래서 두 번째 멘트
이 둘은 같은 객체를 가리키고 있습니다.
객체 -> 인스턴스
*/
function f(o){
    o.message = "f에서 수정함";//외부 객체 O를 수정함.
    o = { // 내부 지역객체를 참조
        message: "새로운 객체!"
    };
    console.log(`f내부: o.message="${o.message}"(할당 후)`);
}
let o = {
    message: `초기값`
};
console.log(`f를 호출하기 전: o.message="${o.message}"`);//f를 호출하기 전: o.message="초기값"
f(o); //f내부: o.message="새로운 객체!"(할당 후)
console.log(`f를 호출한 후: o.message="${o.message}"`);//f를 호출한 후: o.message="f에서 수정함"

/*
function 오버로딩이 없다.
정의된 파라미터 자리에 값을 주지 않으면 그 파라미터 변수는 undefined값을 갖는다.
*/
let a = function(A){
    console.log(A);
};

a("w","B");
//매개변수 해체
/*
이전장에서 배운 객체할당 
{a,b,c}에 값이 주입.
const obj = {b: 2, c: 3, d: 4};
const {a,b,c} = obj;//선언 및 해체할당
a; undefined // obj에 a 없음
b; 2
c; 3
*/
function getSentence( {subject, verb, object} ){
    return `${subject} ${verb} ${object}`;
}
const o = {//(주의) 프로퍼티는 유효한 식별자(띄어쓰기 없는)여야 한다.
    subject: "I",
    verb: "love",
    object: "javaScript",
};
getSentence(o);

//배열역시 해체가능
function getSentence([subject, verb, object]){
    return `${subject} ${verb} ${object}`;
}
const arr = ["I","love","JavaScript"];
getSentence(arr);//"I love JavaScript"

//확산연산자(...)를 써서 나머지 파라미터를 배열로 가질 수 있다.
function addPrefix(prefix, ...words){// (주의) 확산연산자는 마지막 매개변수로!!
    const prefixedWords = [];
    for(let i= 0;i<words.length;i++){
        prefixedWords[i] = prefix +words[i];
    }
    return prefixedWords;
}
addPrefix("con","verse","vex"); // ["converse", "convex"]


//매개변수 기본값 세팅가능
function f(a,b="default",c=3){
    return `${a} - ${b} - ${c}`;
}
f(5,6,7); //"5 - 6 - 7"
f(5,6); //"5 - 6 - 3"
f(5); //"5 - default - 3" (기본값이 두 곳 설정됨)
f(); //"undefined - default - 3"


//간편하게 객체에 메서드 추가
/*
(잠깐)
    function 정의하는 법
    1. var calc = function( ){

    }
    
    2. function calc( ){

    }


*/
//(주의) 매서드는 객체 O의 프로퍼티다.
const o = {
    name: `Wallace`,
    bark() {return `Woof!`;},//(주의)생성자 키워드 function을 쓰지 않는 것이 특징.
};

const o = { name : `whale` ,
    bark : function(){ return `woof`;}
};

//this는 객체의 프로퍼티로써 기능을 하는 메소드 변수명을 통해 호출됐을 때만 효과가 있다.
const o = {
    name: `Wallace`,
    speak() {return `My name is ${this.name}!`;},
}

o.speak(); // `My name is Wallace!`

const speak = o.speak;
speak === o.speak;//true
speak();// `My name is undefined!`

//중첩된 함수 안에서 this를 사용할 때 난감한 상황
const o = {
    name: `Julie`,
    greetBackwards: function(){
        function getReverseName(){ //메서드 greetBackwards를 위한 보조함수 getReverseName
            let nameBackwards = ``;
            //(문제점)getReverseName 이라는 보조함수는 객체 o에 소속된 메소드가 아니라서 this가 없다.
            for(let i=this.name.length-1;i>=0;i--){
                nameBackwards += this.name[i];
            }
            return nameBackwards;
        }
        return `${getReverseName()} si eman ym ,olleH`;
    },
};
o.greetBackwards();

//해결
const o = {
    name: `Julie`,
    greetBackwards: function(){
        const self = this; // 해결책 : 보조함수에서 사용가능한 전역변수를 이용
        function getReverseName(){ //메서드 greetBackwards를 위한 보조함수 getReverseName
            let nameBackwards = ``;
            //(문제점)getReverseName 이라는 보조함수에서는 this를 인식못함.
          //for(let i=this.name.length-1;i>=0;i--){
            for(let i=self.name.length-1;i>=0;i--){
                nameBackwards += self.name[i];
            }
            return nameBackwards;
        }
        return `${getReverseName()} si eman ym ,olleH`;
    },
};
o.greetBackwards();

//6.6 함수 표현식과 익명함수
/*
(잠깐)
    function :  아래1,2의 경우를 굳이 구분하지 않는다. 
    1. 함수 선언
     식별자(함수이름)
     function A(){};

     2. 함수표현식 (자체로 표현식이며 값이다, 값이므로 식별자 B에 할당할 수 있음.)
    이름있는 함수
     function A(){}   // const B = function A(){ } 가능
    
    익명함수
     const B = function(){ } 가능
*/

//재귀함수 : 위 2번-이름있는 함수
const g = function f(){}//외부에서는 g로 함수호출을 하고. 내부에서는 f로 재귀호출한다. 

const g = function f(stop){
    if(stop) console.log(`f stopped`);
    f(true);//내부 호출이므로 f를 재귀사용
};
g(false);//외부 호출이므로 g를 사용

//함수 선언
//6.7화살표 표기법
const f1 = function() {return "hello!";}
const f1 = () => "hello!";
const f2 = function(name){return `Hello, ${name}!`;}
const f2 = name => `Hello, ${name}!`;
const f3 = function(a,b){return a+b;}
const f3 = (a,b) => a+b;

//(장점) 
const o = {
    name: `Julie`,
    greetBackwards: function(){
       // const self = this;
        //function getReverseName(){
        const getReverseName = () => {//(해결)화살표 표기법을 인해 보조함수의 this가 객체o에 정적으로 바인딩 됨.
            let nameBackwards = ``;
            for(let i=this.name.length-1;i>=0;i--){
                nameBackwards += this.name[i];
            }
            return nameBackwards;
        };
        return `${getReverseName()} si eman ym ,olleH`;
    },
};
o.greetBackwards();

//6.8 call 과 apply , bind

/*
(잠깐)
앞 절에서 배웠던 객체의 프로퍼티인 메소드
const o = {
    name: `Wallace`,
    speak() {return `My name is ${this.name}!`;},
}
o.speak(); // `My name is Wallace!`
*/

const bruce = {name: "Bruce"};
const madeline = {name: "Madeline"};
function greet(){//함수
    return `Hello, I'm ${this.name}!`;
}
greet(); // name이 undefined
greet.call(bruce);// name이 Bruce
greet.call(maeline);// name이 Madeline
//'함수' greet를 '메소드' greet인 것처럼 사용할 수 있다.


//매개변수가 있는 함수의 경우
function update(birthYear, occupation){
    
    this.birthYear = birthYear;
    this.occupation = occupation;

}
update.call(bruce, 1949, `singer`);

//call 과 동일한 apply (장점, 파라미터를 배열로 한번에 전달할 수 있음)
const arr = [1949, `singer`];
update.apply(bruce, arr);

const arr = [2, 3, -5, 15, 7];
Math.min.apply(null, arr);

/*(잠깐 앞장에서 배운 확산연산자 ...)
function addPrefix(prefix, ...words){// (주의) 확산연산자는 마지막 매개변수로!!
    const prefixedWords = [];
    for(let i= 0;i<words.length;i++){
        prefixedWords[i] = prefix +words[i];
    }
    return prefixedWords;
}
addPrefix("con","verse","vex"); // ["converse", "convex"]
 */

function update(birthYear, occupation){
    this.birthYear = birthYear;
    this.occupation = occupation;
}
const newBruce = [1940, "martial artist"];
//(주의)위 잠깐에서 사용했던 ...확산연사자와 사용법이 다름함수를 정의할 때 사용한것과 달리 함수를 호출할 때 사용함.
update.call(bruce, ...newBruce);// apply(bruce, arr)와 동일
Math.min(...arr);//Math.min.apply(null,arr)와 동일

//bind
const updateBruce = update.bind(bruce); //새로운 updateBruce 메소드 객체를 생성.
updateBruce(1904, "actor");//update메소드의 소속은 객체 bruce임.
updateBruce.call(madeline, 1274,"king");//소용없음.

//bind + 프로퍼티 디폴트화
const updateBruce1949 = update.bind(bruce, 1949);//bruce의 birthYear프로퍼티는 항상 1949로 디폴트설정됨.
updateBruce1949("singerSongWriter");
    

//[화살표함수에 없는 것들]
$(document).ready(function(){
    'use strict';
    const btn = document.getElementById(`btn`);
    var myObj = {
        count: 0,
        setCounter: function(){
            btn.addEventListener(`click`,function(){
                console.log(this);//btn
            });
            btn.addEventListener(`focus`,function(){
                console.log(this);//btn
            }.bind(this));
        }
    };
    myObj.setCounter();
});

//this가 없다.
const myFun = ()=>{
    //this가 존재하지 않음. 따라서 생성자 함수로서 기능을 못함
    //prototype도 생성되지 않는다.
};

//arguments가 없다.
const myFun = function(){
    console.log(arguments);
}
myFun(1,2,3,4);//[1,2,3,4,callee:f,Symbol.iterator:f]가 있음.

const myFun2 = () => {
    console.log(arguments);
}
myFun2(1,2,3,4);//arguments is not defined.

// => 함수에 없는 변수인 경우 스코프체인에 따라 상위 스코프를 탐색한다.
function outter(){
    const myFun2 = () => {
        console.log(arguments);
    }
    myFun2();
}
outter(1,2,3,4)//[1,2,3,4,callee:f,Symbol.iterator:f]가 있음.

const myFun3 = (...args) => {
    console.log(args);
}
myFun3(1,2,3,4);//arguments is not defined.




$(document).ready(function(){
    'use strict';
    

  



});