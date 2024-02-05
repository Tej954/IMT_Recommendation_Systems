# Load necessary libraries
#We will use recommenderlab for content based filtering 

#install.packages("recommenderlab")
library(recommenderlab)
library(data.table)

# Assuming 'dataset' is already loaded and contains user IDs, book IDs, and ratings

# Read 122 unique  records into a dataframe  
#df5<-read.csv("C:/Dev/aiproff_myaipoc/IMT/Recommendation Systems & Topic Modeling using R/br_small_1500_unq.csv")
#head(df5)

df5<-read.csv("C:/Dev/aiproff_myaipoc/IMT/Recommendation Systems & Topic Modeling using R/br_small.csv")
head(df5)

colnames(df5)

# Convert the dataset to a data.table for efficient manipulation
df6<-df5
df6$UserID<-df5$User_id
df6$BookID<-df5$Id
df6$Rating<-df5$review_score

head(df6)
df7<-select(df6,UserID,BookID,Rating)

dt2 <- as.data.table(df7)
head(dt2,100)
# Create a sparse matrix for the user-item ratings
rating_matrix3 <- dcast(dt2, UserID ~ BookID, value.var = "Rating", fun.aggregate = mean)

rating_matrix3
# Convert the matrix to a realRatingMatrix
rating_matrix3 <- as(rating_matrix3, "realRatingMatrix")

head(rating_matrix3)


#rating_matrix2 <- sparseMatrix(i = df7$UserID, 
#                              j = df7$BookID, 
#                              x = df7$Rating, 
#                              dimnames = list(unique(df7$UserID), unique(df7$BookID))
#                              )


# Define the UBCF model
ubcf_model2 <- Recommender(rating_matrix3, method = "UBCF", parameter = list(nn = 10))
ubcf_model2

ibcf_model <- Recommender(rating_matrix, method = "IBCF", param = list(method = "Cosine"))
ibcf_model

# nn = 50 means the algorithm will consider the top 50 nearest neighbors (similar users)


# Generate recommendations for a user
user_id <- 'B000JX1Y30'  # Replace with an actual user ID
user_id <- 'A2ZT9K1PFBZ1L9'  # Replace with an actual user ID
recommendations2 <- predict(ubcf_model2, rating_matrix3[user_id], n = 5)

# Convert recommendations to a list of book IDs
recommended_books2 <- as(recommendations2, "list")
recommended_books2
# Print the recommended book IDs
print(recommended_books[[user_id]])



recommendations <- predict(ibcf_model, rating_matrix[user_id], n = 5)
recommendations2
