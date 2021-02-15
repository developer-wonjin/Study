(번역) DOM은 정확히 무엇일까? https://wit.nts-corp.com/2019/02/14/5522

## DOM

> Node개체를 계층화한 트리



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
- COMMENT_NODE는 거의 TEXT_NODE와 동일

| 인터페이스 / 생성자                  | nodeType | 예시                   |      |
| ------------------------------------ | -------- | ---------------------- | ---- |
| HTML * Element (예: HTMLBodyElement) | 1        | Element_NODE           |      |
| Text                                 | 3        | TEXT_NODE              |      |
| Attr                                 | 2        | ATTRIBUTE_NODE         |      |
| HTML_Document                        | 9        | DOCUMENT_NODE          |      |
| DocumentFragment                     | 11       | DOCUMENT_FRAGMENT_NODE |      |
| DocumentType                         | 10       | DOCUMENT_TYPE_NODE     |      |



## 1.3. Node 개체로부터 상속받은 하위 노드 개체

<img src="./img/NODE TREE.png">

```
Object
  └ Node
      ├ Element
      │     └ HTMLElement 
      │             └ 겁나많아 (HTML*Element , * 자리에 들어갈 단어: Head, Body, Title, Input, Table, Paragraph, 등등)       ├ Attr
      ├ CharacterData
      │     └ Text
      ├ Docuement
      │     └ HTMLDocuement
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



## 1.6 노드 값 nodeValue (오직 Text와 Comment를 출력하기 위한 것)

> nodeValue 속성은 Text 와 Comment를 제외하고 null값을 반환함

**(Text, Comment 일 경우 nodeValue 값)	textContent 속성값 출력** 

**(그 외)	null**



<hr>
**참고**

Text, Coment 포함한 경우)  childNodes  -   firstChild

else)                                     children      -   firstElementChild

<hr>


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



## 1.8/ 1.9 ElementNode, TextNode 생성 (속성에 속성값을 지정하여)

${HTML *Element 노드} .**innerHTML** = '\<strong>Hi\</strong>'

> Element 노드의 자식요소로 \<strong>Hi\</strong> 가 DOM에 추가됨
>
> HTML파서를 호출하여 성능을 악화시킴, 아래 textContent를 사용할 것 권장

${HTML *Element 노드} .**outterHTML** = '\<strong>Hi\</strong>'

> **Element 노드가 \<strong>Hi\</strong> 로 교체됨**
>
> Element 노드는 없어짐

${HTML *Element 노드} .**textContent** = '메롱'

> **Text노드가 생성**
>
> innerHTML, innerText, outerText, textContent 의 속성값이 '메롱'으로 변경됨
>
> **속성값을 읽을 때)** display:none이 적용된 자식요소의 텍스트까지 보여주고 싶을 때는 `textContent` 를 사용한다

<hr>

### 다음은 비표준 확장임

${HTML *Element 노드} .**innerText**= '메롱'

> **Text노드 생성**
>
> \<script> 태그에서는 동작 안함
>
> **속성값을 읽을 때)**  display:none이 적용된 자식요소의 텍스트를 무시하고 보여주고 싶을 때는 `textContent` 를 사용한다

${HTML *Element 노드} .**outerText**= '메롱'

> **Text노드 생성**
>
> Text노드로 교체됨
>
> Element 노드는 없어짐

<hr>

${HTML *Element 노드} .insertAdjacentHTML('${option}', '${HTML태그 string}');

>option : beforebegin, afterbegin, beforeend, afterend
>
>HTML *Element가 부모 요소를 갖지 않을 경우 위 1, 4번째 옵션사용 불가
>
>HTML *Element 의 열린태그 , 닫힌태그를 대상으로 앞 뒤에 노드를 추가할 수 있다



## 1.10 노드개체 추가하기 

타겟노드**.appendChild**(대상노드)

>타겟노드의 마지막 자식노드로 추가됨
>
>append() 와 동일한 기능이나 append()는 InterExplorer11에서 불가능하여 잘 안씀

타겟노드**.insertBefore**(대상노드, 자식노드中 타겟이 되는 노드)

>타겟이 되는 자식노드 앞에 추가됨





## Value값 읽어오기

- `form 요소(input 등) 의 값` : .value 
- `그 외 div 나 span 등의 요소`:  .textContent

