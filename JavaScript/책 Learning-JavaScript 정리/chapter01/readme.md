Question
1. p.63 전역으로 gulp를 설치하고 프로젝트마다 로컬gulp를 중복해서 설치하는 이유는 뭘까?

Caution
1. 업데이트 되면서 부터 .babelrc 파일은 안쓴다. 삭제할것.
2. env 라는 preset을 사용한다. 코드는 https://blog.naver.com/PostList.nhn?blogId=bluesky4381&from=postList&categoryNo=29 참고



자바스크립트의 역사
==================

# ECMAScript 5.1버전 (ES5) 
## -2011.06 발행
## 현재 웹의 표준으로 자리잡음

# ECMAScript 6버전(ES6)
## -2015.06발행
## ES5로 트렌스컴파일해야하는 불편함이 있음 (ES5가 현재 널리쓰이기 때문, 그러나 대세는 ES6)


텍스트에디터
============
## 유형은 크게  두가지로 나뉜다
# 1. 텍스트 모드
## vi / vim
# 2. 창 모드
## 아톰,서브라임텍스트,코다,vs,노트패드++,텍스트패드,xcode


# 의존성
## 개발의존성 && 일반의존성
### 개발의존성 : 앱을 실행할 때는 필요없음. but, 프로젝트 개발시 필요.
### 일반의존성 :

# package.json 설정파일
### 의존성 관리파일 : 의존성(모듈)의 정보를 가지고 있다.
### `install --save 모듈명` `install --save-dev 모듈명`<br> --save or --save-dev 옵션을 추가하면 package.json파일에 등록됨 (로컬패키지설치)
### `install -g 모듈명` -g 옵션을 추가하면 전역설치됨(개발컴퓨터에 설치되는 것.)
### 이후 프로젝트마다 모듈을 쓰고 싶을 땐,<br>
`npm install --sava-dev 모듈명` or `npm install --sava 모듈명` 을 실행



# node_module 디렉토리
### `npm install` 명령어로 위 package.json 설정파일에 명시된 모듈들을 일괄 설치한다.

# 걸프와 그런트
## 반복잡업의 번거로움을 자동화하는 빌드 도구
### 걸프가 더 많이 쓰임

# 서버side (노드) vs 클아이언트side (브라우저)


## 서버       : /es6/ (노드소스 경로)
## 클아이언트 : /public/es6/  (ES6용 .js) 
##              /public/dist/ (ES5용 .js) dist는 distribution의 약자

# 트랜스컴파일러
### 바벨 & 트레이서 : 모두 잘쓰임
### 바벨 : ES5 , ES6, ES7, 리액트등 여러가지 지원하는 범용 트랜스컴파일러
### [ES5 -> ES6로 변환하기 위한 사용법]
#### 최종결과물이ES6 이므로 ES6 변환 프리셋 설치
#### 바벨이 해당 프리셋을 사용하게끔 설정
