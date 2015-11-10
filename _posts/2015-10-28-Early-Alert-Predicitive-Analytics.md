---
title: "Early Alert and Predictive Analytics"
author: "Patrick Wynne and Elisabeth Lackner"
published: true
status: publish
draft: false
tags: R Persistence
---
 
 
The following is the R code used to create the models and tables in the predictive analytics portion of our presentation Early Alert and Predictive Analytics at the 2015 National Symposium on Student Retention.
 

{% highlight text %}
## Error in library(Zelig): there is no package called 'Zelig'
{% endhighlight %}



{% highlight text %}
## Error in library(pROC): there is no package called 'pROC'
{% endhighlight %}



{% highlight text %}
## Error in library(ROCR): there is no package called 'ROCR'
{% endhighlight %}
 
 

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



{% highlight text %}
## Error: Ckmeans.1d.dp package is required for plotting the importance
{% endhighlight %}



{% highlight r %}
testing$Probationxgboost <- predict(bst, data.matrix(testing[feature.names]))
predxgboost <- prediction(testing$Probationxgboost, testing$Probation)
{% endhighlight %}



{% highlight text %}
## Error in eval(expr, envir, enclos): could not find function "prediction"
{% endhighlight %}



{% highlight r %}
perfxgboost <- performance(predxgboost,"tpr","fpr")
{% endhighlight %}



{% highlight text %}
## Error in eval(expr, envir, enclos): could not find function "performance"
{% endhighlight %}



{% highlight r %}
auc(testing$Probation, testing$Probationxgboost)
{% endhighlight %}



{% highlight text %}
## Error in eval(expr, envir, enclos): could not find function "auc"
{% endhighlight %}



{% highlight r %}
testing$ProbationLogit <- predict(ModelFTF, testing, type = "response")
 
predlogit <- prediction(testing$ProbationLogit, testing$Probation)
{% endhighlight %}



{% highlight text %}
## Error in eval(expr, envir, enclos): could not find function "prediction"
{% endhighlight %}



{% highlight r %}
perflogit <- performance(predlogit,"tpr","fpr")
{% endhighlight %}



{% highlight text %}
## Error in eval(expr, envir, enclos): could not find function "performance"
{% endhighlight %}



{% highlight r %}
auc(testing$Probation, testing$ProbationLogit)
{% endhighlight %}



{% highlight text %}
## Error in eval(expr, envir, enclos): could not find function "auc"
{% endhighlight %}



{% highlight r %}
testing$ProbationLogitnoeas <- predict(ModelFTFNoEas, testing, type = "response")
 
predlogitNoEAS <- prediction(testing$ProbationLogitnoeas, testing$Probation)
{% endhighlight %}



{% highlight text %}
## Error in eval(expr, envir, enclos): could not find function "prediction"
{% endhighlight %}



{% highlight r %}
perflogitNoEAS <- performance(predlogitNoEAS,"tpr","fpr")
{% endhighlight %}



{% highlight text %}
## Error in eval(expr, envir, enclos): could not find function "performance"
{% endhighlight %}



{% highlight r %}
auc(testing$Probation, testing$ProbationLogitnoeas)
{% endhighlight %}



{% highlight text %}
## Error in eval(expr, envir, enclos): could not find function "auc"
{% endhighlight %}
 
 

{% highlight text %}
## Error in plot(perflogit, main = "Academic Probation Model Performance", : object 'perflogit' not found
{% endhighlight %}



{% highlight text %}
## Error in unlist(perflogitNoEAS@x.values): object 'perflogitNoEAS' not found
{% endhighlight %}



{% highlight text %}
## Error in unlist(perfxgboost@x.values): object 'perfxgboost' not found
{% endhighlight %}



{% highlight text %}
## Error in int_abline(a = a, b = b, h = h, v = v, untf = untf, ...): plot.new has not been called yet
{% endhighlight %}



{% highlight text %}
## Error in strwidth(legend, units = "user", cex = cex, font = text.font): plot.new has not been called yet
{% endhighlight %}
 
R version 3.2.2 (2015-08-14)
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
 [1] xgboost_0.4-2      caret_6.0-58       lattice_0.20-33   
 [4] RColorBrewer_1.1-2 foreign_0.8-65     syuzhet_0.2.0     
 [7] repmis_0.4.4       ggplot2_1.0.1      knitr_1.11        
[10] stargazer_5.2      tidyr_0.3.1        dplyr_0.4.3       

loaded via a namespace (and not attached):
 [1] reshape2_1.4.1     splines_3.2.2      colorspace_1.2-6  
 [4] htmltools_0.2.6    stats4_3.2.2       yaml_2.1.13       
 [7] mgcv_1.8-7         chron_2.3-47       R.oo_1.19.0       
[10] nloptr_1.0.4       DBI_0.3.1          R.utils_2.1.0     
[13] foreach_1.4.3      R.cache_0.10.0     plyr_1.8.3        
[16] stringr_1.0.0      MatrixModels_0.4-1 munsell_0.4.2     
[19] gtable_0.1.2       R.methodsS3_1.7.0  codetools_0.2-14  
[22] evaluate_0.8       labeling_0.3       SparseM_1.7       
[25] quantreg_5.19      pbkrtest_0.4-2     parallel_3.2.2    
[28] curl_0.9.3         proto_0.3-10       Rcpp_0.12.1       
[31] scales_0.3.0       formatR_1.2.1      lme4_1.1-10       
[34] digest_0.6.8       stringi_1.0-1      grid_3.2.2        
[37] tools_3.2.2        magrittr_1.5       lazyeval_0.1.10   
[40] car_2.1-0          MASS_7.3-43        Matrix_1.2-2      
[43] data.table_1.9.6   rmarkdown_0.8.1    assertthat_0.1    
[46] minqa_1.2.4        httr_1.0.0         iterators_1.0.8   
[49] R6_2.1.1           nnet_7.3-10        nlme_3.1-121      
 
