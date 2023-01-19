![grid](https://user-images.githubusercontent.com/116260619/213386285-47be116d-938d-4d33-942f-44d42a1f9b71.png)

<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta http-equiv="X-UA-Compatible" content="IE=edge">

    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>08_Grid Layout</title>

    <link rel="stylesheet" type="text/css" href="./08_grid.css">

</head>

<body>S

<!-- class container,  12개의 자식 div가 있습니다.

     item1~item12 까지이고요 모든 div는 item이라는

     클래스명을 가지고 있습니다.  -->

    <div class="container">

        <div class="item" id="item1">div1</div>

        <div class="item" id="item2">div2</div>

        <div class="item" id="item3">div3</div>

        <div class="item" id="item4">div4</div>

        <div class="item" id="item5">div5</div>

        <div class="item" id="item6">div6</div>

        <div class="item" id="item7">div7</div>

        <div class="item" id="item8">div8</div>

        <div class="item" id="item9">div9</div>

        <div class="item" id="item10">div10</div>

        <div class="item" id="item11">div11</div>

        <div class="item" id="item12">div12</div>

    </div>





.container{

    border: 3px solid black;

    background-color: antiquewhite;

    height: 100vh; /* 보이는 화면의 몇 % 를 쓸 것인지 */

}

.item {

    border: 1px dashed purple;

}

.item:nth-child(3n+1) {

   background-color: aqua;

}

.item:nth-child(3n) {

   background-color: white;

}

/* 부모 컨테이너에 적용하는 속성 */

.container {

  display: grid;

  /* fr : 전체 grid를 구간으로 나누는 단위: 여백까지 알아서 계산을 하는 상대적 단위*/

  /* grid-template-columns: 3fr 7fr; */

  /* grid-template-columns: 200px 7fr; */

  /* grid-template-columns: 30% 70%; */

  grid-template-columns: repeat(4, 1fr);

  grid-gap: 10px;

  /* justify-content: center; */

  /* 세로축 */

  /* align-items: center; */

  /* grid-template-rows: 10% 10% 30%; */

}

/* 특정 자식 컨테이너의 영역을 따로 조정하기 쉽기 때문에 많이 사용 */

#item1 {

    grid-row:2/4

}

#item2 {

    grid-column: 1/5;

}

#item11 {

  grid-row: 4;

  grid-column: 3/5;

}

#item12 {

    grid-column: 1/5;

}

</body>

</html>
