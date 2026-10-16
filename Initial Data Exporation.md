# Individual Findings

## John

The intensity subset contains daily, hourly and minute-level Fitbit activity data for 33 participants, covering 12/04/2016 to 12/05/2016. 

Initial exploration in R identified 0 missing values and 0 duplicate records. 

The intensity data are provided at three levels of granularity.
 - **dailyIntensities_merged.csv** contains one row per participant per day, summarising sedentary, lightly active, fairly active and very active minutes and associated distances.
 - **hourlyIntensities_merged.csv** provides one row per participant per hour, containing total and average activity intensity. Minute-level intensity is provided in two structures.
 - **minuteIntensitiesNarrow_merged.csv** uses a long format, with each row representing a participant's intensity value for a single minute.
 - **minuteIntensitiesWide_merged.csv** uses a wide format, with each row representing an hour and separate columns (Intensity00 to Intensity59) containing the intensity recorded for each minute.


## Greg

The "Calories" data has 4 csv': Minute Wide, Minute Narrow, Hourly and Daily. Minute Wide and Narrow are simply csv layout 
differences. They contain 33 unique user ID's over 30 days from 12-APR-2016 00:00:00 through to 12-MAY-2016 15:59:00. 

Only the Narrow Minute Calorie data has been used for the exploratory analysis in R Studio.

CSV's have been checked for missing data using colSums(is.na(df_xxx)): **0 missing data found.**

Below is a brief overview of the data layout:

**Calories Minute (Narrow)**: Rows: 1,325,580, Columns: 3. Details the user ID, the Activity minute (in dd/mm/yyyy HH:mm:ss AM/PM format) and the Calories burnt.

**Calories Hourly**: Rows: 22,099, Columns: 3.  Details the user ID, the Activity start hour (in dd/mm/yyyy HH:mm:ss AM/PM format) and the Calories burnt.

**Calorie Daily** Rows: 940, Columns: 3. Details the user ID, the Activity day (in dd/mm/yyyy format) and the Calories burnt.

A quick histogram/box plot analysis shows circadian style rhythm throughout the day for calories burnt, little variations for days across the week and a skewed bell shaped curve distribution across user ID/Dayaggregate's.

<img width="1728" height="960" alt="image" src="https://github.com/user-attachments/assets/663897ca-d6eb-4e57-9e37-51c632c05700" />
<img width="1728" height="960" alt="image" src="https://github.com/user-attachments/assets/f78cf53f-c359-423d-8079-7770e813680f" />

<img width="1728" height="960" alt="image" src="https://github.com/user-attachments/assets/fc23c3ad-8977-436e-b5ef-9c67f963de43" />


