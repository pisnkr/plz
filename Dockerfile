# Python 이미지를 기반으로 Docker 이미지를 생성합니다.
FROM python:3.10

# 작업 디렉토리 설정

# 파이썬에서 콘솔 출력이 느릴 경우 다음과 같이 환경 변수를 설정해준다.
ENV PYTHONUNBUFFERED=0

# 따라서 파이썬 기본 인코딩을 한국어를 사용할 수 있는 utf-8으로 설정한다.
ENV PYTHONIOENCODING=utf-8

# apt 업그레이트 및 업데이트
RUN apt-get -y update && apt-get -y dist-upgrade

# apt-utils dialog : 우분투 초기 설정 / libpq-dev : PostgreSQL 의존성
RUN apt-get install -y apt-utils dialog wait-for-it libmariadb-dev-compat libmariadb-dev
# pip dev 설치
RUN apt-get install -y python3-pip python3-dev


RUN mkdir /config
ADD /config/requirements.txt /config/

# requirements.txt에 있는 파이썬 패키지 설치
RUN pip3 install -r /config/requirements.txt


### 작업 디렉토리 ###
# Django 소스코드가 들어갈 폴더 생성
RUN mkdir /coin;

# 작업 디렉토리 src로 변경
WORKDIR /coin