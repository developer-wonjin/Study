Chapter 14 비동기적프로그래밍
==

# 14.1 비유
시간이 오래걸리는 일은 제껴두고 시간이 오래걸리지 않는 일을 빛의 속도록 진행한다.
```javascript
console.log(0);
setTimeout(() => {
    console.log(`hello`);
}, 1000);

setTimeout(() => {
    console.log(`hello`);
}, 1000);
console.log(1);
```

# 14.2 콜백
BadCase
```javascript
const start = new Date();
let i = 0;
const intervalid = setInterval(function(){
    let now = new Date();
    if(now.getMinutes() !== start.getMinutes() || ++i > 10)
        return clearInterval(intervalid);
    console.log(`${i}:${now}`);
}, 5*1000);
```
## 자바스크립트 엔진의 동작원리 설명할 것.
```javascript
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
```

```javascript
//절대시간으로 부터 지난 시간을 기준으로 실행됨.
setTimeout(function () {
    console.log(`go1`);
}, (3*1000));

setTimeout(function () {
    console.log(`go2`);
}, (2)*1000);

setTimeout(function () {
    console.log(`go3`);
}, (1)*1000);
return;

//상대시간으로 계산하여 자신을 감싸고 있는 함수가 종료된 기준으로 실행함.
setTimeout(function () {
    console.log(`go1`);
    setTimeout(function () {
        console.log(`go2`);
        setTimeout(function () {
            console.log(`go3`);
        }, (3)*1000);
    }, (5)*1000);
}, (15)*1000);
return;

//Bad
function countDown() {
    let i;
    console.log("Countdown:");
    for(i=5;i>=0;i--){
        setTimeout(function () {
            console.log(i===0?"GO":i);
        }, (5-i)*1000);//timer가 5초 4초 3초 2초 1초 간격으로 제대로 동작안하는거 같은데??
    }
}
countDown();
```
Good
```javascript
//Good
//let을 for문의 조건문에 넣게 되면 블록({ })마다 새로운 변수가 생김
function countDown() {
    console.log("Countdown:");
    for(let i=5;i>=0;i--){
        setTimeout(function () {
            console.log(i===0?"GO":i);
        }, (5-i)*1000);//timer가 5초 4초 3초 2초 1초 간격으로 제대로 동작안하는거 같은데??
    }
}
countDown();
```

# 14.2.3 오류 우선 콜백
//뭔소린지 모르겠어... 설명이 이상해
//(문제상황)콜백의 파라미터로 에러를 받는 방법이 왜 어려운지 알아보자
```javascript
const fs = require(`fs`);
const fname = `may_or_may_not_exist.txt`;
fs.readFile(fname, function (err, data) {
    if(err)return console.error(`error reading file ${fname}: ${err.message}`);//console.error문은 리턴값이 null임.
    console.log(`${fname} contents: ${data}`);
});
```

# 14.2.4 콜백지옥
문제상황
1. 계속 증가하는 depth
2. 코드를 보기 불편함

```javascript
const fs = require(`fs`);
fs.readFile(`a.txt`, function(err, dataA){
    if(err)console.error(err);
    //a가 입력됐다는 전제하에
    fs.readFile(`b.txt`,function(err, dataB) {
        if(err)console.error(err);
        //a, b가 입력됐다는 전제하에
        fs.readFile(`c.txt`, function(err, dataC){
            if(err)console.error(err);
            //a, b, c가 모두 입력되면 그제서야
            //60초를 기다렸다가 d.txt로 출력해라
            setTimeout(function () {
                fs.writeFile('d.txt',dataA+dataB+dataC, function(err){
                    if(err)console.error(err);
                });     
            }, 60*1000);
        });
    });
});

```

3. 에러를 제대로 잡아내지 못함
```javascript
const fs = require(`fs`);
function readSketchyFile(){
    try{
        fs.readFile(`does_not_exist.txt`, function(err, data){
            //콜백함수는 여러번 또는 0번 호출될 문제를 방지하는 안전장치가 없다.
            if(err)throw err;
        });
    }catch(err){
        //readFile메소드의 if문에서 발생한 err가 catch구문으로 throw가 안된다. 따라서 err를 처리하지 못함.
        console.log('warning: minor issue occurred, program continuing');
    }
}
readSketchyFile();
```

# 14.3프로미스
1. 콜백을 예측가능한 패턴으로 사용하게끔 만들어줌
2. 콜백만 사용했을 때 나타나는 버그를 해결
콜백함수방식(프로미스 도입전)
```javascript
function countDown() {
    console.log("Countdown:");
    for(let i=5;i>=0;i--){
        setTimeout(function () { //모든 setTimeout함수는 for문으로 main에 대해서 비동기로 진행됨
            console.log(i===0?"GO":i);
        }, (5-i)*1000);
    }
}
countDown();
```
프로미스 사용 후
```javascript
function countDown(seconds){
    return new Promise(function(resolve, reject){
        for(let i=seconds; i>=0; i--){
            setTimeout(function(){
                if(i>0)console.log(i + `...`);
                else resolve(console.log("GO!"));
            }, (seconds-i)*1000);
        }
    });
}

countDown(5).then(
    function(){
        console.log(`countDown completed successfully`);
    },
    function(err){ //이 함수가 왜 필요하지?
        console.log(`countDown experienced an error: ` + err.message);
    }
);
```
3. 에러유도
에러 유도 BUT, 에러가 발생해도 Promise안의 for문은 계속 돌아감.(문제상황)
```javascript
function countDown(seconds){
    return new Promise(function(resolve, reject){
        for(let i=seconds; i>=0; i--){
            setTimeout(function(){
                if(i === 13)return reject(new Error("Oh my god"));
                if(i>0)console.log(i + `...`);
                else resolve(console.log("GO!"));
            }, (seconds-i)*1000);
        }
    });
}
```

4. err catch잘함

# 14.3.3이벤트
위 에러유도를 해결하기 위한 수단(코드 너무 길어..)

# 14.3.4 프라미스 체인
코드종 실습보여주기

# 14.3.5 결정되지 않는 프라미스 방지하기
결정되지 않는 프로미스 발생
```javascript
function launch(){
    return new Promise(function(resolve, reject){
        if(Math.random() < 0.5)return;
        console.log("Lift off!");
        setTimeout(function(){
            resolve("In orbit!");
        }, 2*1000);
    });
}
```
고난도임ㅠㅠ
