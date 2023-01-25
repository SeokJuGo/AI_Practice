import streamlit as st

# 이미지를 첨부하여 업로드하려면...
from PIL import Image # 파이썬 기본라이브러리는 바로 사용 가능!
import os


# 사이드바 만드는 방법 1: st.sidebar.요소명 
# Using object notation
# 사이드바에 셀렉트박스(혹은 라디오버튼 등등 뭐라도 좋습니다)로 
# 각 드라마 혹은 애니메이션의 제목 세개를 
# 선택할 수 있도록 해주세요
drama_select = ['별그대', '미니언즈', '수리남']

# 인덱스 번호를 활용해서 두 요소를 연결해서 사용하고 있어요 
drama_select_option = st.sidebar.selectbox('좋아하는 드라마를 선택하세요', drama_select, index=0)

# 사이드바 만드는 방법 2: with st.sidebar:
#                           변수명 = st.요소명 

# 본문
folder = './data/'
image_files = ['01.jpeg', '02.jpeg', '03.jpeg']
# 사이드바에 있는 드라마 리스트의 0, 1, 2 순서에 맞춰서 텍스트 데이터가 호출된다
# 서로 다른 리스트를 묶어서 호출하려면 같은 인덱스에 있음을 이용하면 됩니다
drama_select_index = drama_select.index(drama_select_option)

st.write(drama_select_index)
st.header(':blue['+drama_select_option+']')
st.image(folder + image_files[drama_select_index])



    # 보통 사이드바/ 메뉴는 주제별로 서비스를 분류할 때 사용
    # 1) 드라마 좋아하는 목록
    # 2) 만화 좋아하는 목록
    # 3) 사진찍기


    # 1. 하나의 파일에 3개를 다 때려박아놓고 클릭할 때마다 해당 div만 보이게 하기
    # 2. 각 기능별로 별도 파일 혹은 폴더로 만들ㅇ러 놓고 클릭할 때마다 해당 파일에 들어가도록 하기.
    # 보통은 2번의 구조로 사용 -> 1_drama_app.py 2_manhwa_app.py 3. picture_app.py
    