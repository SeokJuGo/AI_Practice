// 1. Login
===================
// login.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <script src="loginCheck.js"></script>
</head>
<body>
    <script>
        let inputId = prompt('Input ID.');
        let inputPw = Number(prompt('Input PW'));

        if (id === inputId && pw === inputPw){
            document.write('Login Success')
        } else {
            document.write('Please Check ID or PW')
        };
    </script>
</body>
</html>

//loginCheck.js
let id = 'user';
let pw = 1234;

// 2. For
===================
## 
var names = ['강동엽', '고석주', '김건영', '남정우', '양효준', '이상훈', '이재영F', '전현준', '정제경', '주한솔', '지우근', '최세현', '이재영M'];

for (var i=0; i < names.length; i++) {
  console.log(names[i] + '님, 맛점하세요!')
}

// 3. Even
===================
var i = 1;   
// print when i is even 
while (true) {
  if (i >= 10) break; // 무한반복을 끝낼 실마리
  i++;  
  
  if ((i%2) ==0) {
    console.log(i);
  } else {
    continue
  }

// 4. Reverse
===================

var i = 1;   
// print when i is even 
while (true) {
  console.log(i);
  i++;
  if (i === 10) break; // 무한반복을 끝낼 실마리
}

}

// 5. CountDown
================
var num1 = 8
// var num2 = -1
// var num3 = 8

// if 안에 while
if (0 < num1 && num1 < 11){
  while (0 <num1){
    console.log(num1);
    num1--;
  }
} else {
  console.log(num1);
}

// do-while
do {
    console.log(num1);
    num1--;
} while (0 < num1 && num1 < 11)

// 6. Delete Index
================
// a 배열에 있는 '가'를 모두 제거해주세요 

// '가'가 있는 인덱스번호를 조건으로 걸면 되겠다 
var index = a.indexOf('가') // 선언 및 초기값 
// -1이 아닌 경우에는 계속 반복하면서 값을 삭제하도록 
while (index > -1) {  // 조건 
   a.splice(index, 1)   // 실행문
  index = a.indexOf('가')        // 이 반복을 끝낼 실마리 
}
console.log(a)
// a.splice(인덱스번호, 1) 