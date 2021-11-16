# Spring 환경설정 방법!

### 기본적으로 모든 의존성 주입 코드들은 Maven에서 다룰 예정. >> https://mvnrepository.com/
### 또한 호환성을 위하여 STS는 3버전을, SpringFrameWork는 5.0.7.RELEASE를 사용할 예정 
### STS3 다운로드 >> https://github.com/spring-projects/toolsuite-distribution/wiki/Spring-Tool-Suite-3
### lombok 다운로드 >> https://projectlombok.org/all-versions

***

_1. STS 설치 및 lombok 실행_

STS 와 lombok은 설치 가이드에 따라 순차적으로 진행.

이후 lombok은 jar 파일로 설치가 되면, 이를 실행해서 sts를 경로로 잡아주면 연동 완료

<img width="836" alt="스크린샷 2021-11-12 오후 3 22 51" src="https://user-images.githubusercontent.com/78843098/141420187-12077afc-d1ff-47b0-ad37-aab300a1e680.png">


***

_2. STS server 연결 (현재 tomcat9.0사용중)_

>> 하단의 server 탭에서 링크클릭

<img width="550" alt="스크린샷 2021-11-12 오후 3 26 09" src="https://user-images.githubusercontent.com/78843098/141420528-d53ec456-6fba-4e4f-9dc8-aad125147305.png">


>> 최상단의 Apache 에서 tomcat9.0찾기

<img width="695" alt="스크린샷 2021-11-12 오후 3 27 04" src="https://user-images.githubusercontent.com/78843098/141420613-5a293339-1c8e-4e5e-8cf8-0c03eb462db8.png">

<img width="635" alt="스크린샷 2021-11-12 오후 3 28 59" src="https://user-images.githubusercontent.com/78843098/141420799-87f68167-06b5-4639-b92b-19fe85000f8e.png">

>> 본인 pc에 tomcat이 설치된 경로를 찾아서 넣어주기

<img width="642" alt="스크린샷 2021-11-12 오후 3 30 05" src="https://user-images.githubusercontent.com/78843098/141421005-aac6a902-0f6a-4459-bf4e-d8f1dac13236.png">


***

_3. Hello World 찍기_

>> 서버 연결이 끝났으면 프로젝트를 생성한다

<img width="1440" alt="스크린샷 2021-11-12 오후 3 34 39" src="https://user-images.githubusercontent.com/78843098/141421570-a3dc978a-8f5c-4b14-81dc-0f5669c810d7.png">

<img width="1440" alt="스크린샷 2021-11-12 오후 3 37 33" src="https://user-images.githubusercontent.com/78843098/141421934-3ff8cbe0-d031-4983-b608-2ea15a4e693b.png">

>> 바로 프로젝트 실행 가능! HelloWorld 프로젝트 우클릭 > Run as Run on server 클릭.

<img width="1440" alt="스크린샷 2021-11-12 오후 3 40 48" src="https://user-images.githubusercontent.com/78843098/141422156-58b6988a-fccd-4053-86fe-6be6b87fc896.png">

>> 실행 완료

<img width="1440" alt="스크린샷 2021-11-12 오후 3 42 14" src="https://user-images.githubusercontent.com/78843098/141422200-61ab43b1-639c-4366-a62c-5093ab074b91.png">

***

_4. 프로젝트 환경설정 추가 > JRE를 현재 환경으로 바꿔주고, MySQL Driver 설치해주기_

>>> 먼저, 프로젝트 properties에서 컴파일러를 JRE11로 바꿔준다.

<img width="1440" alt="스크린샷 2021-11-12 오후 4 08 32" src="https://user-images.githubusercontent.com/78843098/141425422-37acb98a-ce73-4525-91db-fdbc193330a7.png">

>>> 이후, Java Build Path > Labraries > ClassPath 에서 Add External JARs 선택

<img width="1440" alt="스크린샷 2021-11-12 오후 4 11 37" src="https://user-images.githubusercontent.com/78843098/141425667-f8fb4418-4189-454d-8f4d-43e30fbe8f98.png">

>>> 본인이 설치해둔 MySQL Driver(Connecter)jar파일 경로를 잡아준다.


***

_5. JDBC 테스트 진행하기_

>> 첫번째로 porm.xml에서 libarary version settiong을 해준다.

<img width="1440" alt="스크린샷 2021-11-12 오후 3 47 19" src="https://user-images.githubusercontent.com/78843098/141422901-b1e0a7f7-4828-47dc-88ff-d823c6f1640b.png">

### 이 작업은 향후 협업 과정에서 각 개발자들 사이의 버전 통일을 위한 것이다.

>>> JDBC 연결 확인을 위한 class를 생성한다. 이때 사용하는 서버는 MySQL이다.

<img width="1440" alt="스크린샷 2021-11-12 오후 3 50 12" src="https://user-images.githubusercontent.com/78843098/141423148-9eaa456d-adb2-49ec-82bc-a1a9a2508051.png">

<img width="1440" alt="스크린샷 2021-11-12 오후 3 51 34" src="https://user-images.githubusercontent.com/78843098/141423269-f5c33dd3-8e81-4883-9b51-c1e2fc4c588a.png">

>>> JDBCTests class 작성

<img width="1440" alt="스크린샷 2021-11-12 오후 4 01 24" src="https://user-images.githubusercontent.com/78843098/141424463-3847840a-01f2-486d-909b-54d23a3c23e6.png">

위의 코드 작성 후 Log4j 와 Test에서 에러가 난다면, lombok 관련 문제이다. 따라서 porm.xml에서 설정을 해주어야 한다.

<img width="1440" alt="스크린샷 2021-11-12 오후 3 56 38" src="https://user-images.githubusercontent.com/78843098/141424151-e7b92512-774b-4e45-bb62-41050061a045.png">

<img width="1440" alt="스크린샷 2021-11-12 오후 3 57 09" src="https://user-images.githubusercontent.com/78843098/141424162-b7fc9bac-c157-4065-bf3f-a661fdb2ca5c.png">

>>> 에러 잡기 성공!

<img width="1440" alt="스크린샷 2021-11-12 오후 4 45 32" src="https://user-images.githubusercontent.com/78843098/141429645-43e6c727-ced8-45c5-8714-1a797a843dcf.png">

>>> 연결 성공

<img width="888" alt="스크린샷 2021-11-12 오후 4 18 01" src="https://user-images.githubusercontent.com/78843098/141426207-f2ed9b0b-000c-40ee-8d55-2230302d809d.png">


***

_6. DBCP 연동하기 ! With HikariCP_

>>> 만들어둔 패키지(org.zerock.persistence)에 DataSourceTests.java 클래스를 만들어준다.

<img width="1440" alt="스크린샷 2021-11-12 오후 4 20 26" src="https://user-images.githubusercontent.com/78843098/141426596-6645aadc-40d1-4140-9edb-dde08d170b5c.png">

>>> 클래스 작성 전! 먼저 main > webapp > WEB-INF > spring > root-context.xml 에서 xml name space인 context와 HikariCP설정을 해준다!!

<img width="1440" alt="스크린샷 2021-11-12 오후 4 27 45" src="https://user-images.githubusercontent.com/78843098/141427372-82e24f09-a860-4d2b-aa73-05372eb6d4eb.png">

<img width="1440" alt="스크린샷 2021-11-12 오후 4 25 29" src="https://user-images.githubusercontent.com/78843098/141427379-976f0968-43b3-4f23-a709-60c033846d9b.png">

>>> 추가로 porm.xml에서 의존성 주입을 해준다. > Maven사이트에서 각각 spring-test / HikariCP / lombok검색 후, 버전을 위에서 설정한 버전들로 동일하게 바꿔준다.

<img width="1440" alt="스크린샷 2021-11-12 오후 4 29 20" src="https://user-images.githubusercontent.com/78843098/141427678-8ff10b4c-4bf1-4e11-90b3-1ec913f79c6d.png">

>>> DataSourceTests.java작성

<img width="1440" alt="스크린샷 2021-11-12 오후 4 32 05" src="https://user-images.githubusercontent.com/78843098/141427837-5b3c0b23-027f-414a-94fa-45103d300cb2.png">

>>> 실행 후 연결 완료

<img width="1440" alt="스크린샷 2021-11-12 오후 4 41 34" src="https://user-images.githubusercontent.com/78843098/141429081-2e480da2-52ba-4a3d-9028-5f9aa3cf0db1.png">

***

_7. MyBatis 설정_

>>> Maven에서 dependency 가져오기

<img width="1440" alt="스크린샷 2021-11-15 오전 9 38 46" src="https://user-images.githubusercontent.com/78843098/141706230-2fb0a37d-64b6-4970-a881-64e01ec546c3.png">


<img width="1440" alt="스크린샷 2021-11-15 오전 9 39 24" src="https://user-images.githubusercontent.com/78843098/141706246-acff9f81-07fc-4fe0-8ec2-f077919d8e32.png">

<img width="1440" alt="스크린샷 2021-11-15 오전 9 41 09" src="https://user-images.githubusercontent.com/78843098/141706255-a3acbda2-24c8-4218-b2a1-32a3cf91930b.png">

>>> root-context.xml에 bean입력해주기

<img width="1440" alt="스크린샷 2021-11-15 오전 9 45 17" src="https://user-images.githubusercontent.com/78843098/141706278-6ae958ef-bc9a-4dd5-82d4-319097155cb6.png">


