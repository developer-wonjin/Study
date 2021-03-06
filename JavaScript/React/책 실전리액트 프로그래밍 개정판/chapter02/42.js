const obj = { name: "mike", mother: { name: "sara" } };
const {
    name,
    mother: { name: motherName }, //객체 비구조화시 좌변에 속성값 자리에 변수가 오면 속성은 변수로서 기능을 하지 못하고 속성값이 변수가 된다.
} = obj;

console.log(name, motherName);
// console.log(mother); 참조에러
