import streamlit as st

from PIL import Image # 파이썬 기본라이브러리는 바로 사용 가능!
import os
def get_image(image_name):
    image_path = f"{os.path.dirname(os.path.abspath(__file__))}/{image_name}"
    image = Image.open(image_path) # 경로와 확장자 주의!
    st.image(image)

get_image("spam.png") # https://www.canva.com/

st.write(
    """
    # 코드 & 데이터
    * [Colab 노트북](https://colab.research.google.com/drive/1NCFy0W8pCcdHCOPZ-AKj09XA2w5c7SGw?usp=sharing)
    * 사용한 데이터 (spam.csv)
        * 출처 : https://www.kaggle.com/datasets/uciml/sms-spam-collection-dataset
    * 실행 결과 : <https://qus0in-streamlit-example-04-naive-bayesapp-z50aqp.streamlit.app/>
    """
)

import pandas as pd # 판다스 불러오기
data_url = "https://raw.githubusercontent.com/bigdata-young/bigdata_16th/main/data/spam.csv"
df = pd.read_csv(data_url) # URL로 CSV 불러오기

st.write(df) # 자동으로 표 그려줌
# st.table(df) # 이걸로 그려도 됨

st.write("# 모델 통해 예측해 보기")

with st.echo(code_location="below"):
    import joblib
    dir_path = f"{os.path.dirname(os.path.abspath(__file__))}"
    model_path = f"{dir_path}/model.pkl"
    model = joblib.load(model_path)
    st.write("* Naive Bayes 모델")
    cv_path = f"{dir_path}/cv.pkl"
    cv = joblib.load(cv_path)
    st.write("* CountVectorizer") # CountVectorizer도 pkl로 저장해서 쓰면 됩니다!
    st.write(cv.vocabulary_)

st.write("---")

# 입력값을 변수로 받아서 사용 가능!

with st.echo(code_location="below"):
    text = st.text_area('문자 (영어 Only)', value="Did you hear about the new \"Divorce Barbie\"? It comes with all of Ken's stuff!")

    # 실행 버튼
    play_button = st.button(
        label="예측", # 버튼 내부 표시되는 이름
    )

st.write("---") # 구분선

with st.echo(code_location="below"):
    from string import punctuation
    def remove_punc(txt):
        return "".join([t.lower() for t in txt if t not in punctuation])
    
    import nltk
    nltk.download('stopwords')
    from nltk.corpus import stopwords

    def remove_stop_words(text: str) -> str:
        new_word = []
        for word in text.split():
            if word not in stopwords.words('english'):
                new_word.append(word.lower())
        return " ".join(new_word)

    # 실행 버튼이 눌리면 모델을 불러와서 예측한다
    if play_button: 
        rm = remove_stop_words(remove_punc(text))
        st.write(rm)
        vector = cv.transform([rm])
        st.write(vector)
        pred = model.predict(vector)
        st.success("정상적으로 분석되었습니다!")
        st.write("## 분류")
        st.write(f"{'spam' if pred[0] == 1 else 'ham'}")


