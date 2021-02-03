# 환경설정

`sudo npm install -g create-react-app` : cra 설치

## npm vs npx

npx : 실행할 때마다 새로 다운받아 최신버전을 유지시켜줌

npm: 한 번 다운받고 끝



# 개발환경

폴더 `react-app` 생성

`cd react-app` : 프로젝트 폴더

`create-react-app`:  프로젝트 생성

`npm start` : 프로젝트 실행

# 배포

개발할 때, 브라우저를 보면 `1.8MB` 용량을 차지함

따라서 배포용 프로젝트를 만들어야함.

`npm run build` : 빌드시키면 `/build` 폴더가 생성됨

`npm install -g serve` : 웹서버 설치

`npx serve -s build` : 웹서버를 최신으로 1회용으로 설치해서 시작하는데 build 폴더에 있는 것을 기반으로 실행

개발자 도구에 `147 kB` 용량으로 축소된 것을 확인할 수 있음





























































