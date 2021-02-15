/*
MDN Promise 문서에 나와있듯이 Promise의 상태는 3가지입니다. 
[Pending, Fulfilled, Rejected]
Resolve 했다고 무조건 Fulfilled 상태가 되는 것이 아니라 
Resolve값에 따라 Fulfilled / Rejected가 될 수 있습니다.
어떤 Promise(A)의 Resolve값이 또 다른 Promise(B) 일 경우 
A Promise는 B Promise의 상태변화에 따라 상태를 결정하게 됩니다. 
따라서 A Promise의 Resolve 함수를 실행했다고 하더라도 
B Promise의 상태가 rejected가 된다면 A Promise 역시 rejected 상태가 되어 
catch를 통해 등록한 함수가 실행되게 됩니다. 
Resolve는 "현재 Promise가 어떻게 될지(다른 promise를 따르거나 특정 값으로 fulfilled)
결정되었다"를 뜻합니다.
*/

function delay(sec, callback){
    //특징: 1.기능수행 --> 2.처리
    setTimeout(()=>{
        callback(new Date().toISOString());
    }, sec * 1000);

    res = ;
    callback(err,res);
    
}

//way0
delay(3,(time)=>{
    console.log("1st", time);
});
delay(2,(time)=>{
    console.log("2nd", time);
});
delay(1,(time)=>{
    console.log("3rd", time);
});
return;

//way1
delay(1,(time)=>{
    console.log(1, time);
    delay(2,(time)=>{
        console.log(2, time);
        delay(3,(time)=>{
            console.log(3, time);
        });
    });
});
return;


function delayP(num){
    //기능수행
    //resolve: 할 일을 다했을 때 호출
    //reject: 할 일을 하던중 예외가 날 때 호출
    return new Promise((resolve, reject) => {//Promise의 생성자에 전달함. //내부적으로 Promise의 생성자가 => 함수를 실행시킬것임.
        setTimeout(()=>{
            console.log(`(1초를 기다리는) 할 일${num}`);
            //할 일 이후
            resolve(num);//resolve를 통해 파라미터(할 일의 결과값)을 callback에게 전달함.  
        }, 1 * 1000);//내부적으로 Promise의 생성자가 => 함수를 실행시킬것임.
        
        //에러
        //resolve(num);
    });
}

//way2로 넘어가기 전에 체크!
delayP(1);//"할 일"(1초를 기다리는 일)을 할 뿐, 할 일 이후의 "처리할 일"(callback)은 수행되지 않는다. callback을 모르니까.
return;

//way2 비효율적임.
delayP(1).then((result)=>{
    console.log(1, result);
    delayP(1).then((result)=>{
        console.log(2, result);
    });
});
return;

function delayP1(num){
    return new Promise((resolve, reject) => {//Promise의 생성자에 전달함. //내부적으로 Promise의 생성자가 => 함수를 실행시킬것임.
        //할 일
        console.log(`할 일${num}`);
        //할 일 이후
        resolve(num);//resolve를 통해 파라미터(할 일의 결과값)을 callback에게 전달함.  
    });
}

let a = delayP(1);
let c = delayP(2);
//During TO DO

c.then((res)=>{ 
    console.log(`콜백 ${res}`);
    return delayP(3);
}).then((res)=>{ 
    console.log(`콜백 ${res}`);
    
}).then((res)=>{ 
    //윗 줄에서 return을 하지 않았을 지라도 
    //then의 리턴값은 힝상 Promise라는 점과
    // 윗줄의 경우 then의 파라미터인 callback에서 아무것도 리턴하지 않았다면
    // then은 resolve된 Promise를 리턴함.
    console.log(`콜백 ${res}`);
    return "wow";
}).then((res)=>{ 
    //이전 then에서 Promise를 리턴하지 않아 지연없이 "wow"만 callback함수에 전달된다.
    console.log(`콜백 ${res}`);
});
console.log("a: ",a);
console.log("c: ",c);
return;



//★★★실습코드★★★
function delayP(num){
    //기능수행
    //resolve: 할 일을 다했을 때 호출
    //reject: 할 일을 하던중 예외가 날 때 호출
    return new Promise((resolve, reject) => {//Promise의 생성자에 전달함. //내부적으로 Promise의 생성자가 => 함수를 실행시킬것임.
        setTimeout(()=>{
            console.log(`(1초를 기다리는) 할 일${num}`);
            //할 일 이후
            resolve(num);//resolve를 통해 파라미터(할 일의 결과값)을 callback에게 전달함.  
        }, 1 * 1000);//내부적으로 Promise의 생성자가 => 함수를 실행시킬것임.
        
        //에러
        //resolve(num);
    });
}

function delayP1(num){
    return new Promise((resolve, reject) => {//Promise의 생성자에 전달함. //내부적으로 Promise의 생성자가 => 함수를 실행시킬것임.
        //할 일
        console.log(`할 일${num}`);
        //할 일 이후
        resolve(num);//resolve를 통해 파라미터(할 일의 결과값)을 callback에게 전달함.  
    });
}



let a = delayP1(1);
//let a = delayP(1);
let c = delayP1(2);
//let c = delayP(2);

//During TODO
/*
할 일을 모두 마쳤거나/아직 진행중이거나 상관없이
then의 호출시기를 조절할 수 있어서 콜백수행전 필요한 선행작업을 추가할 수 있다.
*/

c.then((res)=>{ 
    console.log(`콜백 ${res}`);
    return delayP1(3);
    //return delayP(3);
}).then((res)=>{ 
    console.log(`콜백 ${res}`);
    
}).then((res)=>{ 
    //윗 줄에서 return을 하지 않았을 지라도 
    //then의 리턴값은 힝상 Promise라는 점과
    // 윗줄의 경우 then의 파라미터인 callback에서 아무것도 리턴하지 않았다면
    // then은 resolve된 Promise를 리턴함(애초에 할 일이 없기 때문에 할 일마침)
    console.log(`콜백 ${res}`);
    return "wow";
}).then((res)=>{ 
    //이전 then에서 Promise를 리턴하지 않아 지연없이 "wow"만 callback함수에 전달된다.
    console.log(`콜백 ${res}`);
});
console.log("a: ",a);
console.log("c: ",c);
return;