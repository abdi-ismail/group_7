# This file loads the relevant CSVs
# Performs some EDA and assigns values to variables used in the main app script.
# It also assigns nicknames to the four award winners based on their data.

source("libraries.R")

# Load CSV files
daily_activity <- read_csv("data/dailyActivity_merged.csv", show_col_types = FALSE)
sleep_day      <- read_csv("data/sleepDay_merged.csv", show_col_types = FALSE)
heart_rate     <- read_csv("data/heartrate_seconds_merged.csv", show_col_types = FALSE)

# Standardize date & datetime formats
daily_activity <- daily_activity %>% 
  mutate(Date = mdy(ActivityDate))

sleep_day <- sleep_day %>% 
  mutate(Date = as.Date(mdy_hms(SleepDay)))

# Heart rate is truncated to nearest hour to avoid the highly granular
# original data which picks up a heart rate every 5 seconds.
heart_rate <- heart_rate %>% 
  mutate(
    DateTime = mdy_hms(Time),
    Date     = as.Date(DateTime),
    Hour     = floor_date(DateTime, "hour") 
  )

# Aggregations per User
activity_summary <- daily_activity %>%
  group_by(Id) %>%
  summarise(
    avg_calories = mean(Calories, na.rm = TRUE),
    avg_steps = mean(TotalSteps, na.rm = TRUE),
    days_active = n(),
    .groups = "drop"
  )

sleep_summary <- sleep_day %>%
  group_by(Id) %>%
  summarise(
    avg_sleep_mins = mean(TotalMinutesAsleep, na.rm = TRUE),
    days_slept = n(),
    .groups = "drop"
  )

hr_summary <- heart_rate %>%
  group_by(Id) %>%
  summarise(
    min_hr = min(Value, na.rm = TRUE),
    total_hr_records = n(),
    total_hr_hours = n_distinct(Hour),
    .groups = "drop"
  )

# Daily Minimum Heart Rate per user
hr_daily_min <- heart_rate %>%
  group_by(Id, Date) %>%
  summarise(daily_min_hr = min(Value, na.rm = TRUE), .groups = "drop")

# Aggregate Heart Rate by Hour (for cleaner plotting)
hr_hourly <- heart_rate %>%
  group_by(Id, Hour) %>%
  summarise(avg_hr = mean(Value, na.rm = TRUE), .groups = "drop")



# Calculating averages of all users in the data for 'global average'
# benchmark on the ggplots
global_avg_calories <- mean(daily_activity$Calories, na.rm = TRUE)
global_avg_steps    <- mean(daily_activity$TotalSteps, na.rm = TRUE)
global_avg_sleep    <- mean(sleep_day$TotalMinutesAsleep, na.rm = TRUE) / 60 # in hours
global_avg_hr       <- mean(heart_rate$Value, na.rm = TRUE)

# Calculate overall group average daily minimum heart rate
global_avg_low_hr <- mean(hr_daily_min$daily_min_hr, na.rm = TRUE)

# Merge profiles together
user_profiles <- activity_summary %>%
  left_join(sleep_summary, by = "Id") %>%
  left_join(hr_summary, by = "Id")

# Identify IDs of the four category
# note that in order to win an award you must have at least 
# 5 days worth of data for the given metric.

furnace_id <- user_profiles %>% 
  filter(!is.na(avg_calories), days_active >= 5) %>% 
  slice_max(avg_calories, n = 1, with_ties = FALSE) %>% 
  pull(Id)

sleepy_id  <- user_profiles %>% 
  filter(!is.na(avg_sleep_mins), days_slept >= 5) %>% 
  slice_max(avg_sleep_mins, n = 1, with_ties = FALSE) %>% 
  pull(Id)

# Top 3 Heart Award contenders (lowest overall min_hr)
top3_hr_users <- user_profiles %>%
  filter(!is.na(min_hr)) %>%
  slice_min(min_hr, n = 3, with_ties = FALSE) %>%
  pull(Id)

lizard_id <- top3_hr_users[1] # 1st place
hr_2nd_id <- top3_hr_users[2] # 2nd place
hr_3rd_id <- top3_hr_users[3] # 3rd place

# Note I didn't end up using 2nd or 3rd place here, only lizard

ian_id     <- user_profiles %>% 
  filter(!is.na(avg_steps), days_active >= 5) %>% 
  slice_max(avg_steps, n = 1, with_ties = FALSE) %>% 
  pull(Id)

# Assign Nicknames & Full Display Names
user_profiles <- user_profiles %>%
  mutate(
Nickname = case_when(
  Id == furnace_id ~ "Furnace",
  Id == sleepy_id  ~ "ZZZ",
  Id == lizard_id  ~ "Lizard",
  Id == hr_2nd_id  ~ "Runner-Up 1",
  Id == hr_3rd_id  ~ "Runner-Up 2",
  Id == ian_id     ~ "H",
  TRUE             ~ paste0("User (", substr(as.character(Id), 1, 4), "...)")
),
FullName = case_when(
  Id == furnace_id ~ "Graham Furnace",
  Id == sleepy_id  ~ "Zack Z. Ziegler",
  Id == lizard_id  ~ "Chris 'The Lizard' Smith",
  Id == hr_2nd_id  ~ "Second Place Contender",
  Id == hr_3rd_id  ~ "Third Place Contender",
  Id == ian_id     ~ "Ian 'H' Watkins",
  TRUE             ~ Nickname
))

winner_ids <- c(furnace_id, sleepy_id, lizard_id, ian_id)

# create a dataframe with all the useful info for each award winner

winners_audit <- user_profiles %>%
  filter(Id %in% winner_ids) %>%
  select(FullName, Nickname, Id, avg_calories, days_active, avg_sleep_mins, days_slept, min_hr, total_hr_hours)
