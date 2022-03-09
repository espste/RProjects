# https://data-flair.training/blogs/data-structures-in-r/

# Data Structures
# If we see in contrast to different programming languages like C and Java, 
# R doesn’t have variables declared as some data type. Further, the variables are 
# appointed with R-objects and the knowledge form of the R-object becomes the 
# datatype of the variable. There are many types of R-objects. 
# The popularly used ones are:

# - Vector
# - Matrix
# - Array
# - Lists
# - Data Frames

# 1. R Vector
# Vector is the most basic data structure in R programming language. 
# It comes in two parts: Atomic vectors and Lists. 
# They have three common properties:

# - Type function - what actually it is?
# - Length function - how many elements does it contain.
# - Attribute function - extra arbitrary metadata.

# Atomic Vectors
# There are four common types of R Atomic Vectors:
# - Numeric Data Type
# - Integer Data Type
# - Character Data Type
# - Logical Data Type

# 2. R Matrix
# First of all, we will discuss what exactly matrices in data structures in R mean. 
# A matrix is a two-dimensional rectangular data set and thus it can be created 
# using vector input to the matrix function. In addition, a matrix is a collection 
# of numbers arranged into a fixed number of rows and columns. Usually, the numbers 
# are the real numbers. By using a matrix function, we can reproduce a memory 
# representation of the matrix in R. Hence, the data elements must be of the same basic type.

mat1 <- matrix(1:4, nrow = 2, ncol = 2)
mat1
mat2 <- matrix(4:7, nrow = 2, ncol = 2)
mat2

# We can access the element present at the mth row and nth column as follows:
mat1[1,2]
mat2[2,1]

# We can also extract the entire mth row and nth row separately as follows:
mat1[2, ]
mat1[, 2]

# Uses of Matrices
# 1. Adding
mat1 + mat2

# 2.Subtracting
mat1 - mat2

# 3. Multiplying by a constant
4 * mat1

# 4. Dividing
(mat1/mat2)

# 5. Transposing
# The transpose of a matrix is a matrix with the rows and columns swapped, 
# we can find the transpose of a matrix with the t() function:
t(mat1)

# 6.  Identity matrix
# We can find the nxn identity matrix using the diag(n) function.
diag(4)


# 3. R Array
# Arrays in R are the data objects which can store data in more than two dimensions.
# An array is created using the array() function. We can use vectors as input. 
# To create an array, we can use these values in the dim parameter.

# In this following example, we will create an array in R of two 3×3 matrices each 
# with 3 rows and 3 columns.In this following example, we will create an array in 
# R of two 3×3 matrices each with 3 rows and 3 columns.

vec1 <- c(1,2,4)
vec2 <- c(15,17,27,3,10,11)
output <- array(c(vec1,vec2), dim = c(3,3,2))
output

# We can give names to the rows, columns, and matrices in the 
# array by using the dimnames parameter.

# Create two vectors of different lengths.
column_names <- c("col1","col2","col3")
row_names <- c("row1","row2","row3")
matrix_names <- c("Mat1", "Mat2")

# Take these vectors as input to the array
output <- array(c(vec1,vec2), dim = c(3,3,2), dimnames = list(row_names, column_names,
                                                              matrix_names))
output

# 2. Accessing Array Elements
# We will create two vectors of different lengths.
output[3,,2]  
output[1,3,1] # Print the element in the 1st row and 3rd column of the 1st Matrix
output[,,2]   # Print the 2nd Matrix


# 3. Manipulating Array Elements
# As the array is made up of matrices in multiple dimensions, the operations on 
# elements of an array are carried out by accessing elements of the matrices.


vec1 <- c(1,2,3)
vec2 <- c(4,5,6,7,8,9)
arr1 <- array(c(vec1,vec2), dim = c(3,3,2))

vec3 <- c(3,2,1)
vec4 <- c(9,8,7,6,5,4)
arr2 <- array(c(vec3,vec4), dim = c(3,3,2))

# Now we create matrix using the arrays we put integer vectors in

mat1 <- arr1[,,2]
mat2 <- arr2[,,2]
output <- mat1 + mat2
output

# Calculations across R array elements
# We will be using the apply() function for calculations in an array in R.

# Syntax: apply(x, margin, func) 

# x is an array
# A margin is the name of the dataset used
# Fun is the function to be applied to the elements of the array

vec1 <- c(1,2,3)
vec2 <- c(4,5,6,7,8,9)
array_new <- array(c(vec1,vec2), dim = c(3,3,2))
array_new

output <- apply(array_new, c(1), sum)
output


# List in R
# Lists are the objects which contain elements of different types – like strings, 
# numbers, vectors and another list inside them. A list can also contain a matrix 
# or a function as its elements. In other words, a list is a generic vector 
# containing other objects. A list is created using the list() function.

# The variable x is containing copies of three vectors n,s,b and a numeric value 3.
num_list = c(3,4,5)
char_list = c("a", "b", "c", "d", "e")
logic_list = c(TRUE, TRUE, FALSE, TRUE)
out_list = list(num_list, char_list, logic_list, 3)
out_list


# Data Frame in R
# A data frame is used for storing data tables.
# It is a list of vectors of equal length.

num_list = c(3,4,5)
char_list = c("a", "b", "c")
logic_list = c(TRUE, FALSE, TRUE)
data_frame = data.frame(num_list, char_list, logic_list)
data_frame



