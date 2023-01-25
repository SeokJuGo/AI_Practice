import streamlit as st
import pandas as pd
import matplotlib.pyplot as plt

import matplotlib
matplotlib.rcParams['font.family'] = 'Malgun Gothic' 
matplotlib.rcParams['axes.unicode_minus'] = False
folder = './data/' 
file = folder + '공장별_생산현황.csv'
df1 = pd.read_csv(file, index_col='year') 
file = folder + '영업팀별_판매현황.xlsx'
df2 = pd.read_excel(file, index_col='월') 
st.title("스트림릿에서 차트 그리기")
ax = df1.plot(grid=True, figsize=(15,5))
ax.legend(['공장 A', '공장 B', '공장 C'], fontsize=10) 
ax.set_title("공장별 생산 현황", fontsize=20)
ax.set_xlabel("연도", fontsize=15) 
ax.set_ylabel("생산량", fontsize=15) 
fig1 = ax.get_figure()
st.subheader("꺾은선형 차트: Matplotlib과 st.pyplot(fig) 이용") 
st.pyplot(fig1) 
ax = df2.plot.bar(grid=True, rot=0,  figsize=(15,5)) 
ax.set_title("영업팀별 판매현황", fontsize=20)
ax.set_xlabel("월", fontsize=15)
ax.set_ylabel("판매현황", fontsize=15) 
fig2 = ax.get_figure()
st.subheader("세로 막대형 차트: Matplotlib과 st.pyplot(fig) 이용") 
st.pyplot(fig2) 
