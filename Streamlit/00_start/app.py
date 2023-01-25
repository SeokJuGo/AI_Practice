import streamlit as st

st.title("멀티페이지 웹 앱")

# 숫자로 시작하는 파일은 일반 문자가 나올 때까지 숫자와 구분자 삭제(다만 숫자만 있는 파일 이름에서는 숫자 삭제 안 함)
# 구분자로 시작하는 파일 이름에서는 일반 숫자가 나올 때까지 구분자 삭제
# 일반 문자 사이에 있는 구분가는 하나의 공백으로 처리

st.subheader("사이드바에서 페이지를 선택하세요.")
st.subheader("- drama_app: 좋아하는 드라마 목록") 
st.subheader("- Manhwa_app: 좋아하는 만화 목록")
st.subheader("- picture_app: 사진찍기") 
# st.markdown(     """     <style>
#     [data-testid="stSidebar"][aria-expanded="true"] > div:first-child{width:250px;}</style>
#     """, unsafe_allow_html=True )