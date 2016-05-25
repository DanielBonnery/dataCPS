\name{aspepXXXX_gov}
\alias{aspep2007_gov}
\alias{aspep2009_gov}
\alias{aspep2010_gov}
\alias{aspep2011_gov}
\alias{aspep2012_gov}
\docType{data}
\title{aspep}
\description{

}
\usage{data(aspep2007_gov)}
\format{
 These tables contain data from the Annual Survey of Public employment and Payroll.
 The primary key of all those datasets is  "id".
  All payroll and part-time hours in the data file are 31-day monthly equivalent values for the month of March.
 This documentation is based on the following file:
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
\item{state}{state}
\item{type_of_gov}{Type of government}
\item{county}{County code}
\item{unit_identification_number}{Unit}
\item{supp_code}{Supplement Code}
\item{sub_code}{Sub code}
\item{name}{Name of the government/Political Description}
\item{census_region}{Census region code}
\item{county_name}{County name}
\item{fips_state}{FIPS state (NA for 2002)}
\item{fips_county}{FIPS county (NA for 2002)}
\item{pefcode}{Population/Enrollment/Function Code}
\item{yearpop_enroll}{Year of Population/Enrollment}
\item{school_level_code}{School Level code}
\item{sample_weight}{Sample Weight}
\item{weekly_hours_code}{Weekly Hours Code }
\item{ftpaycode}{Full-time Pay Code }
\item{ptpaycode}{Part-time Pay Code }
\item{number_of_months_teachers_paid}{Number of Months Teachers Paid}
\item{number_of_months_school_admin_paid}{Number of Months School Admin Paid}
\item{number_of_months_school_other_paid}{Number of Months School Other Paid}
\item{year_of_data}{(Year of Data except dependent school data)
99 = response for 1999
II = data imputed
NN = No information for this unit }
\item{year_of_dependent_school_data}{Year of Dependent School Data}
\item{survey_form_type}{Survey Form Type}
}
}
\source{\url{https://www.census.gov/govs/apes/},

\url{http://www.census.gov/govs/apes/historical_data.html}

See also for documentation about id p25:  \url{http://www2.census.gov/govs/pubs/classification/2006_classification_manual.pdf}
}

\keyword{datasets}
  