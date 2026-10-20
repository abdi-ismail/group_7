# Fitbit Dashboard Requirements

## Data
### Activity intensity

- The dashboard shall enable users to view the distribution of activity intensity across a selected day.
- The dashboard shall enable users to view activity intensity by hour of the day.
- The user should be able to compare calories burnt against activity hours and activity type

### Sleep

- The dashboard shall display sleep duration for each user.
- The dashboard shall calculate and display a rolling 7-day average of sleep duration.

### Steps

- The dashboard shall display the total number of steps recorded for each day of the selected ID
- When a user selects a daily step target the dashbaord shall plot a line at the target to help indicate the days where the target has been met.

### Calories

- The user should be able to see the expended calories up until that point in the day from 00:00:00
- Users should be able to see at what minute(s) an activity expended the most calories

### Heart rate

- Where the dashboard displays a K-Means clustering of heart rate data, the dashboard shall provide a numeric input control that enables the user to specify the number of clusters, k, where k is an integer in the range 2 to 5 inclusive.

## General
- The dashboard shall ingest Fitbit data from CSV files.
- The dashboard shall be accessible through a web browser via a Shiny web application.

## Participant selection and filtering

- When a user specifies a user ID, the system shall filter the Fitbit data to display records associated with the specified user ID.
- We SHALL give individuals recognisable names instead of the identifier code (e.g. 2022484408) used in the source data.
- When a user selects a date or date range, the dashboard shall update relevant visualisations to display data from the selected period.
- While dashboard filters are applied, the dashboard shall clearly indicate the current selection or filtering context to the user.

## Summaries and overview

- The dashboard shall display a summary of all available Fitbit data types, including sleep, activity intensity, and heart rate, to provide an overview of key metrics.
- The dashboard shall display a summary of participant activity including sedentary, lightly active, fairly active and very active minutes.

## Participant comparison and grouping

- The dashboard shall enable users to compare activity levels between participants.
- User should be able to see their average calorie expenditure as a percentile of other users for the week.
- When the user selects a date the dashabord shall display the average step count of all users.
- User should be able to create participant groups, by either ID numbers, metrics or percentile.


## Colour, charts and usability

- The dashboard shall use a consistent colour palette across all visualisations and interface elements.
- All other variables (sleep, step count etc) SHALL also be assigned a unique colour. i.e (red for heart rate, blue for sleep)
- The dashboard shall use appropriate charts to clearly communicate trends and relationships within the Fitbit data.
- IF there is anything that isn't self-explanatory on the dashboard, we SHALL use a TOOLTIP information icon which reveals an explanation when a curser hovers over it.

## Errors, missing data and alerts

- If an error occurs while loading the dashboard, the system shall inform the user of the error.
- If no steps were recorded on the date selected for the given user ID then the dashboard shall show a message indicating no data is available.
- User should be given an alert if there is a sudden change in ID behaviour, loss of data, data anomalies to identify failing device or health concern.

## Performance

- Render times for all elements SHALL be under two seconds.
