const obj = { age: undefined, name: null, grade: "A" };
const { age = 0, name = "noName", grade = "F" } = obj;

console.log(age, name, grade);
