//잘못된 예
function getData() {
	var tableData;
	$.get('https://domain.com/products/1', function(response) {
        //응답이 이뤄지면(시간좀걸림) response에 응답결과가 받아짐
        tableData = response;
	});
	return tableData;//비동기이기 때문에 바로 값이 undefined로 리턴됨
}

console.log(getData()); // undefined

//옳은 예 : 콜백함수로 개선
function getData(callbackFunc) {
	$.get('https://domain.com/products/1', function(response) {
        //get메소드의 function 파라미터도 callback함수의 일종이다.
        
        //클라이언트단에서 사용자 기호에 맞는 함수를 콜백으로 준다.
        callbackFunc(response); // 서버에서 받은 데이터 response를 callbackFunc() 함수에 넘겨줌
	});
}

getData(function(tableData) {
	console.log(tableData); // $.get()의 response 값이 tableData에 전달됨
});

