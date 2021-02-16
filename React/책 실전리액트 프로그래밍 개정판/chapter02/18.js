function makePerson1(age, name) {
    return { age: age, name: name };
}

function makePerson2(age, name) {
    return { age, name };
}

console.log(makePerson2(21, "도원진"));
