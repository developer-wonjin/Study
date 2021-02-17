const obj = { age: 21, name: "mike", grade: "A" };
const { age, ...rest } = obj;
console.log(age, rest); // 21  { name: 'mike', grade: 'A' }  속성들이 분리됨
