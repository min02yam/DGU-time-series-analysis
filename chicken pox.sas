data a;
infile "/folders/myfolders/sasuser.v94/20062020.txt" dlm='	';
input z @@;
date=intnx('month', '1jan06'd, _n_-1);
format date monyy.;
run;


proc sgplot;
ods graphics on / width=15in height=3in;
series x=date y=z/ legendlabel="series";
scatter x=date y=z/ legendlabel="actual";
refline '1jan06'd/axis=x; refline '1jan07'd/axis=x; refline '1jan08'd/axis=x; 
refline '1jan09'd/axis=x; refline '1jan10'd/axis=x; refline '1jan11'd/axis=x; 
refline '1jan12'd/axis=x; refline '1jan13'd/axis=x; refline '1jan14'd/axis=x; 
refline '1jan15'd/axis=x; refline '1jan16'd/axis=x; refline '1jan17'd/axis=x; 
refline '1jan18'd/axis=x; refline '1jan19'd/axis=x; refline '1jan20'd/axis=x; 

yaxis label="chicken pox";
xaxis label="month";
run;

proc arima data=a;
  identify var=z nlag=24;
  run;
  
  /**/
  /*화이트노이즈에대한 오토코릴레이션이 모두 유의하기때문에 에모형 적합 필요성,  
  /*z에대한 시계열: 주기성을 을가지고 점점 우상향하다가 어떤 지점에서 뚝 떨어짐  -> 비정상 자료임이 유력
시간이 지날수록 평균 증가,  분산도 커지다가 작아짐*acf와 pacf가 가지수적인 감소 모양 아님 비정상 시계열임*/
/*acf를 보면 6을 주기로 값이 크다 계절조정이 필요해 해보인다*/
  
/*로그변환*/
data b;
set a;
logz=log(z);
run;


proc arima data=b;
  identify var=logz nlag=24;
  run;
  /*점점 올라가는 추세가 가보이므로 1시차 차분한다*/
  
  
/*1시차 차차분*/
proc arima data=b;
 identify var=logz(1);
  run;
/*acf, pacf로 보아 비정상 상시계열임*/
proc arima data=b;
identify var=logz(1,12);
run;
/*acf 1시차에서 cut off ,pacf 1시차에서 cutt off 혹은 지수적 감소 mean이 0에 가까움을 확인*/


proc arima data=b;
   identify var=logz(1,12);
	estimate p=(1)(12) method=ml noint outstat=out1;
	estimate p=(1) q=(12) method=ml noint outstat=out2;
	estimate p=(12) q=(1) method=ml noint outstat=out3;
	estimate q=(1)(12) method=ml noint outstat=out4;

	

/*잔차분석을 뽰을 떄, 4번째 8번째가 화이트노이즈 측면에서 제일 적합 해 보이다 */

data totalout;
set out1-out4;
where _STAT_="AIC";
run;
/*my model SARIMA(0,1,1)(0,1,1)12*/



proc arima data=b;
   identify var=logz(1,12);
	
	estimate q=(1)(12) method=ml noint outstat=out4;
	estimate q=(1,2)(12) method=ml noint outstat=out5;   /*SARIMA(0,1,1)(0,1,1)12*/
	estimate p=(1) q=(1)(12) method=ml noint outstat=out6; /*SARIMA(1,1,0)(0,1,1)12*/
run;

data totalout2;
set out4-out6;
where _STAT_="AIC";
run;


/*my model SARIMA(0,1,2)(0,1,2)12*/
/*my model SARIMA(1,1,1)(0,1,2)12*/
/*과대적합 비교하니 잘 적합됐음을 알 수 있음

/*final model SARIMA(0,1,1)(0,1,212*/
proc arima data=b;
   identify var=logz(1,12);
   estimate q=(1)(12) noint method=ml;
   forecast id=date  interval=month lead=15 out=outf;
run;


data c;
   set outf;
   
   x        = exp( logz );
   forecast = exp( forecast + std*std/2 );
   l95      = exp( l95 );
   u95      = exp( u95 );
run;

/*구간추정그림*/
proc sgplot data=c;
ods graphics on / width=15in height=3in;
   where date >= '1jan13'd;
   band Upper=u95 Lower=l95 x=date
      / LegendLabel="95% Confidence Limits";
   scatter x=date y=x;
   series x=date y=forecast;
run;


proc sgplot data=c;
ods graphics on / width=15in height=3in;
   where date >= '1jan19'd;
   band Upper=u95 Lower=l95 x=date
      / LegendLabel="95% Confidence Limits";
   scatter x=date y=x;
   series x=date y=forecast;
run;
