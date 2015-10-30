---
title: "Early Alert and Predictive Analytics"
author: "Patrick Wynne and Elisabeth Lackner"
published: true
status: publish
draft: false
tags: R Persistence
---
 
 
## Early Alert and Predictive Analytics
### by Patrick Wynne and Elisabeth Lackner


The following is the R code used to create the models and tables in the predictive analytics portion of our presentation Early Alert and Predictive Analytics at the 2015 National Symposium on Student Retention.
 

 
 

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
 
R version 3.1.3 (2015-03-09)
Platform: x86_64-w64-mingw32/x64 (64-bit)
Running under: Windows 7 x64 (build 7601) Service Pack 1

locale:
[1] LC_COLLATE=English_United States.1252 
[2] LC_CTYPE=English_United States.1252   
[3] LC_MONETARY=English_United States.1252
[4] LC_NUMERIC=C                          
[5] LC_TIME=English_United States.1252    

attached base packages:
[1] stats     graphics  grDevices utils     datasets  methods   base     

other attached packages:
 [1] xgboost_0.4-2      ROCR_1.0-7         gplots_2.17.0     
 [4] caret_6.0-52       ggplot2_1.0.1      lattice_0.20-30   
 [7] pROC_1.8           RColorBrewer_1.1-2 tidyr_0.3.0       
[10] dplyr_0.4.3        foreign_0.8-66     stargazer_5.2     
[13] Zelig_3.5.5        boot_1.3-15        MASS_7.3-39       
[16] rworldmap_1.3-1    sp_1.2-1           knitr_1.11        

loaded via a namespace (and not attached):
 [1] assertthat_0.1      bitops_1.0-6        BradleyTerry2_1.0-6
 [4] brglm_0.5-9         car_2.0-25          caTools_1.17.1     
 [7] chron_2.3-47        Ckmeans.1d.dp_3.3.1 codetools_0.2-10   
[10] colorspace_1.2-6    data.table_1.9.4    DBI_0.3.1          
[13] digest_0.6.8        evaluate_0.7.2      fields_8.3-5       
[16] foreach_1.4.2       formatR_1.2         gdata_2.17.0       
[19] grid_3.1.3          gtable_0.1.2        gtools_3.4.2       
[22] htmltools_0.2.6     iterators_1.0.7     KernSmooth_2.23-14 
[25] labeling_0.3        lazyeval_0.1.10     lme4_1.1-9         
[28] magrittr_1.5        maps_2.3-11         maptools_0.8-37    
[31] Matrix_1.1-5        MatrixModels_0.4-1  mgcv_1.8-4         
[34] minqa_1.2.4         munsell_0.4.2       nlme_3.1-120       
[37] nloptr_1.0.4        nnet_7.3-9          parallel_3.1.3     
[40] pbkrtest_0.4-2      plyr_1.8.3          proto_0.3-10       
[43] quantreg_5.19       R6_2.1.1            Rcpp_0.12.0        
[46] reshape2_1.4.1      rmarkdown_0.8       rsconnect_0.3.79   
[49] scales_0.3.0        spam_1.2-1          SparseM_1.7        
[52] splines_3.1.3       stats4_3.1.3        stringi_0.5-5      
[55] stringr_1.0.0       tools_3.1.3         yaml_2.1.13        
 
