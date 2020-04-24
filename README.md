---
title: "Get Census Bureau CPS microdata from Census Bureau website "
author: Daniel Bonnery
---

# Data: Current Population Survey

`dataCPS` is an R package that pulls CPS public microdata from the census bureau website on install and packs it into an 
## Installation.

To install  the package, execute:

```r
devtools::install_github("DanielBonnery/dataCPS")
```
Note that installation is slow, because part of the installation process is the downloading of data from the Census Bureau website.


## Detailed Documentation

Refer to the dataCPS R package pdf documentation manual available on the github repo:
[https://github.com/DanielBonnery/dataCPS/blob/master/dataCPS.pdf](dataCPS.pdf)

# Demonstration

By default, the package downloads zip files, and only select some variables, as shown in the following summary:


```r
data("cps200501",package="dataCPS")
summary(cps200501)
```

```
FALSE     hrhhid            hrintsta            hrmis             hrhhid2            gestfips        
FALSE  Length:156657      Length:156657      Length:156657      Length:156657      Length:156657     
FALSE  Class :character   Class :character   Class :character   Class :character   Class :character  
FALSE  Mode  :character   Mode  :character   Mode  :character   Mode  :character   Mode  :character  
FALSE                                                                                                
FALSE                                                                                                
FALSE                                                                                                
FALSE      peage          pesex             pulineno           pehspnon           prpertyp        
FALSE  Min.   :-1.00   Length:156657      Length:156657      Length:156657      Length:156657     
FALSE  1st Qu.:11.00   Class :character   Class :character   Class :character   Class :character  
FALSE  Median :32.00   Mode  :character   Mode  :character   Mode  :character   Mode  :character  
FALSE  Mean   :32.54                                                                              
FALSE  3rd Qu.:51.00                                                                              
FALSE  Max.   :85.00                                                                              
FALSE     pemlr              pwsswgt           pwcmpwgt    
FALSE  Length:156657      Min.   :    0.0   Min.   :    0  
FALSE  Class :character   1st Qu.:  609.9   1st Qu.:    0  
FALSE  Mode  :character   Median : 1919.8   Median : 1186  
FALSE                     Mean   : 1850.4   Mean   : 1435  
FALSE                     3rd Qu.: 2813.5   3rd Qu.: 2613  
FALSE                     Max.   :32265.5   Max.   :31739
```


If other variables are wanted, use the `dataCPS::get_data_from_web` 
or 'get_onemonth_data_from_web'
function.
Following example downloads the data for January 2005 and creates a data frame that contains all the variables available. Variable names are then displayed.







