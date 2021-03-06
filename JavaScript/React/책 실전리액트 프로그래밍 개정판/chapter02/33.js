const arr = [1, 2, 3];
const [first, ...rest1] = arr;
console.log(rest1);

const [a, b, c, ...rest2] = arr;
console.log(rest2);
