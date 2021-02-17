p.211 상단 팁 구현해보기
p.219 원한다면 인덱스에서 1을 뺀값을~~

//arr변경
    arr.push("string"); //  push이후 배열길이 리턴
    arr.unshift("string"); //  unshift이후 배열길이 리턴

    //요소제거이후 제거된 요소리턴
    arr.pop();
    arr.shift();

    //삭제하고 요소 추가하기
    arr.splice(target, deleteCnt, ...itmes)

    //요소 복붙해서 교체하기
    arr.copyWithin(target, start, end)

    //배열채워넣기
    const arr = new Array(5).fill(1);
    arr.fill(string, sIdx, eIdx);

    //정렬
    arr.reverse();
    arr.sort();

    const arr = [{name: "Suzanne"}
                ,{name: "Jim"}
                ,{name: "Trevor"}
                ,{name: "Amanda"}];
    arr.sort( (a,b) => a.name > b.name  ); //a 가 b 보다 뒤에 있으면 정렬해라
    
    //reduce
        //배열을 값/배열/객채하나로 변환하기 위해 사용함.
    const arr = [5, 7, 2, 4];

    //첫 파라미터: accumulator
    //이후 파라미터: element, idx, this임.
    const sum = arr.reduce((accu, el) => accu + el);

    const words = ["BeachBall", "Rodeo", "Angel",
        "Aardvark", "Xylophone", "November", "Chocolate",
        "Papaya", "Uniform", "Joker", "Clover", "Bali"];
    const alphabetical = words.reduce((a,x) => {
        if( !a[x[0]]) a[x[0]] = [];
        a[x[0]].push(x);
        return a;
    }, {});



//arr 불변
    arr.concat( 4, 5, 6 )
    arr.slice(start, end)

    const items = [
        {name:"Widget", price:9,95}
        ,{name: "Gadget", price:22.95}
    ];

    //map
    format : arr.map(function(){});
    const name = items.map(x => x.name); 
    const prices = items.map(x => x.price);
    const items2 = name.map(
        (el, idx) => ( {name: el, price: prices[i]} )// 객체배열 생성
    ); 

    //filter
        const cards = [];
        for(let suit of ['H', 'C', 'D', 'S'])
            for(let val = 1; val <= 13; val ++)
                cards.push({suit,value});
        cards.filter(el => el.value === 2);
    
    


//검색
    //idx나 value는 궁금하지 않고 있는지 없는지만 궁금할 때 boolean을 리턴
    arr.some(람다식);
    
    //람다식을 만족하는 element가 배열전체일 때 true
    arr.every(람다식);



    //idx를 원할 때
    const arr = [1,5,"a",o,true,5,[1,2],"9"];
    arr.indexOf(searchElement, sIdx);
        //idx를 뒤에서부터 찾을 때
        arr.lastIndexOf(5,4); // idx 5번째 부터 시작하는 배열에서 찾고, 찾은 결과또한 idx 5번을 0으로 간주하여 시작한 인덱스임

        //더 강력한 idx검색 , 판정함수를 지정할 수 있따.
        arr.findIndex(o => o.id === 5); // boolean자리는 === 로 판별한다.

    //value를 원할 때
    arr.find(o => o.id === 5); //리터럴을 리턴함. 단, 결과값이 없을 때 -1을 리턴하는 위의 findIndex와 달리 undefined를 리턴함.

//findIndex와 find함수 특징
    파라미터로 element, idx, 배열자체this 를 갖을 수 있다.Array
    
    arr.find((obj) => boolean);
    arr.find((obj, idx) => boolean);
    
    arr.find(function(obj){
        return obj.id === this.id        
    },argObj);







    
    
