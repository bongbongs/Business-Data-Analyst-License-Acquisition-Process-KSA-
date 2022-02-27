df <- read.csv("excel_exam.csv",header=T)
df[,c('math','english','science')]

library(dplyr) #filter, select, mutate, arrange, summarise
#열 추출
df %>% select(math,english,science) #combine도, ''도 필요없음

#행 추출
df %>% filter(class==2 | class==4)

#정렬
df %>% arrange(math)
df %>% arrange(desc(math))

library(ggplot2)
ggplot(data=df,aes(x=class,y=math,fill=class)) + geom_col()

df$class <- as.factor(df$class)
ggplot(data=df,aes(x=class,y=math,fill=class)) + geom_col()

library(tibble)
summary(df)
df <- as.tibble(df)
df

df %>% group_by(class) %>% summarise(mean_math=mean(math),
                                     frequency=n(),
                                     max_math=max(math))
#연습문제
#1.displ 4이상, 5이하인 것들의 hwy 평균 비교하기

mpg
df1 <- mpg %>% filter(displ<=4) %>% summarise(mean_hwy=mean(hwy))
df1

df2 <- mpg %>% filter(displ>=5) %>% summarise(mean_hwy=mean(hwy))
df2

mpg

#2.audi,ford 자동차 중 cty가 평균적으로 더 높은 쪽은 ?
mpg %>% filter(manufacturer == 'audi') %>% summarise(mean(cty))
mpg %>% filter(manufacturer == 'ford') %>% summarise(mean(cty))

mpg %>% filter(manufacturer == 'audi' | manufacturer == 'ford') %>% group_by(manufacturer) %>%  summarise(mean_cty=mean(cty))

#3.연비 변수가 hwy,cty 두 종류로 분리되어 있다. 두 변수를 각각 활용하는 대신 하나로 통합하여 평균연비(total) 변수를 만들고, total이 높은 자동차 모델 상위 6개를 조사하라

df2 <- mpg %>% mutate(total=(hwy+cty)/2) %>% arrange(desc(total)) %>% select(model,total) %>% head()

#4. class,cty 2가지 변수만으로 mpg_new라는 데이터 만들기
mpg_new <- mpg %>% select(class,cty)
mpg_new

#5 class가 suv와 compact인 자동차 중 어느 자동차의 cty가 더 높은지 알아보기
mpg_new %>% group_by(class) %>% summarise(mean(cty)) %>% filter(class=='suv'|class=='compact')

#6. compact(경차) 차종을 가장 많이 생산하는 회사는 ?(각 회사별 compact 차종 수를 내림차순으로 정렬)
mpg %>% group_by(manufacturer,class) %>% summarise(freq=n()) %>% filter(class=='compact') %>% arrange(desc(freq))

#ggplot 복습
a <- table(mpg$manufacturer)
class(a)
df <- data.frame(a)
df

#열 이름 바꾸는법(Var1)
df <- rename(df, Manufacturer=Var1)
df
library(ggthemes)
ggplot(data=df,aes(x=Manufacturer,y=Freq,fill=Manufacturer)) + geom_col() + theme_classic()

#시계열(time-series)자료
economics
ggplot(data=economics,aes(x=date,y=unemploy)) + geom_line(linetype='dotted',color='red')

ggplot(data=economics,aes(x=date,y=unemploy/pop)) + geom_line(linetype='dotted',color='red') #없는 열 바로 계산해서 그리기도 가능

economics %>% ggplot(aes(x=date,y=pce)) + geom_line(linety)
