function getDefaultAge() {
    console.log("hello");
    return 0;
}

const obj = { age: 21, grade: "A" };
const { age = getDefaultAge(), grade } = obj;
console.log(age);
