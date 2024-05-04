#### Model Evaluation And Regularization

# Changing Directory Location And Loading Libraries
setwd('/')
getwd()
#install.packages('tidyverse')
#install.packages('rlang')
#install.packages('tidymodels')
#install.packages('glmnet')
library(tidyverse)
library('rlang')
library('tidymodels')
library('glmnet')

# Loading Data For Modeling
url = "https://dax-cdn.cdn.appdomain.cloud/dax-airline/1.0.1/lax_to_jfk.tar.gz"
download.file(url, destfile = "lax_to_jfk.tar.gz")
untar('lax_to_jfk.tar.gz', tar = 'internal')

airline = read_csv('lax_to_jfk/lax_to_jfk.csv', col_types = 
	cols('DivDistance' = col_number(), 'DivArrDelay' = col_number()))

# Cleaning The Data
delay = airline %>% replace_na(list(CarrierDelay = 0, WeatherDelay = 0, 
	NASDelay = 0, SecurityDelay = 0, LateAircraftDelay = 0)) %>%
    select(c(ArrDelayMinutes, DepDelayMinutes, CarrierDelay, WeatherDelay, 
	NASDelay, SecurityDelay, LateAircraftDelay, DayOfWeek, Month))

# Splitting The Data Into Testing And Training Sets
set.seed(1234)
flight_split = initial_split(delay)
train_data = training(flight_split)
test_data = testing(flight_split)

# Setting Up Regression Model
lm_spec = linear_reg() %>% set_engine(engine = 'lm')

# Training The Model
(fit = lm_spec %>% fit(ArrDelayMinutes ~ DepDelayMinutes, data = train_data))
train_results = fit %>% predict(new_data = train_data) %>% 
	mutate(truth = train_data$ArrDelayMinutes)
head(train_results)

# Testing The Model
test_results = fit %>% predict(new_data = test_data) %>% mutate(truth = test_data$ArrDelayMinutes)
head(test_results)

# Evaluating The Models
## Train
rmse(train_results, truth = truth, estimate = .pred)
rsq(train_results, truth = truth, estimate = .pred)

## Test
rmse(test_results, truth = truth, estimate = .pred)
rsq(test_results, truth = truth, estimate = .pred)

# Plotting The Results
test_results %>% mutate(train = "testing") %>%
  bind_rows(train_results %>% mutate(train = "training")) %>%
  ggplot(aes(truth, .pred)) + geom_abline(lty = 2, color = 'blue', 
              size = 1.5) + geom_point(color = 'red', alpha = 0.5) +
  facet_wrap(~train) + labs(x = 'Truth', y = 'Predicted Arrival Delays (min)')

# Cross Validation
set.seed(1234)
cv_folds = vfold_cv(train_data, v = 10)
cv_results = fit_resamples(lm_spec, ArrDelayMinutes ~ DepDelayMinutes,
   resamples = cv_folds)

cv_results %>% collect_metrics()

cv_folds_2 = vfold_cv(train_data, v = 3)
cv_results2 = fit_resamples(lm_spec, ArrDelayMinutes ~ DepDelayMinutes, 
    resamples = cv_folds_2)
cv_results2 %>% collect_metrics()

# Regularization
recipe = recipe(ArrDelayMinutes ~ ., data = train_data)

## Ridge
ridge_spec = linear_reg(penalty = 0.1, mixture = 0) %>%
  set_engine("glmnet")
ridge_wf = workflow() %>% add_recipe(recipe)
ridge_fit = ridge_wf %>% add_model(ridge_spec) %>% fit(data = train_data)
ridge_fit %>% pull_workflow_fit() %>% tidy()

## Lasso
lasso_spec = linear_reg(penalty = 0.1, mixture = 1) %>% set_engine("glmnet")
lasso_wf = workflow() %>% add_recipe(recipe)
lasso_fit = lasso_wf %>% add_model(lasso_spec) %>% fit(data = train_data)
lasso_fit %>% pull_workflow_fit() %>% tidy()

## Elastic Net
elasticnet_spec = linear_reg(penalty = 0.1, mixture = 0.3) %>% set_engine("glmnet")
elasticnet_wf <- workflow() %>% add_recipe(recipe)
elasticnet_fit <- elasticnet_wf %>% add_model(elasticnet_spec) %>%
  fit(data = train_data)
elasticnet_fit %>% pull_workflow_fit() %>% tidy()

## Grid Search
tune_spec = linear_reg(penalty = tune(), mixture = 1) %>% set_engine("glmnet")

lasso_wf = workflow() %>% add_recipe(recipe)
flight_cvfolds = vfold_cv(train_data)
lambda_grid = grid_regular(levels = 50, penalty(range = c(-3, 0.3)))
lasso_grid = tune_grid(lasso_wf %>% add_model(tune_spec), 
    resamples = flight_cvfolds, grid = lambda_grid)
show_best(lasso_grid, metric = "rmse")

## Plotting Results
lasso_grid %>% collect_metrics() %>% filter(.metric == "rmse") %>%
  ggplot(aes(penalty, mean)) + geom_line(size=1, color="red") + scale_x_log10() +
  ggtitle("RMSE")

