#  ⚙️ VSCode 에서 장고 환경 설정하기 ⚙️

### 📜 1. 장고 프로젝트 생성!!

```python
$ conda create --name 가상환경이름
# 1.django 가상환경에 들어가기!
$ conda activate django
# 2.활성화하기!
## 만약 없다면 설치하기($ pip install django)
$ django-admin startproject 프로젝트명
# 3. 프로젝트를 생성하자!
```

### ✅ 2. 장고 서버 접속하기!!

```
$ python manage.py runserver
```

###

### 💻 3. DB 생성하기

```python
$ python manage.py makemigrations // git의 commit 와 유사
$ python manage.py migrate        // git의 push
$ python manage.py createsuperuser// 계정생성
```

###

### 🧬4. URL 관련

##### 4-1 back-end url

```python
# django_project/settings.py

from django.contrib import admin
from django.urls import path, include

urlpatterns = [
    path("admin/", admin.site.urls),
    path('blog/', include('blog.urls')),
]
```

##### 4-2 app url

```
urlpatterns = [
    path('', views.index, name='index'),
]
```

###

### 🔭 5. views 관련

### FBV (Test용)

```python
def index(request):
    posts = Post.objects.all() # 모두 객체로 가져온다! for를 사용함 보통
                               # html에서 템플릿태그 사용시 posts 객체를 사용하면된다.
   #posts = Post.objects.first() # 첫번째 객체를 가져온다.
    return render(
        request,
        'board/index.html',
        {
            'posts':posts, 
        }
    )
```

### CBV (주로 사용)
 
```python
# blog/views.py
from django.views.generic import ListView
from .models import Post

class PostList(ListView):
    model = Post 
    # template_name = 'board/index.html' 
    # ordering =
```


#### CBV class 부가 설명
```python
class PostList(ListView):
    model = Post
    ordering = '-pk' 
    # post_list.html이 default Template로 지정된다.
    template_name = 'blog/index.html'
```
- class와 html 이름은 연동이 된다.(html이름을 동일하게 snake형으로)
- PostList의 snake형은 post_list이다. (html에서 객체처럼 사용함)
- ordering = '-pk' 최신순으로 나열해준다!
