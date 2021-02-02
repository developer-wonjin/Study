# 제이쿼리
<script  src="http://code.jquery.com/jquery-2.2.1.min.js"></script>

# DOM 생성이후 호출
## 1. DOM생성이후 리소스(이미지, 동영상)의 로딩 완료와 상관없이 진행된다.
```javascript
$(document).ready(function(){				
  
});
```
```javascript
 $(function() {
           
 });
```
## 2. DOM생성이후 리소스전부 다운받은 다음에 진행
```javascript
window.onload = function(){};
```
