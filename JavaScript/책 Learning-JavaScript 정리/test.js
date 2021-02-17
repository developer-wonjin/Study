function Person(x){

    var a = Person.prototype;
    a.x = 'test';
    a.xx = 'text1';

    this.y = x;
    this.ddd = x;
    
}

var wonjin = new Person(123);
console.log(wonjin)
console.log(wonjin.x);

console.log(wonjin.__proto__.xx)


