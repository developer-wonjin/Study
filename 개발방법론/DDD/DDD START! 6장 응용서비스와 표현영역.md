# 6장 응용서비스와 표현영역

# 1. 표현영역

- 사용자의 요청을 해석
  - URL
  - 요청파라미터(GET, POST 방식)
  - 쿠키
  - 헤더
- 알맞은 컨트롤러로 요청 분기
  - 알맞은 기능을 실행할 수 있도록 `응용서비스` 실행
- (프레임워크의 기능) 파라미터 바인딩
  - 요청파라미터를 DTO의 필드에 자동 바인딩
  - 응용서비스가 요구하는 DTO를 준비
- 응용역역을 의존함 [그림2.4]

## 1.1. 표현영역의 값리턴

강의 `실전 스프링부트와 JPA활용2 - API개발과 성능최적화`

- 엔티티를 그대로 리턴하면 안됨.
- 엔티티의 필드명 변경시 API스펙이 변경된다.
- 클라이언트에서 잘 사용하고 있다가 에러를 마주한다.
  - 따라서, 이미 한번 공개된 API는 스펙을 변경할 수 없게 해야한다.

## 1.2. 표현영역만 다뤄야하는 자원 : 세션, 쿠키

- 아래 코드와 같이 서블릿 자원을 `응용영역`에 전달하게 되면 문제가 발생한다.

```java
public class XXXService{
    public void XXXmethod(HttpServletRequest request){
        HttpSession session = request.getSession();
        session.setAttribute("auth", new Authentication(id));
    }
}
```

1. `응용영역 -> 표현영역 `  방향으로 잘못된 방향으로 의존이 생겨버림
   - 서블릿자원을 참조하는 것만으로 의존이 생긴다?
   - Controller가 Service를 멤버필드로 갖는 것과 다른 의미의 의존인가?
2. 응용서비스가 테스트하기 어려워진다. (서블릿 자원까지도 테스트를 위한 준비를 해놔야함)
3. 표현영역 소스코드만으로 표현영역의 상태(세션, 쿠키)값의 변경을 파악하기 어려움
   - 응용영역 소스코드까지 들어가봐야 암

## 1.3. 이벤트

추후 뒷 장에서....



# 2. 응용영역

- 사용자에게 제공할 실제기능
- Command, Query 기능으로 크게 두개로 나눌 수 있음
  - CQRS는 인프라, API, 메소드 레벨을 달리하여 바라볼 수 있다
- 표현영역의 구현기술에 의존적이지 않다.
  - 표현영역 구현기술에 관심없다
  - 표현영역에 MVC웹요청(Thymeleaf)인지, 모바일의RestAPI요청인지 관심없다.

## 2.1 역할

```java
public MemberService{
	public Long register(MemberDTO m){
        Member member = memberRepository.dtoToEntity(m); 
        memberRepository.save(member); //1. 레포지토리를 통한 도메인객체 조회, 저장
        
        //... 2. 얻은 도메인객체를 사용
        // 3. 도메인 객체간의 흐름제어
        
        return member.getId();
    }
    
    //4. 다중 DML 건들에 대한 트랜잭션 처리
    @Transactional
    public void makeBlackConsumer(Long[] ids){
        for(Long id : ids){
			Member member = memberRepository.findById(id);
             member.makeBlackConsumber();
        }
    }
}
```

- 위의 3번 역할로 서비스는 소스코드가 간결하다 



## 2.2. 응용서비스는 되도록 잘게 나누자

- 연관성 없는 코드를 함께 보는 것은 괴롭다

- 응용서비스를 잘 나눠놨는데, 갑자기 연관성을 발견했다면?

  - Helper클래스를 도입

    ```java
    public final class MemberServiceHelper{
        public static Member findExistingMember(MemberRepository repo, Long memberId){
            //...
        }
    }
    
    import static com.myshop.member.application.MemberServiceHelper.*;
    public class ChangePasswordService{
        private MemberRepository repo;
        
        public void changePassword(Long memberId, Stirng curPw, String newPw){
            Member member = findExistingMember(repo, memberId);
            //...
        }
    }
    ```



## 2.3. 응용서비스의 인터페이스

- [개발순서]
  - 표현영역 -> 응용영역 
    - 아직 개발되지 않은 응용서비스에 대해 인터페이스(메소드 시그니처) 스펙만 정의한다.
    - 표형영역을 테스트하기 위해  위 인터페이스 스펙에 맞춰`input, output`이 정해진 Mock객체를 생성하여 미래에 실제 구현될 클래스를 대체한다.
    - 근데 인터페이스 없어도 Mock객체는 만들 수 있어서 굳이 인터페이스 필요하겠냐
  - 응용영역 -> 표현영역
    - 책표현이 쫌 이상하네;;



## 3. 유효성검사 (입력값, 비즈니스로직)

스프링 MVC 2편 - 백엔드 웹 개발 활용 기술 (유효성 파트만 5시간)

- `표현영역`에서 담당할 검사 : 입력값 (Hibernate validation 어노테이션으로 간단히 해결)
  - 필수여부
  - 값의형식 : 숫자, 이메일
  - 범위 : min, max
- `응용영역`에서 담당할 검사 
  - 비즈니스로직을 수행중에 발생하는 논리적 오류검사



## 4. 접근제어 Access Control

- 표현영역 

  - Filter 에서 인증객체 존재여부 확인
  - Controller 에서 인가 처리 `ADMIN / DEV / MANAGER / USER`

- 응용서비스

  - `MANAGER` 권한을 지녔어도 프로젝트에 소속된 직원이 아니면 제한주기
  - 프로젝트 소속 여부를 서비스계층에서 DB조회를 통해 알아야함

- 도메인 단위 권한검사

  - 책의 예제가 과연 `개별 도메인 단위`라고 할 수 있을까?

    ```java
    public class DeleteArticleService{
        public void delete(String userId, Long articleId){
            Article article = articleRepository.findById(articleId);
            checkArticleExistence(article);
            permissionSerice.checkDeletePermission(userId, artilce);
            article.markDeleted();
        }
    }
    ```

## 5. 조회전용 기능

- 응용서비스 필요없음.
- Repository는 애그리거트를 위한 용도로만 사용해야 함
- 따라서, `애그리거트간 조인`, `통계쿼리`로 조회를 할 경우 `Spring-Data-Jpa`가 아닌 `EntityManager`를 직접 사용한다.
- p.162
