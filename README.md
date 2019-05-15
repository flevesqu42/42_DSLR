/* 42 project, by flevesqu */

Subject : https://github.com/flevesqu42/42_DSLR/blob/master/github_ressources/DatascienceLogisticRegression.en.pdf

Release date : 03/03/2019

Language : Elixir (self experiment)

Including bindings for Python and Matplotlib, describe, histogram, scatter plot, pair plot and Logistic Regression algorithm.

## DSLR

## Compilation

`make`

## examples:

# Describe

`./describe resources/dataset_train.csv`

# Histogram

`./histogram resources/dataset_train.csv`

# Scatter Plot

`./scatter_plot resources/dataset_train.csv`

# Pair Plot

`./pair_plot resources/dataset_train.csv`

# Train

`./logreg_train resources/dataset_train.csv`

# Predict

`./logreg_predict thetas.csv resources/dataset_test.csv`

# Accuracy

`./accuracy thetas.csv resources/dataset_train.csv`
