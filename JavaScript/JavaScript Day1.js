// JAVASCRIPT INPUT
var scoreE = prompt('INPUT English Score');
var scoreM = prompt('INPUT Math Score');

alert('mean: ' + (+scoreE + +scoreM)/2);



// Logic Operator
var a = 3;
console.log(a > 5 && a < 1);
console.log('5' === 2+a);
console.log(!(a=false));

var y = a-- + 5 + --a;
console.log(y);

// Object Create
let car = {
        name : 'IONIQ 6',
        color : ['black', 'white', 'blue'],
        company : 'Hyundai',
        speed : 260,
        domestic : true
}

// List Swapping OPtion 1,2

// Option 1
var a = 1;
var b = 3;

var temp;
temp = a;
a = b;
b = temp;

// Option 2
[a,b] = [b,a]

// List Swapping

var array = ['banana', 'carrot', 'egg', 'durian']
[array[2], array[3]] = [array[3], array[2]];
