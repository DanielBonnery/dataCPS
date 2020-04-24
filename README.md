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
knitr::kable(summary(cps200501))
```



|   |   hrhhid        |  hrintsta       |   hrmis         |  hrhhid2        |  gestfips       |    peage     |   pesex         |  pulineno       |  pehspnon       |  prpertyp       |   pemlr         |   pwsswgt      |   pwcmpwgt   |
|:--|:----------------|:----------------|:----------------|:----------------|:----------------|:-------------|:----------------|:----------------|:----------------|:----------------|:----------------|:---------------|:-------------|
|   |Length:156657    |Length:156657    |Length:156657    |Length:156657    |Length:156657    |Min.   :-1.00 |Length:156657    |Length:156657    |Length:156657    |Length:156657    |Length:156657    |Min.   :    0.0 |Min.   :    0 |
|   |Class :character |Class :character |Class :character |Class :character |Class :character |1st Qu.:11.00 |Class :character |Class :character |Class :character |Class :character |Class :character |1st Qu.:  609.9 |1st Qu.:    0 |
|   |Mode  :character |Mode  :character |Mode  :character |Mode  :character |Mode  :character |Median :32.00 |Mode  :character |Mode  :character |Mode  :character |Mode  :character |Mode  :character |Median : 1919.8 |Median : 1186 |
|   |NA               |NA               |NA               |NA               |NA               |Mean   :32.54 |NA               |NA               |NA               |NA               |NA               |Mean   : 1850.4 |Mean   : 1435 |
|   |NA               |NA               |NA               |NA               |NA               |3rd Qu.:51.00 |NA               |NA               |NA               |NA               |NA               |3rd Qu.: 2813.5 |3rd Qu.: 2613 |
|   |NA               |NA               |NA               |NA               |NA               |Max.   :85.00 |NA               |NA               |NA               |NA               |NA               |Max.   :32265.5 |Max.   :31739 |


If other variables are needed, use the `dataCPS::get_data_from_web` 
or 'get_onemonth_data_from_web'
function.
Following example downloads the data for January 2005 and creates a data frame that contains all the variables available. Variable names are then displayed.


```r
library(dataCPS)
m=as.Date("20050101","%Y%m%d")
download.instruction.file(last.format.change.date.f(m))
DD<-get_onemonth_data_from_web(m)
knitr::kable(t(sapply(DD,typeof)))
```



|hrhhid    |hrmonth |hryear4 |hurespli |hufinal |huspnish |hetenure |hehousut |hetelhhd |hetelavl |hephoneo |hufaminc |hutypea |hutypb |hutypc |hwhhwgt |hrintsta |hrnumhou |hrhtype |hrmis  |huinttyp |huprscnt |hrlonglk |hrhhid2 |hubus  |hubusl1 |hubusl2 |hubusl3 |hubusl4 |gereg  |gestcen |gestfips  |gtcbsa    |gtco      |gtcbsast |gtmetsta |gtindvpc |gtcbsasz |gtcsa     |proldrrp |pupelig |perrp  |peparent |peage  |prtfage |pemaritl |pespouse |pesex  |puafever |peafwhen |peafnow |peeduca |prdtrace |prdthsp |puchinhh |purelflg |pulineno |prfamnum |prfamrel |prfamtyp |pehspnon |prmarsta |prpertyp |penatvty |pemntvty |pefntvty |prcitshp |prcitflg |prinusyr |puslfprx |pemlr  |puwk   |pubus1 |pubus2ot |pubusck1 |pubusck2 |pubusck3 |pubusck4 |puretot |pudis  |peret1 |pudis1 |pudis2 |puabsot |pulay  |peabsrsn |peabspdo |pemjot |pemjnum |pehrusl1 |pehrusl2 |pehrftpt |pehruslt |pehrwant |pehrrsn1 |pehrrsn2 |pehrrsn3 |puhroff1 |puhroff2 |puhrot1 |puhrot2 |pehract1 |pehract2 |pehractt |pehravl |puhrck1 |puhrck2 |puhrck3 |puhrck4 |puhrck5 |puhrck6 |puhrck7 |puhrck12 |pulaydt |pulay6m |pelayavl |pulayavr |pelaylk |pelaydur |pelayfto |pulayck1 |pulayck2 |pulayck3 |pulk   |pelkm1 |pulkm2 |pulkm3 |pulkm4 |pulkm5 |pulkm6 |pulkdk1 |pulkdk2 |pulkdk3 |pulkdk4 |pulkdk5 |pulkdk6 |pulkps1 |pulkps2 |pulkps3 |pulkps4 |pulkps5 |pulkps6 |pelkavl |pulkavr |pelkll1o |pelkll2o |pelklwo |pelkdur |pelkfto |pedwwnto |pedwrsn |pedwlko |pedwwk |pedw4wk |pedwlkwk |pedwavl |pedwavr |pudwck1 |pudwck2 |pudwck3 |pudwck4 |pudwck5 |pejhwko |pujhdp1o |pejhrsn |pejhwant |pujhck1 |pujhck2 |prabsrea |prcivlf |prdisc |premphrs |prempnot |prexplf |prftlf |prhrusl |prjobsea |prpthrs |prptrea |prunedur |pruntype |prwksch |prwkstat |prwntjob |pujhck3 |pujhck4 |pujhck5 |puiodp1 |puiodp2 |puiodp3 |peio1cow |puio1mfg |peio2cow |puio2mfg |puiock1 |puiock2 |puiock3 |prioelg |pragna |prcow1 |prcow2 |prcowpg |prdtcow1 |prdtcow2 |prdtind1 |prdtind2 |prdtocc1 |prdtocc2 |premp  |prmjind1 |prmjind2 |prmjocc1 |prmjocc2 |prmjocgr |prnagpws |prnagws |prsjmj |prerelg |peernuot |peernper |peernrt |peernhry |puernh1c |peernh2 |peernh1o |prernhly |pthr   |peernhro |prernwa |ptwk   |peern  |puern2 |ptot   |peernwkp |peernlab |peerncov |penlfjh |penlfret |penlfact |punlfck1 |punlfck2 |peschenr |peschft |peschlvl |prnlfsch |pwfmwgt |pwlgwgt |pworwgt |pwsswgt |pwvetwgt |prchld |prnmchld |prwernal |prhernal |hxtenure |hxhousut |hxtelhhd |hxtelavl |hxphoneo |pxinusyr |pxrrp  |pxparent |pxage  |pxmaritl |pxspouse |pxsex  |pxafwhen |pxafnow |pxeduca |pxrace1 |pxnatvty |pxmntvty |pxfntvty |pxhspnon |pxmlr  |pxret1 |pxabsrsn |pxabspdo |pxmjot |pxmjnum |pxhrusl1 |pxhrusl2 |pxhrftpt |pxhruslt |pxhrwant |pxhrrsn1 |pxhrrsn2 |pxhract1 |pxhract2 |pxhractt |pxhrrsn3 |pxhravl |pxlayavl |pxlaylk |pxlaydur |pxlayfto |pxlkm1 |pxlkavl |pxlkll1o |pxlkll2o |pxlklwo |pxlkdur |pxlkfto |pxdwwnto |pxdwrsn |pxdwlko |pxdwwk |pxdw4wk |pxdwlkwk |pxdwavl |pxdwavr |pxjhwko |pxjhrsn |pxjhwant |pxio1cow |pxio1icd |pxio1ocd |pxio2cow |pxio2icd |pxio2ocd |pxernuot |pxernper |pxernh1o |pxernhro |pxern  |pxernwkp |pxernrt |pxernhry |pxernh2 |pxernlab |pxerncov |pxnlfjh |pxnlfret |pxnlfact |pxschenr |pxschft |pxschlvl |qstnum |occurnum |pedipged |pehgcomp |pecyc  |pegrprof |pegr6cor |pems123 |pxdipged |pxhgcomp |pxcyc  |pxgrprof |pxgr6cor |pxms123 |pwcmpwgt |peio1icd |peio1ocd |peio2icd |peio2ocd |primind1 |primind2 |
|:---------|:-------|:-------|:--------|:-------|:--------|:--------|:--------|:--------|:--------|:--------|:--------|:-------|:------|:------|:-------|:--------|:--------|:-------|:------|:--------|:--------|:--------|:-------|:------|:-------|:-------|:-------|:-------|:------|:-------|:---------|:---------|:---------|:--------|:--------|:--------|:--------|:---------|:--------|:-------|:------|:--------|:------|:-------|:--------|:--------|:------|:--------|:--------|:-------|:-------|:--------|:-------|:--------|:--------|:--------|:--------|:--------|:--------|:--------|:--------|:--------|:--------|:--------|:--------|:--------|:--------|:--------|:--------|:------|:------|:------|:--------|:--------|:--------|:--------|:--------|:-------|:------|:------|:------|:------|:-------|:------|:--------|:--------|:------|:-------|:--------|:--------|:--------|:--------|:--------|:--------|:--------|:--------|:--------|:--------|:-------|:-------|:--------|:--------|:--------|:-------|:-------|:-------|:-------|:-------|:-------|:-------|:-------|:--------|:-------|:-------|:--------|:--------|:-------|:--------|:--------|:--------|:--------|:--------|:------|:------|:------|:------|:------|:------|:------|:-------|:-------|:-------|:-------|:-------|:-------|:-------|:-------|:-------|:-------|:-------|:-------|:-------|:-------|:--------|:--------|:-------|:-------|:-------|:--------|:-------|:-------|:------|:-------|:--------|:-------|:-------|:-------|:-------|:-------|:-------|:-------|:-------|:--------|:-------|:--------|:-------|:-------|:--------|:-------|:------|:--------|:--------|:-------|:------|:-------|:--------|:-------|:-------|:--------|:--------|:-------|:--------|:--------|:-------|:-------|:-------|:-------|:-------|:-------|:--------|:--------|:--------|:--------|:-------|:-------|:-------|:-------|:------|:------|:------|:-------|:--------|:--------|:--------|:--------|:--------|:--------|:------|:--------|:--------|:--------|:--------|:--------|:--------|:-------|:------|:-------|:--------|:--------|:-------|:--------|:--------|:-------|:--------|:--------|:------|:--------|:-------|:------|:------|:------|:------|:--------|:--------|:--------|:-------|:--------|:--------|:--------|:--------|:--------|:-------|:--------|:--------|:-------|:-------|:-------|:-------|:--------|:------|:--------|:--------|:--------|:--------|:--------|:--------|:--------|:--------|:--------|:------|:--------|:------|:--------|:--------|:------|:--------|:-------|:-------|:-------|:--------|:--------|:--------|:--------|:------|:------|:--------|:--------|:------|:-------|:--------|:--------|:--------|:--------|:--------|:--------|:--------|:--------|:--------|:--------|:--------|:-------|:--------|:-------|:--------|:--------|:------|:-------|:--------|:--------|:-------|:-------|:-------|:--------|:-------|:-------|:------|:-------|:--------|:-------|:-------|:-------|:-------|:--------|:--------|:--------|:--------|:--------|:--------|:--------|:--------|:--------|:--------|:--------|:------|:--------|:-------|:--------|:-------|:--------|:--------|:-------|:--------|:--------|:--------|:-------|:--------|:------|:--------|:--------|:--------|:------|:--------|:--------|:-------|:--------|:--------|:------|:--------|:--------|:-------|:--------|:--------|:--------|:--------|:--------|:--------|:--------|
|character |double  |double  |double   |double  |double   |double   |double   |double   |double   |double   |double   |double  |double |double |double  |double   |double   |double  |double |double   |double   |double   |double  |double |double  |double  |double  |double  |double |double  |character |character |character |double   |double   |double   |double   |character |double   |double  |double |double   |double |double  |double   |double   |double |double   |double   |double  |double  |double   |double  |double   |double   |double   |double   |double   |double   |double   |double   |double   |double   |double   |double   |double   |double   |double   |double   |double |double |double |double   |double   |double   |double   |double   |double  |double |double |double |double |double  |double |double   |double   |double |double  |double   |double   |double   |double   |double   |double   |double   |double   |double   |double   |double  |double  |double   |double   |double   |double  |double  |double  |double  |double  |double  |double  |double  |double   |double  |double  |double   |double   |double  |double   |double   |double   |double   |double   |double |double |double |double |double |double |double |double  |double  |double  |double  |double  |double  |double  |double  |double  |double  |double  |double  |double  |double  |double   |double   |double  |double  |double  |double   |double  |double  |double |double  |double   |double  |double  |double  |double  |double  |double  |double  |double  |double   |double  |double   |double  |double  |double   |double  |double |double   |double   |double  |double |double  |double   |double  |double  |double   |double   |double  |double   |double   |double  |double  |double  |double  |double  |double  |double   |double   |double   |double   |double  |double  |double  |double  |double |double |double |double  |double   |double   |double   |double   |double   |double   |double |double   |double   |double   |double   |double   |double   |double  |double |double  |double   |double   |double  |double   |double   |double  |double   |double   |double |double   |double  |double |double |double |double |double   |double   |double   |double  |double   |double   |double   |double   |double   |double  |double   |double   |double  |double  |double  |double  |double   |double |double   |double   |double   |double   |double   |double   |double   |double   |double   |double |double   |double |double   |double   |double |double   |double  |double  |double  |double   |double   |double   |double   |double |double |double   |double   |double |double  |double   |double   |double   |double   |double   |double   |double   |double   |double   |double   |double   |double  |double   |double  |double   |double   |double |double  |double   |double   |double  |double  |double  |double   |double  |double  |double |double  |double   |double  |double  |double  |double  |double   |double   |double   |double   |double   |double   |double   |double   |double   |double   |double   |double |double   |double  |double   |double  |double   |double   |double  |double   |double   |double   |double  |double   |double |double   |double   |double   |double |double   |double   |double  |double   |double   |double |double   |double   |double  |double   |double   |double   |double   |double   |double   |double   |

The following code is an example of use of the function 'rbind_period', 
that creates a dataframe combining a series of consecutive monthly CPS datasets. 


```r
library(dataCPS)
data("cps200501",package="dataCPS")
monthsinperiod("200511","200603")
```

```
FALSE [1] "200511" "200512" "200601" "200602" "200603"
```

```r
cps200511.200603<-rbind_period("200511","200603",c("pwsswgt","pesex"))
Y<-plyr::ddply(
  cps200511.200603,
  ~month+pesex,
  function(d){data.frame(y=sum(d$pwsswgt))})

library(ggplot2)
graph1<-ggplot(data=Y,aes(x=month,y=y,group=pesex,color=pesex))+geom_line()
print(graph1)
```

<img src="figure/unnamed-chunk-3-1.png" title="plot of chunk unnamed-chunk-3" alt="plot of chunk unnamed-chunk-3" width="100%" />

In this example we plot the direct estimate of the unemployment rate.
These estimates are rough versions (simpled weighted sums) and differ from the 
more elaborated estimates published by the Census.


```r
  cps200501.201201<-rbind_period("200501","201201",c("pwsswgt","pesex","pemlr"))
Y<-plyr::daply(cps200501.201201,
  ~month+pesex+pemlr,
  function(d){sum(d$pwsswgt)})

U<-reshape2::melt(apply(Y[,,c("1","2")],1:2,sum)/apply(Y[,,c("1","2","3","4")],1:2,sum))
U$month=as.Date(paste(U$month,"01"), "%Y%m%d")
U$pesex=as.factor(U$pesex);
U$pesex=forcats::fct_collapse(U$pesex,male="1",female="2")
graph2<-ggplot(data=U[is.element(U$pesex,c("male","female")),],
               aes(x=month,y=value,group = pesex,colour=pesex))+geom_line()+xlab("")+ylab("")+ggtitle("Direct estimates of the employment rate by gender")
graph2
```

<img src="figure/unnamed-chunk-4-1.png" title="plot of chunk unnamed-chunk-4" alt="plot of chunk unnamed-chunk-4" width="100%" />

