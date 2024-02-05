# 1. Create a sample matrix 
A <- matrix(c(1, 2, 3,
              4, 5, 6,
              7, 8, 9), nrow = 3, byrow = TRUE)

# 2. Perform SVD using the base R 'svd' function
svd_result <- svd(A)

# 3. Extract the decomposed matrices
U <- svd_result$u  # Left singular vectors (m x m)
D <- diag(svd_result$d)  # Diagonal matrix of singular values (m x n)
V <- svd_result$v  # Right singular vectors (n x n)

#print the matrices
U
D
V

# U: Orthogonal matrix capturing key features of the rows of A.
# D: Diagonal matrix with singular values (d_1, d_2, ...), ranked by importance.
# V: Orthogonal matrix capturing key features of the columns of A.

# 5. Approximate the original matrix using SVD:
A_approx <- U %*% D %*% t(V)  # Note: t(V) is the transpose of V
A_approx
