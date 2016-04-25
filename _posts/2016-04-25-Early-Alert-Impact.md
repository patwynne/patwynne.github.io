---
title: "Early-Alert Effect"
author: "Patrick Wynne"
layout: post
date: "April 24, 2016"
output: html_document
published: true
status: publish
draft: false
output: html_document
tags: Text Mining
---

### Early-Alert Impact on Course Outcomes  

**Abstract -- A large urban open-admission community college invested in a campus-wide early-alert and student support system to enable timely and efficient communication between faculty, student support personnel, and students to address academic problems early in the semester and to provide resources such as tutoring. This paper seeks to measure the early alert systems impact on student outcomes in credit bearing courses.**

#### Introduction
In response to demands to increase access to higher education some 50 years ago, municipalities at the state and local levels founded 2-year colleges across the nation, which now total 1,132 colleges in all.  Growth in this sector of higher education has been so great that community college students now make up 40% of all enrolled students in higher education  ().  


The growth of community colleges and community college enrollment well demonstrates that the vision to extend access to higher education for all Americans has been arguably successful; however, as Davis and Jenkins maintains, these institutions have been “designed for access, not success.”  The lack of community college student success is well documented. Data provided by the National Center for Educational Statistics finds that only 59 percent of 2-year public institution students are retained the following year. Moreover, and only 20 percent graduate within 150% of degree-time.  


Responding to these dire facts, the Bill and Melinda Gates Foundation have dedicated one-half billion dollars to forward the success of community college students. They have launched many initiatives addressing student success at this level. The initiative under review is an early-alert support system.  


With the support of the Gates Foundation, Queensborough Community College implemented a campus-wide early-alert and support system in fall 2012.  The aim of the early alert system is to facilitate communication between faculty, student support personnel, and students, in particular, the system aims to diagnose academic problems early and to provide resources such as tutoring. The college is an open admissions community college with an enrollment of over 21,000 undergraduate students per academic year. Over seventy percent of incoming students typically require remediation (developmental education) in one or more than one basic skills area (reading, writing, or mathematics).  


An in house system was implemented in fall 2012 and spring 2013 campus wide; the software was faculty to all classes at the college. Faculty was encouraged to participate but not required. In Fall 2013 purchased proprietary Starfish software which provided additional functionality and more user friendly interface. 


In this study I use college enrollment data from Fall 2010 to the Spring 2015 to examine the impact of the early alert system on student course outcomes. To control for selection biases, I implement a difference in differences design whereby I compare student course performances pre and post implementation. To measure the difference pre implementation, I impute course sections likely to have implemented the early alert system using course subject, class size, online status, and class schedule. I then contrast students enrolled in early alert sections pre and post campus wide implementation. 



#### Methods

A key obstacle in my evaluation is that Starfish usage is not randomly selected. The main use of Starfish is to identify struggling students. It follows logically that course sections implementing the EAS will, on average, have worse course outcomes than sections not implementing the EAS.  


To simulate experimental design, I used differences in differences to measure the impact of EAS. I define treatment as a course section that issues at least one tracking item. The post difference is the difference in the student course outcomes between courses using EAS and those not using EAS. 


In order to determine the difference pre implementation, I impute the likelihood a section would have utilized EAS had it been available. For imputation, I trained a random forest model using course data from the semesters where the EAS was available campus wide. The dependent variable was the binary variable for 1 – the second issued at least one tracking item or 0 – the section had no tracking items. The independent variables used in the model were course subject, class size, class schedule (morning, afternoon, evening) (once per week, twice per week, three times per week), and online. I then ran the model on course data pre EAS implementation to determine sections that likely would have used the EAS system.  


To control student effects, I look at only those students who were enrolled in treatment (EAS sections) and control (non-EAS sections) pre and post implementation. To further control for student effects, I include fixed effects for students. To control for professor characteristics, I also include fixed effects for professors. 
The resulting model looks like:  

$$a^2 + b^2 = c^2$$

$$Y_{ij} = \alpha + \alpha_{1}*Treat_{i} + \alpha_{2}*Post_{i} + \theta(Treat_{i}*Post_{i}) + \beta*X_{i} + Z_{j} + \epsilon_{ij}$$ 

where PostEAS is a dummy variable indicating 0 for pre EAS implementation and 1 for Post EAS implementation. Treamtent is a dummy variable where 0 indicates non-EAS section and 1 indicates a section that used at least one tracking item or we impute would have used a tracking item. Delta(StudentEffects) is the fixed effects for students. Delta(Professor) is the fixed effects for Professors. Beta(X) represents all other exogenous variables we are controlling for. 

Comprehensive analyses were conducted on the effects of an early-alert/student support system implemented in a large urban open-admission community college to provide additional outreach and help to struggling students. The purposes of the analyses were twofold: summative and predictive. Summative analyses included an evaluation of the pass rates and withdrawal rates of students within targeted courses, with additional analyses to determine the effects extended to overall better semester outcomes for students flagged.  Analyses were conducted to identify a predictive model using early-alert data for the purpose of identifying students at-risk of earning lower than a 2.0 GPA in the “current” semester, and/or failing to persist through the first or second semesters.

The research found that early-alert “flags” alone are not a treatment but rather a mechanism by which to identify and reach out to students who are struggling. The evidence suggests that the combination of early-alert with tutoring benefits students, particularly struggling students. This has been observed in other institutions as well (Abrams & Jernigan, 1984; Vander Schee, 2007). We found that academic tutoring in particular improved students’ performance and was crucial for students at risk. Tutoring has a positive effect on course persistence for the most vulnerable student group – high-risk students who were also flagged through the system. 

The prediction models utilizing early-alert data as factors to predict semester GPA and student persistence indicated that indeed flags for poor performance and course attendance were negative factors, and kudos and learning center visits (tutoring) were positive factors for future student performance and persistence. The volume of alerts through the enhanced web-based software makes it more difficult with limited resources and staffing to address each and every alert with the same urgency. Thus, the information derived from our analyses can enable advisers to focus their attention and outreach to students with multiple negative factors such as attendance and poor performance alerts, delayed college entry status, failed placement tests, the absence of kudos and tutoring, and (in the case of continuing students) low prior academic performance. 





<table style="text-align:center"><caption><strong>Early Alert Impact on Next-Semester Retention</strong></caption>
<tr><td colspan="3" style="border-bottom: 1px solid black"></td></tr><tr><td style="text-align:left"></td><td colspan="2">Retained or Graduated the Following Semester</td></tr>
<tr><td></td><td colspan="2" style="border-bottom: 1px solid black"></td></tr>
<tr><td style="text-align:left"></td><td>(1)</td><td>(2)</td></tr>
<tr><td colspan="3" style="border-bottom: 1px solid black"></td></tr><tr><td style="text-align:left">Treatment</td><td>0.241<sup>***</sup></td><td>-0.048</td></tr>
<tr><td style="text-align:left"></td><td>(0.034)</td><td>(0.036)</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">Post</td><td>-0.152<sup>***</sup></td><td>-0.113<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td>(0.038)</td><td>(0.040)</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">Age</td><td></td><td>0.002</td></tr>
<tr><td style="text-align:left"></td><td></td><td>(0.001)</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">CumulativeCredits</td><td></td><td>0.007<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td>(0.0004)</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">CreditsEnrolled</td><td></td><td>0.118<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td>(0.002)</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">Treatment:Post</td><td>0.045</td><td>0.004</td></tr>
<tr><td style="text-align:left"></td><td>(0.043)</td><td>(0.044)</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">Constant</td><td>0.985<sup>***</sup></td><td>-1.596<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td>(0.030)</td><td>(0.251)</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td colspan="3" style="border-bottom: 1px solid black"></td></tr><tr><td style="text-align:left">Observations</td><td>84,198</td><td>84,198</td></tr>
<tr><td style="text-align:left">Log Likelihood</td><td>-47,073.970</td><td>-45,340.360</td></tr>
<tr><td style="text-align:left">Akaike Inf. Crit.</td><td>94,155.930</td><td>90,782.710</td></tr>
<tr><td colspan="3" style="border-bottom: 1px solid black"></td></tr><tr><td style="text-align:left"><em>Note:</em></td><td colspan="2" style="text-align:right"><sup>*</sup>p<0.1; <sup>**</sup>p<0.05; <sup>***</sup>p<0.01</td></tr>
</table>




<table style="text-align:center"><caption><strong>Early Alert Impact on Next-Semester Retention by Gender</strong></caption>
<tr><td colspan="5" style="border-bottom: 1px solid black"></td></tr><tr><td style="text-align:left"></td><td colspan="4">Retained or Graduated the Following Semester</td></tr>
<tr><td></td><td colspan="4" style="border-bottom: 1px solid black"></td></tr>
<tr><td style="text-align:left"></td><td colspan="2">Women</td><td colspan="2">Men</td></tr>
<tr><td style="text-align:left"></td><td>(1)</td><td>(2)</td><td>(3)</td><td>(4)</td></tr>
<tr><td colspan="5" style="border-bottom: 1px solid black"></td></tr><tr><td style="text-align:left">Treatment</td><td>0.302<sup>***</sup></td><td>-0.017</td><td>0.175<sup>***</sup></td><td>-0.088<sup>*</sup></td></tr>
<tr><td style="text-align:left"></td><td>(0.047)</td><td>(0.049)</td><td>(0.049)</td><td>(0.052)</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td><td></td><td></td></tr>
<tr><td style="text-align:left">Post</td><td>-0.177<sup>***</sup></td><td>-0.124<sup>**</sup></td><td>-0.122<sup>**</sup></td><td>-0.107<sup>*</sup></td></tr>
<tr><td style="text-align:left"></td><td>(0.052)</td><td>(0.054)</td><td>(0.057)</td><td>(0.059)</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td><td></td><td></td></tr>
<tr><td style="text-align:left">Age</td><td></td><td>0.003<sup>**</sup></td><td></td><td>-0.005<sup>**</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td>(0.002)</td><td></td><td>(0.002)</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td><td></td><td></td></tr>
<tr><td style="text-align:left">CumulativeCredits</td><td></td><td>0.005<sup>***</sup></td><td></td><td>0.010<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td>(0.001)</td><td></td><td>(0.001)</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td><td></td><td></td></tr>
<tr><td style="text-align:left">CreditsEnrolled</td><td></td><td>0.114<sup>***</sup></td><td></td><td>0.121<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td>(0.003)</td><td></td><td>(0.003)</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td><td></td><td></td></tr>
<tr><td style="text-align:left">Treatment:Post</td><td>0.077</td><td>0.020</td><td>0.011</td><td>-0.010</td></tr>
<tr><td style="text-align:left"></td><td>(0.059)</td><td>(0.060)</td><td>(0.063)</td><td>(0.065)</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td><td></td><td></td></tr>
<tr><td style="text-align:left">Constant</td><td>1.003<sup>***</sup></td><td>-1.232<sup>***</sup></td><td>0.964<sup>***</sup></td><td>-2.245<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td>(0.041)</td><td>(0.294)</td><td>(0.044)</td><td>(0.502)</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td><td></td><td></td></tr>
<tr><td colspan="5" style="border-bottom: 1px solid black"></td></tr><tr><td style="text-align:left">Observations</td><td>45,034</td><td>45,034</td><td>39,164</td><td>39,164</td></tr>
<tr><td style="text-align:left">Log Likelihood</td><td>-24,518.830</td><td>-23,652.420</td><td>-22,506.640</td><td>-21,587.740</td></tr>
<tr><td style="text-align:left">Akaike Inf. Crit.</td><td>49,045.660</td><td>47,402.840</td><td>45,021.280</td><td>43,277.490</td></tr>
<tr><td colspan="5" style="border-bottom: 1px solid black"></td></tr><tr><td style="text-align:left"><em>Note:</em></td><td colspan="4" style="text-align:right"><sup>*</sup>p<0.1; <sup>**</sup>p<0.05; <sup>***</sup>p<0.01</td></tr>
</table>




<table style="text-align:center"><caption><strong>Early Alert Impact on Next-Semester Retention by Ethnicity</strong></caption>
<tr><td colspan="6" style="border-bottom: 1px solid black"></td></tr><tr><td style="text-align:left"></td><td colspan="5">Retained or Graduated the Following Semester</td></tr>
<tr><td></td><td colspan="5" style="border-bottom: 1px solid black"></td></tr>
<tr><td style="text-align:left"></td><td>Asian</td><td>African American</td><td>Hispanic</td><td>White</td><td>International</td></tr>
<tr><td style="text-align:left"></td><td>(1)</td><td>(2)</td><td>(3)</td><td>(4)</td><td>(5)</td></tr>
<tr><td colspan="6" style="border-bottom: 1px solid black"></td></tr><tr><td style="text-align:left">Treatment</td><td>-0.093</td><td>-0.085</td><td>0.028</td><td>-0.049</td><td>0.114</td></tr>
<tr><td style="text-align:left"></td><td>(0.083)</td><td>(0.070)</td><td>(0.071)</td><td>(0.075)</td><td>(0.158)</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td><td></td><td></td><td></td></tr>
<tr><td style="text-align:left">Post</td><td>-0.143</td><td>-0.187<sup>**</sup></td><td>0.060</td><td>-0.139</td><td>-0.286<sup>*</sup></td></tr>
<tr><td style="text-align:left"></td><td>(0.092)</td><td>(0.077)</td><td>(0.079)</td><td>(0.086)</td><td>(0.166)</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td><td></td><td></td><td></td></tr>
<tr><td style="text-align:left">Age</td><td>0.004</td><td>0.007<sup>***</sup></td><td>-0.006<sup>*</sup></td><td>0.005<sup>*</sup></td><td>-0.010</td></tr>
<tr><td style="text-align:left"></td><td>(0.003)</td><td>(0.002)</td><td>(0.003)</td><td>(0.003)</td><td>(0.007)</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td><td></td><td></td><td></td></tr>
<tr><td style="text-align:left">CumulativeCredits</td><td>0.002<sup>**</sup></td><td>0.009<sup>***</sup></td><td>0.011<sup>***</sup></td><td>0.005<sup>***</sup></td><td>0.003<sup>*</sup></td></tr>
<tr><td style="text-align:left"></td><td>(0.001)</td><td>(0.001)</td><td>(0.001)</td><td>(0.001)</td><td>(0.002)</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td><td></td><td></td><td></td></tr>
<tr><td style="text-align:left">CreditsEnrolled</td><td>0.121<sup>***</sup></td><td>0.116<sup>***</sup></td><td>0.123<sup>***</sup></td><td>0.113<sup>***</sup></td><td>0.098<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td>(0.005)</td><td>(0.005)</td><td>(0.005)</td><td>(0.005)</td><td>(0.010)</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td><td></td><td></td><td></td></tr>
<tr><td style="text-align:left">Treatment:Post</td><td>0.051</td><td>0.037</td><td>-0.129</td><td>0.064</td><td>-0.168</td></tr>
<tr><td style="text-align:left"></td><td>(0.102)</td><td>(0.086)</td><td>(0.087)</td><td>(0.096)</td><td>(0.189)</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td><td></td><td></td><td></td></tr>
<tr><td style="text-align:left">Constant</td><td>-0.984<sup>*</sup></td><td>-2.310<sup>***</sup></td><td>-1.832<sup>***</sup></td><td>-1.315<sup>**</sup></td><td>-0.162</td></tr>
<tr><td style="text-align:left"></td><td>(0.527)</td><td>(0.616)</td><td>(0.458)</td><td>(0.522)</td><td>(1.443)</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td><td></td><td></td><td></td></tr>
<tr><td colspan="6" style="border-bottom: 1px solid black"></td></tr><tr><td style="text-align:left">Observations</td><td>18,705</td><td>20,493</td><td>22,961</td><td>16,474</td><td>4,984</td></tr>
<tr><td style="text-align:left">Log Likelihood</td><td>-9,431.992</td><td>-11,694.330</td><td>-12,560.820</td><td>-8,680.330</td><td>-2,399.142</td></tr>
<tr><td style="text-align:left">Akaike Inf. Crit.</td><td>18,965.980</td><td>23,488.670</td><td>25,219.640</td><td>17,460.660</td><td>4,888.285</td></tr>
<tr><td colspan="6" style="border-bottom: 1px solid black"></td></tr><tr><td style="text-align:left"><em>Note:</em></td><td colspan="5" style="text-align:right"><sup>*</sup>p<0.1; <sup>**</sup>p<0.05; <sup>***</sup>p<0.01</td></tr>
</table>
