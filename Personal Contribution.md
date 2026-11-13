# Personal Contribution – Gregory

## Exploratory Data Analysis

I began by conducting exploratory data analysis (EDA) on the calorie dataset.

***
The calorie dataset contains four CSV files: Minute Wide, Minute Narrow, Hourly, and Daily. The Minute Wide and Minute Narrow files represent the same data in different layouts. Together, they include 33 unique user IDs over a 30-day period from 12 April 2016 00:00:00 to 12 May 2016 15:59:00.

For the exploratory analysis, I focused on the Minute Narrow Calorie dataset in R Studio.

I checked the CSV files for missing data using `colSums(is.na(df_xxx))`, and no missing values were found.

Below is a brief overview of the data structure:

- Calories Minute (Narrow): 1,325,580 rows and 3 columns. Contains the user ID, activity timestamp (in dd/mm/yyyy HH:mm:ss AM/PM format), and calories burned.
- Calories Hourly: 22,099 rows and 3 columns. Contains the user ID, activity start hour (in dd/mm/yyyy HH:mm:ss AM/PM format), and calories burned.
- Calories Daily: 940 rows and 3 columns. Contains the user ID, activity date (in dd/mm/yyyy format), and calories burned.

A quick histogram and boxplot analysis showed a daily circadian pattern in calorie expenditure, limited variation across weekdays, and a right-skewed distribution in user-level daily aggregates.

![Calorie distribution overview](image-1.png)
![Hourly calorie patterns](image-2.png)
![Daily activity trends](image-3.png)

***

## Dashboard Requirements

I then defined the key dashboard requirements:

### Calorie data
1. Live calories  
   The user should be able to view the calories expended up to the current point in the day from 00:00:00.

2. Calories summation  
   The user should be able to view calories over a selected date range, such as hour, day, week, or custom periods.

3. Calories against activity hours  
   The user should be able to compare calories burned against activity hours and activity type.

4. Calorie deep dive  
   Users should be able to see key statistics, including the most calorie-intensive activities and peak hours of the day.

5. Calorie ranking  
   The user should be able to view their average calorie expenditure as a percentile relative to other users over the week.

6. Calories by minute  
   Users should be able to identify the minute(s) when an activity expended the highest calories.

### Generic
7. Grouping of IDs  
   Users should be able to create participant groups based on ID numbers, metrics, or percentiles.

8. Sudden change alert/warning  
   Users should receive alerts for sudden changes in behaviour, loss of data, or anomalous readings that could indicate a failing device or potential health concern.

***

These requirements were developed using the "Crazy 8s" method, and we carried forward the essential features needed for our minimum viable product (MVP).

## Dashboard Creation

The dashboard was created using R Shiny. Due to time constraints, we produced an MVP (Minimum Viable Product) rather than a fully featured end-state dashboard.


# WEEKLY LOG
Weekly Log 
# WC 12/10/26


Performed EDA on the Fitbit calories data in RStudio: four CSVs (Minute Wide/Narrow, Hourly, Daily), 33 user IDs, 12 Apr – 12 May 2016; used Minute Narrow (1,325,580 rows) and confirmed no missing data

Histograms and box plots revealed a  daily pattern, little day-of-week variation and a skewed distribution across users; documented findings for the dashboard design



# WC 19/10/26


Used Crazy 8s to brainstorm, then wrote eight requirements: six on calories (live view, date-range totals, versus activity hours, key stats, percentile ranking, minute-level peaks) and two generic (participant grouping; anomaly alerts); agreed MVP scope with the team
Reflection
Crazy 8s pushed me past obvious ideas towards users beyond the main participant, such as rankings and failing-device alerts. Rewriting sketch-like ideas as requirements made them easier to merge with the team's, though collating exposed vague terms like "sudden" that needed defining. Next time, I would define such terms while writing rather than at build stage.

# WC 26/10/26


Shiny; delivered an MVP covering the essential requirements within project time constraints
