# Creating a dummy user-item matrix
set.seed(42)  # For reproducibility

# Generate random ratings between 1 and 5, with some NAs introduced
#ratings_matrix <- matrix(sample(c(1:5, rep(NA, 10)), 50, replace = TRUE), nrow = 5)


# Assign row and column names for clarity
#rownames(ratings_matrix) <- paste("User", 1:5)
#colnames(ratings_matrix) <- paste("Item", 1:10)

ratings_matrix <- matrix(c(4, 5, 2, NA, 3,
                           NA, 1, 4, 5, 4,
                           NA, 2, NA, 3, 5,
                           5, 4, NA, NA, 4,
                           2, NA, 5, 3, NA), nrow = 5, byrow = TRUE)

# Display the matrix
print(ratings_matrix)

# Replace NAs with column means
ratings_matrix_no_NA <- apply(ratings_matrix, 2, function(x) ifelse(is.na(x), mean(x, na.rm = TRUE), x))
# In real world we use techniques like regularization and iterative optimization to handle 
#missing values and improve prediction accuracy 

# Perform SVD
svd_result <- svd(ratings_matrix_no_NA)

# Extract the matrices
U <- svd_result$u
Sigma <- diag(svd_result$d)
Vt <- svd_result$v

# Reconstruct the matrix
reconstructed_matrix <- U %*% Sigma %*% t(Vt)

# Display the reconstructed matrix
print(reconstructed_matrix)


# Display results
print("Original Matrix with NAs:")
print(ratings_matrix)
print("\nReconstructed Matrix with Estimated Ratings:")
print(reconstructed_matrix)
print(ratings_matrix_no_NA)


#Now lets compare the imputed matrix with the reconstructed matrix and understand the implications

#Role of Dimensionality Reduction: Typically, the power of SVD in applications 
#like recommendation systems or data compression comes from dimensionality 
#reduction — retaining only the top-k singular values and vectors, which captures the 
#most significant underlying patterns while discarding noise or less relevant details. 
#Without this reduction, the reconstruction is just a mathematical reformation of the 
#original (imputed) data. 


# Approximate the matrix using a reduced rank (e.g., 3)
k <- 3  # Choose a suitable rank based on data analysis
U_k <- U[, 1:k]
Sigma_k <- Sigma[1:k, 1:k]
Vt_k <- Vt[, 1:k]
ratings_approx1 <- U_k %*% Sigma_k %*% t(Vt_k)
ratings_approx1
