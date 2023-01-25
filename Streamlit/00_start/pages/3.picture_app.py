import streamlit as st

# 이미지를 첨부하여 업로드하려면...
from PIL import Image # 파이썬 기본라이브러리는 바로 사용 가능!
import os


import streamlit as st
import cv2
import numpy as np

img_file_buffer = st.camera_input("Take a picture")

if img_file_buffer is not None:
    # To read image file buffer with OpenCV:
    bytes_data = img_file_buffer.getvalue()
    cv2_img = cv2.imdecode(np.frombuffer(bytes_data, np.uint8), cv2.IMREAD_COLOR)

    # Check the type of cv2_img:
    # Should output: <class 'numpy.ndarray'>
    st.write(type(cv2_img))

    # Check the shape of cv2_img:
    # Should output shape: (height, width, channels)
    st.write(cv2_img.shape)


    # 보통 사이드바/ 메뉴는 주제별로 서비스를 분류할 때 사용
    # 1) 드라마 좋아하는 목록
    # 2) 만화 좋아하는 목록
    # 3) 사진찍기


    # 1. 하나의 파일에 3개를 다 때려박아놓고 클릭할 때마다 해당 div만 보이게 하기
    # 2. 각 기능별로 별도 파일 혹은 폴더로 만들ㅇ러 놓고 클릭할 때마다 해당 파일에 들어가도록 하기.
    # 보통은 2번의 구조로 사용 -> 1_drama_app.py 2_manhwa_app.py 3. picture_app.py
    