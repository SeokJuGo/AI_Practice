# 📖 DJANGO DAY 2 공부

### 🧠 1. REMIND

```python
$ conda activate django
# 재접속을 했으니 가상환경을 활성화하자
$ python manage.py runserver
# 기억이 안나니 서버에 다시 접속해보기 
```

## 🖼️ 2. 이미지 추가해보기

```python
{% load static %}
<img src="{% static 'blog/jjanggu.png' %}" class="card-img-top" alt="...">
# 이미지 파일은 미리 준비하여 제공하는 데 사용한다.! 
```

### 💻 3. 모델에 업로드 이미지변수&DB 생성해보기

```python
header_img = models.ImageField(upload_to='blog/images/%Y/%m/%d/', blank=True)
file_upload = models.FileField(upload_to='blog/files/%Y/%m/%d/', blank=True)
# 관용상 파일 관리들 /%Y/%m/%d/ # 년/월/일을 사용한다!
# 장고의 특징인 ORM => DB충돌이 생길 수 있다.
```

### ⚠️주의⚠️ Media File(사용자 업로드 파일)

```python
# backend/setting.py

from pathlib import Path
import os

# Build paths inside the project like this: BASE_DIR / 'subdir'.
BASE_DIR = Path(__file__).resolve().parent.parent
MEDIA_URL = '/media/'
MEDIA_ROOT = os.path.join(BASE_DIR, '_media') 

```

```python
# board/models.py
head_image = models.ImageField(upload_to='board/images/%Y/%m/%d/', blank=True)

```

```python
# django_project/urls.py에 추가

# 이미지 업로드 필드를 위한 추가
from django.conf import settings
from django.conf.urls.static import static

urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
```

#####

###### (이런식으로 기입됨! #m) upload 파일들은 꼭 기입해주자!! #

### 🚪 4. pk마다 다른 PostDetail 들어가기!

```python
# blog/views.py
class PostDetail(DetailView):
    model = Post
# 스네이크형으로 post_detail을 사용할 수도 있고 post를 사용해도 된다!
```

```html
<!   post_detail  >
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    POST DETAIL
    {{ post.title }}
    {{ post.content }}
    {{ post.created_at }}
<!-- 위에 서술했던 거처 post와 스네이크형 post_detail 둘 다 된다  -->
</body>
</html>
```

```python 

# blog/urls.ppy
urlpatterns =+ path('<int:pk>/',views.PostDetail.as_view())
# '<int:pk>/' 현재 주소에서 pk 번호로 들어가면 그에 상응하는 postDetail에 들어가준다!
```

![aaa](https://user-images.githubusercontent.com/116260619/218657895-c377c3d3-c50d-4a48-a54a-c5c7fc08f460.gif)
