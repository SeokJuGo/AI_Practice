# HTML

<aside>
💡 HTML(Hyper-Text Markup Language)

- 하이퍼-텍스트로 이루어진 소스코드
- `<, >`로 이루어진 텍스트를 마크업 언어라고 합니다.
  - 언어라고 볼지 의견이 분분합니다.
  - 정확하게 표현하자면, 문서의 구조를 표현
  - `자바스크립트`가 HTML의 부족한 부분을 대신하고 있다.
    
    </aside>

## HTML의 구조

- **TAG**
  
  - `<, >`를 이용해서 표현
  - 내용(contents)에 대한 타입을 나타내는 용도
  - 태그는 열리고(open) 닫히는(close) 태그 구조를 가지고 있으며 이는 한 쌍입니다.
  - 이 구조는 태그의 범위를 만들어 줍니다.
  
  ```html
    <opening tag> 내용 </closing tag>
    <tagName /> self closing
  
      <h1>HTML(Hyper-Text Markup Language) </h1>
      <p>- `<, >`로 이루어진 텍스트를 마크업 언어라고 합니다.
      - 언어라고 볼지 의견이 분분합니다...</p>
  
      <제목 시작>HTML(Hyper-Text Markup Language) </제목 끝>
      <문단 시작>- `<, >`로 이루어진 텍스트를 마크업 언어라고 합니다.
      - 제어, 분기문이 없어 언어라고 볼지 의견이 분분합니다...</문단 끝>
  ```

- HTML 문서 작성 규칙
  
  ```html
  <!DOCTYPE html> 
  <html>
  <title>공백 처리 예제</title>
  <body>
    공             백
    줄바꿈
    줄바꿈
  </body>
  </html>
  ```
  
  - content 내의 연속된 공백 또는 줄 바꿈은 하나의 공백으로 처리
  
  - 여러 개의 공백이나 탭, 줄 바꿈 등은 다른 특수문자를 사용하여 표현
  
  - 태그 이름은 대소문자를 구분하지 않으나 보통 소문자로 작성
  
  - 각 태그는 시작 태그와 종료 태그 쌍이 서로 교차되면 안됨
  
  - **미리 정의된 서식 태그**
    
    ```html
    <pre>
    내가 쓰는      그대로     화면에 나옵니다
    무시
    
                     무시
    
    </pre>
    ```
    
    - `<pre>` 태그는 preformatted text로 입력한 텍스트 그대로 화면에 표시할 때 사용하는 태그
    - 안 좋은 이유 : css 적용이 어렵다

- **부모와 자식 요소**
  
  태그A가 태그B의 콘텐츠로 사용되면, 태그B는 태그A의 부모 요소, 태그A는 태그B의 자식 요소라고 합니다.
  
  ```
  <PARENT>
    <CHILD></CHILD>
  </PARENT>
  ```
  
  ```
  <section class="fruits">
    <h1>과일 목록</h1>
    <ul>
      <li>사과</li>
      <li>딸기</li>
      <li>바나나</li>
      <li>오렌지</li>
    </ul>
  </section>
  
  <!-- 다음과 같이 이해할 수 있습니다. -->
  <섹션영역 태그별명="fruits">
    <주제1>과일 목록</주제1>
    <순서없는목록>
      <항목>사과</항목>
      <항목>딸기</항목>
      <항목>바나나</항목>
      <항목>오렌지</항목>
    </순서없는목록>
  </섹션영역>
  ```
  
  **`<section></section>`** 안에는(콘텐츠) **`<h1></h1>`**, **`<ul></ul>`**, **`<li></li>`**가 있고 **`<ul></ul>`** 안에는(콘텐츠) **`<li></li>`**가 있습니다.(이하 닫히는 태그는 생략할게요)
  
  이러한 구조에서 **`<section>`**는 **`<h1>`**과 **`<ul>`**의 부모 요소입니다.
  
  또한 **`<ul>`**은 **`<li>`**의 부모 요소입니다.
  
  반대로 **`<h1>`**과 **`<ul>`**은 **`<section>`**의 자식 요소입니다.
  
  또한 **`<li>`**는 **`<ul>`**의 자식 요소입니다.
  
  여기서 **`<ul>`**은 **`<section>`**의 자식 요소이면서 **`<li>`**의 부모 요소입니다.
  
  이처럼 부모와 자식 요소는 상대적인 개념입니다.(조금 더 나아가면 **`<section>`**은 **`<li>`**의 조상(상위) 요소, 반대로 **`<li>`**는 **`<section>`**의 후손(하위) 요소라고 합니다)
  
  우리가 기본적인 가계도를 통해 할아버지, 엄마, 삼촌, 형제 같은 호칭을 정의하듯(혹은 반대로 호칭을 통해 가계도를 이해하듯), HTML의 구조도 위와 같은 개념으로 호칭을 정의하여 추후 선택자(Selector)를 통해 CSS와 JS로 HTML을 다룰 때 중요하게 사용됩니다.

- 기본적으로 태그들은 계층적인 구조를 같이 표현
  
  - 최상위 태그는 항상 `HTML`이 됩니다.
  - `head`와 `body`는 `HTML`의 하위 태그가 됩니다.
  - 일반적으로 계층 표현을 `들여쓰기`를 이용해서 표현
  
  ```html
  <!DOCTYPE html><!-- HTML5 표준을 따르는 문서라는 표시 -->
  <html lang="en"><!-- HTML 문서의 시작 -->
  <!-- HTML 문서가 어떤 언어로 작성되었는지 명시, 이 속성 값에 따라 번역여부 결정. -->
  <head><!-- 화면에 보이지 않는 내용들 
          HTML 문서의 정보에 대한 내용들이 주로 들어가게 됩니다. Header -->
      <meta charset="UTF-8"/>     <!--문서의 문자 인코딩 방식 -->
      <!--문서의 저자, 작성자 -->
    <meta name="author" content="Yoo"/>
      <!--문서의 설명, 개요 -->
      <meta name="dsecription" content="HTML tutorial"/>
      <!--웹 애플리케이션 이름 -->
      <meta name="application-name" content="Application name"/>
      <!--웹 페이지의 뷰포트(화면에 보여지는) 영역 -->
    <meta name="viewport" content=""/>
      <!--검색 엔진에 적용되는 키워드 목록 -->
    <meta name="keywords" content=""/>
      <!--문서에 사용되는 소프트웨어 패키지 -->
    <meta name="generator" content=""/>
      <!-- 지정된 HTTP 헤더 제공 -->
      <meta http-equiv="refresh" content="3"/>
  </head>
  <body>
   <!-- 
          화면(웹 브라우저)에 보여지는 모든 내용들
      -->
  </body>
  </html>
  ```

## 자주 사용되는 태그들

### 기본태그

- 문서의 구조를 표현
  - 워드나 한글을 이용해서 작성할 수 있는 내용들
  - 제목, 본문, 표, 그림, 목차, ...
  - 웹이 발전하면서, 원래 용도 보다는 현재는 응용된 형태로 더 많이 사용

---

### Heading

- 제목을 표현하는 태그
- 6단계로 구분
  - `<h1> ~ <h6>`
- 사용법

```
        <h1> 가장 큰 제목 </h1>
        <h3> 중간 제목 </h3>
        <h5> 소제목 </h5>
```

---

### Paragraph

- 문단, 본문, 단락, ... 표현 하는 용도
- 일반적으로는 문자를 표현할 때 주로 사용
- 사용법

```
  <p> 일반적으로 텍스트를 표현하는 용도로 사용이 됩니다 </p>
```

- Line Break
  - html은 엔터도 태그로 표현
  - `<br>` 태그 입니다. 내용이 없기 때문에 따로 태그를 닫지 않아도 됩니다.
- 사용법

```
        <p>
            일반적으로 텍스트를 표현하는 용도로 사용이 됩니다 <br>
            태그안에 들어있는 텍스트도 CRLF를 사용할 수 없습니다. <br>
        </p>
        텍스트를 반드시 p 태그에 넣을 필요는 없습니다. <br>
        문제는 HTML은 줄바꿈(엔터) 문자로 CRLF를 사용하지 않습니다. <br>
        어? 왜 줄바꿈이 안되지? <br>
```

- Non-breaking Space
  - `&nbsp;, &ensp;, &emsp;`
  - 공백 대신에 사용하는 공백문자
- 사용법

```
  <p> 공백 문자도      HTML은 해석하지 않습니다.</p>
```

---

### 리스트

- 목차, 목록 등을 표현할 때 사용할 수 있는 태그
- 현재는 응용해서 다른 형태로 더 많이 사용

<aside>
💡 정렬된 리스트: Ordered List `<ol>`

</aside>

<aside>
💡 비정렬 리스트: Unordered List `<ul>`

</aside>

<aside>
💡 정의, 설명을 위한 리스트: Description List  `<dl>`

</aside>

- 사용법

```
        <ol> 순서있는 리스트
            <li> 첫번째</li>
            <li> 두번째</li>
            <li> 세번째</li>
        </ol>

        <ul> 순서없는 리스트
            <li> 첫번째</li>
            <li> 두번째</li>
            <li> 세번째</li>
        </ul>
```

- ol과 ul의 차이점은 리스트 아이템을 나열할 때 아이템의 순서를 아라비아 숫자로 표현하는 것과 안하는 것의 차이입니다

### 테이블

- 일반적인 문서에서 `표`에 해당하는 내용

- 테이블을 이용해서 웹 페이지 레이아웃을 표현 하기도 합니다.
  
  - html5 표준 부터는 데이터 문제로 div를 더 적극적으로 많이 사용합니다.
  
  ![image](https://user-images.githubusercontent.com/116260619/212608094-53a2f072-7311-43f5-a1f9-b4e1d5bec420.png)

- 테이블의 기본 구조

```
<table>   <!-- 테이블의 시작 -->
  <thead> <!-- 제목 라인 -->
    <tr>  <!-- 행을 표현 -->
      <th></th>  <!-- 컬럼 -->
    </tr>
  </thead>

  <tbody> <!-- 표에 들어갈 내용 -->
    <tr>  <!-- 행을 표현 -->
      <td> </td> <!-- 컬럼 -->
    </tr>
  </tbody>
</table>  <!-- 테이블의 끝 -->
```

---

### 이미지

- `<img>`는 내용이 없는 태그중에 하나 입니다.
- 일반적인 사용법

```
  <img src='url/path' />
```

- `height`, `width` 속성 사용법

```
  <img src='url/path' width='px', height='px' />
```

[Freepik | Graphic Resources for everyone](https://www.freepik.com/)

[Beautiful Free Images & Pictures | Unsplash](https://unsplash.com/)

[AutoDraw](https://www.autodraw.com/)

---

---

### anchor

- 하이퍼-링크
  - 지금의 웹이 만들어지는데 가장 중요한 기능
  - 봇(bot) - 자동화된 프로그램
    - 웹 페이지도 봇에 의해서 자동으로 수집
    - 시드(seed)페이지를 통해서 하이퍼-링크를 통해서 연결되어 있는 다른 웹 페이지를 찾는 방식
    - 전세계에 흩어져 있는 웹 페이지를 전부 수집
    - 이렇게 수집된 페이지에서 사용자가 원하는 페이지를 가장 빠르게 검색해서 제공하는 해주던 사이트가 바로 구글입니다.
- 사용법

```
  <a> 연결된 페이지의 이름 </a>
```

- 속성
  
  - href: 연결된 페이지의 주소(URL/URI)
  - target: 연결된 페이지로 이동하는 방식
    - _self(default): 현재 창에서 해당 페이지로 바로 이동
    - _blank: 새창에서 해당 페이지로 이동
    - _parent: 현재 창보다 상위 창에서 해당 페이지로 이동
    - _top: 최상위 창에서 해당 페이지로 이동

- 몇가지 비슷한 기능을 하는 태그들
  
  - <i> vs <em>
    
    i - 비주얼적으로만 이탤릭
    
    em - 시맨틱 태그에서 더 강조하고 싶은 내용에 사용
  
  - <b> vs <strong>
    
    b - 비주얼적으로만 이탤릭
    
    strong - 시맨틱 태그에서 더 강조하고 싶은 내용에 사용

- **속성(Attribute)과 값(Value)**
  
  태그(요소)의 기능을 확장하기 위해 ‘속성’을 사용할 수 있습니다.
  
  ```html
  <TAG 속성="값"></TAG>
  ```
  
  - HTML 요소는 여러 속성을 가짐
    - 태그 이름: `p`
    - 속성명: `class`
    - 속성값: `value`
    - 내용: `단락`
  
  ## 속성(Attributes)
  
  ```html
  <a href="링크주소">링크</a>
  ```
  
  - 요소에 추가적인 정보 및 설정 적용
  - 속성 이름은 대소문자를 구분하지 않지만, 소문자를 권장
  - 시작 태그에 `속성이름 = "값"` 형태로 사용됨
  - `<a>` 태그에 `href` 속성으로 `링크주소`의 값을 설정
  
  ```html
  <a href="<http://google.com>"> Hello!! </a>
  <div class="name">HTML</div>
  
  <앵커링 경로="<http://google.com>" 대체텍스트="구글로 이동하기" />
  <의미없는분할 태그별명="name">HTML</의미없는분할>
  ```
  
  **`<a />`**는 경로를 삽입할 때 사용하는 태그입니다. 하지만 태그만 사용하면 경로를 삽입하는지 알 수 없기 때문에 href(href)라는 속성을 사용해서 삽입할 이미지의 경로를 지정합니다.
  
  **`<div></div>`**는 의미를 가지지 않는 태그로 범위를 묶어낼(Wrap) 수 있습니다.위에선 **`'HTML'`**이라는 텍스트를 묶었으나 그 내용이 무엇을 의미하는지 알 수 없기 때문에 **`name`**이라는 태그 별명(**`class`**)을 추가했습니다.
  
  1. 일반속성
     ◦ 태그별로 사용할 수 있는 속성들이 정해져 있습니다.
     ◦ 지원하는 속성을 이용해서 태그에 대한 세부적인 설정이 가능
     ◦ 태그별 속성을 전부 외우는 것은 불가능하니 그때 그때 찾아보세요.
  
  [HTML Attributes](https://www.w3schools.com/tags/ref_attributes.asp)
  
  2. 글로벌 속성
     ◦ 모든 태그에서 공통적으로 사용할 수 있는 속성
     ◦ class, id, ...
     ◦ 이벤트 속성
     ◦ 스타일 속성
  
  3. HTML Character Entity(HTML 문자 단위(엔티티))

### 입력 태그들

- 사용자로부터 웹 페이지를 입력을 받아서 서버에 전달하기 위한 용도

---

### form

- POST 방식으로 서버에 데이터를 전달
  - 가장 많이 사용되는 경우가 로그인 처리와 같은 경우가 있습니다.
- form 태그의 일반적인 형태는 다음과 같습니다.

```
<form action='url/app/id' method='post'>
  <!-- 여러가지 입력 태그들이 올 수 있습니다 -->
</form>
```

- form의 주요 속성
  - action: 입력 데이터를 처리할 서버(백엔드/웹어플리케이션)의 URL
  - method: 데이터를 전달하는 방법(GET/POST)
    - GET 방식: URL/URI를 통해서 전달
      - 보내려는 데이터가 매우 쉽게 외부에 노출되기 때문에 보안에 취약하다고 얘기합니다.
      - 별로 중요하지 않은 데이터를 전송하는 경우
    - POST 방식: 데이터를 별도의 방식으로 전달
      - 보내려는 데이터가 외부에 쉽게 노출되지 않음
      - 암호화된 통신(https)을 사용하면 보내려는 데이터가 암호화 되기 때문에, 더욱더 확인하기가 어렵다

---

---

### input

- 입력받고자 하는 형태를 정의
  - text, radio, button, checkbox, email, password, url, tel, file, date, month, week, time, color, number, range, submit, ...
- 실습용 코드

```
        <input type='text' />
        <select>
            <option value='첫번째'>1</option>
            <option value='두번째'>2</option>
            <option value='세번째'>3</option>
        </select>
        <input type='hidden' />

        <input type='button' value='버튼'/>
        <input type='submit' value='제출'/>
```

- 속성
  
  - name
    - 각, 입력요소를 구분하는 중요한 속성
    - 데이터를 서버에 전달할 때, 변수의 이름으로 사용
    - 반드시, 정의해주는 게 좋습니다.
  
  ### `<input>` 태그
  
  ```html
  <label for="name">이름:</label>
  <input type="text" id="name" name="name" value="Suan" size="20">
  ```
  
  ### `<select>` 태그
  
  ```html
  <select id="food" name="food">
    <option value="pizza" selected>피자</option>
    <option value="hamburger">햄버거</option>
    <option value="pasta">파스타</option>
  </select>
  ```
  
  ### `<select>` 태그 (다중 선택)
  
  ```html
  <select id="food" name="food" multiple>
    <option value="pizza" selected>피자</option>
    <option value="hamburger">햄버거</option>
    <option value="pasta">파스타</option>
  </select>
  ```
  
  ### `<select>` 태그 (그룹)
  
  ```html
  <select id="food" name="food" multiple>
    <optgroup label="음식">
      <option value="pizza" selected>피자</option>
      <option value="hamburger">햄버거</option>
      <option value="pasta">파스타</option>
    </optgroup>
    <optgroup label="후식">
      <option value="cola">콜라</option>
      <option value="coffee"">커피</option>
      <option value="icecream">아이스크림</option>
    </optgroup>
  </select>
  ```
  
  ### `<textarea>` 태그
  
  ```html
  <textarea name="article" rows="20" cols="30">
  텍스트 
  </textarea>
  ```
  
  ## 입력 형식]
  
  - `<input>` 태그를 `<form>` ~ `</form>` 내부에서 사용되며, `type` 속성에 데이터 입력 양식 지정
  - 주요 공통 속성
    - `readonly` : 읽기 전용
    - `disabled` : 비활성화
    - `autocomplete` : 자동 완성
    - `autofocus` : 웹 페이지 로드시 초기에 포커싱 설정
    - `placeholder` : 입력 폼에 희미하게 설명을 보여줌
    - `required` : 필수 속성
    - `spellcheck` : 오타 점검
  
  ### **text** 타입
  
  텍스트 입력에 사용
  
  ```html
  <input type="text" name="text" size="20">
  ```
  
  ### **password 타입**
  
  비밀번호 사용
  
  ```html
  <input type="password" name="password" required>
  ```
  
  ### button 타입
  
  버튼 모양에 사용
  
  ```html
  <input type="button" value="Button">
  ```
  
  ### **radio 타입**
  
  여러 개의 항목 중에서 하나를 선택할 때 사용
  
  ```html
  <input type="radio" name="gender" value="male">남자
  <input type="radio" name="gender" value="female">여자
  ```
  
  ### **checkbox 타입**
  
  여러 개의 항목 중에서 여러개를 선택할 때 사용
  
  ```html
  <input type="checkbox" name="food" value="pizza">피자<br>
  <input type="checkbox" name="food" value="hamburger">햄버거<br>
  <input type="checkbox" name="food" value="pasta">파스타<br>
  ```
  
  ### **date 타입**
  
  날짜를 입력할 때 사용
  
  ```html
  <input type="date" name="date" min="2020-01-01" max="2020-12-31">
  ```
  
  ### **month 타입**
  
  월과 년도를 입력할 때 사용
  
  ```html
  <input type="month" id="month" name="month">
  ```
  
  ### **week 타입**
  
  주를 입력할 때 사용
  
  ```html
  <input type="week" id="week" name="week">
  ```
  
  ### **time 타입**
  
  시간을 입력할 때 사용
  
  ```html
  <input type="time" id="time" name="time">
  ```
  
  ### **datetime-local 타입**
  
  날짜/시간을 입력할 때 사용
  
  ```html
  <input type="datetime-local" id="datetime" name="datetime">
  ```
  
  ### **color 타입**
  
  색상을 선택할 때 사용
  
  ```html
  <input type="color" name="color">
  ```
  
  ### **number 타입**
  
  숫자를 입력할 때 사용
  
  ```html
  <input type="number" name="num" min="0" max="1000">
  ```
  
  ### **range 타입**
  
  범위를 지정할 때 사용
  
  ```html
  <input type="range" name="point" min="0" max="100">
  ```
  
  ### **email 타입**
  
  email을 입력할 때 사용, 이메일 형식을 자동 체킹
  
  ```html
  <input type="email" name="email">
  ```
  
  ### **url 타입**
  
  url을 입력할 때 사용, url 형식을 자동 체킹
  
  ```html
  <input type="url" name="myUrl">
  ```
  
  ### **tel 타입**
  
  전화번호 입력에 사용
  
  ```html
  <input type="tel" id="phone" name="phone" pattern="[0-9]{3}-[0-9]{4}-[0-9]{4}">
  ```
  
  ### **file 타입**
  
  파일 선택에 사용
  
  ```html
  <input type="file" id="myfile" name="myfile">
  ```
  
  ### **submit과 reset 타입**
  
  입력 양식의 전송과 초기화에 사용
  
  <input> 태그의 'type' 속성을 'submit'이라고 지정해 주면,
  
  **1. 자동으로 데이터를 전송할 수 있는 버튼이 생성되고,**
  
  **2. 그 버튼을 클릭하면 지정된 URL로 <form>태그 안에 입력된 값들이 'action' 속성으로 지정된 서버 페이지로 전송됩니다.**
  
  ```html
  <form>
    <label for="name">이름:</label><br>
    <input type="text" id="name" name="name" value="Kim"><br>
    <label for="affiliation">소속:</label><br>
    <input type="text" id="affiliation" name="affiliation" value="SIAT"><br><br>
    <input type="submit" value="전송"> <!-- value를 지워보고 바꿔보기 -->
    <input type="reset" value="초기화">
  </form>
  ```
  
  ### 회원가입 폼 예제
  
  label - 클릭의 유효범위
  
  ![image](https://user-images.githubusercontent.com/116260619/212608302-6351ec57-63ea-449a-8e3b-155c042f9a27.png)
  
  ```html
  <form name="signUp" action="signUp.jsp" method="post">
    <fieldset width="500px" height="600px">
      <legend>회원가입</legend>
      아이디 : <input type="text" name="id" placeholder="아이디를 입력 해주십시오." required>
      <button type="button" onclick="alert('사용가능한 아이디 입니다!')">아이디 확인</button><br><br>
      비밀번호 : <input type="password" placeholder="8글자 이상 입력 해주십시오." required><br><br>
      생년월일 : <input type="date" name="birthday"><br><br>
      이메일 : <input type="email" name="email" placeholder="이메일을 기입해주십시오." required><br><br>
      전화번호 : <input type="tel" name="tel" placeholder="연락처를 기입해주십시오." required><br><br>
      사이트를 알게된 경로:<br>
      <input type="checkbox" name="a" value="serch">검색
      <input type="checkbox" name="a" value="friend">친구
      <input type="checkbox" name="a" value="recommend">추천
    </fieldset>
    <button type="submit">회원가입</button>
    <button type="reset">다시 입력</button>
  </form>
  ```

## 오디오 태그

오디오를 삽입할 때 사용하는 태그

```html
<audio src="audio.mp3" controls autoplay></audio>
```

- 속성
  - `src` : 오디오 파일의 경로
  - `controls` : 오디오 파일의 재생 제어기 표시
  - `autoplay` : 자동 재생
  - `loop` : 반복 재생
  - `muted` : 초기에 음소거 상태
  - `preload` : 오디오 파일 미리 다운로드

## 비디오 태그

비디오를 삽입할 때 사용하는 태그

```html
<video src="video.mp4" controls width="500" height="400"></video>
```

- 속성
  - `src` : 비디오 파일의 경로
  - `controls` : 비디오 파일의 재생 제어기 표시
  - `autoplay` : 자동 재생
  - `width` : 비디오의 가로크기
  - `height` : 비디오의 세로크기
  - `loop` : 반복 재생
  - `muted` : 초기에 음소거 상태
  - `preload` : 비디오 파일 미리 다운로드
  - `poster` : 비디오의 썸네일

---

- 가장 많이 쓰이는 html 태그 32개

![image](https://user-images.githubusercontent.com/116260619/212608355-79c513e2-05f3-4803-9c06-9bbba4e15954.png)



## Block / Inline Elements

태그들은 배치되는 형태에 따라서 크게 2가지로 분류

- 어떤 태그를 사용하느냐에 따라서 레이아웃이 결정

### Block 기반의 태그

- `DIV`
  
  - `익명태그`라고 부릅니다.
  - 용도가 정해져 있지 않은 태그로, 활용성이 굉장히 높아서, 많이 사용

- 그 외의 블록기반의 태그들
  
  - p, ol, ul, li, table, h

- 실습 예제
  
  - 주석
    
    <!- -!>
    
    주석(comment)이란 개발자가 작성한 해당 코드에 대한 이해를 돕는 설명이나 디버깅을 위해 작성한 구문을 의미합니다.
    
    이러한 주석은 다른 CSS 코드와는 달리 웹 브라우저에 의해 해석되지 않습니다.

```
<!DOCTYPE html>
<html style='border: 0.5px dashed blue'>
    <head>
    </head>

    <body style='border: 0.5px dashed red'>

        <!-- 블록기반의 태그들 -->
        <h1 style='border: 0.5px dashed green'> Heading </h1>
        <p style='border: 0.5px dashed yellow'> Paragraph </p>

        <div style='border: 0.5px dashed black; width:100px; height:100px'>
        </div>
        <div style='border: 0.5px dashed black; width:100px; height:100px'>
        </div>
        <div style='border: 0.5px dashed black; width:100px; height:100px'>
        </div>
    </body>
</html>
```

- 스타일 속성
  - border: 경계선(테두리)
    - 선의 굵기가 0.5px이고, 타입이 점선이고 컬러 지정
- 각 태그들이 브라우저에서 차지하는 영역을 확인
  - 즉, 지금 보여지는 박스들이 각 태그각 화면에서 차지하는 영역
- 블록기반의 태그의 특징
  - 태그 하나가 전체 너비를 모두 차지
  - 수직으로 쌓임
  - 크기를 지정할 수 있음
  - 다음 라인에 태그의 내용이 표시
  - 즉, 블록기반의 태그들은 화면에 배치가 될 때, 한 줄에 하나씩 배치가 됩니다.
  - margin, padding의 위, 아래, 좌, 우 모두 사용 가능

### Inline 기반의 태그

- `<span>`
  - 인라인 기반의 대표적인 태그로 `div`와 마찬가지로 `익명태그`중에 하나 입니다.
  - 기본적으로는 div와 거의 동일하지만, `inline`기반이 차이점 입니다.
- 그 외 인라인 기반의 태그들
  - img, a, ...
- 인라인 기반의 태그의 특징
  - 필요한만큼의 너비를 사용한다
  - 크기를 지정할 수 없다
  - 수평으로 쌓인다
  - margin, padding의 위/아래 사용 불가
- 실습용 코드

```
<!DOCTYPE html>
<html style='border: 0.5px dashed blue'>
    <head>
    </head>

    <body style='border: 0.5px dashed red'>

        <!-- 블록기반의 태그들 -->
        <h1 style='border: 0.5px dashed green'> Heading </h1>
        <p style='border: 0.5px dashed yellow'> Paragraph </p>

        <div style='border: 0.5px dashed black; width:100px; height:100px'>
            div1
        </div>
        <div style='border: 0.5px dashed black; width:100px; height:100px'>
            div2
        </div>
        <div style='border: 0.5px dashed black; width:100px; height:100px'>
            div3
        </div>

        <!-- 인라인 기반의 태그들 -->
        <span style='border: 0.5px dashed black;'>
            span1
        </span>
        <span style='border: 0.5px dashed black;'>
            span2
        </span>
        <span style='border: 0.5px dashed black;'>
            span3
        </span>
    </body>
</html>
```



```html
<!DOCTYPE html>
<html>
<body>

<div style="border: 1px solid black">Hello World</div>

<p style="border: 1px solid black">The DIV element is a block element, and will always start on a new line and take up the full width available (stretches out to the left and right as far as it can).</p>

<span style="border: 1px solid black">The DIV element is a block element, and will always start on a new line and take up the full width available (stretches out to the left and right as far as it can).</span>

</body>
</html>
```

## 레이아웃

- div를 통해서 배치
- semantic tag를 사용해서 배치
- table을 이용해서 배치
  - HTML5 표준부터 사용하지 않는 방법

---

### iframe

- inline frame의 약자로, 웹 페이지 안에 또 다른 웹 페이지를 표현할 수 있는 방법
- 사용법

```
<iframe src='<https://www.daum.net>'></iframe>
```

- 🚩 실습 - 네이버 메인화면에 들어가서 개발자도구 콘솔창에 아래와 같이 입력해봅니다.

```jsx
document.head.parentNode.removeChild(document.head);
```

- minimi, 트렌드쇼핑 등의 부분은 아직 옷을 입고 있는 이유는? iframe으로 만들어져 있어서입니다.
- w3school 에서 iframe에 대해 찾아보세요.

---

### semantic tag

- HTML5 표준에서 새로 제공하는 태그들
  - 레이아웃을 위해서 제공
- 레이아웃을 나타내는 시멘틱 태그
  - header, nav, main, section, article, asise, footer
- HTML5 표준 이전의 방식

```
<div id="header" role="banner">
<div id="container" role="main">
<div id="footer" role="contentinfo">
```

- HTML5 표준 이후의 방식

```
<header id="daumHead" class="head_daum" data-tiara-layer="header">
<main id="daumContent">
<footer id="daumFoot" class="foot_daum" data-tiara-layer="footer">
```

- 시맨틱 태그를 사용해도 배치가 자동으로 되지는 않습니다.
  
  - 검색에 용이, 웹 접근성, 유지보수를 위해 의미적으로 사용됩니다
  - 배치는 CSS를 통해서 해야 합니다
  
  
  
  ```
          <header >
              헤더 부분 입니다.
          </header>
          <main>
              메인 부분 입니다.
          </main>
          <footer>
              푸터 부분 입니다.
          </footer>
  ```



## emmet

<aside>
💡 Emmet
강력한 자동완성 기능 등으로 HTML 작성 속도를 크게 향상시켜주는 플러그인
주의! Emmet에는 **미리 정해진 태그 이름이 없다**.

</aside>

1. 요소 (Elements) 생성 : `html:5[tab]`
- 생성하려는 요소의 이름을 입력한 뒤 `tab`을 누르면 태그가 자동 생성된다.
2. 구조화 하기 (Nesting operators)
- 자식요소 > : `div>ul>li`

- 형제요소 + : `div+p+bq`

- 한 단계 올리기 ^ : `div+div>p>span+em^bq`
  
  ```
                                 `div+div>p>span+em^^bq`
  ```

- 여러번 만들기 * : `ul>li*5`

- 그루핑 () : `div>(header>ul>li*2>a)+footer>p`
3. ID와 CLASS
- 값 부여: `div#header+div.page+div#footer.class1.class2.class3`

- 넘버링 $ : `ul>li.item$*5`
  
  ```
                `ul>li.item$$$*4`
  ```
  
  
