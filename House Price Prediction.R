library(tidyverse)
library(magrittr)
library(rsample)
library(broom)
library(modelr)
library(GGally)
library(ggplot2)
library(car)
library(lindia)
library(MLmetrics)

#Import data set
df <- read_csv("C:/Users/Dell/Desktop/My Projects/Houses.csv")

###### Data Wrangling
house <- as_tibble(df)
str(house)

#Checking whether there are any missing value exists.
anyNA(house)

house$city <- as.factor(house$city)
house$floor <- as.factor(house$floor)

# Splitting Training (70%) and testing set(30%)
# Used SRS ; rsample package to split the data
set.seed(2022)
house_split <- initial_split(house, prop = 0.7)
house_train <- training(house_split)
house_test <- testing(house_split)

# Handling outliers for "sq"
summary(house_train)
house_train %>% ggplot(aes(x = sq)) + geom_dotplot()
# There is unusul outlier exists in variables "sq". 
# It is replaced with the median value

# This code have to run untill there are no outliers exists
house_train$sq[which.max(house_train$sq)] <- median(house_train$sq)
head(house_train)

house_train %>% ggplot(aes(x = sq)) + geom_dotplot()

# Handling outliers for "latitude"
house_train %>% ggplot(aes(x = latitude)) + geom_dotplot()

# Handling outliers for "longitude"
house_train %>% ggplot(aes(x = longitude)) + geom_dotplot()

# Handling outliers for "price"
house_train %>% ggplot(aes(x = price)) + geom_dotplot()

# Handling categorical variables

# Reshaping Year variable in to quantitative variable
df2_train <- subset(house_train,((house_train$year > 1000) & (house_train$year < 2023)))
df3_train <- df2_train %>% mutate(age = 2022 - year)


df2_test <- subset(house_test,((house_test$year > 1000) & (house_test$year < 2023)))
df3_test <- df2_test %>% mutate(age = 2022 - year)

df3_train %>% filter(floor == "0") %>% ggplot(aes(x=price)) + geom_histogram() 
df3_train %>% filter(floor == "10") %>% ggplot(aes(x=price)) + geom_histogram() 

df3_train %>% ggplot(aes(x=price, col = floor, fill = floor)) + 
  geom_density(alpha = 0.2)
# There are no effect to the price when it is comes to the floor

#df3_train$floor <- as.factor(df3_train$floor)
#df3_test$floor <- as.factor(df3_test$floor)

df4_train <- df3_train %>% select(city,latitude,longitude,price,rooms,sq,age)
df4_test <- df3_test %>% select(city,latitude,longitude,price,rooms,sq,age)

# Exploratory Data Analysis
#df4_train %>% filter(city == "Poznañ") %>% 
  #ggplot(aes(x = price)) + 
#geom_boxplot()

df4_train %>% select(latitude,longitude,price,rooms,sq,age) %>% ggpairs()

df4_train %>% ggplot(aes(x=price, y= latitude, col = city)) + geom_point()+
  facet_grid(~city)
 
# Model Fitting - Multiple linear regression Model
model_1 <- lm(price ~ latitude +longitude + rooms + sq + age + city , data = df4_train)
model_1 %>% tidy()

model_1_fitresd <- augment(model_1)
model_1_fitresd

# H0: Errors are normlly distributed Vs H1 : Errors are not normally distributed
ggplot(model_1_fitresd, aes(sample = .resid)) + stat_qq() + stat_qq_line()

#Testing Multicolinerity
vif(model_1)
# There is no mulicolinerity exists.(VIF < 10)

# Defecting influential cases
gg_cooksd(model_1)
# Data point 4725 above massively influences model outcomes, 
#thus increasing Type I errors.
# Weight regression have to use rather than dropping

# Predictions

Prdict_test <- df4_test %>% add_predictions(model_1)

######
#Prdict_test$pred <- predict(model_1, df4_test)

hist(Prdict_test$pred)


RMSE(y_pred = Prdict_test$pred, y_true = df4_test$price)

# The RMSE result quit small, it’s mean the model has enough good to predict.

################ END #####################################

