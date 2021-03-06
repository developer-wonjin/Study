const obj1 = { age: 21, name: "mike" };
const obj2 = { hobby: "soccer" };

const obj3 = { ...obj1, ...obj2 };
console.log(obj3);
