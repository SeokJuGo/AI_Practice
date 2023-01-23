![practice_grid](https://user-images.githubusercontent.com/116260619/213389144-771992e3-17b1-49e0-a0d1-8dc587448146.png)
 
<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta http-equiv="X-UA-Compatible" content="IE=edge">

    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Document</title>

    <style>

        div {

            border: blue 1px solid;

            padding: 20px;

        }

        .container {

            display: grid;

            grid-template-columns: 70fr 30fr;

            grid-gap: 10px;

            align-items: flex-start;

        }

        #item1 {

            border: 1px red solid;

            grid-column: 1/3;

        }

        #item2 {

            grid-column: 2/3;

            grid-row: 2;

        }

        #item3 {

            border: 1px brown solid;

            grid-column: 1/2;

        }

        #item4 {

            border: 1px black solid;

            grid-column: 1/3;

        }

    </style>

</head>

<body>

    <div class="container">

        <div class="item" id="item1">헤더</div>

        <div class="item" id="item2">사이드바</div>

        <div class="item" id="item3">컨텐츠 Lorem ipsum dolor sit amet consectetur adipisicing elit. Non ducimus numquam ea corporis ullam culpa, aperiam debitis labore rerum distinctio sunt ab repellat, velit tempora. Dolores commodi id expedita suscipit? Lorem, ipsum dolor sit amet consectetur adipisicing elit. Fuga assumenda placeat sapiente voluptatum sit? Recusandae totam voluptatum magnam adipisci modi perferendis accusamus laboriosam quaerat facilis velit, tenetur sit illum reprehenderit! Lorem ipsum dolor sit amet consectetur adipisicing elit. Et, suscipit! Atque ratione quasi provident in placeat, eligendi soluta molestias impedit distinctio rem, expedita a, culpa pariatur nihil iste aut harum.</div>

        <div class="item" id="item4">푸터</div>

    </div>

</body>

</html>
