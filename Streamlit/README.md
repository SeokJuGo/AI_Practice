# 1. Streamlit이란?
[app · Streamlit.pdf](https://github.com/SeokJuGo/Learn-Study/files/10496891/app.Streamlit.pdf)
파이썬 라이브러리 중 하
나로 딥러닝 모델이나 데이터 시각화를 쉽게 구현하고 웹서비스로 만들고 싶을 때 이용한다.

 공식사이트

[https://streamlit.io/](https://streamlit.io/)

- 장점
  
  - 짧은 코드로 애플리케이션을 개발 용이
  - 학습곡선이 짧다.
  - OpenCV, Vega-Lite, seaborn, PyTorch, NumPy, Altair 등과 같은 여러 주요 라이브러리 및 프레임워크와 호환

# 2. 가상환경 Virtual Environments

## 1. 가상환경(Virtual Environments)이란?

![image](https://user-images.githubusercontent.com/116260619/214497651-f3ae5414-4129-42a6-8fbb-03369dcb07a8.png)

- **자신이 원하는 Python 환경을 구축하기 위해 필요한 모듈만 담아 놓는 바구니.**
- 각 가상환경(virtualenv1, 2, 3…)은 독립적으로 관리
- 각 모듈은 다른 모듈에 대한 의존성(dependency)이 다르기 때문에 마구잡이로 설치하다보면 충돌이 나는 경우가 많음.
- 가상 환경은 패키지가 시스템 전체에 설치되는 것이 아니라, 특정 응용 프로그램에 사용되도록 설치될 수 있도록 하는 반격리된 파이썬 환경

## 2. 가상환경 설치하기

```bash
$ conda deactivate
$ conda create --name playdata python=3.9
$ pip install --upgrade pywin32==225

$ conda activate playdata 
$ conda install ipykernel
$ python -m ipykernel install --user --name playdata --display-name "Playdata"
$ jupyter notebook

조금 더 전문적인 환경을 사용하고 싶을 때는 
$ conda install -c conda-forge jupyterlab
$ jupyter lab

이후 해당 가상환경을 실행할 때는
$ conda activate playdata

다른 가상환경에 접속할 때는
$ conda deactivate

가상환경을 삭제할 때는
$ conda remove --name playdata --all
```

## 3. 가상환경 설치 확인

- 🪜 **과정**
  
  명령 프롬프트 → 명령어 입력 :
  
  ```bash
  conda env list
  ```
  

## 4. 가상환경째로 배포시

```bash
가상환경 추출

    $ conda env export --name 가상환경명 > environment.yml

추출한 가상환경으로 새로운 가상환경 생성

    $ conda env create -f ./environment.yml
```

## 5. 설치한 패키지들을 다른 환경에서 사용할 수 있게 하려면

- requirements.txt 파일에 설치할 패키지 리스트를 정의한 후, 전체 목록을 한꺼번에 설치할 수 있습니다.
- "pip install 패키지명" 을 사용하여 패키지를 하나 하나 설치하지 않고, requirements.txt를 만들어 패키지 리스트
  를 파일로 관리하고 이 파일을 통해 pip 설치를 수행하면 좀 더 쉽게 패키지를 관리할 수 있습니다.
