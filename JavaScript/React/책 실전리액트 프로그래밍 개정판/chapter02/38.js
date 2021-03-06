const obj = { age: undefined, name: null, height: 183 };
const { age: theAge = 0, name = "noName", height } = obj;

console.log({ theAge, name, height });
