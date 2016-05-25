cps.dbname <- "cps.db"
monthseq<-seq(startingdate,enddate,by="month")
if ( file.exists( file.path(tempdir() , cps.dbname ) ) ){
  warning( "the database file already exists in your working directory.\nyou might encounter an error if you are running the same year as before or did not allow the program to complete.\ntry changing the cps.dbname in the settings above." )}

library("RSQLite")     
library("data.table")
library("downloader")
library("descr")                 # load the descr package (converts fixed-width files to delimited files)
library("downloader")        # downloads and then runs the source() function on scripts from github
#source_url( "https://raw.github.com/ajdamico/usgsd/master/SQLite/read.SAScii.sqlite.R" , prompt = FALSE )
devtools::install_github("DanielBonnery/SAScii")

format.change.dates<-as.Date(paste0(c("199401","199404","199506","199509","199801","200301","200405","200508","200701","200901","201001","201205","201301","201401","201501"),"01"),"%Y%m%d")
last.format.change.date.f<-function(m){max(format.change.dates[format.change.dates<=m])}

#Zip file name
cpszipfilenamef<-function(m){paste0(tolower(format(m,"%b%y")),"pub.zip")}
URLf<-function(m){paste0("http://thedataweb.rm.census.gov/pub/cps/basic/",format(last.format.change.date.f(m),"%Y%m"),"-")}
#Download a zip file function
download.unzip.cpsmicrodata<-function(m){
    file.location<-file.path( URLf(m),cpszipfilenamef(m)) 
    download.file(file.location, file.path(tempdir(),cpszipfilenamef(m)) , mode = "wb" )
    unzip(file.path(tempdir(),cpszipfilenamef(m)) ,exdir = tempdir())
    unzip(file.path(tempdir(),cpszipfilenamef(m)) ,list=TRUE)$Name}

paste0("cps",tolower(format(m,"%Y%m")))

#Instruction file  download function
download.instruction.file <- function(m){
  download.file(url=file.path( "http://www.nber.org/data/progs/cps-basic",instructionfilenamef(m)),
                mode="wb",
                destfile=file.path(tempdir(),instructionfilenamef(m)))}
#Instruction file name function 
instructionfilenamef<- function(m){paste0('cpsb',tolower(format(m,"%b%y")),".sas")}
#CPS table name  function
cps.tablenamef <- function(m)t{olower(paste0(tolower(format(m,"%b%y")),"pub.zip"))}
#Create an R file function
creeRfile <- function( cps.tablename,instructions){
    read.SAScii( 
        cps.tablename, 
        instructions , 
        zipped = FALSE)}
creeRfilem <- function(m){    
    assign( cps.tablenamem(m),
           creeRfile( cps.tablenamem(m), 
                      instructionfilenamef(m))
           ,env=parent.frame)}
#For database:
addtodb <- function(m){     
    db <- dbConnect( SQLite() , paste(dpath,cps.dbname,sep="/") )
    read.SAScii.sqlite ( 
        cps.tablenamem(m) , 
        instructionfilenamef(m) , 
        zipped = FALSE ,
        tl = TRUE ,
        tablename = cps.tablenamem(m) ,
        conn = db )
    dbDisconnect( db )}

                                        #lapply(lmonyea,telzipfile)

#lapply(list('bjan13','bmay12','bjan10','bjan09','rwdec07','bjan07','baug05','bmay04'),telinstructionfile)
#lapply(lmonyea,creeRfile)

allsteps <- function(m){
    print(cps.tablenamem(m))
    x=download.unzip.cpsmicrodata(m)
    unzipfile(m)
    addtodb(m)
    file.remove(cps.tablenamem(m),
                zipfilename(m))}
#dbSendQuery(db, "DROP TABLE IF EXISTS may11cps")

get_data_from_web<-function(
  startingdate=as.Date("20050101","%Y%m%d"),
  enddate=as.Date("20130110","%Y%m%d")){
  
  sapply(sapply(format.change.dates,download.instruction.file)
  lapply(monthseq,allsteps)
  sapply(unique(sapply(lmonyea,instructionfile)),file.remove)}

varlist  <- tolower(c(
             'pulineno',             'pwsswgt',
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
downloadcps <- function(){
    lapply(lmonyea,allsteps)
}


creeRtablefromDB<-function(m){
  conn  <- dbConnect( SQLite() , paste(dpath,cps.dbname,sep="/") )
dn <- names(data.table(dbGetQuery(conn,paste0( "SELECT *
 from ",cps.tablenamem(m), " LIMIT 1"))))
  peage <- intersect(c('peage','prtage'),dn)

  dd <- data.frame(dbGetQuery(conn,tolower(paste0( "SELECT
 hrhhid as hrlongid,
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
nov05cps<-rename(nov05cps,c("hrlongid"="hrhhid","pumlr"="pemlr","pesex"="PESEX","gestfips"="GESTFIPS"))
conn <- dbConnect(SQLite() , paste(dpath,cps.dbname,sep="/"))
dbRemoveTable(conn,"nov05cps")
dbWriteTable(conn, "nov05cps", nov05cps)
dbDisconnect(conn)
}
}

