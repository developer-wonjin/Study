//객체복사에 쓰이는 spread op

const arr1 = [1, 2, 3];
const obj1 = { age: 23, name: "mike" };

const arr2 = [...arr1];
const obj2 = { ...obj1 };

console.log(arr2);
console.log(obj2);
