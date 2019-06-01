---
title: "Econometric Slides with Revealjs and Rmarkdown"
author: "Patrick Wynne"
layout: post
date: "April 24, 2016"
output: html_document
---

I was recently asked to speak to a finance class about R and what  the benefits of using an open source programming language for data analysis and how they can get started using it themselves. One of the early appeals to me of using R was the ability to create dynamic documents using knitr/rmarkdown that combine the programming logic of the data analysis with the actual text and content of the report. So I figured I should practice what I preach and decided to creat the slides for my short talk using R, Rmarkdown, revealjs.

The revealjs package in R was pretty straightforward, however, I did hit stumbling blocks trying to get github pages to serve an .html file rather than processing a .md, but including the .nojekyll file seems to have done the trick.

The final slides can seen [here](http://patwynne.me/econometricsPresentation/) and the source code for the slides is available at the [repository](https://github.com/patwynne/econometricsPresentation)

As an quick explainer for the slides, I had an hour to speak to the students about R. I decided to list some potential problems with spreadsheets (finance loves their spreadsheets). After that I helped the students install R and R Studio on their machines before going over a couple quick examples. We were a little tight on time, but it was a fun experience.
