# Load necessary libraries
library(tidyverse)
library(text2vec)
library(tm)

# Read 122 unique  records into a dataframe  
df1<-read.csv("C:/Dev/aiproff_myaipoc/IMT/Recommendation Systems & Topic Modeling using R/Recommendation System/br_small_1500_unq.csv")
head(df1)

colnames(df1)



# Text preprocessing for 'BookTitle' and 'UserReview'
preprocess_text <- function(text) {
  text_corpus <- Corpus(VectorSource(text))
  text_corpus <- tm_map(text_corpus, content_transformer(tolower))
  text_corpus <- tm_map(text_corpus, removePunctuation)
  #text_corpus <- tm_map(text_corpus, removeNumbers)
  text_corpus <- tm_map(text_corpus, removeWords, stopwords("en"))
  text_corpus <- tm_map(text_corpus, stripWhitespace)
  return(text_corpus)
}


df2<-df1

head(df2)



# Combine 'AuthorName', 'BookTitle', and 'UserReview' into a single content feature
df2$ContentFeatures <- paste(df2$review_score, df2$BookTitle,  
                            df2$review_text, df2$description, df2$authors, 
                              sep=" ")

head(df2$ContentFeatures)

# Create a document-term matrix
dtm <- DocumentTermMatrix(Corpus(VectorSource(df2$ContentFeatures)))

tfidf <- weightTfIdf(dtm)
tfidf
# Step 4: Compute Similarity
# Calculate cosine similarity between books based on TF-IDF
similarity_matrix <- sim2(as.matrix(tfidf), method = "cosine", norm = "l2")
#takes about 15 sec on 1000 records 

inspect(dtm)
# Calculate cosine similarity between books
#cosine_similarity <- function(dtm) {
#  similarity_matrix <- crossprod(as.matrix(dtm)) / (sqrt(sum(dtm^2) %*% t(sum(dtm^2))))
#  return(similarity_matrix)
#}


head(similarity_matrix)
#similarity_matrix <- cosine_similarity(dtm)

# Recommend books for a user based on their highest-rated book
recommend_books <- function(user_id, n_recommendations = 5) {
  user_ratings <- df2[df2$User_id == user_id, ]
  #print(user_ratings)
  highest_rated_book <- user_ratings[which.max(user_ratings$review_score), "RowId"]
  #print(highest_rated_book)
  # Get similarity scores for the highest-rated book
  book_similarities <- similarity_matrix[highest_rated_book, ]
  #print(book_similarities)
  # Sort and get top recommendations
  recommendations <- sort(book_similarities, decreasing = TRUE)[1:n_recommendations]
  #print(recommendations)
  recommended_book_ids <- names(recommendations)
  #print(recommended_book_ids)
  # Return recommended book titles
  return(df2[df2$RowId %in% recommended_book_ids, "Title"])
}

# Example: Recommend books for a random user
set.seed(123) # For reproducibility


random_user <- "AZ0IOBU20TBOP"
random_user <- "A2B3X891TTT91M"

recommended_books <- recommend_books(random_user)
print(recommended_books)
