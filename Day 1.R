library(ggplot2)
diamonds
#자동완성은 꼭 사용하기 (오타방지)
ggplot(data=diamonds,aes(x=carat,y=price,color=color)) + 
  geom_point()

## working directory
getwd()

print("Hello") #interpreter 언어, 기계어로 만드는 '컴파일' 과정 생략, 속도는 느림

#?seq => 단축키 : 함수 아무데나 커서 두고 fn + f1키(제일 간단)

a <- 2
b <- 3
a+b

#a=2,b=3 -> 할당연산자, 배려차원에서의 표시
#등호 -> '=='

#factor : 범주형(category)
d <- factor(c('A','B'))
class(d)

#chart = table = dataFrame, 벡터는 1차원 데이터프레임은 2차원

CRUD
Create
Read
Update
Delete

#R에서 처음 배우는 함수 c()
a <- c(2,3,4)
#변수 a : 장독, 단지

a
length(a)

#접근 : 시작하는 번호는 1부터 (다른 프로그래밍은 모두 0부터 시작)
a[2]
a[1]

#수정(덮어쓰기)
a[2] <- 13
a

a <- matrix(c(1,2,3,4,5,6),nrow=3,ncol=2)
a

#matrix help 검색 후 example 복사한 것 (다른 것들도 하다가 모르면 이렇게 복사해 실행해보면 이해가 쉽다!)
mdat <- matrix(c(1,2,3, 11,12,13), nrow = 2, ncol = 3, byrow = TRUE,
               dimnames = list(c("row1", "row2"),
                               c("C.1", "C.2", "C.3")))
mdat

matrix(c(1,2,3,4),ncol=2,nrow=2,byrow=TRUE)

mat <- matrix(c(1:12),nrow=3,ncol=4,byrow=TRUE,dimnames=list(c("국어","영어","수학"),c("a1","a2","a3","a4")))
mat

mat[2,]
mat[,3]
mat[-2,]
mat[c(1,3),]

mat["국어",]
mat[c(1,2),c(3,4)]
sum(mat[c(1,2),c(3,4)])

df <- data.frame(mat)
class(df)

rownames(df)
colnames(df)
names(df)

df[,-4]
df[,1:3]

getwd()

#csv 불러오기(txt는 매우 복잡, 쓰지 않는게 좋다)
df <- read.csv("excel_exam.csv",header=T)
df <- df[1:10,3:5]
df

#원본 데이터 편집 후 새로운 csv 파일로 작성
write.csv(df,file="Edit1_excel_exam.csv")
read.csv("Edit1_excel_exam.csv")

#엑셀 불러오기
library(readxl)
df2 <- read_excel("excel_exam.xlsx")




