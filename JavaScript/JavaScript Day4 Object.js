// 객체지향프로그래밍의 특징: 추상화, 상속, 다형성, 캡슐화(, 은닉성)

// person1 이라는 객체를 만드시고 name, age, introduce()라는 함수를 넣습니다. 
// 1. 객체와 변수를 담아서 만드는 방법 
var person1 = {
    name: '김연지',
    age: '24',
    introduce : () => {
      console.log('안녕하세요! 김연지입니다!')
    }
  }
  person1.name
  person1.age 
  
  // 2. 빈 객체를 만들고 거기에 하나씩 속성, 함수를 채워넣는 방법 
  var person2 = new Object();
  person2.name = '신짱구';
  person2.age = 5
  
  
  // Class : 비슷한 객체를 여러개 만들어야 할 때 비슷한 객체를 묶어서 관리하기 위한 특별한 자료형을 말합니다. 
  // 어느 언어에서건 함수나 변수는 대개 소문자를 사용합니다. 근데 class를 만드는 함수는 대문자로 시작합니다. 
  
  // 1. 생성자(constructor) 함수
  // 자바스크립트 2016년 전까지는 class라는 명령어가 따로 없었어요. 그 이전에는 생성자 함수를 사용했습니다.
  
  // 생성자 함수 
  // 생성자함수에서의 this는 파이썬의 self 와 유사한 기능을 하고 있다
  function Person(name, age){
    this.name = name;
    this.age = Number(age); 
    // return this; 생략 가능
    this.introduce = () => {
      console.log('안녕하세요!')
    }
  }
  
  // 생성자 함수를 통해 객체를 찍어낼 때는 new 명령어를 사용합니다. 
  var person1 = new Person('김연지', 11)
  
  // 2. 2016년 이후 (ES6 문법)에는 class 명령어를 지원합니다. 근데 둘 중 무엇으로 만들건 결과는 똑같다 라는 거
  class Person1 {
    // __init__() 과 같은 역할을 한다고 생각하시면됩니다 
    constructor(name, age) {
      // 따로 파라미터로 정의하지 않아도 항상 정의되어있는 셈이 됩니다.
      this.name = name;
      this.age = Number(age); 
      this.introduce = () => {
      console.log('안녕하세요!')
      }
    }
  }
  
  // 실습. Car라는 클래스를 만드셔서 color, name, company 라는 속성과 start라는 함수를 만들어주세요. start를 실행하면 name변수에 담긴 이름과 함께 차가 출발합니다! 라고 출력이 됩니다.
  function Car(color, name, company){
    this.color = color;
    this.name = name;
    this.company = company;
    this.start = function () {
      console.log(`${this.name} 차가 출발합니다!`)
    }
  }
  
  // class 예약어 사용 -> wrapper 
  class Car1 {
    // 클래스 변수 - 틀을 통해 찍혀나가는 객체의 변수가 아니라 클래스 자체의 변수가 되는 셈입니다. 
    static seller = '김연지';
    static soldNum = 1;
    #debt; // private 변수 선언 변수명에 #을 사용하면 자동으로 은닉성이 생긴다 -> 계좌번호, 금액 이런 종류의 바깥에서 함부로 접근하면 안 되는 속성들은 변수명 앞에 #을 붙여줌으로써 private 변수로 지정할 수 있습니다.
    
    // 생성자의 자리에는 속성(변수)들만 넣어주는 것을 권장합니다
    constructor(color, name, company, debt){
      this.color = color;
      this.name = name;
      this.company = company;
      this.#debt = debt;
      this.carNum = Car1.soldNum;
      Car1.soldNum++;
      this.seller = Car1.seller;
      }
      start = function () {
      console.log(`${this.name} 차가 출발합니다!`)
      }
    
      // 세상의 모든 함수는 getter (값을 확인하는 함수) - return 있음/ setter (값을 변경하는 함수) = return 없음
      // private 변수에 접근하기 위한 메소드
      // get 명령어를 함수 앞에 사용하면 getter로만 함수를 사용합니다. 그리고 변수처럼 호출합니다. 
      get check() {
        return this.#debt
      }
    
      // private 변수에 접근하여 수정하기 위한 메소드 
    // set 명령어를 함수 앞에 붙이시면 setter로만 사용합니다.
    // 실생활에서 데이터의 사용 형태와 자료형이 가지는 데이터의 사용 형태가 다를 때 앞에 조건문을 통해서 판별을 시키고 값을 변경할 수도 있다.
      set lend(debt) {
        if (this.#debt >= 0) { 
          this.#debt -= debt;
        } else { // 0보다 작은 금액이 빚으로 남아있는 경우는 더이상 빚을 갚을 수 없도록 
          console.log('빚 다 갚으셨습니다!!')
        }
      }
    
    // class 자체의 변수, 함수는 static 명령어를 통해 구현할 수 있습니다 
    static sold() {
      console.log(`${Car1.soldNum} 대수만큼 팔렸습니다.`)
    }
  }
  
  // dCar1, dCar2 라는 두개의 드림카를 설명하는 객체를 만들어주세요. 
  var dCar3 = new Car1('white', '테슬라', 'T?');
  var dCar2 = new Car1('blue', '벤츠', 'BMW');
  var dCar1 = new Car1('red', '모닝', '기아', 8000); 
  // dCar1.#debt: "Private field '#debt' must be declared in an enclosing class"
  

  
  // 중고차를 판매하는 클래스
class Car1 {
    static seller = '김연지';
    static soldNum = 1;
    #debt;  // private변수로 인식됩니다
  
    constructor(color, name, company, debt){
      this.color = color;
      this.name = name;
      this.company = company;
      this.#debt = debt;
      this.carNum = Car1.soldNum;
      Car1.soldNum++;
      this.seller = Car1.seller;
      }
  
      start = function () {
      console.log(`${this.name} 차가 출발합니다!`)
      }
    
      // getter 값을 확인만 할 수 있게 함수를 만들고 변수처럼 호출하기 위한 명령어
      get check() { // dCar1.check()가 아니라 dCar1.check 처럼 변수와 같은 방식으로 호출됨
        return this.#debt
      }
    
     // setter 값을 변경할 수 있게 함수를 만들고 변수처럼 값을 집어넣는 명령어 
      set lend(debt) { // dCar1.lend(5000)이 아니라 dCar1.lend = 5000 와 같은 방법으로 파라미터를 넣을 수 있음
        // 은닉성 유지 또는 현실의 데이터의 기준에 맞게 값 변경을 제어하기 위해서 
        if (this.#debt >= 0) { 
          this.#debt -= debt;
        } else { 
          console.log('빚 다 갚으셨습니다!!')
        }
      }
    
    static sold() {
      console.log(`창사 이래 지금까지 총 ${Car1.soldNum} 대만큼 팔렸습니다.`)
    }
  }
  
  var dCar3 = new Car1('white', '테슬라', 'T?');
  var dCar2 = new Car1('blue', '벤츠', 'BMW');
  var dCar1 = new Car1('red', '모닝', '기아', 8000); 
  
  // 중고차를 렌탈하는 Car2 클래스를 다시 만들어서 렌탈 고객, 렌탈 차량을 관리할 필요가 생겼습니다. 보니까 하나하나 다시 만들기보다 판매용 클래스 Car1을 가지고 와서 재사용하면 수월할 것 같아요.
  class Car2 extends Car1 {
    static seller = '김연지';
    static soldNum = 1;
    #debt;
    constructor(color, name, company, debt, customerName){
      super(color, name, company, debt);
      this.cName = customerName;
    }
    rent() { // 자식 클래스에만 메서드 추가
      console.log('이 차는 렌탈차량입니다')
    }
    
    lend() {
      super.lend();
      }
  }
  
  var rCar1 = new Car2('black', '프라이드', '현대', 9000, '강동원')
  
  rCar1.rent()
  rCar1.lend()

  // 실습. 생성자 함수로 된 Movie를 class 문법으로 구현하고 상속 및 static 변수, 함수 부여
  function Movie(director, actor, star, review) {
    this.director = director
    this.actor = actor
    this.star = star
    this.review = review
    this.info = function() {
      console.log(`감독: ${this.director}
      배우: ${this.actor}
      별점: ${this.star}
      리뷰: ${this.review}`)
    }
  }
    
    // 1. class 문법으로 변경해 주세요.
    // function Movie(director, actor, star, review) {
//   this.director = director
//   this.actor = actor
//   this.star = star
//   this.review = review
//   this.info = function() {
//     console.log(`감독: ${this.director}
//     배우: ${this.actor}
//     별점: ${this.star}
//     리뷰: ${this.review}`)
//   }
// }

// 1. class 문법으로 변경해 주세요.
class Movie {
    #star;
    static nation = 'Universal' // 클래스 변수 
    constructor(director, actor, star, review) {
    this.director = director
    this.actor = actor
    this.#star = star
    this.review = review
    }
    
    info() { 
      console.log(`감독: ${this.director}
      배우: ${this.actor}
      별점: ${this.#star}
      리뷰: ${this.review}`)
    }
    
    get point() {
       return this.#star;    
    }
    
    set point(changed_star) {
       this.#star = changed_star;    
    }
    
    static check_nation() {
      console.log(`${Movie.nation}의 영화 를 관리하는 자료형입니다`)
    }  
  }
  // 2. Movie를 상속받는 KoreanMovie 클래스를 만들어주세요. engName(영어로 된 영화제목)이라는 변수가 생성자에 추가됩니다. 
  // 3.KoreanMovie로 만들어진 객체는 객체.info() 를 실행하면 engName도 같이 출력합니다. 
  class KoreanMovie extends Movie {
    constructor(director, actor, star, review, engName){
      super(director, actor, star, review);
      this.engName = engName;
    }
      
    info(){
      super.info();
      console.log(`영어제목: ${this.engName}`);
    }
  }
  var 지구를지켜라 = new KoreanMovie('장준환', '신하균', 4.5, '이제 지구는 누가 지키지?', 'Save the Earth')
  
  
  // 4. 클래스에 movieNum 이라는 static 변수를 만드셔서 객체가 생성될 때마다 자동으로 번호(movieNum)가 매겨지도록 개선해보세요.
  class KoreanMovie extends Movie {
    static movieNum = 0;
    
    constructor(director, actor, star, review, engName){
      super(director, actor, star, review);
      this.engName = engName;
      this.movieNum = ++KoreanMovie.movieNum;
    }
      
    info_check(){
      console.log(`영화번호: ${this.movieNum}`);
      super.info(); // info() 함수의 실행문을 가져와서 사용합니다.
      console.log(`영어제목: ${this.engName}`);
    }
  }
  
  var 지구를지켜라 = new Movie('장준환', '신하균', 4.5, '이제 지구는 누가 지키지?')
  var 패터슨 = new Movie('짐자무쉬', '아담드라이버', 5, '아하')
  var 지구를지켜라 = new KoreanMovie('장준환', '신하균', 4.5, '이제 지구는 누가 지키지?', 'Save the Earth')
  var 올빼미 = new KoreanMovie(undefined, '류준열', undefined, '나는 안보고 본 척하는 사람이 싫어', 'Owl')
  
  올빼미 instanceof Movie; 
  올빼미 instanceof KoreanMovie;
  올빼미.info();
  올빼미.info_check();