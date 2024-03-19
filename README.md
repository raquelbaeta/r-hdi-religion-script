###
# Examining the Human Development Index and Non-religious Groups
### 

### Overview

This script analyses the relationship between the Human Development Index (HDI), population, and non-religious groups in various countries. The analysis includes data exploration, data cleaning, visualization, and linear regression.

### Requirements

To run this script, you'll need the following:

R packages: tidyverse, readr, ggplot2, car

### Script Structure

The script is divided into several sections:

1. Data Loading and Inspection: Loads the data set, checks for failures, and examines the structure of the data.
2. Data Selection: Selects relevant variables (country, population, HDI, and non-religious groups) for further analysis.
3. Data Transformation: Applies a logarithmic transformation to the population variable.
4. Missing Data: Checks for missing values and removes incomplete cases.
5. Data Visualization: Creates scatterplots to visualize the relationships between HDI, population, and non-religious groups, as well as other variables of interest.
6. Linear Regression: Estimates a linear regression model to predict HDI based on population and non-religious groups, and plots the regression results.

### Usage

Install the required packages:

install.packages(c("tidyverse", "readr", "ggplot2", "car"))

library(c(tidyverse, readr, ggplot2, car)

### Output

The script generates several scatterplots to visualise the data and a linear regression model with a corresponding plot. The main findings are presented in the "Linear Regression" section, which summarises the results of the regression analysis.

## Contributing

Contributions are welcome! If you find any issues or have suggestions for improvements, please open an issue or submit a pull request.

### Contact

For any questions or inquiries, please contact Raquel at raquelcbaeta.sa@gmail.com.

Last Updated: 2023-03-19
