#' Bind monthly datasets together
#' 
#' @param startingmonth a character string that is a date in the format "%Y%m" between "200501" and "201201".
#' @param endmonth a character string that is a date in the format "%Y%m" between "200501" and "201201".
#' @return a vector
#' @examples 
#' monthsinperiod("200510","200602")

monthsinperiod <- function(startingmonth="200501",endmonth="201201"){
  format(seq(as.Date(paste(startingmonth,"01"), "%Y%m%d"),
                        as.Date(paste(endmonth,"01"), "%Y%m%d"),
                        by="month"), "%Y%m")}

#' Bind monthly datasets together
#' 
#' @param list.tables a list of tables
#' @param w a character string: name of the  weights variable (should be the same in all tables)
#' @param list.y a vector of variable names
#' @param id a character string: name of the identifier variable  (should be the same in all tables)
#' @param groupvar a character string: name of the  rotation group variable (should be the same in all tables)
#' @param groups_1 a character string:
#' @param groups0  if \code{groupvar} is not null, a vector of possible values for L[[groupvar]]
#' @return
#' @seealso CompositeRegressionEstimation::AK
#' @examples
#' rbind_period(startingmonth="200501",endmonth="200503",c("pemlr","pwsswgt"))

rbind_period<-function(startingmonth="200501",endmonth="201201",variables=NULL){
  period=monthsinperiod(startingmonth,endmonth)
  names(period)<-period
  plyr::ldply(period,function(pp){
    DD<-get(data(list=paste0("cps",pp),package="dataCPS",envir = environment()),envir=environment())
    if(is.null(variables)){DD}else{DD[variables]}},
    .id="month")}

