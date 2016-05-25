\name{aspep2007_samplinginfo}
\alias{aspep2007_samplinginfo}
\docType{data}
\title{aspep2007_samplinginfo}
\description{
  
}
\usage{data(aspep2007_samplinginfo)}
\format{
  These table contain information on the design.
    \url{http://www.census.gov//govs/apes/gov_id_layout_07.html}
  \describe{
    \name{aspepXXXX_gov}
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
      SUP = supplemental unit code, for dependent agencies of the parent unit 
      SB = subsidiary code for dependent agencies that require separate data collection / canvassing    
    }
    \item{itemcode}{itemcode}
    \item{inSample }{In 2007 table, selection indicator }
    \item{stratum}{Factor variable for substratum
      Levels: "C1": initial certainty (determined by the survey director or customer(Bureau of Economic Analysis for example), this substratum contains all units which the customer want to see on the report),
      "C2" : the second certainty substratum corresponding to all units selected with certainty, as determined by the proc surveyselect sas procedure with the "method=pps" option used by the Census Bureau.
      "CF": corresponds to all units that were added to the sample after the intial sample was drawn, on the demand of the customer.
      "LG": Stratum containing large units, in the sense of the cutoff sampling method (See Cochran 129)
      "SM": Stratum containing small units, in the sense of the cutoff sampling method (See Cochran 129)
      "FU": Cutoff sampling method was applied to type 3 and 4 only. units of type 1, 2 and 5 that are not in one of the previous substrata will be put in "FU" ("FU" for full, no cutoff)}

}
\source{\url{https://www.census.gov/govs/apes/},
  
  \url{http://www.census.gov/govs/apes/historical_data.html}
  
  See also for documentation about id p25:  \url{http://www2.census.gov/govs/pubs/classification/2006_classification_manual.pdf}
}

\keyword{datasets}
