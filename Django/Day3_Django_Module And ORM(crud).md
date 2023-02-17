# ⚙️ DJANGO DAY 3 공부

### 📜 1. REMIND

```python
$ conda activate django
# 재접속을 했으니 가상환경을 활성화하자
$ python manage.py runserver
# 기억이 안나니 서버에 다시 접속해보기 
```

## 🤼 2. 모듈화

##### base.html을 만들어 공통 영역만 파일로 남겨둠

```python
#blog/post_list.html
          {% extends 'board/base.html' %}
					
          {% block page_area %}
            <section class="py-5">
						  ... 생략 ...
            </section>
            {% endblock %}
```

### 👊 3. ORM 접근해서 CRUD 해보기!

```python
# 터미널에서 shell 접
$ python manage.py shell  
```

```python
# shell에서 확인해볼 내용
from 앱.models import 클래스명 
>>> from blog.models import Post
```

### 1. Create

```python
p1 = Post() 
p2 = Post(title="Second", content="Django")
p2.save()
Post.objects.create(title="Third", content="django") # 저장 바로됨!
```

### 2. Read

```python
# Read
Post.objects.all() # 전부다 가져오기
# select * from blog_post where id=3;
Post.objects.filter(id=3)
Post.objects.get(id=3)

# SELECT * FROM blog_post WHERE title LIKE '%글%';
Post.objects.filter(title__contains='글') 
Post.objects.filter(title__icontains='글')

Post.objects.filter(title__contains='Third')  
Post.objects.filter(title__icontains='Third') # icontains 대소문자 구분안함
Post.objects.filter(title__exact='Third')  # 꼭 그 문자열을 검색해주는 메소드

Post.objects.filter(title__exact='Third').first() # 하나만

Post.objects.filter(id__gt=3) # 3개 이상
# in 함수
Post.objects.filter(id__in=[3, 6, 9])
Post.objects.filter(content__in=['Django', 'django', 'jango'])

# 평균, 최소, 최대, 합계
from django.db.models import Avg, Max, Min, Sum
Post.objects.all().aggregate(Avg('id')) #평균

Post.objects.all().count() #전체

```

### 3. Update

```python
p3 = Post.objects.get(id=4)
p3.title = '제목 변경'
p3.save()
```

### 4. Delete

```python
# Delete
p3.delete()
Post.objects.filter(id__lte=4).delete()
```


