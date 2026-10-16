# Individual Findings

## John

The intensity subset contains daily, hourly and minute-level Fitbit activity data for 33 participants, covering 12/04/2016 to 12/05/2016. 

Initial exploration in R identified 0 missing values and 0 duplicate records. 

The intensity data are provided at three levels of granularity. *dailyIntensities_merged.csv* contains one row per participant per day, summarising sedentary, lightly active, fairly active and very active minutes and associated distances. *hourlyIntensities_merged.csv* provides one row per participant per hour, containing total and average activity intensity. Minute-level intensity is provided in two structures. *minuteIntensitiesNarrow_merged.csv* uses a long format, with each row representing a participant's intensity value for a single minute. *minuteIntensitiesWide_merged.csv* uses a wide format, with each row representing an hour and separate columns (Intensity00 to Intensity59) containing the intensity recorded for each minute.


