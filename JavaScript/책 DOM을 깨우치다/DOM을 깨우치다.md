(번역) DOM은 정확히 무엇일까? https://wit.nts-corp.com/2019/02/14/5522

## DOM

> Node개체를 계층화한 트리
>
> 이 트리(DOM)은 인터페이스를 제공한다. 그 목적은 아래를 참고



## DOM의 목적 

> 내부적인 동작방식을 몰라도 `node개체의 정보와 부모자식간 계층` 을 안다면 쉽게 프로그래밍할 수 있음.

- 프로그래밍 : Javascript를 이용해 문서에 대한 스크립트 작성(삭제, 추가, 수정, 이벤트처리)

- 쉽게: 인터페이스 역할

# 1. 노드 개요





## 1.2. 노드 개체 유형

**가장 일번적인 노드**

| 노드유형               | 예                                                           | 정수값 |
| ---------------------- | ------------------------------------------------------------ | ------ |
| DOCUMENT_NODE          | window.document                                              | 9      |
| ELEMENT_NODE           | <body>, <a>, <p>, <script> 등등                              | 1      |
| ATTRIBUTE_NODE         | <div class="ab"> 에서 class="ab"                             | 2      |
| TEXT_NODE              | <p>Hi</p> 에서 HI (줄바꿈과 공백을 포함한 HTML문서 내의 텍스트문자) | 3      |
| DOCUMENT_FRAGMENT_NODE | document.createDocumentFragment()                            | 11     |
| DOCUMENT_TYPE_NODE     | <!DOCTYPE html>                                              | 10     |

<img src="./img/노드유형.png">

​	

- ATTRIBUTE_NDOE는 실제 DOM 트리구조의 일부가 아님(역사적인 이유로 목록에 포함될 뿐)
  - DOM4 에서 사용금지됨
- COMMENT_NODE는 거의 TEXT_NODE(개행포함함)와 동일

| 인터페이스 / 생성자                           | nodeType | 예시(뒤에 _NODE가 붙지만 생략) |      |
| --------------------------------------------- | -------- | ------------------------------ | ---- |
| HTML * Element()    (예: HTMLBodyElement()  ) | 1        | Element                        |      |
| Text()                                        | 3        | TEXT                           |      |
| Attr()                                        | 2        | ATTRIBUTE                      |      |
| HTMLDocument()                                | 9        | DOCUMENT                       |      |
| DocumentFragment()                            | 11       | DOCUMENT_FRAGMENT              |      |
| DocumentType()                                | 10       | DOCUMENT_TYPE                  |      |



## 1.3. Node 개체로부터 상속받은 하위 노드 개체

<img src="./img/NODE TREE.png">

```
Object
  └ Node
      ├ Element(1)
      │     └ HTMLElement 
      │             └ 겁나많아 (HTML*Element , * 자리에 들어갈 단어: Head, Body, Title, Input, Table, Paragraph, 등등)       ├ Attr
      ├ Attr(2)
      ├ CharacterData
      │     └ Text(3)
      │     └ Comment(8)
      ├ Docuement(9)
      │     └ HTMLDocuement
      ├ Docuement(9)
      └ DocuementFragment        
   
```



## 1.4. 노드를 다루자 (속성 및 메서드)

1. Node

   - 속성
     - childNodes
     - firstChild
     - nextSibling
     - **nodeName**
     - **nodeType**
     - nodeValue
     - parentNode
     - previousSibling

   - 메서드

     - appendChild()

     - cloneNode()

     - compareDocumentPosition()

     - contains()

     - hasChildNodes()

     - insertBefore()

     - isEqualNode()

     - removeChild()

     - replaceChild()

       

2. Document 

   - 메서드
     - document.createElement()
     - document.createTextNode()

3. HTML * Element

   - 속성
     - innerHTML
     - outerHTML
     - textContent
     - innerText
     - outerText
     - firstElementChild
     - lastElementChild
     - nextElementChild
     - previousElementChild
     - children
   - 메서드
     - insertAdjacentHTML()

## 1.5 노드 유형과 이름 식별하기

- **모든 노드는 Node개체로 부터 상속받기 때문에 nodeType과 nodeName 속성을 갖는다.**
- 



## 1.6 노드 값 

## 1.6.1. value값의 종류

| 노드유형          |                                               |
| ----------------- | --------------------------------------------- |
| Text 또는 Comment | nodeValue 값: 텍스트                          |
| div, span, a, p   | nodeValue 값: null                            |
| input, select     | nodeValue 값: null ,      value속성값을 사용. |

- [Q] textContent와 nodeValue의 차이는?

  [A] 아래표 3행에 답이 있음



## 1.6.2.  [ (inner/outer), (Text/HTML) ] , textContent

| **textContent**                                              | **innerText**                                                | innerHTML                                                    |
| ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| **Text, Comment노드면)    <br>Node.nodeValue 값을 리턴**     |                                                              | 단순 텍스트를 생성할 거면 권장X<br>HTML파서는 많은 성능악화를 불러옴 |
| **자식요소가 많은 노드면)<br> 각 자식노드들의 Node.nodeValue값을 병합한 값을 리턴** |                                                              |                                                              |
| **<script> <style> 내부의 텍스트들도 포함하여 리턴함**       | **사람이 읽을 수 있는 요소만 리턴<br>hidden처리된 요소는 리턴하지 않음** | HTML태그 전부를 텍스트로 보여줌                              |
| **document와 document_node 타입일 경우 null리턴**            |                                                              |                                                              |
| **XSS공격 위험이 없음**                                      |                                                              |                                                              |

| 메소드명           | 설명                                                         | 사용법                                                    | 특징                                                       |
| ------------------ | ------------------------------------------------------------ | --------------------------------------------------------- | ---------------------------------------------------------- |
| innerHTML          | [create]<br/>1. element와 text 노드 생성<br>2. DOM에 추가(자식노드를 교체) | ${element}.innerHTML = '\<strong>Hi\</strong>'            | 상단 표 참고                                               |
| outerHTML          | [create]<br/>1. element와 text 노드 생성<br>2. DOM에 추가(현 노드까지 교체) |                                                           | [read]<br/>현 노드포함 리턴됨.                             |
| textContent        | [create]<br>1. text노드 생성<br>2. DOM에 추가(자식노드를 교체) | ${element}.textContent = 'Hello'                          | [read]<br/>읽을 수 없는 요소**도** 리턴<br>위 표 1열 참고  |
| innerText          | [create]<br>위 textContent와 동일<br>\<script> 태그노드에서는 동작 안함 | ${element}.innerText = 'Hello'                            | [read]<br/>읽을 수 있는 요소**만** 리턴<br/>위 표 2열 참고 |
| outerText          | [create]<br/>1. text 노드 생성<br/>2. DOM에 추가(현 노드포함 교체됨) |                                                           | [read]<br>위와 동일                                        |
| insertAdjacentHTML | option, string 순으로 파라미터를 받음<br>열린태그 , 닫힌태그를 대상으로 앞 뒤에 노드를 추가할 수 있다 | option종류 : beforebegin, afterbegin, beforeend, afterend | 부모 요소를 갖지 않을 경우<br> 위 1, 4번째 옵션사용 불가   |



## 1.6.3. 자식노드를 선택하는 방법

| 텍스트, 주석을 무시하는 속성 | 텍스트, 주석을 신경쓰는 속성 |
| ---------------------------- | ---------------------------- |
| parentElement                | parentNode                   |
| children                     | childNodes                   |
| firstElementChild            | firstChild                   |
| lastElementChild             | lastChild                    |
| nextElementSibling           | nextSibling                  |
| previousElementSibling       | previousSibling              |

- childElementCount 는 자식요소들의 갯수를 셀 때 유용함.





## 1.7 ElementNode, TextNode 생성 (create * 메소드 사용하여)


### 추가는 1.10 에서 다룸

```js
var elementNode = document.createElement('div');
var textNode = document.createTextNode('Hi');
var commentNode = document.createComment('안녕');
console.log(elementNode, elementNode.nodeType, elementNode.nodeName);
console.log(textNode, textNode.nodeType, textNode.nodeName);
console.log(commentNode, commentNode.nodeType, commentNode.nodeName);

console.dir(elementNode)
console.dir(textNode)
console.dir(commentNode)
/*
createElement('{tagName}')
	1. Element 개체를 생성
	2. Element 개체의 tagName 속성값과 createElementt의 파라미터와 동일하다

createAttribute는 사용금지
	1. 대신 setAttribute, gettAttribute, removeAttribute 를 사용한다

createComment() 메소드도 존재함
*/
```

- `console.log는 요소를 HTML과 같은 트리 구조로 출력합니다.`
- `console.dir은 요소를 JSON과 같은 트리 구조로 출력합니다.`



## 1.10 노드개체 추가하기 

| 메소드                                              | 설명                     | 특징                                                         |
| --------------------------------------------------- | ------------------------ | ------------------------------------------------------------ |
| appendChild(대상노드)                               | 마지막 자식노드로 추가됨 | append() 와 동일한 기능이나 append()는 InterExplorer11에서 불가능하여 잘 안씀 |
| insertBefore(대상노드, 자식노드中 타겟이 되는 노드) |                          |                                                              |
| prepend()                                           |                          |                                                              |
| before()                                            |                          |                                                              |
| after()                                             |                          |                                                              |



## 1.11 노드 제거/교체

> 노드자신.removeChild(자식노드)
>
> 노드자신.replaceChild(새 자식노드, 기존 자식노드)

- 위 두개 메소드는 리턴값으로 제거되는 대상노드 / 교체되는 대상노드 를 리턴한다.
- 또한 이 대상노드들은 위 두 메소드가 실행된 이후에도 접근할 수 있다.

## 1.12 노드 복사

> var clone = 현노드.cloneNode(); // 자기 자신만 복사
>
> var clone = 현노드.cloneNode(true); //자식까지 모두 복사

- 현 노드의 속성값 전부가 복제된다.(인라인 이벤트포함)
- addEventListener() 나 node.onclick 으로 추가된 것은 복제되지 않는다.
- 요소ID도 복사되기 때문에 요소ID가 중복되는 것을 주의하자



## 1.13 노드컬렉션에 대한 이해 _ 이절의 마지막에 표로 정리해놓음

<a href="https://devsoyoung.github.io/posts/js-htmlcollection-nodelist">링크</a>

**1.13.1 HTMLCollection**

- 문서 내에 순서대로 정렬된 노드의 컬렉션
- 유사배열임. 배열이 아니므로 array.prototype의 모든 메서드를 사용할 수 없음
- 배열처럼 인덱스로 접근가능
- 배열 구조분해나 `Array.from()`으로 `HTMLCollection`으로부터 배열을 생성해서 해당 메서드를 사용할 수 있습니다.

```js
const collection = document.body.children;

// Array Destructuring을 사용
[...collection].map(node => node.tagName);
> (8) ["SCRIPT", "DIV", "SCRIPT", "DIV", "SCRIPT", "SCRIPT", "SCRIPT", "SCRIPT"]

// Array.from()을 사용
Array.from(collection).map(node => node.tagName);
> (8) ["SCRIPT", "DIV", "SCRIPT", "DIV", "SCRIPT", "SCRIPT", "SCRIPT", "SCRIPT"]
```

**요소접근방법**

```html
<body>
  <div name="myDiv"></div>
  <div name="my Div"></div>
  <div name="3"></div>
</body>
```

- name속성값으로 위 첫번째 <div>태그를 선택할 수 있음.(두번째, 세번째 <div>태그의 name속성값은 불가능)

- 별도의 대안으로 namedItem( ),  item( ) 을 사용할 수 있음

  ```js
  const collection = document.body.children;
  
  console.log(collection.myDiv); // <div name="myDiv"></div>
  console.log(collection.3);     // Uncaught SyntaxError: Unexpected number
  
  //별도의 대안1
  console.log(collection.namedItem("my Div")); // <div name="my Div"></div>
  console.log(collection.namedItem(3));        // <div name="3"></div>
  
  //별도의 대안2
  console.log(collection.item(0));
  ```



## Node 컬렉션정리표

|                | HTMLCollection                                               | NodeList                                                     |      |
| -------------- | ------------------------------------------------------------ | ------------------------------------------------------------ | ---- |
| **특징**       | 문서에 배치된 HTML태그 순서대로 정렬됨                       | 문서에 배치된 HTML태그 순서대로 정렬됨                       |      |
|                | 유사배열(**foreach**, **map**사용불가)                       | 유사배열(**map**사용불가)<br>`forEach`,`entries()`, `keys()`, `values()` 사용가능 |      |
|                | Live Collection                                              | Live Collection<br>**querySelectorAll( ) 만 예외**           |      |
|                | length속성                                                   | length속성                                                   |      |
| **얻는 방법**  | Element.**children**<br>document.all<br/>document.images<br/>document.links<br/>document.scripts<br/>document.styleSheets<br/> | Element.**childNodes**         (live콜렉션)<br>Element.**querySelectorAll**(static콜렉션)<br/>document.**querySelectorAll**(static콜렉션) |      |
| **배열로변환** | 배열구조분해, Array.from( ) 이용한다                         | 배열구조분해, Array.from( ) 이용한다                         |      |
| **요소접근법** | collection['nam속성값'] <br>collection[idx]<br>collection.item(idx) | nodeList[0]<br/>nodeList.item(0)                             |      |
| 요소의 타입    | Element                                                      | Element, Text, Comment                                       |      |

- HTMLCollection타입인  children속성은 자식이 없는경우라도 null이 아닌 빈 HTMLCollection 개체를 갖음





## 1.14 직계자식만 선택하기

> childNodes 속성: NodeList 타입
>
> 1.6.3 참고

## 1.15 노드컬렉션을 JS배열로 변환

- JS배열로 변환하는 목적:
  1. DOM에 국한되지 않은 리스트 스냅샷을 만들 수 있게 해준다.
  2. Array개체가 제공하는 매서드를 사용할 수 있다
     - foreach, pop, map, reduce
- Array.prototype.slice() 로 파라미터를 주지 않으면 아무것도 슬라이스하지 않고 배열을 리턴

~~~html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    
<a href=""></a>
<script>
    console.log(Array.isArray(Array.prototype.slice.call(document.links)));
    console.log(Array.isArray(Array.prototype.slice.call(document.querySelector('a'))));
</script>

</body>

</html>
~~~



## 1.16 노트탐색

1.6.3 참고



## 1.17 contain()와 compareDocumentPosition()으로 DOM트리 내의 Node위치를 확인하기

> 조상노드.contains(타겟노드)
>
> 리턴: true / false

> 현재노드.compareDocument(타겟노드)
>
> 리턴값
>
> 0: 동일Element
>
> 1: 동일문서에 없음
>
> 2: 타겟노드가 앞형제
>
> 4: 타겟노드가 뒤형제
>
> 8: 타겟노드가 조상임
>
> 16, 10 : 타겟노드가 자손임



## 1.18 두 노드가 동일한지 여부판단

현노드.isEqualNode(타겟노드)









# 2. document노드

- DOM의 시작점
- 문서전체를 의미
- 인터페이스임 (규격일 뿐)
- 실제 사용은 Document개체가 아닌 Document개체를 상속한 **HTMLDocument**를 사용함.

~~~js
console.log(window.document.constructor); // function HTMLDocument() 출력
console.log(window.document.nodeType);    // Document_NODE에 매핑값인 9출력
~~~

[정리]

HTMLDocument() 생성자호출로 Document_NODE인 window.document 객체 (전역객체 window생략해서 걍 document 객체 라고 써도 됨) 가 생성됨. 

document 개체는 Document개체와 다름. 분명히 구별할 것. Document

## 2.2 HTMLDocument의 속성 및 메서드(상속포함)

```js
//document own properties
console.log(Object.keys(document).sort());

//document own properties & inherited properties
var documentPropertiesIncludeInherited = [];
for (var p in document) {
    documentPropertiesIncludeInherited.push(p);
}
console.log(documentPropertiesIncludeInherited.sort());

//documment inherited properties only
var documentPropertiesOnlyInherited = [];
for (var p in document) {
    if (!document.hasOwnProperty(p)) {
        documentPropertiesOnlyInherited.push(p);
    }
}
console.log(documentPropertiesOnlyInherited.sort());
```



## 2.3 document개체의 속성

```js
var d = document;
console.log('title = ' +d.title);
console.log('url = ' +d.URL);
console.log('referrer = ' +d.referrer);
console.log('lastModified = ' +d.lastModified);
```



## 2.4 [DOM상에서] document의 2개의 자식노드

- docType
- <html>태그라는 하나의 element

```js
//This is the doctype/DTD
console.log(document.childNodes[0].nodeType); //logs 10, which is a numeric key mapping to DOCUMENT_TYPE_NODE

//This is the <html> element
console.log(document.childNodes[1].nodeType); //logs 1, which is a numeric key mapping to ELEMENT_TYPE_NODE

```



## 2.5 [개체의 속성상에서] document의 속성

~~~js
console.log(document.doctype); // logs DocumentType {nodeType=10, ownerDocument=document, ...}

console.log(document.documentElement); // logs <html lang="en">

console.log(document.head); // logs <head>

console.log(document.body); // logs <body>
~~~

## 2.7 문서내 포커스를 가지고 있거나 활성상태인 노드에 대한 접근

~~~js
//set focus to <textarea>
document.querySelector('textarea').focus();

//get reference to element that is focused/active in the document
console.log(document.activeElement); //logs <textarea>
~~~

## 2.8 document 혹은 element가 포커스를 가지고 있는지 판별

```js
//If you keep focus on the window/tab that has the document loaded its true. If not it's false.
setTimeout(function(){console.log(document.hasFocus())},5000);
```

## 2.9 최상위/전역 개체로 접근

```js
console.log(document.defaultView) //reference, head JS object. Would be window object in a browser.
```

## 2.10 element에서 document로 접근

~~~
<iframe src="http://someFileServedFromServerOnSameDomain.html"></iframe>
<script>
    console.log(document.body.ownerElement);
	console.log(window.frames[0].document.body.ownerElement)
</script>
~~~





# 3장 Element노드

## 3.3 Element 생성

```js
var elementNode = document.createElement('textarea'); //HTMLTextAreaElement() constructs <textarea>
document.body.appendChild(elementNode);

console.log(document.querySelector('textarea')); //verify it's now in the DOM
```

## 3.4. Element 노드의 속성

- tagName
- nodeName

두 속성이 값이 같다. 대문자로 나타난다.

## 3.5. Attribute 및 값에 대한 리스트/컬렉션 얻기

[attributes 속성]

> Attr노드의 컬렉션임(리스트)
>
> 리스트이나 정확한 타입명은 NameNodeMap임
>
> 유사배열컬렉션임
>
> length속성을 가짐
>
> option 엘리먼트의 경우 다음의 예에서 selected속성은 속성값을 갖지 않는다.
>
> <option selected>foo</option>
>
> option 엘리먼트의 경우 다음의 예에서 selected속성은 속성값을 갖는다.
>
> <option selected="selected">foo</option>

```js
<a href='#' title="title" data-foo="dataFoo" class="yes" style="margin:0;" foo="boo"></a>
    <script>
        var atts = document.querySelector('a').attributes;
        for (var i = 0; i < atts.length; i++) {
            console.log(atts[i].nodeName + '(' + atts[i].nodeType + ')' + '=' + atts[i].nodeValue);
        }
    </script>
```





## 3.6. Attribute값 get, set, remove

- 값을 null, ''(빈문자열) 로 설정하지 말고 removeAttribute로 설정하라
- body Element의 경우 attribute가 엘리먼트 노드의 개체속성으로 접근을 할 수 있지만(document.body.id, document.body.className) 지양하고 getAttribute, setAttribute, removeAtttribute를 사용할 것.

```html
<a href='#' title="title" data-foo="dataFoo" style="margin:0;" class="yes" foo="boo" hidden="hidden">#link</a>
<script>
var atts = document.querySelector('a');

//remove attributes
atts.removeAttribute('href');
atts.removeAttribute('title');
atts.removeAttribute('style');
atts.removeAttribute('data-foo');
atts.removeAttribute('class');
atts.removeAttribute('foo'); //custom attribute
atts.removeAttribute('hidden'); //boolean attribute

//set (really re-set) attributes
atts.setAttribute('href','#');
atts.setAttribute('title','title');
atts.setAttribute('style','margin:0;');
atts.setAttribute('data-foo','dataFoo');
atts.setAttribute('class','yes');
atts.setAttribute('foo','boo');
atts.setAttribute('hidden','hidden'); //boolean attribute requires sending the attribute as the value too

//get attributes
console.log(atts.getAttribute('href'));
console.log(atts.getAttribute('title'));
console.log(atts.getAttribute('style'));
console.log(atts.getAttribute('data-foo'));
console.log(atts.getAttribute('class'));
console.log(atts.getAttribute('foo'));
console.log(atts.hasAttribute('hidden'));

</script>
```



## 3.7 attribute를 가지고 있나

- 없는 속성에 대해 true를 반환

```html
<a href='#' title="title" data-foo="dataFoo" style="margin:0;" class="yes" foo></a>
<script>
	var atts = document.querySelector('a');
    console.log(
        atts.hasAttribute('href'),
        atts.hasAttribute('title'),
        atts.hasAttribute('style'),
        atts.hasAttribute('data-foo'),
        atts.hasAttribute('class'),
        atts.hasAttribute('foo') //Notice this is true regardless if a value is defined 
    )
</script>
```

- Boolean attribute (checked)에 대해서도 유의미하게 사용됨.
- 위의 없는 속성에 대한 처리와 혼동하지 말것
- checked 없음 => false 반환
- checked 있음 => true 반환

```html
<input type="checkbox" checked></input>
<script>
    var atts = document.querySelector('input');
	console.log(atts.hasAttribute('checked')); //logs true
</script>
```



## 3.8. class Attribute값에 대해 리스트 얻기

- className은 클래스명 전부를 공백으로 연결한 문자열임.
- classList 은 DOMTokenList 타입으로 `유사 배열 컬렉션`임
  - length속성
  - 읽기전용이지만 add(), remove(), contains(), toggle() 메서드를 사용해서 변경가능함

```html
<div class="big brown bear"></div>

<script>
	var elm = document.querySelector('div');
    console.log(elm.classList); //big brown bear {0="big", 1="brown", 2="bear", length=3, ...}
    console.log(elm.className); //logs 'big brown bear'
</script>
```

## 3.9. class 속성 추가/제거/토글, 포함여부

classList.add('속성명')

classList.remove('속성명')

classList.toggle('속성명')

classList.contains('속성명')

```html
<div class="dog"></div>
<scriptt>
	var elm = document.querySelector('div');
    elm.classList.add('cat');
    elm.classList.remove('dog');
    elm.classList.toggle('bug');
    console.log(elm.className); // 'cat'
</scriptt>
```



## 3.10 data-* attribute 값 가져오고 세팅하기

- html 태그상의 data속성중 하이픈(-) 이 있는 경우는 javascript에서 카멜케이스로 대체된다.
- 예) foo-foo  -> fooFoo
- HTMLElement.dataset  은 DOMStringMap 개체를 리턴한다.
- 삭제는 delete dataset.fooFoo
- getAttribute/ setAttribute/ removeAttribute/ hasAttribute는 언제나 사용가능하다.

```html
<div data-foo-foo="foo" data-bar-bar="bar"></div>
<script>
	var elm = document.querySelector('div');

    //get
    console.log(elm.dataset.fooFoo); //logs 'foo'
    console.log(elm.dataset.barBar); //logs 'bar'

    //set
    elm.dataset.gooGoo = 'goo';
    console.log(elm.dataset); //logs DOMStringMap {fooFoo="foo", barBar="bar", gooGoo="goo"}

    //what the element looks like in the DOM 
    console.log(elm) //logs <div data-foo-foo="foo" data-bar-bar="bar" data-goo-goo="goo">
</script>
```



# 4장. Element 선택하기

## (1.13 표 참고)

## 4.1. 특정Element 노드 하나 선택하기

| 주체                 | 메소드                                 | 설명     | 특징                                                        |
| -------------------- | -------------------------------------- | -------- | ----------------------------------------------------------- |
| document,<br>element | Element **querySelector**(cssSelector) | 단일선택 | cssSelector자리 예)<br>  #score>tbody>tr>td:n th-of-type(2) |
| document             | Element **getElementById**(cssID)      | 단일선택 |                                                             |



## 4.2. Element노드 리스트 선택하기

- 아래 메소드 전부 Element에도 정의되어있다.

| 주체                 | 메소드                                      | 설명     | 특징                                                         |
| -------------------- | ------------------------------------------- | -------- | ------------------------------------------------------------ |
| document,<br>element | NodeList **querySelectorAll**()             | 다중선택 | static상태, 문서 스냅샷임, <br>문서의 변경내용을 반영하지 않음 |
| document,<br>element | HTMLCollection **getElementsByTagName**()   | 다중선택 | Live상태                                                     |
| document,<br>element | HTMLCollection **getElementsByClassName**() | 다중선택 | Live상태                                                     |
| document             | NodeList **getElementsByName**()            | 다중선택 |                                                              |

- name 속성을 갖는 element( form, img, frame, embed, object )를 선택할 때 getElementsByName를 사용한다.

## 4.3.  컨텍스트 기반 Element선택

- 위 두개의 표에서 주체에 element가 있는 메소드의 경우 DOM트리를 특정부분으로 제한할 수 있다. 즉, 컨텍스트를 선택할 수 있다.



## 4.6. Element.matches 로 검증하기

```html
<ul id="birds">
  <li>Orange-winged parrot</li>
  <li class="endangered">Philippine eagle</li>
  <li>Great white pelican</li>
</ul>

<script type="text/javascript">
  var birds = document.getElementsByTagName('li');

  for (var i = 0; i < birds.length; i++) {
    if (birds[i].matches('.endangered')) {
      console.log('The ' + birds[i].textContent + ' is endangered!');
    }
  }
</script>
```



# 5. Element 노드의 Geometry 와 스크롤링 Geometry

## 5.1. 개요

Element노드의 지오메트리를 측정하고 조작하는 API를 제공함.

## 5.2. offsetParent기준으로 element의 offsetTop및 offsetLeft 값을 가져오기





# 6. 인라인스타일 (Element노드에 한해서)

## 6.1. 개요

Element의 style에 접근하는 방법

**Element.style** 의 개체유형:  CSSStyleDeclaration(오직 인라인스타일을 위한 개체)

```html
<div style="background-color:red;border:1px solid black;height:100px;width:100px;"></div>
<script>
	var divStyle = document.querySelector('div').style; 

    //logs CSSStyleDeclaration {0="background-color", ...}
    console.log(divStyle);
</script>
```



## 6.2. get/set/remove CSS속성

CSS)  background-color 속성명

Javascript) backgroundColor 로 camelCase를 사용한다.

- Element.style에 대해서 getProperty, setProperty, removeProperty 를 사용한다.

```html
<script>
    var divStyle = document.querySelector('div').style; 
	divStyle.backgroundColor = 'red'
    divStyle.setProperty('속성명', '값')
    divStyle.getProperty('속성명', '값')
    divStyle.removeProperty('속성명', '값')
</script>


```



## 6.3 CSS속성값 여러개 일일이 바꾸기 귀찮을 때, 일괄변경

방법A) Element.style.cssText 속성값

방법B) Element의 setAttribute 로 설정,제거 모두 가능

```html
<script>
    var div = document.querySelector('div');
    var divStyle = div.style;

    //set using cssText
    divStyle.cssText = 'background-color:red;border:1px solid black;height:100px;width:100px;';
    //get using cssText
    console.log(divStyle.cssText);
    //remove
    divStyle.cssText = '';

    //exactly that same outcome using setAttribute() and getAttribute()

    //set using setAttribute
    div.setAttribute('style','background-color:red;border:1px solid black;height:100px;width:100px;');
    //get using getAttribute
    console.log(div.getAttribute('style'));
    //remove
    div.setAttribute('style','');
</script>
```



## 6.4. getComputedStyle() 을 사용하여 element의 계산된 스타일(계층화된 것을 포함한 실제 스타일) 가져오기



## 6.5 class 및 id를 사용하여 CSS적용하기

- class의 경우) Element.classList.add('클래스명')
- id의 경우) Element.setAttribute('id', 'id명')





























































