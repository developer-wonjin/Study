 PHP 7.4.x

 web으로 확인하실 때는 **nginx + php-fpm**으로 연동하시면 됩니다.

 공부하시면서 작성한 코드는 **github를 이용하여 코드 관리**해주시기 바랍니다.

 함수 공부하실 때는 **예제를 만들어서 꼭 확인**해보시기 바랍니다.

 궁금하신 내용은 [@박성민](mailto:sungmin@bizspring.co.kr) 주임님께 물어보시면 됩니다.



1. APM, NPM 설치
   Apache - PHP - MySQL
   Nginx - PHP - MySQL

   CentOS: Source 설치
   Ubuntu: apt

2. 설절 파일
    Apache
    PHP
    MySQL
    Nginx

    Virtual Host
    **Access Log, Error Log**
    PHP 확장자 연결
    **session directory**

    my.cnf

3. PHP 함수들
    dirname()
    basename()
    pathinfo()
    parse_url()
    urldecode()
    urlencode()
    explode()
    implode()

    **eregi() --> 체크**
     preg_match() 
     preg_split()
     preg_replace()

strip_tags()
addslashes()
stripslashes()
htmlspecialchars()

ucfirst()
lcfirst()
strtolower()
strtoupper()
strlen()
count()
substr()

date()
mktime()
strtotime()
time()

setcookie()
**header()   체크**
session_start()
session_destroy()

$_GET
$_POST
$_COOKIE
$_SESSION
**$_SERVER['HTTP_X_FORWARDED_FOR']  안나오는데??**
$_SERVER

ini_get()
ini_set()

extract()
**ob_start()           체크**
ob_get_length()
**ob_end_flush()	 체크**
**flush()			 체크**	

mb_substr()
mb_detect_encoding()
iconv

mysqli 함수들 - db 연결

pdo 함수들 - db 연결

**\4. 정규식**
 정규식 기본 -완료

 정규식 패턴 : email, url, id, 주민번호, 정수, 숫자, 알파벳, 대,소문자구분, 전화번호, IP주소 등등

 **정규식 사용언어: php, java, mysql, javascript에서 같은 예제로 구현   - 체크**

 브라우저 에이전트 판별 방식

**5. 조사할 내용들**
 URL, URI
 PATH
 QUERY
 REFERER
 Browser Agent
 Cookie - Session
 1사 쿠키, 3사 쿠키

