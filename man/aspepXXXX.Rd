\name{aspepXXXX}
\alias{aspep2007}
\alias{aspep2009}
\alias{aspep2010}
\alias{aspep2011}
\alias{aspep2012}
\docType{data}
\title{aspep}
\description{

}
\usage{data(aspep2007)}
\format{
 These tables contain data from the Annual Survey of Public employment and Payroll.
 The primary key of all those datasets is  "id" and "itemcode".
See \url{http://www.census.gov//govs/apes/gov_data_layout_07.html}.
  \describe{
    \name{aspepXXXX}

\item{ id }{Govenment integrated ID: 
The government unit code is the basic identification system used by the Census Bureau to keep track 
of all governments and their dependent agencies.  The code is a 14 digit, numeric identifier.  The 
format is: 
SS T CCC UUU SUP SB   
where:  
SS = state  
T = type of government    
CCC = county area within the state 
UUU = unit code within the county area 

SUP = supplemental unit code, for de
pendent agencies of the parent unit 

SB = subsidiary code for dependent agencies that require separate data collection / canvassing    
The following parameters and rules apply to the code structure: 

SS is a numeric sequence assigned to the states alphabetically – Alabama is 01, Alaska 02, and 
so forth, until Wyoming at 51.  Note the District of Columbia is assigned code 09 and the U.S. 
Federal Government is assigned code 00. 

T represents type of government, as defined by 
the Census Bureau. See type_of_gov

CCC, the county area codes, are assigned alphabetically within each state area, although there 
are some exceptions where county consolidations
 have taken place or new counties have been 
created.                                                                 

The unit code UUU identifies a specific government
 within the state, county, and type of 
government sequence.  They, too, are generally alphabetical within the county area and type of 
government combination, but exceptions exist (especially for special districts).  The unit code 

}
\item{itemcode}{Data Function (Item) Code: 
See \url{http://www.census.gov//govs/apes/data_function_item_codes.html} for more details.
}
\item{ ftemp}{Number of full time  employees }
\item{ fteemp}{Full-time equivalent employyes}
\item{ ftpay }{Full-time payroll }
\item{ ptemp }{Number of part-time employees }
\item{ ptpay }{Part-time payroll}

}
}
\source{\url{https://www.census.gov/govs/apes/},

\url{http://www.census.gov/govs/apes/historical_data.html}

See also for documentation about id p25:  \url{http://www2.census.gov/govs/pubs/classification/2006_classification_manual.pdf}
}

\keyword{datasets}
  