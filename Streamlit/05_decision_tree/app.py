import streamlit as st

from PIL import Image # 파이썬 기본라이브러리는 바로 사용 가능!
import os
def get_image(image_name):
    image_path = f"{os.path.dirname(os.path.abspath(__file__))}/{image_name}"
    image = Image.open(image_path) # 경로와 확장자 주의!
    st.image(image)

get_image("salary.png") # https://www.canva.com/

st.write(
    """
    # 코드 & 데이터
    * [Colab 노트북](https://colab.research.google.com/drive/1QtzUzGmNxPJtUANkm7aQkD7j7WtdmqdE?usp=sharing)
    * 사용한 데이터 (salary.csv)
        * 출처 : https://www.kaggle.com/datasets/ayessa/salary-prediction-classification
    * 실행 결과 : <https://qus0in-streamlit-example-05-decision-treeapp-g6z906.streamlit.app/>
    """
)

import pandas as pd # 판다스 불러오기
data_url = "https://raw.githubusercontent.com/bigdata-young/bigdata_16th/main/data/salary.csv"
df = pd.read_csv(data_url) # URL로 CSV 불러오기

st.write(df) # 자동으로 표 그려줌
# st.table(df) # 이걸로 그려도 됨

st.write("# 모델 통해 예측해 보기")

with st.echo(code_location="below"):
    import joblib
    dir_path = f"{os.path.dirname(os.path.abspath(__file__))}"
    model_path = f"{dir_path}/model.pkl"
    model = joblib.load(model_path)
    st.write("* Decision Tree 모델")

    import graphviz as graphviz
    from sklearn import tree
    plot_tree  = tree.export_graphviz(model, out_file=None, max_depth=3)
    st.graphviz_chart(plot_tree)

st.write("---")

# 입력값을 변수로 받아서 사용 가능!

with st.echo(code_location="below"):
    # TODO: 다른 예시들을 활용하여 input을 직접 구성해보세요!

    # 실행 버튼
    play_button = st.button(
        label="예측", # 버튼 내부 표시되는 이름
    )

st.write("---") # 구분선

with st.echo(code_location="below"):
    # 실행 버튼이 눌리면 모델을 불러와서 예측한다
    if play_button: 
        input_values = [

        ]
        # pred = model.predict(input_values)
        # st.success("정상적으로 분석되었습니다!")
        # st.write("## 분류")
        # st.write(f"{'5만 달러 초과' if pred[0] == 1 else '5만 달러 이하'}")
