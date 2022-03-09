# Moving from Scripts to R Function
# R provides two major advantages over the script:
# - Functions can work with any input. YOu can provide diverse input data to the 
#   functions.
# - The output of the function is an object that allows you to work with the result.

# How to Create a Script in R
# As we know, R supports several editors. So the script can be created in any of 
# the editors like Notepad, MS Word or Word Pad and can be saved with R extension
# in the current working directory.
# Now to read the file in R, the source() function can be used.

# Example:
# If we want to read the sample.R script in R, we need to provide below cmd:

source("sample.R")

# This will read the file sample in R. In order to create a script, first open a
# script file in the editor mode and type the required code.

# We will create a script that takes inout in the form of fractions and converts it into a precentage 
# by further rounding it to one decimal digit.

frac <- c(0.452, 1.5642, 0.84520)
percentage <- round(frac * 100, digits = 1)
out <- paste(percentage, "%", sep = "")
print(out)

# That is, you need to give values that you want to convert to a percentage as 
# input and then convert it into percentage and round off to required places.
# Then put the % sign and display the answer.

# Save script and now you can call this script on the console with the help of source
# command which we have already seen.
# source('pastPercentage.R')


# Transforming the Script into R function
# Now, we are going to see how to convert R script into the function in R.
# Firstly, define a function with a name so that it becomes easier to call an R 
# function and pass arguments to it as input.
# The R function should be followed by parentheses that act as a front gate for
# your function and between the parentheses, arguments for the function are provided.

# Use the return() statement that acts as a back gate of your function. The return()
# statement provides the final result of the function that is returned to your workshop.

# Let us now see how we can convert the script that we had written earlier to 
# convert values into percentage and round off into an R function.

Percent_add <- function(frac){
  percent <- round(frac * 100, digits = 1)
  out <- paste(percent, "%", sep = "%")
  return(out)
}

# The keyword 'function' defines the starting of function. The parentheses after 
# the function form the front gate, or argument list of the function. Between 
# the parentheses are the arguments to the function. In this case, there is
# only one argument.

# The return statement defines the end of the function and returns the result. 
# The object put between the parentheses is returned from inside the function 
# to the workspace. Only one object can be placed between the parentheses.

# The braces, {} are the walls of the function. Everything between the braces 
# is part of the assembly line or the body of the function. This is how 
# functions are created in R.


# Using R function

# https://data-flair.training/blogs/r-function/







