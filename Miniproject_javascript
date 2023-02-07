# 🍇 Java Script Mini Project 🍇
> 2023년 2월 6일 ~ 2023년 2월 7일


<div align='center'>
</div>
<br/>

## 팀원 💁
- 고석주
- 주한솔
- 전현준



## 목차 :bookmark_tabs:
- [개발언어](#개발언어)


- [개요](#개요)


- [시연영상](#시연영상)


- [ERD](#ERD)


- [코드](#코드)


- [추가기능](#추가하고싶은기능)

## 개발언어
- JavaScript
- HTML
- CSS

## 개요

#### 마켓 컬리 사이트의 고객 정보를 확인 후 등급에 맞는 서비스 객체화해서 만들기 

## 시연영상
![market](https://user-images.githubusercontent.com/116260619/217056358-a6dea18c-0c63-43d9-9c6e-64380146e47a.gif)
### 오른쪽 하단에 total이 누적된다.(Cart UI는 미완성)


### 링크 https://seokjugo.github.io/JavaScript_Member/


![market2](https://user-images.githubusercontent.com/116260619/217057905-d0f9e113-9339-4c63-bbb9-a143e51eba1b.gif)

## ERD
![image](https://user-images.githubusercontent.com/116260619/217052540-06b293d9-350d-411d-809f-a7aeb76c27c5.png)

#### 세 개의 클래스로 구성

> Member Class

- name 고객이름 
- total 총 결제 금액
- reward 적립금
- delivery fee 배달료



> Product
- p_num 제품번호
- p_name 제품이름
- p_quantity 수량
- jjim 찜


> Cart
- p_num 제품번호
- c_num 카트번호
- quantity 카트에 들어가 있는 수량






## Trouble Shooting
- 





## 코드
```
class Member {
    constructor(name) {
      this.name = name;
      this.total = 0;
      this.reward = 0;
      this.delivery_fee = 3000;
      this.cart = new Cart();
    }
      info() {
      console.log(`이름: ${this.name}`);
    }
      buy(product,value=1) {
        this.total += product.p_price*value;
        product.quantity-=value
        console.log(`${this.name}님이 ${product.p_name}(₩${product.p_price*value})를 ${value}개 샀습니다!`);
    }
      add_cart(product, quantity) {
        this.cart.add_item(product, quantity);
      }
       delete_cart(product) {
         this.cart.delete_item(product);
    }
      get_cart() {
        return this.cart;
      }
   }
  // 0. 조건: 등급은 일반회원, 프렌즈, 퍼플(Plain, Friends, Purple) + 개인정보는 이름만 받습니다. 이외 3개 클래스를 구현하는데 필요한 속성, 함수를 직접 논의하고 구현해보세요
  class PlainMember extends Member {
    constructor(name,total,reward,delivery_fee) {
      super(name,total,reward,delivery_fee);
      reward=this.total*0.005;
    }
    info_check(){
      super.info();
      this.reward=Math.floor(this.total*0.005);
      console.log(`총 구매금액 : ₩${this.total} , 적립금 : ₩${this.reward}, 회원등급번호: 일반, 배송비 :${this.delivery_fee}원`);
    }
  }
  class FriendsMember extends Member {
    constructor(name,total,reward,delivery_fee) {
      super(name,total,reward);
      reward=this.total*0.01;
      this.delivery_fee=2000;
    }
    info_check(){
      super.info();
      this.reward=Math.floor(this.total*0.01);
      console.log(`총 구매금액 : ₩${this.total} , 적립금 : ₩${this.reward}, 회원등급번호: 프렌즈 , 배송비 :${this.delivery_fee}원`);
    }
  }
  class PurpleMember extends Member {
    constructor(name,total,reward,delivery_fee) {
      super(name,total,reward);
      this.delivery_fee=0;
      reward=this.total*0.07;
    }
     info_check(){
      super.info();
      this.reward=Math.floor(this.total*0.07);
      console.log(`총 구매금액 : ₩${this.total} , 적립금 : ₩${this.reward}, 회원등급번호: 퍼플 , 배송비 :${this.delivery_fee}원`);
    }
  }
  // 1. 일련번호, 상품명, 수량, 가격을 속성으로 가지는 Product 클래스를 구현해보세요. (일련번호는 자동 입력됨)
  class Product {
    static product_num = 0;
    constructor(p_name, p_quantity, p_price,jjim=0) {
      this.p_num = ++Product.product_num;
      this.p_name = p_name;
      this.p_quantity = p_quantity;
      this.p_price = p_price;
      this.jjim = jjim;
    }
    get num() {
      return this.p_num;
    }
    get name() {
      return this.p_name;
    }
    set name(value) {
      this.p_name = value;
    }
    get quantity() {
      return this.p_quantity;
    }
    set quantity(value) {
      this.p_quantity = value;
    }
    get price() {
      return this.p_price;
    }
    set price(value) {
      this.p_price = value;
    }
  }
  class Cart {
    constructor() {
      this.items = [];
    }
    add_item(product, quantity) {
      let exist = this.items.find(i => i.product.name === product.name);
      if (exist) {
        exist.quantity += quantity;
      } else {
        this.items.push({ product, quantity });
      }
    }
    delete_item(product) {
      this.items.pop({product});
    }
    get_items() {
      return this.items;
    }
  }
  // Go는 일반회원
  const Go = new PlainMember("SeokJu");
  // Joo는 프렌즈회원
  const Joo = new FriendsMember("Hansol");
  // Jeon은 퍼플회원
  const Jeon = new PurpleMember("hyunjun");
  const apple = new Product("사과", 10, 1500);
  const mouse= new Product("마우스", 20, 20000);
  const notebook = new Product("노트북", 10, 300000);
```

![image](https://user-images.githubusercontent.com/116260619/217062224-8cb6232f-8360-4380-9cfa-1e4606bbd52f.png)
### 1. Cart 클래스 추가, 제품, 이름을 담은 객체들을 여러 개 불러오고 지움



![image](https://user-images.githubusercontent.com/116260619/217061515-c99fec8a-5097-477d-b2a6-4ddff69bce90.png)
### 2. reward, delivery fee 변수로 상속받은 Memeber 등급별 차등 부여



![image](https://user-images.githubusercontent.com/116260619/217061930-808ac2f5-1c48-4c96-9e8c-e47854aeb2e1.png)
### 3. buy 매개변수 value=1 기본값으로 함으로써 수량을 입력 제품만 입력 시에도 하나 씩 구매



## 추가하고싶은기능
- 데이터베이스 추가 (fireabase or mysql)
- 반응형으로 제품별 찜 추가 후 사용자가 원할 시 리다이렉션 리스트 나열하기
- Cart 목록 전체 구매하기
- UI로 Cart 목록(이름, 개수) 나열하기
- Member_detail 클래스 생성하기
