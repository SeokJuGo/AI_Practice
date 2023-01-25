import streamlit as st

from PIL import Image # 파이썬 기본라이브러리는 바로 사용 가능!
import os
def get_image(image_name):
    image_path = f"{os.path.dirname(os.path.abspath(__file__))}/{image_name}"
    image = Image.open(image_path) # 경로와 확장자 주의!
    st.image(image)

get_image("insurance.png") # https://www.canva.com/

st.write(
    """
    # 코드 & 데이터
    * [Colab 노트북](https://colab.research.google.com/drive/14QXhTVyMeo9vE6rEk2Q8cmcybsMgtV4k?usp=sharing)
    * 사용한 데이터 (insurance.csv)
        * 출처 : https://www.kaggle.com/datasets/awaiskaggler/insurance-csv
    * 실행 결과 : <https://qus0in-streamlit-example-01-linear-regressionapp-bnlrbe.streamlit.app/>
    """
)

import pandas as pd # 판다스 불러오기
data_url = "https://raw.githubusercontent.com/bigdata-young/bigdata_16th/main/data/insurance.csv"
df = pd.read_csv(data_url) # URL로 CSV 불러오기

st.write(df) # 자동으로 표 그려줌
# st.table(df) # 이걸로 그려도 됨

st.write("# 모델 통해 예측해 보기")

with st.echo(code_location="below"):
    import joblib
    model_path = f"{os.path.dirname(os.path.abspath(__file__))}/model.pkl"
    model = joblib.load(model_path)
    st.write("## 선형 회귀 모델")
    st.write(pd.Series(model.coef_, index=["age", "bmi", "children", "smoker", "sex_male", "region_northwest", "region_northeast", "region_southwest"]))

st.write("---")

# 입력값을 변수로 받아서 사용 가능!

with st.echo(code_location="below"):
    # 나이 입력 (숫자)
    age = st.number_input(
        label="나이", # 상단 표시되는 이름
        min_value=1, # 최솟값
        max_value=99, # 최댓값
        step=1, # 입력 단위
        # value=30 # 기본값
    )

with st.echo(code_location="below"):
    # 성별 입력 (라디오 버튼)
    sex = st.radio(
        label="성별", # 상단 표시되는 이름
        options=["남성", "여성"], # 선택 옵션
        # index=0 # 기본 선택 인덱스
        # horizontal=True # 가로 표시 여부
    )

with st.echo(code_location="below"):
    # bmi 입력 (숫자)
    bmi = st.number_input(
        label="BMI", # 상단 표시되는 이름
        min_value=0.0, # 최솟값
        max_value=100.0, # 최댓값
        step=0.1, # 입력 단위
        # value=25.0 # 기본값
    )

with st.echo(code_location="below"):
    # 자녀 수 입력 (숫자)
    children = st.number_input(
        label="자녀수", # 상단 표시되는 이름
        min_value=0, # 최솟값
        max_value=99, # 최댓값
        step=1, # 입력 단위
        # value=2 # 기본값
    )

with st.echo(code_location="below"):
    # 흡연 여부 입력 (Bool)
    st.write("흡연 여부")
    smoker = st.checkbox(
        label="", # 상단 표시되는 이름
        # value=True # 기본값
    )

with st.echo(code_location="below"):
    # 지역 입력 (Select Box)
    region = st.selectbox(
        label="지역", # 상단 표시되는 이름
        options=["북동", "북서", "남동", "남서"] # 선택 가능한 옵션들
        # index=2 # 기본 선택 인덱스
    )

with st.echo(code_location="below"):
    # 실행 버튼
    play_button = st.button(
        label="예측", # 버튼 내부 표시되는 이름
    )

st.write("---") # 구분선

with st.echo(code_location="below"):
    # 실행 버튼이 눌리면 모델을 불러와서 예측한다
    if play_button:
        st.balloons() # 풍선 애니메이션 표시
        input_values = [[age, bmi, children, smoker, sex == "남성", region == "북서", region == "북동", region == "남서" ]]
        pred = model.predict(input_values)
        # st.write(pred[0])
        st.metric(label="예측값", value = pred[0]) # 숫자를 좀 더 멋지게 표시해줌


