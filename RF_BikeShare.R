# Thanks to https://www.kaggle.com/benhamner/bike-sharing-demand/random-forest-benchmark/code

library(ggplot2)
library(lubridate)
library(randomForest)

# Train a model across all the training data and plot the variable importance
rf <- randomForest(extractFeatures(train), train$count, ntree=100, importance=TRUE)
imp <- importance(rf, type=1)
featureImportance <- data.frame(Feature=row.names(imp), Importance=imp[,1])

p <- ggplot(featureImportance, aes(x=reorder(Feature, Importance), y=Importance)) +
  geom_bar(stat="identity", fill="#53cfff") +
  coord_flip() + 
  theme_light(base_size=20) +
  xlab("Importance") +
  ylab("") + 
  ggtitle("Random Forest Feature Importance\n") +
  theme(plot.title=element_text(size=18))

ggsave("2_feature_importance.png", p)


set.seed(1)

train <- read.csv("../input/train.csv")
test <- read.csv("../input/test.csv")

library(randomForest)

extractFeatures <- function(data) {
  features <- c("season",
                "holiday",
                "workingday",
                "weather",
                "temp",
                "atemp",
                "humidity",
                "windspeed",
                "hour")
  data$hour <- hour(ymd_hms(data$datetime))
  return(data[,features])
}

trainFea <- extractFeatures(train)
testFea  <- extractFeatures(test)