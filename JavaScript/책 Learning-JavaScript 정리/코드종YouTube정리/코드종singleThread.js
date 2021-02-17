/*
자바스크립트 엔진에는 큐, 콜스택이 있다.

큐: main, EventHandler

이벤트루프는 계속 큐를 확인해서 콜스택으로 집어넣음.
(단, 콜스택이 empty상태일때)

*/

/*
//예제1
function delay(sec, callback){
    setTimeout(()=>{
        callback(new Date().toISOString());
    }, sec * 1000);
}

delay(1,(time)=>{
    console.log(1, time);
});
delay(1,(time)=>{
    console.log(2, time);
});
delay(1,(time)=>{
    console.log(3, time);
});
console.log("hello");
*/

//예제2
function yo(){
    setTimeout(function(){
        console.log(`1.5초 타이머 끝!`);
    }, 1500);
    for(let i=0; i<3; i++){
        //doSomething();
        console.log(i);
    }
    console.log(`3초 걸리는 for문 끝!`);
}

yo();
console.log(`main끝!`);

//스택:  
//큐  : main

//스택: main 
//큐  : 

//스택: main yo
//큐  : 

//스택: main yo 
//큐  : 
//타이머: {fn, 1500}

//0초~1초
//스택: main yo doSomething
//큐  : 
//타이머: {fn, 1500}

//스택: main yo 1출력
//큐  : 
//타이머: {fn, 1500}

//스택: main yo
//큐  : 
//타이머: {fn, 1500}

//1초~2초
//스택: main yo doSomething
//큐  : fn
//타이머: 

//스택: main yo 2출력
//큐  : fn
//타이머: 

//2초~3초
//스택: main yo doSomething
//큐  : fn
//타이머: 

//스택: main yo 3출력
//큐  : fn
//타이머:

//스택: main yo 
//큐  : fn
//타이머:

//스택: main 
//큐  : fn
//타이머:

//스택: 
//큐  : fn
//타이머:

//스택: fn
//큐  : 
//타이머:

//스택: 1.5초 출력
//큐  : 
//타이머:

/*
$(document).ready(function(){
    'use strict';
    
});
*/