library(ggplot2)
data()
class(diamonds) #tbl = table = tibble = data.frame

df <- read.csv("excel_exam.csv",header=T)
str(df) #obs = observations(관측치)

library(tibble) 
df <- as.tibble(df)
df #데이터형이 뭔지 따로 확인할 필요 없이 바로 보여줌

#지금까지 한 과정 : 데이터 전처리(pre processing), 정제

#정리, tidy data

#데이터 가공 : https://rpubs.com/jmhome/R_data_wrangling 참고
library(dplyr) #filter.select.arrange
arrange(head(filter(df,class==1),2),english)

df %>% filter(class==1) %>% head(2) %>% arrange(english)
# '%>%' : pipe

filter(df,class==1)
df %>% filter(class==2 | class==4) %>% filter(math>=60)

df %>% select(english,math) #순서에 따라 결과 달라짐

#1반 학생의 수학점수들
df %>% select(math, class) %>% filter(class==1)

df %>% arrange(desc(math,science))

#새로운 열 추가(mutate)
df %>% mutate(math+science+english)
df %>% mutate(total = math+science+english)
df %>% mutate(평균 = (math+science+english)/3)

#ifelse(조건,참일시 실행할 것, 거짓일시 실행할 것)
df %>% mutate( 'science test' = ifelse(science>=60,'pass','fail')) %>% head

#summarise => 통상적으로 group_by와 함께 쓰여짐
#반별 수학 평균
df$class <- as.factor(df$class) #범주화
df
str(df)

df1 = df %>% group_by(class) %>% summarise(mean_math=mean(math))
df1

ggplot(df1,aes(x=class,y=mean_math)) + geom_col()

df %>% group_by(class) %>% summarise(mean_math=mean(math)) %>% arrange(mean_math) %>% ggplot(aes(x=class,y=mean_math,fill=class)) + geom_col()

#빈도수=n(), 최고점=max()
df %>% group_by(class) %>% summarise(mean_math=mean(math),
                                     frequency=n(),
                                     max=max(math))

diamonds #dbl = 정수, ord = ordered factor(세분화된 범주)

diamonds %>% group_by(cut,color) %>% 
  summarise(평균가격=mean(price)) %>% 
  ggplot(aes(x=color,y=평균가격,fill=cut)) + geom_col(position='dodge')

#수학 열 찾기
df[,3]
df[,'math']
df$math

table(df$class)

ggplot(diamonds,aes(x=cut,y=price,color=clarity)) + geom_point()

#mpg + 라벨 + 테마 + x,y축 구간까지
#install.packages('ggthemes')
library(ggthemes)
ggplot(mpg,aes(x=displ,y=hwy,color=manufacturer)) + 
  geom_point(size=5) +
  labs(title = 'displ', x='배기량', y='고속도로') +
  theme_economist() +
  xlim(3,4) + ylim(20,30)
  
#color에 연속형, 범주형 변수 넣었을 때 차이
#범주형
ggplot(mpg,aes(x=displ,y=hwy,color=drv)) + 
  geom_point(size=2) +
  labs(title = 'displ', x='배기량', y='고속도로') +
  theme_economist()

#연속형
ggplot(mpg,aes(x=displ,y=hwy,color=cty)) + 
  geom_point(size=4) +
  labs(title = 'displ', x='배기량', y='고속도로') +
  theme_economist()

mpg
#범주형 목록 확인
mpg$drv
unique(mpg$drv)

mpg$trans
unique(mpg$trans)

#shape 바꾸기, geomsmooth(회귀분석), 
str(mpg)
p <- ggplot(mpg,aes(x=displ, y=hwy, color=drv, shape=drv))
p + 
  geom_point(size=3) + geom_smooth(method='lm') +
  facet_wrap(~drv)

#facet_wrap, facet_grid
str(mpg)
p <- ggplot(mpg,aes(x=displ, y=hwy, color=class, shape=class))
p + 
  geom_point(size=3) + geom_smooth(method='lm') +
  facet_wrap(~class)

p <- ggplot(mpg,aes(x=displ, y=hwy, color=class, shape=class))
p + 
  geom_point(size=3) + geom_smooth(method='lm') +
  facet_grid(~class)


#90%는 ggplot으로 가능, 나머지 10%의 세세한 포인트엔 많은 노력이 필요
#ex) 제목을 가운데로 옮기기, y축 글씨 회전시키기
#이번 강의 내에선 여기까지만!

#mtcars$cyl를 범주로 바꾼 뒤, 산점도 하나 그려보기(cyl 무조건 사용)
mtcars$cyl <- as.factor(mtcars$cyl)
str(mtcars)

ggplot(mtcars,aes(x=carb,y=disp,color=cyl,shape=cyl)) + 
  geom_point(size=3) +
  labs(title='carb~disp') +
  facet_grid(~cyl)
       
#geom cheat sheet 활용
#변수가 모두 연속적이여야 하는지, 하나는 이산적이고 하나는 연속적이여야 하는지의 유용한 정보도 나와있음!

ggplot(mtcars,aes(x=cyl,y=disp,color=cyl)) + geom_boxplot()

ggplot(mtcars,aes(x=cyl,y=disp,fill=cyl)) + geom_boxplot()

ggplot(mtcars,aes(x=cyl,y=disp,fill=cyl)) + geom_col()

ggplot(mtcars,aes(x=disp,y=cyl,fill=cyl)) + geom_dotplot()


ggplot(mtcars,aes(x=cyl,y=disp,fill=cyl)) + geom_violin()
ggplot(mtcars,aes(x=cyl,y=disp,fill=cyl)) + geom_jitter()
#violin,zitter 비슷한 맥락, 겹친 포인트 정도를 보여줌


#geom_density
mtcars <- as_tibble(mtcars)
mtcars

ggplot(data=mtcars,aes(x=qsec)) + geom_density()

ggplot(data=mtcars,aes(x=qsec)) + geom_area(stat='bin')



#특정 정보 바그래프로
#1차원
ggplot(mpg,aes(x=manufacturer,fill=manufacturer)) + geom_bar()

#2차원
mpg$manufacturer
table(mpg$manufacturer)
a <- as.data.frame(table(mpg$manufacturer))
a

mtcars
ggplot(a,aes(x=Var1,y=Freq,fill=Var1))+geom_col()

#그림은 똑같지만, 사용한 코드는 다르다는것 알아두기

#특수 경우로 ggplot(a,aes(x=Var1,y=Freq,fill=Var1))+geom_bar(stat=identity) 그리기도 가능 
#but 헷갈리기 떼문에 1차원은 geom_bar, 2차원은 geom_col로 외워두기!
       