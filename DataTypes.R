# Data types
# For example, addition cannot be performed on the words ‘hello’ and ‘world’.
# Similarly, you cannot change the numbers 1 and -34.5 from lower to uppercase. Due to 
# this, R has a feature called the data types. Different kinds of values are assigned 
# different data types that help differentiate them. These types have certain characteristics
# and rules associated with them that define their properties.

# R provides the class() and typeof() functions to find out what is the class and type 
# of any variable. R has five data types which are:
# - Numeric
# - Integers
# - Complex
# - Logical
# - Characters

# 1.  NUMERIC DATA TYPE
# The numeric data type is for numeric values. It is the default data type for numbers in R.
# Examples of numeric values would be 1, 34.5, 3.145, -24, -45.003, etc.

num <- 1
class(num)
typeof(num)

# Note: When R stores a number in a variable, it converts the number into a ‘double’
# value or a decimal type with at least two decimal places. This means that a value 
# such as ’1’ is stored as 1.00 with a type of double and a class of numeric.

# 2.  INTEGERS DATA TYPE
# The Integer data type is used for integer values. To store a value as an integer, 
# we need to specify it as such. The integer data type is commonly used for discrete
# only values like unique ids. We can store as well as convert a value into an 
# integer type using the as.integer() function.

int <- as.integer(16)
class(int)
typeof(int)

int2 <- as.integer(num)
int2
class(int2)
typeof(int)

# We can also use the capital ‘L’ notation to denote that a particular value is of 
# the integer data type.

int3 <- 5L
class(int3)
typeof(int3)

# 3.  COMPLEX DATA TYPE
# The complex data type is to store numbers with an imaginary component. 
# Examples of complex values would be 1+2i, 3i, 4-5i, -12+6i, etc.

comp <- 22-6i
class(comp)
typeof(comp)

# 4.  LOGICAL DATA TYPE
# The logical data type stores logical or boolean values of TRUE or FALSE.


logi <- FALSE
class(logi)
typeof(logi)

# 5.  CHARACTER DATA TYPE
# The character data type stores character values or strings. Strings in R can 
# contain the alphabet, numbers, and symbols. The easiest way to denote that a 
# value is of character type in R is to wrap the value inside single or double 
# inverted commas.

char <- "dataflairtutorial1234"
class(char)
typeof(char)

# We can also use the as.character() function to store a value as a character or to 
# convert a value to the character data type.

char2 <- as.character("hello")
char3 <- as.character(comp)

char2
char3

class(char2)
class(char3)
typeof(char2)
typeof(char3)

# Conversion into Numeric
# We can use the as.numerical function to convert the values of other data 
# types into numerical values. The conversion follows a few rules, which are:

# - To convert an integer value into a numeric, we can use the as.numeric function.
# - We can convert a complex value into numeric by using the function. This removes
#   the imaginary part of the number.
# - Logical Values can be converted into numeric as well. The TRUE value is 
#   converted to 1, and FALSE is converted to 0.
# - Character values can similarly be converted into numerical values but if the string contains
#   letters, alphabets and symbols then the numeric value becomes NA.

num2 <- as.numeric(int)
num2

num3 <- as.numeric(comp)
num3

num4 <- as.numeric(logi)
num4

num5 <- as.numeric(char)
num5 <- as.numeric("1234")
num5


# Conversion into Integer
# - Numeric values can be converted into an integer using the function as.integer(). 
#   This removes any decimal values from the number.
# - Complex values can also be converted into integers. The function removes
#   the imaginary parts of the number.
# - The conversion from logical values to integers is similar to the conversion
#   of logical values to numerics. TRUE is converted to 1, and FALSE is 
#   converted to 0.
# - Character values can be converted into integers as well by using the 
#   as.integer function. This conversion follows the same rules as the character
#   to numeric conversion.

int4 <- as.integer(num)
int4
int5 <- as.integer(14.7)
int5
int6 <- as.integer(comp)
int6
int7 <- as.integer(logi)
int7
int8 <- as.integer("1234")
int8


# Conversion into Complex
# - Numeric values can be converted into complex by using the as.complex 
#   function or by adding an imaginary part to it.
# - Integer value can also be converted into complex values similarly.
# - Logical values become 0+0i for FALSE and 1+0i for TRUE when converted
#   into complex values using the as.complex function. We can also convert a 
#   logical value into a complex value by adding an imaginary part to it.
# - The conversion from a character to a complex is the same as the conversion 
#   from character to numeric or an integer with 0i added to the converted 
#   value if it is not NA.

comp2 <- as.complex(num)
comp2
comp3 <- as.complex(int)
comp3
comp4 <- as.complex(logi)
comp4
comp5 <- as.complex("1234")
comp5


# Conversion into Logical
# - Numeric, integer, and complex values can be converted into logical values, 
#   but the function returns FALSE if the value is zero and TRUE if it is anything else.
# - Character values when converted by the as.logical function, always return NA.

logi2 <- as.logical(num)
logi2
logi3 <- as.logical(int)
logi3
logi4 <- as.logical(comp)
logi4
logi5 <- as.logical(char)
logi5


# Conversion into Character
# We can convert a value of any data type into character data type using the
# as.character() function. The function converts the original value into a 
# a character string.

char2 <- as.character(num)
char2
char3 <- as.character(int)
char3
char4 <- as.character(comp)
char4
char5 <- as.character(logi)
char5

# Note: NA values have no type and therefore stay as such when converted to any type.