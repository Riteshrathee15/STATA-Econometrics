clear all
use "C:\Users\Ritesh Rathee\OneDrive\Desktop\University\SEM 2\Econometrics\Dta\HappinessAlcoholConsumption.dta"

**Descriptive Statistics
describe
summarize

sum happinessscore
histogram happinessscore
generate loghappinessscore = log(happinessscore)
sum loghappinessscore
histogram loghappinessscore

sum hdi
histogram hdi
generate loghdi = log(hdi)
sum loghdi
histogram loghdi

sum gdp_percapita
generate loggdp_percapita = log(gdp_percapita)
sum loggdp_percapita
histogram gdp_percapita
histogram loggdp_percapita

sum beer_percapita
histogram beer_percapita
generate logbeer_percapita = log(beer_percapita)
sum logbeer_percapita
histogram logbeer_percapita

sum spirit_percapita
histogram spirit_percapita
generate logspirit_percapita = log(spirit_percapita) 
sum logspirit_percapita
histogram logspirit_percapita
 
sum wine_percapita
histogram wine_percapita
generate logwine_percapita = log(wine_percapita)
sum logwine_percapita
histogram logwine_percapita

twoway scatter loghappinessscore loggdp_percapita

**Initial Regression
regress loghappinessscore loghdi loggdp_percapita logbeer_percapita logspirit_percapita logwine_percapita

**Checking Correlation
vif 
correlate loghappinessscore loghdi loggdp_percapita logspirit_percapita logbeer_percapita logwine_percapita

**About Residuals
predict yhat
predict uresid, resid
predict sresid, rstandard
predict resi, rstu

**Use residuals plot to assess the assumption is met :
twoway scatter resi yhat, yline(0)

**Outliers
generate absVrstu=abs(resi)
 
**Sort on that new varaible
 sort absVrstu
 list country resi absVrstu
 list country resi absVrstu in 111/122

**heterodeskacity
estat hettest
reg loghappinessscore loghdi loggdp_percapita logbeer_percapita logwine_percapita


**White Test
regress loghappinessscore loghdi loggdp_percapita logbeer_percapita logwine_percapita
regress loghappinessscore loghdi loggdp_percapita logbeer_percapita logwine_percapita,vce(robust)

**Endogeneous
regress logbeer_percapita loghdi loggdp_percapita logwine_percapita, vce(robust)
predict beer_hat, xb

**IV Regression
regress loghappinessscore beer_hat loghdi loggdp_percapita logwine_percapita, vce(robust)
ivregress 2sls loghappinessscore loghdi loggdp_percapita logwine_percapita (beer_hat = logbeer_percapita), vce(robust)
ivregress 2sls loghappinessscore loghdi loggdp_percapita (beer_hat = logbeer_percapita), vce(robust)