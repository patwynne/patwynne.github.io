---
title: "Student Attrition Modelling Using XGBoost"
author: "Patrick Wynne"
layout: post
date: "April 30, 2016"
draft: false
output: html_document
tags: Data Mining
---

In this post I will briefly outline how we use XGBoost to model student attrition.

We start with a data frame named SpringSemesters. Each row in the data set represents a student enrolled in either the spring 14 or spring 15 semesters. If a student was enrolled in both the spring 14 and spring 15, they will have two rows in the data set. The data set has 26884 rows and 141 columns. 


# Partitioning the Data


```r
# Set seed to make results reproducible

set.seed(10)

# Partition Data. Here I'm setting 70% of the data to be used for training my model

Partition <- createDataPartition(SpringSemesters$RetainedGraduated, p = .70, list = FALSE)

training <- SpringSemesters[Partition, ]
testingSets <- SpringSemesters[-Partition, ]

# Here I'm breaking up my test set into 2 sets. The first (testing) will to be used to determine parameter tuning on xgboost
# FinalTest will be used to test the model once I'm done with parameter tuning

PartitionTesting <- createDataPartition(testingSets$RetainedGraduated, p = .5, list = FALSE)

testing <- testingSets[ PartitionTesting,]
FinalTest  <- testingSets[-PartitionTesting,]
```

In the above code block, we partition the data into three disinct data frames. First we use the set.seed function to ensure that my results are reproducible. Then we need use the createDataPartition function from the caret package to create a random index of 70% of the rows in my SpringSemesters data frame. We then assign the indexed subset to a data frame named training. We assign the complementary rows to a data frame named testingSets. We then repeat this process to create two evenly sized testing data sets.

## Creating Sparse Matrices


```r
library(xgboost)

# Create a character vector of variables other than the dependent variable
feature.names <-names(training)[which(names(training) != "RetainedGraduated")]

# Convert the data.frame to all numeric values
for (f in feature.names) {
    if (class(training[[f]])=="character") {
        levels <- unique(c(training[[f]], testing[[f]], FinalTest[[f]]))
        training[[f]] <- as.integer(factor(training[[f]], levels=levels))
        testing[[f]]  <- as.integer(factor(testing[[f]],  levels=levels))
        FinalTest[[f]]<- as.integer(factor(FinalTest[[f]],  levels=levels))
    }
}


# Create sparse matrix for inputs into xgboost function
dtrain <- xgb.DMatrix(data = data.matrix(training[,feature.names]), label=training$RetainedGraduated)
dtest <- xgb.DMatrix(data = data.matrix(testing[,feature.names]), label=testing$RetainedGraduated)

# Watch list allows to track how well the model is fitting the the test set as each tree is added
watchlist <- list(train=dtrain, test=dtest)
```

Xgboost requires sparse matrices as an input. This requires all character vectors to be converted to numeric values. First we create a character vector called "feature.names" that contains the column names in the data frame of all values other than the dependent variable "RetainedGraduated" (we leave RetainedGraduated out for reasons that will be explained later). Then we iterate along the feature.names vector converted every character vector to factor than integer. 

## Train the boosted trees model


```r
set.seed(1337)

BoostedTrees <- xgb.train(data        = dtrain,
                          params      = list(max_depth         = 5,      
                                             eta               = 0.005,  
                                             gamma             = .01,    
                                             subsample         = .8,     
                                             colsample_bytree  = .4,
                                             min_child_weight  = 0),
                          nround      = 2000, 
                          watchlist   = watchlist, 
                          objective   = "binary:logistic",
                          eval_metric = "auc")
```

We use the set.seed function to ensure reproducibility. Then we run the xgb.train function. Adjusting the various parameters can improve model performance greatly, but can also lead to overfitting on your test set. We created two test sets initially so that we can tune the paramters of the xgb.train to improve the models performance on the initial test set. Once we're satisfied with the model performance, we give a final test to my cleverly named "FinalTest" data frame.


## Create importance 


```r
# Create the importance matrix that determine which features are used most frequently. Note that I'm only 
importance_matrix <- xgb.importance(feature.names, model = BoostedTrees)[1:15, ]


xgb.plot.importance(importance_matrix) +theme(text = element_text(size=12)) +
    theme(axis.text.y=element_text(colour="black"))
```

![Feature Importance](/figures/Feature Importance-1.png)

The xgb.importance function outputs a data frame detailing the gain in accuracy brought by each feature. The xgb.plot.importance function provides a simple ggplot2 template to visualize the feature importance

## Testing the Model


```r
# Run the model against the "FinalTest" data set

FinalTest$RetPrediction <- predict(BoostedTrees, data.matrix(FinalTest[feature.names]))

library(pROC)

auc(FinalTest$RetainedGraduated, FinalTest$RetPrediction)
```

```
## Area under the curve: 0.7455
```

Here we determine the area under the ROC curve using the auc function in the pROC package. As can be seen above, the model had an auc of .745.

## ROC Curve


```r
# Creates my ROC curve graph

predgbm <- prediction(FinalTest$RetPrediction, FinalTest$RetainedGraduated)
perfgbm <- performance(predgbm,"tpr","fpr")

plot(perfgbm, main="'Drop Out Risk' Model Performance", col = "#00306E", lwd = 3.5)
abline(a=0, b=1, lwd = 3.5, col="#636466")
legend(x=.5,y=.2, c("XGBoost (AUC=.75)", "Random (AUC=.5)"),
       lwd=c(3.5,3.5),col=c("#00306E","#636466"))
```

![ROC Curve](/figures/ROC Curve-1.png)

The above is our Receiver Operator Characteristic Curve. The x axis is the false positive rate or in our case its the percent of students that returned the following semester that we identified as likely to drop out. The Y axis is the true positive rate or the percent of all drop outs we identified that we identified as likely to drop out. As we select more students, we select more drop outs but also more returning students. 


```r
# Create a new variable to determine what probability cut off a student belongs to

FinalTest$`Probabilty Cut-Off`[FinalTest$RetPrediction < .4] <- 40
FinalTest$`Probabilty Cut-Off`[FinalTest$RetPrediction < .45 &
                                 FinalTest$RetPrediction >= .4] <- 45
FinalTest$`Probabilty Cut-Off`[FinalTest$RetPrediction < .5&
                                   FinalTest$RetPrediction >= .45] <- 50
FinalTest$`Probabilty Cut-Off`[FinalTest$RetPrediction < .55 &
                                 FinalTest$RetPrediction >= .5] <- 55
FinalTest$`Probabilty Cut-Off`[FinalTest$RetPrediction < .6 &
                                 FinalTest$RetPrediction >= .55] <- 60
FinalTest$`Probabilty Cut-Off`[FinalTest$RetPrediction < .65 &
                                 FinalTest$RetPrediction >= .6] <- 65
FinalTest$`Probabilty Cut-Off`[FinalTest$RetPrediction < .70 &
                                   FinalTest$RetPrediction >= .65] <- 70
FinalTest$`Probabilty Cut-Off`[FinalTest$RetPrediction < .75 &
                                 FinalTest$RetPrediction >= .7] <- 75
FinalTest$`Probabilty Cut-Off`[FinalTest$RetPrediction < .80 &
                                 FinalTest$RetPrediction >= .75] <- 80
FinalTest$`Probabilty Cut-Off`[FinalTest$RetPrediction < .85&
                                 FinalTest$RetPrediction >= .8] <- 85
FinalTest$`Probabilty Cut-Off`[FinalTest$RetPrediction < .9 &
                                 FinalTest$RetPrediction >= .85] <- 90
FinalTest$`Probabilty Cut-Off`[FinalTest$RetPrediction < .95 &
                                   FinalTest$RetPrediction >= .9] <- 95
FinalTest$`Probabilty Cut-Off`[FinalTest$RetPrediction <= 1 &
                                 FinalTest$RetPrediction >= .95] <- 100



# Creates my accuracy table

FinalTestAUCTable <- FinalTest%>%
    mutate(TrackingItems = FLAG + KUDO + REFERRAL,
           Treated = ifelse(TrackingItems > 0, 1, 0))%>%
    group_by(RetainedGraduated, `Probabilty Cut-Off`)%>%
    summarise(freq = n())%>%
    spread(RetainedGraduated, freq, fill = 0)%>%
    mutate(`Total Selected` = cumsum(`0` + `1`),
           `Drop Outs Selected` = cumsum(`0`),
           `Accuracy Rate (% Correct)` = round((`Drop Outs Selected`/ `Total Selected`)*100, 2),
           `Non-Drop Outs Selected` = `Total Selected` - `Drop Outs Selected`,
           `Drop Outs not Selected` = max(`Drop Outs Selected`) - `Drop Outs Selected`,
           `Sensitivity Rate` = round((`Drop Outs Selected`/max(`Drop Outs Selected`))*100,2),
           `False Positive Rate` = round((`Non-Drop Outs Selected`/max(`Non-Drop Outs Selected`))*100,2))%>%
    ungroup(.)%>%
    select(-`0`, -`1`)%>%
    arrange(`Probabilty Cut-Off`)

stargazer::stargazer(FinalTestAUCTable, summary = FALSE, type = "html", rownames = FALSE,
           title = "Accuracy Table at Various Probability Cut-Offs")
```


<table style="text-align:center"><caption><strong>Accuracy Table at Various Probability Cut-Offs</strong></caption>
<tr><td colspan="8" style="border-bottom: 1px solid black"></td></tr><tr><td style="text-align:left">Probabilty Cut-Off</td><td>Total Selected</td><td>Drop Outs Selected</td><td>Accuracy Rate (% Correct)</td><td>Non-Drop Outs Selected</td><td>Drop Outs not Selected</td><td>Sensitivity Rate</td><td>False Positive Rate</td></tr>
<tr><td colspan="8" style="border-bottom: 1px solid black"></td></tr><tr><td style="text-align:left">40</td><td>421</td><td>281</td><td>66.75</td><td>140</td><td>867</td><td>24.48</td><td>4.85</td></tr>
<tr><td style="text-align:left">45</td><td>590</td><td>385</td><td>65.25</td><td>205</td><td>763</td><td>33.54</td><td>7.11</td></tr>
<tr><td style="text-align:left">50</td><td>769</td><td>466</td><td>60.6</td><td>303</td><td>682</td><td>40.59</td><td>10.51</td></tr>
<tr><td style="text-align:left">55</td><td>984</td><td>549</td><td>55.79</td><td>435</td><td>599</td><td>47.82</td><td>15.08</td></tr>
<tr><td style="text-align:left">60</td><td>1236</td><td>641</td><td>51.86</td><td>595</td><td>507</td><td>55.84</td><td>20.63</td></tr>
<tr><td style="text-align:left">65</td><td>1550</td><td>734</td><td>47.35</td><td>816</td><td>414</td><td>63.94</td><td>28.29</td></tr>
<tr><td style="text-align:left">70</td><td>1938</td><td>839</td><td>43.29</td><td>1099</td><td>309</td><td>73.08</td><td>38.11</td></tr>
<tr><td style="text-align:left">75</td><td>2328</td><td>921</td><td>39.56</td><td>1407</td><td>227</td><td>80.23</td><td>48.79</td></tr>
<tr><td style="text-align:left">80</td><td>2769</td><td>1012</td><td>36.55</td><td>1757</td><td>136</td><td>88.15</td><td>60.92</td></tr>
<tr><td style="text-align:left">85</td><td>3294</td><td>1085</td><td>32.94</td><td>2209</td><td>63</td><td>94.51</td><td>76.6</td></tr>
<tr><td style="text-align:left">90</td><td>3793</td><td>1135</td><td>29.92</td><td>2658</td><td>13</td><td>98.87</td><td>92.16</td></tr>
<tr><td style="text-align:left">95</td><td>4014</td><td>1147</td><td>28.57</td><td>2867</td><td>1</td><td>99.91</td><td>99.41</td></tr>
<tr><td style="text-align:left">100</td><td>4032</td><td>1148</td><td>28.47</td><td>2884</td><td>0</td><td>100</td><td>100</td></tr>
<tr><td colspan="8" style="border-bottom: 1px solid black"></td></tr></table>

Ultimately we want to identify students deemed at risk of dropping out of school, and to do so we need to determine the cut off for students at risk versus those not at risk. With that in mind, I made the above table. In the above table, we see that in our test data set, when we set the cut off at 55 (actually .55) we selected 40% of all drop outs and only 7% of returning students. In total, at the 55 cutoff, we selected 805 students of which 468 were accurately identified (did not return to school the following Fall).

I will try to update this post as I continued to make progress on the project. If you happened to have stumbled across this post and you have any questions or suggestion feel free to email me. 
