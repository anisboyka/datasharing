library(recommenderlab)
library(reshape2)
library(ggplot2)
g=read.csv("C:/Users/anisboyka/Desktop/projettutore/songsDataset.csv")
if(!"recommenderlab" %in% rownames(installed.packages())){
  install.packages("recommenderlab")}
set.seed(1)
data_package <- data(package = "recommenderlab")
data_package$results[, "Item"]
#data(MovieLense)
#summary(MovieLense)
datasongs=read.csv("C:/Users/anisboyka/Desktop/songsDataset.csv" ,header = TRUE , sep = ",")
class(datasongs)

realsongs=as(datasongs,"realRatingMatrix")
methods(class = class(realsongs))

dim(realsongs)

#ratings_movies <- realsongs[rowCounts(realsongs) > 5,colCounts(realsongs) > 10] 
#ratings_movies
realsongsnormalize =normalize(realsongs)
which_train <- sample(x = c(TRUE, FALSE), size = nrow(realsongsnormalize),
                      replace = TRUE, prob = c(0.8, 0.2))

head(which_train)


recc_data_train <- realsongsnormalize[which_train, ] #ensemple d'apprentissage 
recc_data_test <- realsongsnormalize[!which_train, ] #ensemple de test 

recommender_models <- recommenderRegistry$get_entries(dataType =
                                                        "realRatingMatrix")
recommender_models$UBCF_realRatingMatrix$parameters

#recc_model <- Recommender(data = recc_data_train, method = "IBCF",parameter = list(k = 30))
recc_model <- Recommender(data = recc_data_train, method = "UBCF")
recc_model
model_details <- getModel(recc_model)
names(model_details)
model_details$data
n_recommended <- 6

recc_predicted <- predict(object = recc_model, newdata = recc_data_test, n = n_recommended)
recc_predicted
