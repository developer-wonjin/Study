# 환경설정

`sudo npm install -g create-react-app` : cra 설치

또는, `npx create-react-app`

## npm vs npx

npx : 실행할 때마다 새로 다운받아 최신버전을 유지시켜줌

npm: 한 번 다운받고 끝



# 개발환경

폴더 `react-app` 생성

`cd react-app` : 프로젝트 폴더

`create-react-app .`:  프로젝트 생성

`npm start` : 프로젝트 실행

# 배포

개발할 때, 브라우저를 보면 `1.8MB` 용량을 차지함

따라서 배포용 프로젝트를 만들어야함.

`npm run build` : 빌드시키면 `/build` 폴더가 생성됨

`npm install -g serve` : 웹서버 설치

`npx serve -s build` : 웹서버를 최신으로 1회용으로 설치해서 시작하는데 build 폴더에 있는 것을 기반으로 실행

개발자 도구에 `147 kB` 용량으로 축소된 것을 확인할 수 있음

# 재사용성

`index.html 의 <div id="root"></div>` 과 `index.js` 

index.js코드

```js
import React from 'react';
import ReactDOM from 'react-dom';
import './index.css';
import App from './App';
import reportWebVitals from './reportWebVitals';

ReactDOM.render(
    <App />,
  document.getElementById('root')
);
```

```
App  _____ Subject
     \____ TOC
     \____ Content
```

App.js

```js
import React, { Component } from 'react';
import './App.css';

import Subject from "./components/Subject"
import TOC from "./components/TOC"
import Content from "./components/Content"

class App extends Component{
  render(){
    return (
      <div className="App">
        <Subject title="WEB" sub="world wide web!!"></Subject>
        <TOC></TOC>
        <Content title="HTML" desc="HTML is HyperText Markup Language."></Content>
      </div>
    );
  }
}
```

Subject.js

```js
import React, { Component } from 'react';

class Subject extends Component{
    render(){
      return (
        <header>
          <h1>{this.props.title}</h1>
          {this.props.sub}
        </header>
      );
    }
  }
  
  export default Subject;
```

TOC.js  와 Content.js 이하 동일

# State  and Props

- 사용자 입장
  - **사용자가** Component를 사용할 때 값을 **Props를 변경시킴**
- 개발자 입장
  - 내부적 상태(State)를 관리
  - Props 에 따라 State가 변경됨
  - 외부에 노출될 필요 없음

- 동작 순서
  1. Component 생성
  2. 사용자가 Component 외부에서 Component의 Props 조작함. (사용자는 오직 props만 다룰줄 암)
  3. 내부적으로 사용되는 값의 총체(State)가 변경됨

# 상위 Component에서 하위 Component에 Props 전달

state의 값을 Component 태그의 속성으로 전달하면 됨.





# 이벤트 등록시 유의사항

1. html 태그상에서 이벤트 등록

~~~html
<a href="/" onClick={function(e){
              e.preventDefault();
              this.state.mode = 'welcome';
              this.setState({
                mode: 'welcome',
              })
}.bind(this)}>{this.state.subject.title}</a>
~~~

- bind를 꼭 해줘야함
- this.setState({key: value}) 를 호출하여 state를 변경해줘야함



2. Component 태그상에서 이벤트 등록

- 부모컴포넌트 App

```react
<Subject
    title={this.state.subject.title}
    sub={this.state.subject.sub}
    onChangePage={function(){
        alert('hihihi');
    }.bind(this)}></Subject>
```

- 자식컴포넌트 Subject

```react
return (
	<header>
    	<h1><a href="/" onClick={function(e){
                    e.preventDefault();
                    this.props.onChangePage();
              }.bind(this)}>{this.props.title}</a></h1>
    </header>
)
```









































































