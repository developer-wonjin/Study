//Q. setTimeout(function(){}, (10-i)*1000) 반복횟수에 따라 속도가 달라지긴함?

//13 함수와 추상적사고
//13.1 리턴없는 서브루틴으로서 함수
//13.2 리턴하는 서브루틴으로서 함수
//13.3 함수로서의 함수(순수함수가 권장)
/*
순수함수
특징1. input이 같으면 output도 같다.
특징2. 함수를 사용하는(호출하는) client단에서,순수함수는 client단에 있는 변수를 변경시키지(영향을 주지) 말아야함.

메소드
특징1. 객체(컨텍스트)라는 소속을 갖음.
특징2. 메소드의 동작은 소속환경(객체의 상태)에 따라 좌우됨.
*/

//단점 : colorIndex값이 변함, input값이 undefined라는 동일조건에 매호출시마다 다른 값을 리턴함.
const colors = [`red`, `orange`, `yellow`, `green`, `blue`,`indigo`,`violet`];
let colorIndex = -1;
function getNextRainbowColor(){
    if(++colorIndex >= colors.length)colorIndex = 0;
    return colors[colorIndex];
}

//개선 :colorIndex값이 변하지 않음.
const getNextRainbowColor2 = (function(){
    const colors = [`red`, `orange`, `yellow`, `green`, `blue`,`indigo`,`violet`];
    let colorIndex = -1;
    return function getNextRainbowColor(){
        if(++colorIndex >= colors.length)colorIndex = 0;
        return colors[colorIndex];
    };
})();

//완벽한 개선 : 호출시 동일한 이터레이터를 반환함.
//p.277 상단 설명 대단쓰...
function getRainbowIterator(){
    const colors = [`red`, `orange`, `yellow`, `green`, `blue`,`indigo`,`violet`];
    let colorIndex = -1;//클로저의 중요성
    return {    //iter객체를 리턴
        next(){
            if(++colorIndex >= colors.length)colorIndex = 0;
            return {value: colors[colorIndex], done: false}; 
        }
    };
}
const iter1 = getRainbowIterator();//colorIndex = -1
//new getRainbowIterator() 호출후 colorIndex는 블록{ }밖에서 소멸되야하나
//next()스코프와 클로저를 형성한 colorIndex가 계속 남아 있어 0,1,2,3,,,값으로 변하게 됨.
const iter2 = getRainbowIterator();//위 colorIndex와 다른 별도의 변수가 할당됨.

//13.4.1함수도 객체다
//typeof를 선행해서 사용하여 function임을 확인, 이후 instanceof 로 Object를 확인

/*13.5 함수표현식(IIFE, Immediately Invoked Function Expression)
와 비동기적 코드
*/

//var 키워드
//Bad
var i;
for(i=5;i>=0;i--){
    //setTimeout은 루프가 종료된 후에 실행됨.
    //루프가 종료된 시점에는 i 가 -1 이다.
    setTimeout(function(){
        // 이 줄의 i는 위에서 선언한 i와 동일한 스코프에 있다.
        console.log(i===0?`go!`: i);
    },(5-i)*1000);
}

//Bad
for(var i=5;i>=0;i--){
    //setTimeout은 루프가 종료된 후에 실행됨.
    setTimeout(function(){
        // 위와 동일하게 모든 반복문에 쓰이는 i는 같은 스코프에 있는 놈이다.
        console.log(i===0?`go!`: i);
    },(5-i)*1000);
}

//Good
function loopBody(i){
    //복사해서 전달 받은 i가 새로운 스코프를 구성함.
    setTimeout(function(){
        console.log(i===0?`go!`: i);
    },(5-i)*1000);
}
var i;//var나 let이나 관계없이, for문의 조건문에서 선언을 하던말던
for(i=5;i>=0;i--){
    loopBody(i);//함수에 값을 복사해서 전달함.
}

//Good
var i;//var나 let이나 관계없이, for문의 조건문에서 선언을 하던말던
for(i=5;i>=0;i--){
    (function(i){
        setTimeout(function(){
            console.log(i===0?`go!`: i);
        },(5-i)*1000);
    })(i);
}

//let 키워드
//Bad
let i;//main 스코프를 구성, for문 안의 모든 i들은 main스코프에 있는 i를 참조
for(i=5;i>=0;i--){
    setTimeout(function(){
        console.log(i===0?`go!`: i);//main스코프의 i임.
    },(5-i)*1000);
}

//Good
for(let i=5;i>=0;i--){
    //매 반복시 중괄호내부에 독립적인 스코프를 형성함.
    setTimeout(function(){
        console.log(i===0?`go!`: i);//반복회차에 해당하는 스코프의 i이다.
    },(5-i)*1000);
}

//13.6변수로서의 함수
//13.6.1배열 요소로서 함수
//13.6.2함수에 함수 전달
"콜백함수로서 함수"는 일부임. 비동기처리에서 콜백을 파라미터로 받는 함수가 모든 작업을 마친 후 실행되는 것이 콜백임.
"파라미터로서 함수"가 일반적임. 

//13.6.3함수를 반환하는 함수
[1, 2, 3] 각 요소를 더할 때, 제곱 또는 세제곱...네제곱을 한 후 더하는 조건을 준다면
sum이라는 함수가 모든 조건을 다 가지고 있기 불편함.
function sum(arr, f) {
    if(typeof f != `function`)f = x => x;
    return arr.reduce((a,x) => a += f(x), 0);
}

function newSummer(f) {
    //f가채워진 함수를 리턴
    return arr => sum(arr,f);//쩐다... arr을 파라미터로 하는 함수임.
}

const sumOfCubes = newSummer(x => Math.pow(x,3));
sumOfCubes([1, 2, 3]);//arr만 던져주면 됨.


