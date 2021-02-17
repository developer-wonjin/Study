function getDefaultAge() {
    console.log("hello");
    return 0;
}

//우항에 값이 있을 경우(null 포함) 좌항의 기본값이 사용되지 않음 따라서 function getDefaultAge 호출은 없다.
const obj1 = { age1: 12, grade1: "A" };
const { age1 = getDefaultAge(), grade1 } = obj1;
console.log(age1);
console.log("======================================");

const obj3 = { age3: null, grade3: "A" };
const { age3 = getDefaultAge(), grade3 } = obj3;
console.log(age3);
console.log("======================================");

//우항의 속성값이 undefined인 경우 좌항의 기본값이 사용됨 따라서 function getDefaultAge 호출
const obj2 = { age2: undefined, grade2: "A" };
const { age2 = getDefaultAge(), grade2 } = obj2;
console.log(age2);
console.log("======================================");
