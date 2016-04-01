Finance in R
========================================================
title: "Finance in R"
author: "Patrick Wynne"
date: "April 1, 2016"
autosize: true

First Slide
========================================================


```r
library(dplyr)
library(tidyr)
library(repmis)
library(stargazer)
library(knitr)
library(ggplot2)

#import files from dropbox

Data <- source_DropboxData(file = "FinanceExample.csv", 
                              key = "x61awpr4vqvi97y", header = TRUE)
```

Slide With Code
========================================================


```r
library(DescTools)

Desc(Data$JPM)
```

```
------------------------------------------------------------------------- 
Data$JPM (numeric)

          length               n             NAs          unique              0s            mean          meanSE
           6e+01           6e+01               0             = n               0   1.2441417e-02   9.6865247e-03

             .05             .10             .25          median             .75             .90             .95
  -1.0981335e-01  -7.1466600e-02  -1.8257500e-02   2.2488500e-02   5.4154500e-02   9.1957600e-02   1.2700690e-01

           range              sd           vcoef             mad             IQR            skew            kurt
   4.0047400e-01   7.5031498e-02   6.0307841e+00   5.5582674e-02   7.2412000e-02  -6.8720199e-01   1.2659795e+00
 
lowest : -2.2871100e-01, -1.9808300e-01, -1.2464000e-01, -1.0903300e-01, -9.3307000e-02
highest: 1.1385400e-01, 1.2688500e-01, 1.2932300e-01, 1.6235100e-01, 1.7176300e-01
```

Slide With Plot
========================================================

![plot of chunk unnamed-chunk-3](Finance in R_1.Rmd-figure/unnamed-chunk-3-1.png) 
