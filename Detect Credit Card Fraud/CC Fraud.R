library(ranger)
library(caret)
library(data.table)
creditcard_data <- read.csv("/Users/espst/Documents/RProjects/Detect Credit Card Fraud/creditcard.csv")

# 2.  DATA EXPLORATION
dim(creditcard_data)

head(creditcard_data,6)

tail(creditcard_data,6)

table?creditcard_data$Class)
summary(creditcard_data$Amount)
names(creditcard_data)
var(creditcard_data$Amount)
sd(creditcard_data$Amount)


# 3.  DATA MANIPULATION
# we will scale our data using the scale() function. We will apply 
# this to the amount componen? of our creditcard_data amount. With 
# the help of scaling, the data is structured according to a 
# specified range. Therefore, there are no extreme values in our 
# dataset that might interfere with the functioning of our model. 
head(creditcard_data)

?reditcard_data$Amount=scale(creditcard_data$Amount)

NewData = creditcard_data[,-c(1)]
head(NewData)


# 4.  DATA MODELING
# After we have standardized our entire dataset, we will split our 
# dataset into training set as well as test set with a split rati?
# of 0.80. This means that 80% of our data will be attributed to 
# the train_data whereas 20% will be attributed to the test data. 
# We will then find the dimensions using the dim() function

library(caTools)

set.seed(123)

data_sample = sample.split(N?wData$Class,SplitRatio = 0.80)
train_data = subset(NewData,data_sample==TRUE)
test_data = subset(NewData,data_sample==FALSE)

dim(train_data)
dim(test_data)


# 5.  FITTING LOGISTIC REGRESSION MODEL
# We will begin with logistic regression model. A logisti? regression
# is used for modeling the outcome probability of a class such as 
# pass/fail, positive/negative and in our case - fraud/not fraud. 

Logistic_Model = glm(Class~., test_data, family = binomial())
summary(Logistic_Model)

# Visualize through fo?lowing plots

plot(Logistic_Model)

# In order to assess the performance of our model, we will delineate the ROC curve. 

library(pROC)

lr.predict <- predict(Logistic_Model, train_data, probability = TRUE )
auc.gbm = roc(train_data$Class, lr.predict, plot?= TRUE, col = "blue")


# 6.  FITTING A DECISION TREE MODEL
# In this section, we will implement a decision tree algorithm. Decision Trees to plot the 
# outcomes of a decision. These outcomes are basically a consequence through which we can 
# conclude as?to what class the object belongs to. We will now implement our decision tree
# model and will plot it using the rpart.plot() function. We will specifically use the 
# recursive parting to plot the decision tree.

library(rpart)
library(rpart.plot)

decisio?Tree_model <- rpart(Class ~ . , creditcard_data, method = 'class')

predicted_val <- predict(decisionTree_model, creditcard_data, type = 'class')
probability <- predict(decisionTree_model, creditcard_data, type = 'prob')

rpart.plot(decisionTree_model)


#?7.  ARTIFICIAL NEURAL NETWORK
# We import the neuralnet package that would allow us to implement our ANNs.
# Then we proceeded to plot it using the plot() function. Now, in the 
# case of Artificial Neural Networks, there is a range of values that is
# bet?een 1 and 0. We set a threshold as 0.5, that is, values above 0.5 
# will correspond to 1 and the rest will be 0.

library(neuralnet)

ANN_model = neuralnet(Class~., train_data, linear.output = FALSE)
plot(ANN_model)

predANN=compute(ANN_model, test_data)
?esultANN=predANN$net.result
resultANN=ifelse(resultANN>0.5,1,0)

library(gbm, quietly = TRUE)

# Get the time to train the GBM model

system.time(
  model__gbm <- gbm(Class ~ .
      , distribution = "bernoulli"
      , data = rbind(train_data, test_data)
?     , n.trees = 500
      , interaction.depth = 3
      , n.minobsinnode = 100
      , shrinkage = 0.01
      , bag.fraction = 0.5
      , train.fraction = nrow(train_data) / (nrow(train_data) + nrow(test_data))
      )
)

gbm.iter = gbm.perf(model__gbm, ?ethod = "test")

model.influence = relative.influence(model__gbm, n.trees = gbm.iter, sort. = TRUE)
plot(model__gbm)


# Plot and calculate AUC on test data
gbm_test = predict(model__gbm, newdata = test_data, n.trees = gbm.iter)
gbm_auc = roc(test_data$Cla?s, gbm_test, plot = TRUE, col = "red")
print(gbm_auc)

## PROBLEM WITH ROC ##





