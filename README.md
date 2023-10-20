# SARIMA모형을 활용한 수두 발생 예측
2020년 2학기 시계열해석 과목을 수강하며 진행한 개인 프로젝트입니다.


## 💁🏻 프로젝트 요약

- 기간: ‘20.10. ~ ‘20.12. (2개월)
- 언어: SAS(90%), R(10%)
- 알고리즘 : SARIMA
- 활용한 데이터
    - 기관: 질병관리청
    - 출처: 질병관리청> 감염병포털([https://www.kdca.go.kr/npt/biz/npp/nppMain.do](https://www.kdca.go.kr/npt/biz/npp/nppMain.do))
    - 기간: 2006.01 ~ 2020.11 (총 179달)
    - 구분: `전수감시감염병`>감염병명> 2급> 수두> 발생 수,
            `환자분류`> 전체
- 주요 내용
    - 분포에 근거해 Holt-winters 승법계절지수 평활법 적합했으나 평활상수, 과적합, 예측 오차 랜덤성에서 문제 발생
    - 로그 변환, 시차 차분, 계절 차분으로 SARIMA 후보 모형 4개 선정
- 주요 결과 및 배운점
    - SARIMA(0,1,1)(0,1,2)12 모형 구축으로 코로나 19이후 수두 발생 건수 예측값 추정
    - 처음부터 올바르게 문제를 정의하는 것의 중요성 학습 및 새로운 발견은 이론적 지식에 기반함을 깨달음
      



## 목차
<img width="416" alt="image" src="https://github.com/min02yam/Prediction-of-Chickenpox-Incidence-Using-SARIMA-Model/assets/93497667/05fbf2e2-a1b2-4b7d-8add-2545d9953904">
(보고서 일부 발췌)
<img width="459" alt="image" src="https://github.com/min02yam/Prediction-of-Chickenpox-Incidence-Using-SARIMA-Model/assets/93497667/337242fb-1b1b-4809-a9be-e37c70a8938d">

- 제 1 장 서론
  - 제1절	분석 필요성
  - 제2절	자료 설명 및 특징
  - 제3절	예상결과 

- 제 2 장 본론
  - 제1절	모형계획
    - Ⅰ. Winters의 승법계절지수평활법
    - Ⅱ. ARIMA 모형 적합
      - 1.	모형 탐색
      - 2.	모형 비교
  - 제 2절 최종 모형 적합 및 예측값 추정


- 제 3 장 결론
