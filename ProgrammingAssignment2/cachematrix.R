#####################################################################
## The functions below calculates and returns the inverse of        #
## a square matrix, or returns the inverse from                     #
## the cache, if the matrix has been inverted previously            #
##                                                                  #  
## Part of R Programming (Coursera)                                 #
## (code modified from the Vector example from the assignment page) #
#####################################################################

## The function makeCacheMatrix(x = matrix,...) returns a list of functions doing the following:
##   set the matrix x,
##   get the matrix x,
##   set the inverse of the matrix x,
##   get the inverse of the matrix x
##
##   NOTE: The list of functions is used as input in the function cacheSolve()

makeCacheMatrix <- function(x = matrix()) {
  # matrix x must be a invertible square matrix 
  
  inv_matrix = NULL 
  set = function(y) {
    # the "<<-" operator is used to assign a value to an object in an environment that is different from the current environment.
    x <<- y
    inv_matrix <<- NULL
  }
  get = function() x # Function that returns the original matrix x
  setinv = function(inverse) inv_matrix <<- inverse  # Function that sets the inverse matrix
  getinv = function() inv_matrix # Function that returns the inverse matrix of x
  list(set=set, 
       get=get, 
       setinv=setinv, 
       getinv=getinv)
}


## cacheSolve uses the output from makeCacheMatrix() as input,
## and returns the inverse of the square matrix used as input to the makeCacheMatrix() function
## The inverse matrix is either calculated or read from the cache (if already calculated)

cacheSolve <- function(x, ...) {
  
  inv = x$getinv() # Setting the 'inv' variable to the inverse of matrix x, or NULL if the inverse has not been calculated
  
  # Check to see if the inverse matrix has been calculated
  # Return the cached inverse matrix if available, thus skipping the calculation
  if (!is.null(inv)){
    #print("Return inversed matrix from Cache")
    return(inv)
  }
  
  # If inverse matrix has not been found in the cache, it has to be calculated:
  matrix_x = x$get() # This is the original matrix x
  inv_matrix = solve(matrix_x, ...) # The solve function calculates the inverse of the matrix
  
  # The value of the inverse matrix is set using the setinv function from makeCacheMatrix()
  x$setinv(inv_matrix)
  
  return(inv_matrix)
}
