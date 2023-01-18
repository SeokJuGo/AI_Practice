# CSS

# CSS 이론

<aside>
💡 CSS, Cascading Style Sheets
HTML 요소들이 각종 미디어에서 어떻게 보이는가를 정의하는 데 사용되는 스타일 시트 언어.
HTML4 부터는 이러한 모든 서식 설정을 HTML 문서로부터 따로 분리하는 것이 가능해졌습니다.

</aside>

- HTML에 CSS를 적용하는 방법 (실습과 함께 확인)
  
  1. Inline style
    
    - html 태그에 `style` 속성을 이용하는 방법
    - html의 style 속성 안에는 css가 들어오기로 약속이 되어있습니다.
    - 우선순위가 제일 높습니다.
  2. Internal style
    
    - html 코드 내에 `<style>` 태그를 이용해서 표현
  3. External style
    
    - 대부분은 외부 스타일 시트를 이용해서 CSS를 적용
      
    - 이유 : HTML은 내용과 구조만 다루게 하기 위해서
      
      ```
            (유지보수, 웹사이트 전체 스타일 일관성 유지 용이, 검색순위 우선)
      ```
      
    - 스타일 시트 파일을 html 페이지에서 가져와서 적용하는 방법
      
      ```
        <link rel='stylesheet' type='text/css' href='css 파일의 경로' />
      ```
      
    - 코드의 재사용
      
      <aside>
      💡 css를 외부참조로 하면 얻을 수 있는 효과
      
      - 코드의 간결성, 유지보수 수월
      - 웹사이트 전체의 디자인 통일성
      - 빠른 렌더링 속도 (캐싱 덕분입니다)
        
        </aside>
        
      
      <aside>
      💡 **캐싱**(Caching)
      캐시(Cache)라고 하는 좀 더 빠른 메모리 영역으로 데이터를 가져와서 접근하는 방식을 말한다. 캐시는 컴퓨터 과학에서 데이터나 값을 미리 복사해 놓는 임시 장소를 가리킨다. 캐시는 캐시의 접근 시간에 비해 원래 데이터를 접근하는 시간이 오래 걸리는 경우나 값을 다시 계산하는 시간을 절약하고 싶은 경우에 사용한다.
      
      </aside>
      

---

# CSS의 구조

![ 출처  http//wwwtcpschoolcom/css/cssintrosyntax](http://www.tcpschool.com/lectures/img_css_syntax.png)

CSS의 문법은 선택자(selector)와 선언부(declaratives)로 구성됩니다.

선택자는 CSS를 적용하고자 하는 HTML 요소(element)를 가리킵니다.

선언부는 하나 이상의 선언들을 세미콜론(;)으로 구분하여 포함할 수 있으며, 중괄호({ })를 사용하여 전체를 둘러쌉니다.

각 선언은 CSS 속성명(property)과 속성값(value)을 가지며, 그 둘은 콜론(:)으로 연결됩니다.

이러한 CSS 선언(declaration)은 언제나 마지막에 세미콜론(;)으로 끝마칩니다.

```
선택자(Selector) {
  속성이름1: 속성값1 속성값2 속성값3 ... ;
  속성이름2: 속성값1 ... ;
}
```

- 선택자: 스타일을 적용할 태그가 됩니다.
- 속성과 속성값은 `:(콜론)`으로 구분
- 속성값이 여러개인 경우는 `(공백)`으로 구분
- 속성과 속성은 `;`으로 구분
- 주석은 /* */ 사이에 입력합니다.

---

### 글자와 관련된 속성들

- 폰트, 글자 크기, 글자 색, ...
- 물려받음
- 상속
  - CSS의 속성이 부모 태그에서 자식 태그로 상속되어서 하위 태그들도 동일한 속성 적용
  - 무조건 상속이 되지는 않습니다.
  - 글자와 관련된 속성들은 상속이 가능한 대표적인 속성 입니다.

```
html {
    font-size: 20px;
    font-family: '나눔고딕코딩', '굴림체', 'serif', 'sans-serif';
    line-height: 0.8; /* 줄간격 */
}
```

- 글꼴은 `font-family`로 지정할 수 있습니다.
  - 로컬(브라우저가 실행되는 환경)에 해당 글꼴이 설치되어 있어야만 사용이 가능합니다.
  - 없는 글꼴을 사용하는 경우에 화면에 깨질 수 있습니다.
    - 여러개의 글꼴을 지정
    - 글꼴들이 전부 없는 경우에는 기본글꼴이 사용될 수 있도록
    - serif, sand-serif, monospace, ...

---

### 색상과 관련된 속성들

- 글자색, 배경색, 배경이미지, ...

```
    color: #006400;            /* 글자색 */
    background-color: black;   /* 배경색 */
```

# CSS 셀럭터

## **스타일 시트의 기본 형식**

- CSS-Selector
  - 스타일을 원하는 태그에 정확하게 적용하기 위한 여러가지 방법
  - CSS에서만 사용하지 않고, 다른 곳에서도 동일한 셀렉터를 지원

<aside>
💡 **선택자 (selector)**

- **스타일을 적용할 대상**
  
- **HTML 문서의 태그, 아이디, 클래스, 속성** </aside>
  
- **{속성:값}**
  
  - **변경하고자 하는 속성**
  - **글꼴, 크기, 색상 등**
  - **{속성:값;}**
- **사용 예: 모든 <h1> 태그에 다음 스타일 적용**
  
- 가장 기본적으로는 `태그 셀렉터`, `id 셀렉터`, `class 셀렉터` 등이 많이 사용
  
- 우선순위
  
  - `Id 선택자 > class 선택자 > 태그 선택자`

## **선택자 유형**

- **태그 선택자**
  
  - **태그명 사용**
    
  - **요소(element) 선택자라고도 함**
    
  - **HTML 문서에 있는 같은 모든 태그에 동일하게 적용**
    
  - 문법
    
    **태그명 { 속성:값; }**
    
    ![image](https://user-images.githubusercontent.com/116260619/213190032-b87289fe-b3a3-4116-84f5-d80d01c5fb22.png)
    
  - 태그 여러개를 선택시
    
    여러 선택자를 쉼표(,)로 구분하여 연결
    
    ```html
    <style>
    h1 { color: navy; }
    h1, h2 { text-align: center; }
    h1, h2, p { background-color: lightgray; }
    </style>
    ```
    
- **아이디 선택자 #**
  
  - **# 사용**
  - **문서에서 특정 부분에만 필요한 CSS 적용할 때 사용**
  - **필요한 부분에 유일한 아이디를 지정하고 CSS 적용**
  - **식별 선택자라고도 함**
  - 중복된 아이디는 자바스크립트에서 오류를 발생시키므로 하나의 요소에 하나의 id를 적용할 것을 권장
  - **문법**
    - **#idName { 속성:값; }**
    - **<태그명 id=“idName”> </태그명>**
- **클래스 선택자 .**
  
  - **. 사용**
  - **문서에서 특정 부분에만 필요한 CSS 적용할 때 사용**
  - **사용자 정의 선택자 또는 도트(.) 선택자라고도 함**
  - **정의한 클래스 선택자를 태그에 적용**
  - **문법**
    - **.className { 속성:값; }**
    - **<태그명 class=“className”> </태그명>**
- **속성 선택자**
  
  - **문서에 삽입된 HTML 태그(요소)의 지정된 속성 값에 따라 선택자로 정의**
    
  - **예: <a> 태그의 title 속성 값**
    
    - **<a title=“겨울”>겨울</a>**
    
    ```html
     a {
          선언명 : 값
    }
    ```
    
    - 실습
      - 태그[속성] : 지정한 속성
      - 태그[속성=값] : 특정 값을 갖는 속성 a[target=”_blank”]
      - 태그[속성 ~= 값] : 여러 값 중 특정 값이 포함된 속성에 적용 (띄어쓰기 단위)
      - 태그[속성 |= 값] : 속성이 값과 같거나, “값-”로 시작하는 단어
      - 태그[속성 ^= 값] : 속성이 값으로 시작하는 단어
      - 태그[속성 $= 값] : 속성이 값으로 끝나는 단어
      - 태그[속성 *= 값] : 속성 중에 값이 들어가는 단어
- 전체 선택자
  
  - - (와일드 카드)
  - html 문서내의 모든 태그를 선택
  - 사용법
  
  ```
  * {
    ...
  }
  ```
  
  - 하위 선택자
    
    - 태그들의 계층 구조를 이용해서 선택
    - 공백으로 표현
      - 선택자 SP 선택자
    - 사용법
    
    ```
    상위선택자 하위선택자 {
      ...
    }
    ```
    
    - 하위의 개념은 상위 선택자의 모든 하위 태그들을 전부 포함
  
  ---
  
  - 자식 선택자
    
    - 하위 선택자와 마찬가지로 계층구조를 이용한 선택자
    - `>` 표현
      - `직계 자손`: 바로 밑에 하위 태그만 자식으로 인정
    - 사용법
    
    ```
    상위선택자 > 하위선택자 {
      ...
    }
    ```
    

---

- **상태 선택자**
  
  - **선택자:checked - 체크된 input 태그 선택**
  - **선택자:focus - 포커스를 받은 input 태그 선택**
  - **선택자:enabled - 사용 가능한 input 태그 선택**
  - **선택자:disabled - 사용 불가능한 input 태그 선택**

```
1) 다크모드를 클릭하지 않고 다크모드를 만들어보세요

2) ‘메일’을 클릭하면 구글로 이동하도록  만들어보세요

3) **CSS 관련 엘리먼트 태그 제거**
```

## 속성

- **CSS 속성**
  
  - **텍스트 속성**
  - **배경 색상 / 이미지 관련 속성**
  - **테두리 속성**
  - **여백 속성**
  - **display 속성 : inline / block / inline-block**
  - **float 속성**
  - **목록 관련 속성**
  - **위치 관련 속성**
  - **겹침 (레이어)**
- 색
  
  CSS에서 색을 표현하는 방법에는 다음과 같이 세 가지 방법이 있습니다.
  
  1. 색상 이름으로 표현
  2. RGB 색상값으로 표현
  3. 16진수 색상값으로 표현]
  
  - 실습
    - html 태그로 제목의 색을 지정해보기
    - <style /> 로 위 태그 변경해보기
      
    - style.css를 별도로 만들어 참조하게 하기
- 텍스트
  
  CSS에서 사용할 수 있는 대표적인 text 속성은 다음과 같습니다.
  
  1. color
    
  2. direction
    
  3. letter-spacing
    
  4. word-spacing
    
  5. text-indent
    
  6. text-align
    
  7. text-decoration
    
  8. text-transform
    
  9. line-height
    
    1. text-shadow
      

- html에서 태그는 영역에 대해서 상자로 표현할 수 있는데 이를 `박스모델`이라고 합니다.
  
- 박스모델과 관련된 속성
  
  - margin
    - margin-left
    - margin-right
    - margin-top
    - margin-bottom
  - border
  - padding
    - padding-left
    - padding-right
    - padding-top
    - padding-bottom
  - 내용
- border를 기준으로 바깥쪽 여백을 `margin`이라고 하고, 안쪽(내용과 border 사이) 여백을 `padding`이라고 합니다.
  
  <aside>
  💡 **리팩터링,** refactoring
  '결과의 변경 없이 코드의 구조를 재조정함'을 의미합니다. 주로 가독성을 높이고 유지보수를 편하게 하기 위해서입니다. 버그를 없애거나 새로운 기능을 추가하는 행위가 아니라 사용자가 보는 외부 화면은 그대로 두면서 내부 논리나 구조를 바꾸고 개선하는 유지보수 행위입니다.
  
  </aside>
  

![image](https://user-images.githubusercontent.com/116260619/213190258-119c10c4-0b74-4b3c-95b2-2de1b1000806.png)

## positioning

- 태그의 위치를 지정
  - static(default)
    - 블록과 인라인에 따라서 자동으로 위치가 결정 됩니다.
    - 즉, 기본흐름에 따른 배치
  - relative
    - top, bottom, left, right 속성을 이용해서 원래 위치를 변경
    - 원래 자기 자신의 위치에서 변경
  - absolute
    - top. bottom, left, right 속성을 이용해서 원래 위치를 변경
    - 자기 자신을 감싸는 태그에 대해 상대적으로 위치를 지정
    - 상위 태그의 position이 static이면 해당하지 않는다.
      - `body`를 기준으로 위치가 정해집니다.
  - fixed
    - 고정 위치를 지정
    - 스크롤링이 되어도 항상 같은 영역에 표시
    - top, bottom, left, right 속성으로 위치를 지정

# 3_position.html

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>positioning</title>
    <!-- 4.css 만드셔서 두번째 코드블록을 링크해주세요  -->
</head>
<body>
    <body style='border: 0.5px dashed red'>
        <!--  -->
            <header id="header">
                <!-- 블록기반의 태그들 -->
                <h1 style='border: 0.5px dashed green'> Heading </h1>
                <p style='border: 0.5px dashed yellow'> Paragraph </p>
            </header>

            <content id="container"  style='border: 5px dashed gray'>
                <article id="divs">
                    <div class="special" style='border: 0.5px dashed black; width:100px; height:100px'> DIV1
                    </div>
                    <div class="special"style='border: 0.5px dashed black; width:100px; height:100px'> DIV2
                    </div>
                    <div style='border: 0.5px dashed black; width:100px; height:100px'> DIV3
                    </div>
                </article>

                <article id="spans">
                    <!-- 인라인기반의 태그들 -->
                    <span class="special" style='border: 1px dashed purple; width:100px; height:100px'> SPAN1
                    </span>
                    <span class="special" style='border: 1px dashed purple; width:100px; height:100px'> SPAN2
                    </span>
                    <span style='border: 1px dashed purple; width:100px; height:100px'> SPAN3
                    </span>
                </article>
            </content>
            <footer id="footer" style='border: 1px dashed rgb(128, 85, 0); height:100px'>
                푸터입니다.
            </footer>
    </body>
</body>
</html>
```

---

```
header {
    background-color: #006699;
    color: #FFFFFF;
}

.title {
    display: inline;
}

.list {
    display: inline;
    position: absolute;
    right: 20px;
    bottom: 25px;
    text-align: right;
}

.list-item {
    display: inline-block;
    /* inline 속성은 너비 속성을 가지지 않습니다 */
    /* inline-block은 inline 속성이면서, block 속성을 같이 사용 */
    width: 300px;
    font-size: 30px;
    text-transform: uppercase;
}

.container {
    position:relative;
    margin-top: 20px;
    margin-bottom: 20px;
    padding-top:20px;
    padding-bottom:20px;
}

.span {
    position: absolute;
    top: 50px;
    left: 180px;
}
```

#
