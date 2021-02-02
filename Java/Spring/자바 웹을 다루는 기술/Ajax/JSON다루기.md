[자바스크립트에서의 JSON](#자바스크립트에서_JSON) <br>
[자바에서의 JSON](#Java에서_JSON만들기) <br>

# JSON객체
{key : value} 형식을 갖춤. 즉 객체면 중괄호임. { } <br>
key 자리에는 문자열로 식별자가 자리함. value에는 문자열, 객체 , 배열, 객체배열 모두 올 수 있음.

## 자바스크립트에서_JSON
문자열 배열
~~~javascript
 var jsonStr  = '{"name": ["홍길동", "이순신", "임꺽정"] }';          
 var jsonInfo = JSON.parse(jsonStr); //제이쿼리에 JSON 클래스의 parse 메소드를 사용하여 JSON객체로 손쉽게 변형한다.
~~~

정수 배열
~~~javascript
 var jsonStr = '{"age": [22, 33, 44]}';  
 var jsonInfo = JSON.parse(jsonStr);
~~~

문자열 배열(단, 다양한 key를 갖음)
~~~javascript
  var jsonStr = '{"name":"박지성","age":25,"gender":"남자","nickname":"날센돌이"}';
  var jsonObj = JSON.parse(jsonStr);
~~~

객체 배열
~~~javascript
var jsonStr = '{"members":[{"name":"박지성","age":"25","gender":"남자","nickname":"날센돌이"}'
	    	               +', {"name":"손흥민","age":"30","gender":"남자","nickname":"탱크"}] }';
var jsonInfo = JSON.parse(jsonStr);
~~~

# Java에서_JSON만들기
JSON 라이브러리 https://code.google.com/archive/p/json-simple/downloads<br>
json-simple-1.1.1.jar 다운 및 lib에 복붙
## 방법1) Sting -> JSON객체  (예외처리해야함)
~~~java
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
~~~
이때, 문자열은 " "로 감싸고 내부의 key,value도 \"로 감싸준다.
~~~java
private void doHandle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		....
		String jsonString = "{\"name\":\"박지성\",\"age\":\"25\"}";
		try {
			JSONParser jsonParser = new JSONParser(); //파서객체 생성
			JSONObject jsonObject = (JSONObject) jsonParser.parse(jsonInfo);//형변환 필수
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
~~~
## 방법2) 직접 JSON객체생성
~~~java
private void doHandle(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		PrintWriter writer = response.getWriter();

		JSONObject totalObject = new JSONObject(); //배열을 value로 하는 JSON {"key" : [  ] }
		JSONArray membersArray = new JSONArray(); //배열 [ ]
		JSONObject memberInfo = new JSONObject(); //객체 { }  (배열에 들어갈 요소)

		memberInfo.put("name", "박지성");
		memberInfo.put("age", "25");
		memberInfo.put("gender", "남자");
		memberInfo.put("nickname", "날센돌이"); // memberInfo 는  {"name":"박지성", "age":"25", "gender":"남자", "nickname":"날쎈돌이"}
		//  배열에 입력
		membersArray.add(memberInfo); // membersArray 는 [ {"name":"박지성", "age":"25", "gender":"남자", "nickname":"날쎈돌이"} ]

		memberInfo = new JSONObject();
		memberInfo.put("name", "김연아");
		memberInfo.put("age", "21");
		memberInfo.put("gender", "여자");
		memberInfo.put("nickname", "칼치");
		membersArray.add(memberInfo);  
    /*[ {"name":"박지성", "age":"25", "gender":"남자", "nickname":"날쎈돌이"} 
       ,{"name":"김연아", "age":"21", "gender":"여자", "nickname":"칼치"} ] */
		
		totalObject.put("members", membersArray); //{"members": [ { }, { } ]}
		String jsonInfo = totalObject.toJSONString();
		System.out.print(jsonInfo);
		writer.print(jsonInfo);
	}
~~~
# JSONArray (JSON이라기 보다 Array에 가깝다)
[ {"name":"박지성", "age":"25", "gender":"남자", "nickname":"날쎈돌이"} 
       ,{"name":"김연아", "age":"21", "gender":"여자", "nickname":"칼치"} ]<br>
# JSONObject
위 JSONArray를 브라우저에게 전송하고 싶다면 최종형태는 대괄호 [ 와 ] 가 아닌 {key : value} 형태로 만들어줘야 한다.
jsonObject.put("key", JSONArray);로 JSONObject로 만든다.

# JSONObject의 toJSONString() 메소드를 이용해 String으로 변환한다.
String jsonInfo = jsonObject.toJSONString();
writer.print(jsonInfo);
