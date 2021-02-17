class Log {
    constructor() {
        this.messages=[];
        /*[{message: `string` , timestamp: '20200101'}
           ,{   }
           ,{   }]
        */
    }
    add(message) {
        this.messages.push({message, timestamp: Date.now()});
    }
    //symbol.iter메소드가 있으면 이터레이션프로토콜을 따르는 객체로 간주
    // [Symbol.iterator]() {
    //     //배열(messages)의 iter을 리턴
    //     return this.messages.values;
        
    // }

    //이 메소드가 리턴하는 것은 next()메소드가 있는  객체임.
    //next()메소드는 객체{value: 요소(iter가 가르키는), done: false }를 반환함.
    [Symbol.iterator](){
        let i = 0;//iter역할을 함.
        const messages = this.messages;
        return {
            //iter의 next메소드로 배열messages의 요소가 담긴 
            //{values: 요소, done: false}를 가져올 수 있음.
            next(){
                if(i >= messages.length)
                    return {value: undefined, done: true};
                return {value: messages[i++], done: false};
            }
        };
    }
}
const log = new Log();
log.add("first day at sea");
log.add("spotted whali");
log.add("spotted another vessel");
for(let entry of log){
    //entry는 next()로 반환된 객체{value: 요소, done: false}에서 
    //키value의 값을 가져옴. 그 값은 객체{messaget: "String", timestamp: "String"}임.
    console.log(`${entry.message}@${entry.timestamp}`);
}


class FibonacciSequence {
    [Symbol.iterator]() {
        let a = 1, b = 1;//
        return {
            next() {
                let rval = {value: b, done: false};
                b+=a;//(주의) rval 의 value b에는 반영안됨.
                a=rval.value;
                console.log(rval,` b: ${b}`);
                return rval;
            }
        };
    }
}

// 수정 버전
const fib = new FibonacciSequence();
let i = 0;
for(let n of fib){
    console.log(n);
    if(++i > 9)break;
}

 // 12.2 제네레이터
function* rainbow() {
    yield "yellow",
    yield `green`,
    yield `blue`,
    yield `volent`,
    yield `red`
 }

const it = rainbow();

console.log(it.next());
console.log(it.next());
console.log(it.next());
console.log(it.next());
console.log(it.next());
console.log(it.next());

// rainbow 제네레이터 for...of에서 사용
for(let color of rainbow())
    console.log(color);

//12.2.1 yield 표현식과 양방향 통신    
function* interrogate() {
    const name = yield "What is your name?";
    const color = yield "What is your favorite color?";
    return `${name} $ favorite color is ${color}`;
}

const it = interrogate();//(주목) 함수안의 코드가 실행되는 것이 아니다! 
console.log(it.next());  //next()호출할 때 함수코드가 한 줄 실행되는 것으로 함수의 실행을 제어한다.
console.log(it.next('Ethan'));
console.log(it.next('orange'));

//12.2.2 제네레이터와 return
// function* abc() {
//     yield 'a';
//     yield 'b';
//     yield 'c';
// }

function* abc() {
    yield 'a';
    yield 'b';
    return 'c';
}
const it = abc();
console.log(it.next()); // {value:'a', done: false}
console.log(it.next()); // {value:'b', done: false}
console.log(it.next()); // {value:'c', done: true}

// a와 b 출력 c는 출력X
for(let l of abc()) {
    console.log(l);
}