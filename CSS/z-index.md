![z-index](https://user-images.githubusercontent.com/116260619/213386313-c94424e3-f136-43b8-a9ae-6c0222b8f095.png)

<!doctype html>

<html lang="ko">

    <head>

        <meta charset="utf-8">

        <title>CSS</title>

        <style>

            div {

                width: 100px;

                height: 100px;

                position: absolute;

            }

            div.x {

                background-color: #2196F3;

                top: 20px;

                left: 000px;

                z-index: 1;

            }

            div.y {

                background-color: #1976D2;

                top: 50px;

                left: 60px;

                border-radius: 50%;

            }

            div.z {

                top: 80px;

                left: 30px;

                width: 0;

                height: 0;

                 border-bottom: 50px solid transparent;

                 border-top: 50px solid transparent;

                 border-left: 70px solid skyblue;

                border-right: 70px solid transparent;

            }

            div.xx {

                background-color: #F44336;

                top: 30px;

                left: 50px;

            }

            div.yy {

                background-color: #D32F2F;

                top: 60px;

                left: 110px;

                border-radius: 50%;

                z-index: 1;

            }

            div.zz {

                width: 0;

                height: 0;

                 border-bottom: 50px solid transparent;

                 border-top: 50px solid transparent;

                 border-left: 70px solid red;

                border-right: 70px solid transparent;

                top: 90px;

                left: 70px;

            }

        </style>

    </head>

    <body>

        <div class="x"></div>

        <div class="y"></div>

        <div class="z">

            <div class="xx"></div>

            <div class="yy"></div>

            <div class="zz"></div>

        </div>

    </body>

</html>
