
<main>
  <h2>House Price Prediction &#127968;&#128178;</p></h2>
  <h3> With R </h3>
  <p>Data Set</p>
  <p>The data set includes the house price and orther information of houses from Poland in 2021.<p>
  <p>Source : https://www.kaggle.com/datasets/dawidcegielski/house-prices-in-poland.<p>
  <P>Contain 23764 observations and 11 variables.<p>
  <P>address - Full addres ;city - Warszawa (Warsaw), Kraków (Cracow), Poznań (Poznan).;
  floor - The number of the floor where the apartment is located; id - id ; latitude - latitude ; longitude - longitude;
  price - Price of apartment in PLN [TARGET] ; rooms - Number of rooms in the apartment ; sq - Number of square meters of the apartment ; year - Year of the building / apartment
  <article>
    <h4>R Packages</h4>
    <p><h6>tidyverse | magrittr | rsample| broom | modelr| GGally| ggplot2| car| lindia | MLmetrics</h6><p>
  </article>

  <article>
    <h3>Data Wrangling</h3>
    <p><h6>Data Cleaning – No missing Values in the dataset.<h6><p>
    <p>There are outliers in many variables, and the median values take their place.<p>
    <p>New variable is created using the built year of house.<p>
    <p>Training and testing test are splitted using SRS with 70% and 30% samples. </p> 
  </article>

  <article>
    <h3>Model Fitting </h3>
    <p><h6>Multiple linear regression model is created with one categorical variable (two dummies)
    <p>Normality assumption is checked.<p>
    <p>Multicollinearity is tested.<p>
    <p>Influential cases are tested.<h6><p>
</p>
  </article>
</main>

<h3> With Python </h3>

<article>
    <h4>R Packages</h4>
    <p><h6>sklearn | numpy | matplotlib| pandas | seaborn
  </article>
  
  <article>
    <h4>R Packages</h4>
    <p><h6> * Outliers are handled
    <p>* Performed Correlation Analysis 
    <p> * Dummy Variables are created
    <p> *Calculate Adjusted R squared value
    <p> Calculated RMSE & mean absolute error (MAE)
    <p> Checked the normality Assumption using histogram and Kolmogorov smirnov test
  </article>

