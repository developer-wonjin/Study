# 1. 노드

## DOM

> Node개체를 계층화한 트리



## DOM의 목적 

> 내부적인 동작방식을 몰라도 `node개체의 정보와 부모자식간 계층` 을 안다면 쉽게 프로그래밍할 수 있음.

- 프로그래밍 : Javascript를 이용해 문서에 대한 스크립트 작성(삭제, 추가, 수정, 이벤트처리)

- 쉽게: 인터페이스 역할

  

## 노트개체 6가지 유형

| 유형                   | 설명                                                      | 상수값 | 비고 |
| ---------------------- | --------------------------------------------------------- | ------ | ---- |
| DOCUMENT_NODE          | window.document                                           | 9      |      |
| ELEMENT_NODE           | <html>  와 하위 태그 모두                                 | 1      |      |
| ATTRIBUTE_NODE         | class="" sttyle="" value=""<br/>data-OO="" placeholder="" | 2      |      |
| TEXT_NODE              | <p> 가나다라</p>  에서 `가나다라`                         |        |      |
| DOCUMENT_FRAGMENT_NODE | document.createDocumentFragment()                         |        |      |
| DOCUMENT_TYPE_NODE     | <!DOCTYPE html>                                           |        |      |
|                        |                                                           |        |      |



## 최상위 개체 Object 그 다음이 Node

- 모든 노드개체는 `Node 개체` 로부터 상속받는다.
- 











------------

p.5





