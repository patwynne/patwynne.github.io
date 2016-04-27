---
title: "Econometric Examples in R"
author: "Patrick Wynne"
layout: slide
date: "April 27, 2016"
theme: league
transition: slide
---
<section data-markdown>
## Loading packages and importing data


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
</section>
<section data-markdown>
## JP Morgan


```r
library(stargazer)

stargazer(Data, type = "html")
```
</section>
<section data-markdown>
## JP Morgan


<table style="text-align:center"><tr><td colspan="6" style="border-bottom: 1px solid black"></td></tr><tr><td style="text-align:left">Statistic</td><td>N</td><td>Mean</td><td>St. Dev.</td><td>Min</td><td>Max</td></tr>
<tr><td colspan="6" style="border-bottom: 1px solid black"></td></tr><tr><td style="text-align:left">date</td><td>60</td><td>20,130,680.000</td><td>14,265.690</td><td>20,110,131</td><td>20,151,231</td></tr>
<tr><td style="text-align:left">JPM</td><td>60</td><td>0.012</td><td>0.075</td><td>-0.229</td><td>0.172</td></tr>
<tr><td style="text-align:left">MS</td><td>60</td><td>0.009</td><td>0.100</td><td>-0.228</td><td>0.309</td></tr>
<tr><td style="text-align:left">GS</td><td>60</td><td>0.005</td><td>0.077</td><td>-0.186</td><td>0.233</td></tr>
<tr><td style="text-align:left">S&P</td><td>60</td><td>0.009</td><td>0.034</td><td>-0.072</td><td>0.108</td></tr>
<tr><td style="text-align:left">mktrf</td><td>60</td><td>0.010</td><td>0.035</td><td>-0.076</td><td>0.114</td></tr>
<tr><td style="text-align:left">smb</td><td>60</td><td>-0.001</td><td>0.022</td><td>-0.042</td><td>0.043</td></tr>
<tr><td style="text-align:left">hml</td><td>60</td><td>-0.002</td><td>0.017</td><td>-0.045</td><td>0.046</td></tr>
<tr><td style="text-align:left">rf</td><td>60</td><td>0.00002</td><td>0.00004</td><td>0.000</td><td>0.0001</td></tr>
<tr><td style="text-align:left">JPM-rf</td><td>60</td><td>0.012</td><td>0.075</td><td>-0.229</td><td>0.172</td></tr>
<tr><td style="text-align:left">MS-rf</td><td>60</td><td>0.008</td><td>0.100</td><td>-0.228</td><td>0.309</td></tr>
<tr><td style="text-align:left">GS-rf</td><td>60</td><td>0.005</td><td>0.077</td><td>-0.186</td><td>0.233</td></tr>
<tr><td style="text-align:left">S&P-rf</td><td>60</td><td>0.009</td><td>0.034</td><td>-0.072</td><td>0.108</td></tr>
<tr><td colspan="6" style="border-bottom: 1px solid black"></td></tr></table>
</section>
