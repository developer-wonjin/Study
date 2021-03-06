const name = "mike";
const obj = {
    age: 21,
    name,
    getName() {
        return this.name;
    },
};
console.log(obj);
