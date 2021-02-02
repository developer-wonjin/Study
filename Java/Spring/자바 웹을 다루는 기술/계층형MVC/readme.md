# 계층형 sql (sqldeveloper)
SELECT LEVEL,
    articleNO,
    parentNO ,
    LPAD(' ', 4*(LEVEL-1)) || title title,
    content,
    writeDate,
    id
    FROM t_board
    START WITH parentNO = 0 //부모글 번호를 기준으로 계층형구조를 만든다는 의미임
    CONNECT BY PRIOR articleNO=parentNO //
    ORDER SIBLINGS BY articleNO DESC; // 게시글 번호를 기준으로 내림차순

# 계층형 게시판 p.708
DAO.java
~~~
String query = "SELECT LEVEL,articleNO,parentNO,title,content,id,writeDate" 
			             + " from t_board"
					     + " START WITH  parentNO=0"              // 계층을 어떤 컬럼을 기준으로 할 것인가
               + " CONNECT BY PRIOR articleNO=parentNO" // 계층의 연결방식은 어떻게 할 것인가.
					     + " ORDER SIBLINGS BY articleNO DESC";   //계층내에서 정렬하라
			System.out.println(query);
			pstmt = conn.prepareStatement(query);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				int level = rs.getInt("level");
				int articleNO = rs.getInt("articleNO");
				int parentNO = rs.getInt("parentNO");
~~~

# ResultSet의 column 인덱스는 1부터 시작이다.

# 이미지 파일 미리보기 
~~~
<script type="text/javascript">
   function readURL(input) {
      if (input.files && input.files[0]) {
	      var reader = new FileReader();
	      reader.onload = function (e) {
	        $('#preview').attr('src', e.target.result);
          }
         reader.readAsDataURL(input.files[0]);
      }
  }
  
.....

  <tr>
        <td align="right">이미지파일 첨부:  </td>
	     <td> <input type="file" name="imageFileName"  onchange="readURL(this);" /></td>
         <td><img  id="preview" src="#"   width=200 height=200/></td>
	 </tr>
~~~
