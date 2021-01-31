

| 저장시 Encoding | PageEncoding  | CharsetEncoding | 브라우저 결과 | 브자우저 응답헤더   |
| --------------- | ------------- | --------------- | ------------- | ------------------- |
| EUC-KR          | EUC-KR        | EUC-KR          | Good          | Charset과 동일      |
|                 | EUC-KR        | UTF-8           | Good          | Charset과 동일      |
|                 | EUC-KR        | ISO-8859-1      | Good          | Charset과 동일      |
|                 | EUC-KR        | 정의되지 않음   | Good          | PageEncoding과 동일 |
|                 | UTF-8         | EUC-KR          | Bad           | Charset과 동일      |
|                 | UTF-8         | UTF-8           | Bad           | Charset과 동일      |
|                 | UTF-8         | ISO-8859-1      | Bad           | Charset과 동일      |
|                 | UTF-8         | 정의되지 않음   | Bad           | PageEncoding과 동일 |
|                 | 정의되지 않음 | EUC-KR          | Good          | EUC-KR              |
|                 | 정의되지 않음 | UTF-8           | Bad           | UTF-8               |
|                 | 정의되지 않음 | 정의되지 않음   | Bad           | ISO-88859-1         |

# charset 인코딩 우선순위

## 1. Charset 지정시

지정된 charset으로 인코딩하여 응답

## 2. Chartset없을 때

pageEncoding 값으로 대체

## 3. 둘다 없을 때

톰캣 기본인코딩인 ISO-88590-1로 인코딩하여 응답

