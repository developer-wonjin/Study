# url에 있는 맵핑값 써먹기
```java
@RestController 
@RequestMapping("/test/*")
public class TestController {

  @RequestMapping(value= "/notice/{num}" , method = RequestMethod.GET)
  public int notice(@PathVariable("num") int num ) throws Exception {
	  return num;
  }	
  
```
# JSON과 HttpStatusCode 전송
new ResponseEntity ( Collection list, HttpStatusCode HttpStatus )
```java
  @RequestMapping("/membersList2")
  public  ResponseEntity<List<MemberVO>> listMembers2() {
    List<MemberVO> list = new ArrayList<MemberVO>();
    for (int i = 0; i < 10; i++) {
      MemberVO vo = new MemberVO();
      vo.setId("lee" + i);
      vo.setPwd("123"+i);
      vo.setName("�̼���" + i);
        vo.setEmail("lee"+i+"@test.com");
      list.add(vo);
    }
    return new ResponseEntity(list,HttpStatus.INTERNAL_SERVER_ERROR);//JSON과 HttpStatusCode 전송
  }	
````

# 전송할 데이터 종류와 한글 인코딩 설정
new ResponseEntity ( String str, HttpHeaders responseHeaders, HttpStatusCode HttpStatus )
```java
	@RequestMapping(value = "/res3")
	public ResponseEntity res3() {
		HttpHeaders responseHeaders = new HttpHeaders();
	    responseHeaders.add("Content-Type", "text/html; charset=utf-8");
	    String message = "<script>";
		message += " alert('�� ȸ���� ����մϴ�.');";
		message += " location.href='/pro29/test/membersList2'; ";
		message += " </script>";
		return  new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);
	}
	
}
```

# REST방식으로 URI 표현하기
1. Http 메소드 종류 POST / GET / PUT / DELETE
2. URI 포멧 : <b>/작업명/기본기</b> + 메서드 + 데이터

## REST예제 코드
```java
@RestController
@RequestMapping("/boards")
public class BoardController {
	//전체조회	
	@RequestMapping(value = "/all", method = RequestMethod.GET) 
	public ResponseEntity<List<ArticleVO>> listArticles() {
		List<ArticleVO> list = new ArrayList<ArticleVO>();
		for (int i = 0; i < 10; i++) {
			ArticleVO vo = new ArticleVO();
			vo.setArticleNO(i);
			vo.setWriter("�̼���"+i);
			vo.setTitle("�ȳ��ϼ���"+i);
			vo.setContent("�� ��ǰ�� �Ұ��մϴ�."+i);
			list.add(vo);
		}
		
		return new ResponseEntity(list,HttpStatus.OK);
	}
	//특정 게시글 조회
	@RequestMapping(value = "/{articleNO}", method = RequestMethod.GET)
	public ResponseEntity<ArticleVO> findArticle (@PathVariable("articleNO") Integer articleNO) {
		logger.info("findArticle �޼��� ȣ��");
		ArticleVO vo = new ArticleVO();
		vo.setArticleNO(articleNO);
		vo.setWriter("ȫ�浿");
		vo.setTitle("�ȳ��ϼ���");
		vo.setContent("ȫ�浿 ���Դϴ�");
		return new ResponseEntity(vo,HttpStatus.OK);
	}	
	
	//등록
	@RequestMapping(value = "", method = RequestMethod.POST)
	public ResponseEntity<String> addArticle (@RequestBody ArticleVO articleVO) {
		ResponseEntity<String>  resEntity = null;
		try {
			logger.info("addArticle �޼��� ȣ��");
			logger.info(articleVO.toString());
			resEntity =new ResponseEntity("ADD_SUCCEEDED",HttpStatus.OK);
		}catch(Exception e) {
			resEntity = new ResponseEntity(e.getMessage(),HttpStatus.BAD_REQUEST);
		}
		
		return resEntity;
	}	
	
	//수정
	@RequestMapping(value = "/{articleNO}", method = RequestMethod.PUT)
	public ResponseEntity<String> modArticle (@PathVariable("articleNO") Integer articleNO, @RequestBody ArticleVO articleVO) {
		ResponseEntity<String>  resEntity = null;
		try {
			logger.info("modArticle �޼��� ȣ��");
			logger.info(articleVO.toString());
			resEntity =new ResponseEntity("MOD_SUCCEEDED",HttpStatus.OK);
		}catch(Exception e) {
			resEntity = new ResponseEntity(e.getMessage(),HttpStatus.BAD_REQUEST);
		}
		
		return resEntity;
	}
	
	//삭제
	@RequestMapping(value = "/{articleNO}", method = RequestMethod.DELETE)
	public ResponseEntity<String> removeArticle (@PathVariable("articleNO") Integer articleNO) {
		ResponseEntity<String>  resEntity = null;
		try {
			logger.info("removeArticle �޼��� ȣ��");
			logger.info(articleNO.toString());
			resEntity =new ResponseEntity("REMOVE_SUCCEEDED",HttpStatus.OK);
		}catch(Exception e) {
			resEntity = new ResponseEntity(e.getMessage(),HttpStatus.BAD_REQUEST);
		}
		
		return resEntity;
	}	

}

```





