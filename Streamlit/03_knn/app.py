import streamlit as st

from PIL import Image # 파이썬 기본라이브러리는 바로 사용 가능!
import os
def get_image(image_name):
    image_path = f"{os.path.dirname(os.path.abspath(__file__))}/{image_name}"
    image = Image.open(image_path) # 경로와 확장자 주의!
    st.image(image)

get_image("wine.png") # https://www.canva.com/

st.write(
    """
    # 코드 & 데이터
    * [Colab 노트북](https://colab.research.google.com/drive/1p5AZ6-a_W8Hmuxd0qtv2s-LQGHNlLn1J?usp=sharing)
    * 사용한 데이터 (wine.csv)
        * 출처 : https://www.kaggle.com/datasets/akhil0007/wine-data
    * 실행 결과 : <https://qus0in-streamlit-example-03-knnapp-9lgbwh.streamlit.app/>
    """
)

import pandas as pd # 판다스 불러오기
data_url = "https://raw.githubusercontent.com/bigdata-young/bigdata_16th/main/data/wine.csv"
df = pd.read_csv(data_url) # URL로 CSV 불러오기

st.write(df) # 자동으로 표 그려줌
# st.table(df) # 이걸로 그려도 됨

st.write("# 모델 통해 예측해 보기")

with st.echo(code_location="below"):
    import joblib
    dir_path = f"{os.path.dirname(os.path.abspath(__file__))}"
    model_path = f"{dir_path}/model.pkl"
    model = joblib.load(model_path)
    st.write("* KNN 모델")
    scaler_path = f"{dir_path}/scaler.pkl"
    scaler = joblib.load(scaler_path)
    st.write("* MinMax 스케일러") # 스케일러도 pkl로 저장해서 쓰면 됩니다!

st.write("---")

# 입력값을 변수로 받아서 사용 가능!

with st.echo(code_location="below"):
    def get_float_input(label, default=0):
        return st.number_input(
            label=label, min_value=0.0, step=0.001, value=float(default)
        )

    alcohol = get_float_input('Alcohol', 14.13)
    malic_acid = get_float_input('Malic_Acid', 4.1)
    ash = get_float_input('Ash', 2.74)
    ash_alcanity = get_float_input('Ash_Alcanity', 24.5)
    magnesium = get_float_input('Magnesium', 96)
    total_phenols = get_float_input('Total_Phenols', 2.05)
    flavanoids = get_float_input('Flavanoids', 0.76)
    nonflavanoid_phenols = get_float_input('Nonflavanoid_Phenols', 0.56)
    proanthocyanins = get_float_input('Proanthocyanins', 1.35)
    color_intensity = get_float_input('Color_Intensity', 9.2)
    hue = get_float_input('Hue', 0.61)
    od280 = get_float_input('OD280', 1.6)
    proline = get_float_input('Proline', 560)

    # 실행 버튼
    play_button = st.button(
        label="예측", # 버튼 내부 표시되는 이름
    )


st.write("---") # 구분선

with st.echo(code_location="below"):
    # 실행 버튼이 눌리면 모델을 불러와서 예측한다
    if play_button:
        input_values = [[
            alcohol, malic_acid, ash, ash_alcanity, magnesium,
            total_phenols, flavanoids, nonflavanoid_phenols, proanthocyanins, color_intensity,
            hue, od280, proline
        ]]
        pred = model.predict(scaler.transform(input_values))
        st.success("정상적으로 분석되었습니다!")
        st.write("## 분류")
        st.write(f"{pred[0]}등급")


