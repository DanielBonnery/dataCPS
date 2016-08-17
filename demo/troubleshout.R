
library(dataCPS)
m=  as.Date("20050101","%Y%m%d")
fn=download.unzip.cpsmicrodata(m)
download.instruction.file(last.format.change.date.f(m))
sas_ri=file.path(tempdir(),instructionfilenamef(last.format.change.date.f(m)))
library(readr)
sel=    tolower(c(
  'pulineno',             'pwsswgt','hrhhid','hrlongid',
  'pwcmpwgt',
  'hwniwgt',
  'PUMLR'   ,
  'Pemlr'   ,
  'PEHSPNON',
  'prtage',
  'peage',
  'PESEX'   ,
  'GESTFIPS',
  'puhhmem' ,
  'prpertyp',
  'PTDTRACE',
  'prwtrace',
  'PRBLNONB',
  'GESTREC'))
col_types  =list(
  'pulineno'=col_character(),
  'pwsswgt'=col_double(),
  'hrhhid'=col_character(),
  'hrlongid'=col_character(),
  'pwcmpwgt'=col_double(),
  'hwniwgt'=col_double(),
  'pumlr'  =col_character() ,
  'pemlr'   =col_character(),
  'pehspnon'=col_character(),
  'prtage'=col_double(),
  'peage'=col_double(),
  'pesex'=col_character()   ,
  'gestfips'=col_character(),
  'puhhmem' =col_character(),
  'prpertyp'=col_character(),
  'ptdtrace'=col_character(),
  'prwtrace'=col_character(),
  'prblnonb'=col_character(),
  'gestrec'=col_character())
y=SAScii::read.SAScii3(
  fn=fn, 
  sas_ri=sas_ri,sel=sel,col_types = col_types)# , zipped = FALSE)


   
library(readr)
SASinput <- readLines(sas_ri)
SASinput <- gsub("\t", " ", SASinput)
SASinput <- SASinput[1:length(SASinput)]
SASinput <- tolower(SASinput)
firstline <- grep("input", SASinput)[1]
a <- grep(";", toupper(SASinput))
lastline <- min(a[a > firstline])
FWFlines <- SASinput[firstline:lastline]
input_word <- unlist(gregexpr("input", FWFlines[1], fixed = T))
FWFlines[1] <- substr(FWFlines[1], input_word + 5, nchar(FWFlines[1]))
semicolon <- unlist(gregexpr(";", FWFlines[length(FWFlines)], 
                             fixed = T))
FWFlines[length(FWFlines)] <- substr(FWFlines[length(FWFlines)], 
                                     1, semicolon - 1)
for (i in 1:length(FWFlines)) FWFlines[i] <- gsub("$", " $ ", 
                                                  FWFlines[i], fixed = T)
for (i in 1:length(FWFlines)) FWFlines[i] <- gsub("-", " - ", 
                                                  FWFlines[i], fixed = T)
FWFlines <- FWFlines[which(gsub(" ", "", FWFlines) != "")]
Char=grepl("$",FWFlines,fixed=TRUE)
FWFlines <- gsub("$","",FWFlines,fixed=TRUE)
FWFlines <- gsub("\\.\\d+","",FWFlines)
FWFlines <- gsub(".","",FWFlines,fixed=TRUE)
FWFlines <- gsub("@","",FWFlines)
z <- t(sapply(FWFlines,function(x){unlist(strsplit(x,split =  "\\s+"))}))
if(!is.null(sel)){vars<-is.element(z[,2],sel)}
y<-data.frame(varname=z[vars,2],start=strtoi(z[vars,1]),end=strtoi(z[vars,1])+strtoi(z[vars,3])-1,char=Char[vars],stringsAsFactors = FALSE)
col_types=col_types[z[,2][vars]]
X=readr::read_fwf(fn,readr::fwf_positions(start=y$start,end=y$end,col_names=y$varname),col_types = col_types)

