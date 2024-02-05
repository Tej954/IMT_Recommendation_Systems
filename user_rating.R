# Creating a mock ratings matrix
ratings_matrix <- matrix(c(5, NA, 4, NA, 3, 3, NA, 2, 5, 1, NA, NA, 4, NA, 5, 3), nrow = 4, byrow = TRUE)
rownames(ratings_matrix) <- paste("User", 1:4)
colnames(ratings_matrix) <- paste("Item", 1:4)
ratings_matrix


# Simple demonstration of matrix factorization concept
set.seed(123) # For reproducibility
U <- matrix(runif(8), nrow = 4) # Mock user-feature matrix
I <- matrix(runif(8), nrow = 2) # Mock item-feature matrix

# Approximated ratings matrix
approx_ratings <- U %*% I
approx_ratings


# Install and load the recommenderlab package
#if (!requireNamespace("recommenderlab", quietly = TRUE)) install.packages("recommenderlab")
library(recommenderlab)

ratings_matrix[is.na(ratings_matrix)] <- 0
sparse_ratings <- as(ratings_matrix, "sparseMatrix")

# Convert the matrix to a realRatingMatrix
ratings_data <- new("realRatingMatrix", data = sparse_ratings)

# Check the converted data
ratings_data



# Matrix factorization using Recommender systems lab (recommenderlab)
model <- Recommender(data = ratings_data, method = "ALS", parameter = list(dim = 2))


# Extracting the model matrices
model_matrices <- getModel(model)
str(model_matrices)

#The user feature feature matrix is denoted retrived by p and item features matrix
#is denoted by i   
model_matrices$data@data@p
model_matrices$data@data@i

# Predicting ratings for a given user
predicted_ratings <- predict(model, ratings_data, type = "ratings")
as(predicted_ratings, "matrix")[1, ] # Show predicted ratings for User 1
