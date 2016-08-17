.onLoad<- function(libname, pkgname) {
  deb=as.Date("20050101","%Y%m%d")
  fin=as.Date("20130110","%Y%m%d")
  Months<-seq(deb,fin,by="month")
  if(!all(is.element(tolower(paste0("cps",format(Months,"%Y%m"),".rda")),
                     list.files(file.path(find.package("dataCPS"),"data"))))){
    packageStartupMessage("This is the first time the package dataCPS is loaded. Data is going to be downloaded from the Census Website.
                          A connection to the web is needed.")
    z=find.package("dataCPS")
    if(!file.exists(file.path(z,'data'))){dir.create(file.path(z,'data'))}
    library(readr)
    
    sapply(seq(deb,fin,by="month")[!is.element(tolower(paste0("cps",format(Months,"%Y%m"),".rda")),
                                       list.files(file.path(find.package("dataCPS"),"data")))],function(m){
                                         
    get_data_from_web(m,m,
      directory=file.path(z,'data'),
      createdatabase=FALSE,
      createrdafiles=TRUE)})
  }}