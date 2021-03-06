//우항 배열을 분해하여 좌항 각 요소(여기선 객체)에 대입
const [{ prop: x } = { prop: 123 }] = []; // {prop: 123} 이 기본값
//속성값 자리의 x만 변수 선언됨
console.log(x); // 123

const [{ prop: x } = { prop: 123 }] = [{}]; // {prop: 123} 이 기본값
console.log(x); //undefined
