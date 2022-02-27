#descriptive(기술적 데이터 분석) => 그림 그려보기
cars
head(cars)
plot(cars)

#linear model(y~x)
fit <- lm(dist~speed,data=cars)
fit
summary(fit) #p-value <0.05, (adjusted) R^2>=0.6 이상이면 믿을만한 식
