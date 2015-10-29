---
title: "Predicting Academic Probation"
author: "Patrick Wynne"
published: true
status: publish
draft: false
tags: R Persistence
---
 
 
 

 
 

{% highlight r %}
ModelFTF <- glm(Probation ~ LimitedEnglish + `Credits Enrolled` +
                        DelayEnteringCollege +
                        RemedialWriting + 
                        `Remedial Math` +
                        `Attendance Concern` + DangerofFailing + `Poor Performance` + Unprepared +
                        `Keep Up Good Work` +
                        OutstandingPerformance + ShowingImprovement +
                        Al + CW,
                data = training,
                family = "binomial")
 
ModelFTFNoEas <- glm(Probation ~ LimitedEnglish + `Credits Enrolled` +
                        DelayEnteringCollege +
                        RemedialWriting + 
                        `Remedial Math`,
                data = training,
                family = "binomial")
 
 
 
train <- training
test <- testing
 
feature.names <- names(train)[2:ncol(train)-1]
 
dtrain <- xgb.DMatrix(data = data.matrix(train[,feature.names]), label=train$Probation)
dtest <- xgb.DMatrix(data = data.matrix(test[,feature.names]), label=test$Probation)
 
watchlist <- list(train=dtrain, test=dtest)
 
set.seed(1337)
 
bst <- xgb.train(data=dtrain, 
                 params = list(max_depth         = 3,  # maximum depth of tree 
                               eta              = 0.01,      # step size shrinkage 
                               gamma             = 0,      # minimum loss reduction 
                               subsample         = .9, # part of data instances to grow tree 
                               colsample_bytree  = .5,
                               min_child_weight  = 0),
                 nround=1500, 
                 watchlist=watchlist, 
                 objective = "binary:logistic",
                 eval_metric = "auc")
 
importance_matrix <- xgb.importance(feature.names, model = bst)
 
importance_matrixR1 <- importance_matrix[1:10, ]
 
xgb.plot.importance(importance_matrixR1) + theme(text = element_text(size=20)) +
        theme(axis.text.y=element_text(colour="black"))
{% endhighlight %}

![plot of chunk unnamed-chunk-2](/figures/unnamed-chunk-2-1.png) 

{% highlight r %}
testing$Probationxgboost <- predict(bst, data.matrix(testing[feature.names]))
predxgboost <- prediction(testing$Probationxgboost, testing$Probation)
perfxgboost <- performance(predxgboost,"tpr","fpr")
auc(testing$Probation, testing$Probationxgboost)
 
testing$ProbationLogit <- predict(ModelFTF, testing, type = "response")
 
predlogit <- prediction(testing$ProbationLogit, testing$Probation)
perflogit <- performance(predlogit,"tpr","fpr")
auc(testing$Probation, testing$ProbationLogit)
 
testing$ProbationLogitnoeas <- predict(ModelFTFNoEas, testing, type = "response")
 
predlogitNoEAS <- prediction(testing$ProbationLogitnoeas, testing$Probation)
perflogitNoEAS <- performance(predlogitNoEAS,"tpr","fpr")
auc(testing$Probation, testing$ProbationLogitnoeas)
{% endhighlight %}
 
 
![plot of chunk unnamed-chunk-3](/figures/unnamed-chunk-3-1.png) 
 
