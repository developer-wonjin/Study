# DOM 스크립트 _윤석찬

<div style="text-align: right"><b>작 성 일 : 20.00.00</b></div>
<div style="text-align: right"><b>작 성 자 : 도 원 진</b></div>

# 1.DOM 의 정의

## 1.1 문서객체모델

HTML 태그들을 JavaScript가 사용할 수 있는 객체(Object)로 인식하게 끔 만드는 구조

Object 개별 하나 하나는 DOM 구조에서 `요소 node` 하나로 대표될 수 있고 이 요소노드는 하위에 `속성 노드` , `텍스트 노드` 를 갖는다.

- D: Document
- O: Object
- M: Model

## 1.2 Document

- HTML 태그로 이루어진 텍스트

## 1.3 Object

Property와 Method를 갖는 인스턴스

- Property
- Method

### JS가 다루는 Object 종류

- 윈도우객체(브라우저 객체모델BOM)
- 문서객체모델(DOM)

## 1.4 Model

- 지도, 형태, 구조
- DOM에서 Model은 노드(객체)들이 tree구조를 이룸
  - tree 구조를 이루는 노드는 아래 설명함.
- tree구조 안에서 부모, 자식간의 관계가 존재

# 2. NODE란

문서의 HTML 태그를  DOM 구조에서 `요소 node` 하나로 대표하고 HTML태그의 속성값과 텍스트를 `속성node` 와 `텍스트node` 가 `요소 node`의 자식노드가 된다.

~~~html
<body class="abc" id="def" style="margin: 1px">
    <h1>가족 사진22</h1>
    <ul>
        <li>
            <a href="images/A.jpg" onclick="javascript:showPic(this);return false;" title="A">A</a>
        </li>
        <li>
            <a href="images/B.jpg" onclick="showPic(this);return false;" title="B">B</a>
        </li>
        <li>
            <a href="images/C.jpg" onclick="showPic(this);return false;" title="C">C</a>
        </li>
    </ul>
    <img id="placeholder" src="images/default.png" alt="">
</body>

~~~



**document.getElementsByTagName('body')[0]  출력시**

~~~json
{
    0 : {
        body : {
                aLink: ""
                accessKey: ""
                ariaAtomic: null
                ariaAutoComplete: null
                ariaBusy: null
                ariaChecked: null
                ariaColCount: null
                ariaColIndex: null
                ariaColSpan: null
                ariaCurrent: null
                ariaDescription: null
                ariaDisabled: null
                ariaExpanded: null
                ariaHasPopup: null
                ariaHidden: null
                ariaKeyShortcuts: null
                ariaLabel: null
                ariaLevel: null
                ariaLive: null
                ariaModal: null
                ariaMultiLine: null
                ariaMultiSelectable: null
                ariaOrientation: null
                ariaPlaceholder: null
                ariaPosInSet: null
                ariaPressed: null
                ariaReadOnly: null
                ariaRelevant: null
                ariaRequired: null
                ariaRoleDescription: null
                ariaRowCount: null
                ariaRowIndex: null
                ariaRowSpan: null
                ariaSelected: null
                ariaSetSize: null
                ariaSort: null
                ariaValueMax: null
                ariaValueMin: null
                ariaValueNow: null
                ariaValueText: null
                assignedSlot: null
                attributeStyleMap: StylePropertyMap {size: 0}
                attributes: NamedNodeMap {length: 0}
                autocapitalize: ""
                autofocus: false
                background: ""
                baseURI: "http://localhost:8080/domScript/gallery.html"
                bgColor: ""
                childElementCount: 3
    
    		   //요소노드 + 비요소노드(줄바꿈, 주석)
                childNodes: NodeList(7) [text, h1, text, ul, text, img#placeholder, text]
                //요소노드만                         
                children: HTMLCollection(3) [h1, ul, img#placeholder, placeholder: img#placeholder]
                                         
                /*
                NodeList :       
                	childNodes 프로퍼티로 얻음(document.querySelectorAll 도 가능)
                	유사배열
                	forEach는 가능
                	그 외는 아래와 같은 사용법을 따른다
                	
                HTMLCollection : 
                	children 프로퍼티로 얻을 수 있음, 
                	유사배열(배열의 모든 메소드를 갖고 있진 않음 즉 forEach, map 호출 불가능)
       			   해결방법 : [...collection].map(node => node.tagName);
       			          또는 Array.from(collection).map(node => node.tagName);
                    사용법:
                    const collection = document.body.children;
                    //name 속성값으로 접근 가능
				  console.log(collection.myDiv); //  > <div name="myDiv"></div>
				  //name 속성값이 숫자이거나 띄어쓰기가 있으면 불가능
				  //따라서 namedItem 메소드를 사용
				  console.log(collection.namedItem("my Div")); //  > <div name="my Div"></div>
				  console.log(collection.namedItem(3)); //  > <div name="3"></div>
				  //순번 idx로 찾을 땐 item 메소드
				  console.log(collection.item(0));      //  > <div name="myDiv"></div>
				  
                */
                
                /*
               [childNodes와 querySelectorAll()의 차이]
				element.childNodes와 querySelectorAll()은 둘 다 ￿NodeList를 반환하지만 차이점을 가지고 	
                  있습니다. 바로 변경사항의 유무입니다. Node.childNodes의 NodeList는 라이브 콜렉션으로, 
                  DOM의 변경사항을 실시간으로 반영합니다. 반면에, document.querySelectorAll()의 NodeList는 정적 콜렉션으로, 
                  DOM이 변경되어도 collection의 내용에는 영향을 주지 않습니다.
               */
                                                           
                classList: DOMTokenList [value: ""]
                className: ""
                clientHeight: 628
                clientLeft: 0
                clientTop: 0
                clientWidth: 837
                contentEditable: "inherit"
                dataset: DOMStringMap {}
                dir: ""
                draggable: false
                elementTiming: ""
                enterKeyHint: ""
                firstChild: text
                firstElementChild: h1
                hidden: false
                id: ""
                innerHTML: "↵    <h1>가족 사진22</h1>↵    <ul>↵        <li>↵            <a href="images/A.jpg" onclick="javascript:showPic(this);return false;" title="A">A</a>↵        </li>↵        <li>↵            <a href="images/B.jpg" onclick="showPic(this);return false;" title="B">B</a>↵        </li>↵        <li>↵            <a href="images/C.jpg" onclick="showPic(this);return false;" title="C">C</a>↵        </li>↵    </ul>↵    <img id="placeholder" src="images/C.jpg" alt="">↵↵↵"
                innerText: "가족 사진22↵A↵B↵C"
                inputMode: ""
                isConnected: true
                isContentEditable: false
                lang: ""
                lastChild: text
                lastElementChild: img#placeholder
                link: ""
                localName: "body"
                namespaceURI: "http://www.w3.org/1999/xhtml"
                nextElementSibling: null
                nextSibling: null
                nodeName: "BODY"
                nodeType: 1
                nodeValue: null
                nonce: ""
                offsetHeight: 628
                offsetLeft: 0
                offsetParent: null
                offsetTop: 0
                offsetWidth: 837
                onabort: null
                onafterprint: null
                onanimationend: null
                onanimationiteration: null
                onanimationstart: null
                onauxclick: null
                onbeforecopy: null
                onbeforecut: null
                onbeforepaste: null
                onbeforeprint: null
                onbeforeunload: null
                onbeforexrselect: null
                onblur: null
                oncancel: null
                oncanplay: null
                oncanplaythrough: null
                onchange: null
                onclick: null
                onclose: null
                oncontextmenu: null
                oncopy: null
                oncuechange: null
                oncut: null
                ondblclick: null
                ondrag: null
                ondragend: null
                ondragenter: null
                ondragleave: null
                ondragover: null
                ondragstart: null
                ondrop: null
                ondurationchange: null
                onemptied: null
                onended: null
                onerror: null
                onfocus: null
                onformdata: null
                onfullscreenchange: null
                onfullscreenerror: null
                ongotpointercapture: null
                onhashchange: null
                oninput: null
                oninvalid: null
                onkeydown: null
                onkeypress: null
                onkeyup: null
                onlanguagechange: null
                onload: null
                onloadeddata: null
                onloadedmetadata: null
                onloadstart: null
                onlostpointercapture: null
                onmessage: null
                onmessageerror: null
                onmousedown: null
                onmouseenter: null
                onmouseleave: null
                onmousemove: null
                onmouseout: null
                onmouseover: null
                onmouseup: null
                onmousewheel: null
                onoffline: null
                ononline: null
                onpagehide: null
                onpageshow: null
                onpaste: null
                onpause: null
                onplay: null
                onplaying: null
                onpointercancel: null
                onpointerdown: null
                onpointerenter: null
                onpointerleave: null
                onpointermove: null
                onpointerout: null
                onpointerover: null
                onpointerrawupdate: null
                onpointerup: null
                onpopstate: null
                onprogress: null
                onratechange: null
                onrejectionhandled: null
                onreset: null
                onresize: null
                onscroll: null
                onsearch: null
                onseeked: null
                onseeking: null
                onselect: null
                onselectionchange: null
                onselectstart: null
                onstalled: null
                onstorage: null
                onsubmit: null
                onsuspend: null
                ontimeupdate: null
                ontoggle: null
                ontransitioncancel: null
                ontransitionend: null
                ontransitionrun: null
                ontransitionstart: null
                onunhandledrejection: null
                onunload: null
                onvolumechange: null
                onwaiting: null
                onwebkitanimationend: null
                onwebkitanimationiteration: null
                onwebkitanimationstart: null
                onwebkitfullscreenchange: null
                onwebkitfullscreenerror: null
        }
    }
	,length: 1
	,__proto__: HTMLCollection
}



~~~





















