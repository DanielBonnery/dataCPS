#' List of format change dates.
format.change.dates<-as.Date(paste0(c("199401","199404","199506","199509","199801","200301","200405","200508","200701","200901","201001","201205","201301"),"01"),"%Y%m%d")#,"201401","201501")

#' Last format change date.
#' 
#' @param m a character string
#' @details 
#' this is valid as long as the Census.gov website does not change it. 
#' @examples 
#' last.format.change.date.f(as.Date("20050101","%Y%m%d"))
last.format.change.date.f<-function(m){max(format.change.dates[format.change.dates<=m])}

#Zip file name
cpszipfilenamef<-function(m){paste0(tolower(format(m,"%b%y")),"pub.zip")}
#' get the URL of format file as a function of month
#' @param m a character string
#' @details 
#' this is valid as long as the Census.gov website does not change it. 
#' @examples 
#' URLf(as.Date("20050101","%Y%m%d"))
URLf<-function(m){paste0("http://thedataweb.rm.census.gov/pub/cps/basic/",format(last.format.change.date.f(m),"%Y%m"),"-")}

#' name of the instruction file name  as a function of month
#' @param m a date
#' @details 
#' this is valid as long as the Census.gov website does not change it. 
#' @examples 
#' instructionfilenamef(as.Date("20050101","%Y%m%d"))
instructionfilenamef<- function(m){paste0('cpsb',tolower(format(m,"%b%y")),".sas")}
#` CPS R table name function

#' @param m a date
#' @details 
#' construct a table name as a function of month
#' @examples 
#' cps.tablenamef(as.Date("20050101","%Y%m%d"))
cps.tablenamef <- function(m){tolower(paste0("cps",format(m,"%Y%m")))}

#' CPS data table name function
#' @param m a date
#' @details 
#' construct a table name as a function of month
#' @examples 
#' dat.file.name.f(as.Date("20050101","%Y%m%d"))
dat.file.name.f <- function(m){paste0(cps.tablenamef(m),".dat")}

#' Download and unzip cps microdata file for month m function
#' @param m a date
#' @returns a character string, the path to the unzipped file
#' @details 
#' download a zip file and unzip it in a temporary directory
#' @examples 
#' download.unzip.cpsmicrodata(as.Date("20050101","%Y%m%d"))
download.unzip.cpsmicrodata<-function(m){
  file.location<-file.path( URLf(m),cpszipfilenamef(m))
  try(download.file(file.location, file.path(tempdir(),cpszipfilenamef(m)) , mode = "wb" ))
  unzip(file.path(tempdir(),cpszipfilenamef(m)) ,exdir = tempdir())
  newname<-file.path(tempdir(),dat.file.name.f(m))
  file.rename(from = file.path(tempdir(),unzip(file.path(tempdir(),cpszipfilenamef(m)) ,list=TRUE)$Name),
              to=newname)
  file.remove(file.path(tempdir(),cpszipfilenamef(m)))
  newname}

#' Instruction file  download function
#' @param m a date
#' @returns a character string, the path to the unzipped file
#' @details 
#' download the instruction file for a specific month
#' Not any month is valid
#' @examples 
#' download.instruction.file(as.Date("20040501","%Y%m%d"))
download.instruction.file <- function(m){
  download.file(url=file.path( "http://www.nber.org/data/progs/cps-basic",instructionfilenamef(m)),
                mode="wb",
                destfile=file.path(tempdir(),instructionfilenamef(m)))}

#'Create an R file function
#' @param m a date
#' @details 
#' creates a SQLite database if not existing and loads a downloaded file into it.  
#' @examples 
#' download.instruction.file(as.Date("20040501","%Y%m%d"))

#For database:
addtodb <- function(m){     
  db <- dbConnect( SQLite(),
                   file.path(tempdir(),cps.dbname) )
  read.SAScii.sqlite ( 
    file.path(tempdir(),dat.file.name.f(m)), 
    fileinstructionfilenamef(m) , 
    zipped = FALSE ,
    tl = TRUE ,
    tablename = cps.tablenamef(m) ,
    conn = db )
  dbDisconnect( db )}

clean<-function(){sapply(list.files(tempdir()),unlink)}
#' Downloads and extract data for one specific month
#' @param m  a character string in the Date format %Y%m
#' @param returnvalue a boolean
#' @param createrdafiles a boolean
#' @param directory a character string (Default tempdir())
#' @param varlist a character string vector
#' @param cps.dbname (Default "cps.db")
#' @param coltypes a named character string vector,
#' @examples 
#' DD<-get_onemonth_data_from_web(
#' m=as.Date("20050101","%Y%m%d"))
#' plot(DD[c(5,9)])
#' names(DD)

get_onemonth_data_from_web <- function(m,
                     returnvalue=TRUE,
                     createdatabase=FALSE,
                     createrdafiles=FALSE,
                     directory=tempdir(),
                     varlist=NULL,
                     col_types  =NULL,
                     cps.dbname="cps.db"){
  x=download.unzip.cpsmicrodata(m)
  y=SAScii::read.SAScii3(
    fn=x, 
    sas_ri=file.path(tempdir(),instructionfilenamef(last.format.change.date.f(m))),
    col_types=col_types,sel=varlist)# , zipped = FALSE)]
  if(is.element("pwsswgt",names(y))){y$pwsswgt=y$pwsswgt/10000}
  if(is.element("pwcmpwgt",names(y))){y$pwcmpwgt=y$pwcmpwgt/10000}
  #if(is.element("pemlr",names(y))){y$pemlr=as.factor(y$pemlr)}
    if(createrdafiles){
      assign( cps.tablenamef(m),y)
      eval(parse(text=paste0("save(",cps.tablenamef(m),",file='",file.path(directory,cps.tablenamef(m)),".rda')")))}
    if(createdatabase){addtodb(m)}
    unlink(x)
    return(if(returnvalue){y}else{NULL})}


#' downloads CPS data from web
#' 
#' @param startingdate a date (default: \code{as.Date("20050101","%Y%m%d")})
#' @param endgdate a date (default: \code{startingdate})
#' @param varlist a vector of character strings, the variables to keep from the downloaded file
#' @param coltypes a vector of character strings, the variables to keep from the downloaded file
#' @param directory where to save the file 
#' @param createdatabase a boolean(default FALSE),
#' @param createrdafiles a boolean(default FALSE),
#' @param returnvalue a boolean
#' @param cps.dbname="cps.db"
#' @examples 
#' DD<-get_data_from_web(
#' startingdate=as.Date("20050101","%Y%m%d"),
#' varlist  =tolower(c('hryear4','hehousut')),
#' col_types  =list('hryear4'=col_character(),  'hehousut'=col_character()),
#' returnvalue=TRUE)
#' plot(DD)

  get_data_from_web<-function(
    startingdate=as.Date("20050101","%Y%m%d"),
    enddate=startingdate,
    varlist  =tolower(c(
      'pulineno',             
      'pwsswgt',
      'hrhhid',
      'hrlongid',
      'hrhhid2',
      'cpsid',
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
      'GESTREC',
      'hrintsta','hrmis')),
    col_types  =list(
      'pulineno'=col_character(),
      'pwsswgt'=col_double(),
      'hrhhid'=col_character(),
      'hrlongid'=col_character(),
      'hrhhid2'=col_character(),
      'cpsid'=col_character(),
      'pwcmpwgt'=col_double(),
      'hwniwgt'=col_double(),
      'pumlr'  =col_character() ,
      'pemlr'   =col_character(),
      'pehspnon'=col_character(),
      'prtage'=col_double(),
      'peage'=col_integer(),
      'pesex'=col_character()   ,
      'gestfips'=col_character(),
      'puhhmem' =col_character(),
      'prpertyp'=col_character(),
      'ptdtrace'=col_character(),
      'prwtrace'=col_character(),
      'prblnonb'=col_character(),
      'gestrec'=col_character(),
      'hrintsta'=col_character(),
      'hrmis'=col_character()
      ),
        directory=NULL,
    createdatabase=FALSE,
    createrdafiles=FALSE,
    returnvalue=TRUE,
    cps.dbname="cps.db"){
    monthseq<-seq(startingdate,enddate,by="month")
    if(createdatabase){
      if ( file.exists( file.path(tempdir() , cps.dbname ) ) ){
        warning( "the database file already exists in your working directory.\nyou might encounter an error if you are running the same year as before or did not allow the program to complete.\ntry changing the cps.dbname in the settings above." )}}
    sapply(unique(do.call(c,lapply(monthseq,last.format.change.date.f))),download.instruction.file)
    lapply(monthseq,get_onemonth_data_from_web,createdatabase=createdatabase,createrdafiles=createrdafiles,varlist=varlist,col_types=col_types,returnvalue=returnvalue,directory=directory)
    NULL}
  
  
  
  #paste0("cps",tolower(format(m,"%Y%m")))
  vartab<-function(m){
    con <- dbConnect( SQLite() , paste(dpath,cps.dbname,sep="/") )
    
    dd <- data.table(dbGetQuery(con,paste0( "SELECT *
 from ",cps.tablenamem(m), " LIMIT 1")))  
    dbDisconnect(con)
    
    return(!is.element(varlist,names(dd)))}
  #tt <- sapply(lmonyea,vartab)
  #varlist[apply(tt,1,any)]
  #varlist[apply(tt,1,all)]
  #cbind(varlist,apply(tt,1,sum))



creeRtablefromDB<-function(m){
  conn  <- dbConnect( SQLite() , paste(dpath,cps.dbname,sep="/") )
  dn <- names(data.table(dbGetQuery(conn,paste0( "SELECT *
 from ",cps.tablenamem(m), " LIMIT 1"))))
  peage <- intersect(c('peage','prtage'),dn)
  
  dd <- data.frame(dbGetQuery(conn,tolower(paste0( "SELECT
 hrlongid,
 hrhhid,
 hrhhid2,
 cpsid,
             pulineno,
             pwsswgt,
             pwcmpwgt,
             pemlr as pumlr,"
            ,peage, " as peage,
             PESEX   ,
             GESTFIPS,
             prpertyp
 from ",cps.tablenamem(m)))))  
  dbDisconnect(conn)
  return(dd)}

if(FALSE){
  load("nov05cps.Rdata")
  usePackages("plyr")
  nov05cps<-rename(nov05cps,c("hrlongid"="hrhhid",
                              "pumlr"="pemlr","pesex"="PESEX","gestfips"="GESTFIPS"))
  conn <- dbConnect(SQLite() , paste(dpath,cps.dbname,sep="/"))
  dbRemoveTable(conn,"nov05cps")
  dbWriteTable(conn, "nov05cps", nov05cps)
  dbDisconnect(conn)
}

