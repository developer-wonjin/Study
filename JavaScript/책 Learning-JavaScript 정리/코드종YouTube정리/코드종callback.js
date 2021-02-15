//setTimeout (webAPI) 정의
/*setTimeout(callback, sec){
    callback과 sec을 Timer에게 전달해라.
}
즉, 전달만 했지 callback을 실행하진 않음.
*/

//setTimeout 호출
// setTimeout(() => {//비동기 콜백
//     console.log(`hello`);
// },1000);

//fakeSetTimeout 정의
function fakeSetTimeout(callback, sec){
    callback();
}

//fakeSetTimeout 호출
console.log(0);
setTimeout(() => {
    console.log(`hello`);
}, 1000);

setTimeout(() => {
    console.log(`hello`);
}, 1000);
console.log(1);

//setTimeout은 브라우저가 제공하는 webAPI이며 인터페이스다.


