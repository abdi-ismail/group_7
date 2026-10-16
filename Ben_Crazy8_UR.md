## Ben's Crazy 8 User Requirement ideas

<br>

We **SHALL** include a radio button or dropdown menu to select the data
for an individual person in the dataset.

We **SHALL** give individuals recognisable names instead of the
identifier code (e.g. 2022484408) used in the source data.

**When** an individual is selected, their name **SHALL** be clearly
visible on the dashboard.

**IF** there is anything that isn't self-explanatory on the dashboard,
we **SHALL** use a TOOLTIP information icon which reveals an explanation
when a curser hovers over it.

**IF** we include a plot of my K-Means heart rate clusters, we **SHALL**
have a numeric input box allowing the user to choose between 2, 3, 4 or
5 clusters. A similar example is [here](https://shiny.posit.co/r/gallery/start-simple/kmeans-example/)

Render times for all elements **SHALL** be under two seconds.

All plots **SHALL** use red for any visualisation of heart rate data.

All other variables (sleep, step count etc) **SHALL** also be assigned a
unique colour.

<br>

**Addendum:**

This code was used in the RStudio console to convert Word to Markdown

`rmarkdown::pandoc_convert("document.docx", to = "markdown", output =
"document.md")`
