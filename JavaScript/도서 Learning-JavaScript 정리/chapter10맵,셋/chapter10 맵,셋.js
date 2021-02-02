/*
WeakMap 사용이유.
WeakMap를 사용하는 한가지 경우는 객체의 사적인 정보를 저장하기 위해서 
이거나 상세 구현 내용을 숨기기 위한 것이다.



*/
const privates = new WeakMap();

function Public() {
  const me = {
    // Private data goes here
  };
  privates.set(this, me);
}

Public.prototype.method = function () {
  const me = privates.get(this);
  // Do stuff with private data in `me`...
};

module.exports = Public;