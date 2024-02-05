#library(recosystem)

# Create  User-Item Matrix:
ratings_matrix <- matrix(sample(c(0, 1), 100, replace = TRUE), nrow = 10, ncol = 10)
rownames(ratings_matrix) <- paste0("user", 1:nrow(ratings_matrix))
colnames(ratings_matrix) <- paste0("item", 1:ncol(ratings_matrix))

ratings_real_matrix <- as(ratings_matrix, "realRatingMatrix")

ratings_real_matrix

# 3. Create Recommender Model:
# - Choose an algorithm suitable for implicit feedback (e.g., IBCF)
#recommender1 <- Recommender(ratings_real_matrix, method = "IBCF")

sampled_data1<- sample(x = c(TRUE, FALSE),
                      size = nrow(ratings_real_matrix),
                      replace = TRUE,
                      prob = c(0.7, 0.3))


training_data1 <- ratings_real_matrix[sampled_data1, ]

testing_data1 <- ratings_real_matrix[!sampled_data1, ]

training_data1@data
testing_data1@data 

# Building the Recommendation System
#recommendation_system <- recommenderRegistry$get_entries(dataType ="realRatingMatrix")
#recommendation_system$IBCF_realRatingMatrix$parameters

recommen_model1 <- Recommender(data = training_data1,
                              method = "IBCF",
                              parameter = list(k = 30))

recommen_model1

model_info1 <- getModel(recommen_model1)
class(model_info1$sim)
dim(model_info1$sim)

# Make Recommendations for a User:

# Get top N recommendations (adjust N as needed)
top_recommendations<-5

predicted_recommendations1 <- predict(object = recommen_model1,
                                     newdata = testing_data1,
                                     n = top_recommendations)

#Now predict for test data 
