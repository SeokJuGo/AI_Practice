![flex](https://user-images.githubusercontent.com/116260619/213386268-dffccd67-5d91-491f-a86c-68418015ce4e.png)

<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta http-equiv="X-UA-Compatible" content="IE=edge">

    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Flex Layout</title>

    <link rel="stylesheet" href="./07_flex.css">

</head>

<body>

     <div class="container">

        <div class="item" style="background-color:red" id="item1">div 1</div>

        <div class="item" style="background-color:orange" id="item2">div 2</div>

        <div class="item" style="background-color:yellow" id="item3">div 3</div>

        <div class="item" style="background-color:green" id="item4">div 4</div>

        <div class="item" style="background-color:blue" id="item5">div 5</div>

        <div class="item" style="background-color:darkblue" id="item6">div 6</div>

        <div class="item" style="background-color:purple" id="item7">div 7</div>

        <div class="item" style="background-color:gray" id="item8">div 8</div>

    </div>

</body>

</html>



.container{

    border: 3px solid black;

    background-color: antiquewhite;

    height: 100vh; /* 보이는 화면의 몇 % 를 쓸 것인지 */

}

.item {

    border: 1px dashed purple;

    width:40px;

    height:40px;

}

/* 컨테이너에 적용하는 속성 */

.container {

    /* display를 flex로 지정해주지 않으면 적용 안 됩니다 */

    display: flex;

    /* 중심 축 정하기 */

/*     flex-direction: column; */

    /* flex-direction: row;  */

    /* flex-direction: row-reverse; */

    /* 다음줄 넘기기 */

    flex-wrap: wrap;

/*     flex-wrap: nowrap; */

    /* direction과 wrap을 하나의 속성으로 적용 */

    /* flex-flow: column nowrap; */

    /* 중심 축 기준으로 어떻게 아이템을 배치할 지*/

/*     justify-content: flex-end;  */

    justify-content: space-around;

    /* 맞은편 축 기준으로 어떻게 아이템을 배치할 지*/

    align-items: center;

    /* 여러 줄들 사이의 간격:

    한 줄만 있는 경우, align-content는 효과를 보이지 않음 - flex-wrap - wrap 상태에서 div 8개 더 복사하고 확인해보기 */

    /* align-content: space-between; */

}

/* container 속성을 모두 확인 후에는 다 확인 후 앞에 4개만 남겨봅니다 */

/* 아이템에 적용하는 속성 */

#item1 {

    /* 각 아이템의 순서 */

    /* order: 0; */

    /* 컨테이너가 크기를 늘렸을 때 같이 늘어날 것인지. 기본값은 0 */

    /* flex-grow: 2; */

    /* 컨테이너가 작아졌을 때 어떻게 작아지느냐 -기본값은 0 */

    /* flex-shrink: 2;  */

    /* item 별로 차지하는 공간 다를 때 content의 높이(또는 너비) 기준으로 정렬*/

    flex-basis: 60%;

    /* flex-basis: 500px; */

    /* width: 100px; */

    /* 컨테이너에 지정된 것을 벗어나서 하나만 설정 바꾸고 싶을 때 */

/*     align-self: center; */

}

#item2 {

    /* 각 아이템의 순서 */

    /* order: 1; */

    /* flex-grow: 1; */

    /* flex-shrink: 1;  */

    /* flex-basis: 20%; */

    /* align-self: flex-end; */

}

#item3 {

    /* order: 2; */

    /* flex-grow: 1; */

    /* flex-shrink: 1;  */

    /* flex-basis: auto; */

}

#item4 {

    /* order: 3; */

    /* flex-grow: 0; */

    /* flex-shrink: 1;  */

    /* flex-basis: auto; */

}

.item:nth-child(odd) {

/* .item:nth-child(even) { */

    border: 2px dashed red;

}
