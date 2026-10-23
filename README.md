------------------------------------------------------------------------

# Group 7 - Data Dashboard

------------------------------------------------------------------------

## How to run the app

To run the dashboard locally on your machine, follow these steps:

1.  Clone the Repository (Ben's branch): git clone -b Ben <https://github.com/abdi-ismail/group_7.git>

2.  Open the Project: Double-click the `Dashboard.Rproj` file to launch RStudio with the correct working directory automatically configured.

3.  Install Dependencies: Ensure all required packages are installed by opening `libraries.R` and running the file, or execute: source("libraries.R")

4.  Run the Dashboard: Open `app.R` in RStudio and click the **Run App** button in the top right of the editor, or execute: shiny::runApp()

------------------------------------------------------------------------

## Repository Structure

``` text
group_7/
├── Dashboard.Rproj    # RStudio Project file (sets working directory)
├── app.R              # Main Shiny dashboard application script
├── Prep_File.R        # Data cleaning & preparation file which is sourced by app.R
├── libraries.R        # R packages required by the project, sourced by app.R
├── data/              # Processed datasets used by the application
├── www/               # Custom images used in the app.
└── Other/             # Project documentation, research notes, and test scripts
```

------------------------------------------------------------------------
