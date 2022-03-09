# Control structures aka loops
# - if
# - if-else
# - for
# - nested loops
# - while
# - repeat and break
# - next
# - return

# R provides various standard control structures for our requirements. 
# The expr expression consists of multiple statements that can be enclosed in braces {}.

# It is more efficient to use built-in functions in R rather than control structures, 
# whenever possible. This facilitates the flow of execution to be controlled inside a function.
# Control structures define the flow of the program. 
# The decision is then made after the variable is assessed.

# 1.  if 
# This task is carried out only if this condition is returned as TRUE. R makes it even 
# easier: You can drop the word then and specify your choice in an if statement.

# Syntax:
# if(test_expression) {
#   statement
# }

values <- 1:10
if (sample(values,1) <= 10) 
print(paste(values, "is less than or equal to 10"))


# 2.  if-else
# An if…else statement contains the same elements as an if statement 
# (see the preceding section), with some extra elements:
# - The keyword else, placed after the first code block.
# - The second block of code contained within the braces that has to be carried
#   out, only if the result of the condition in the if() statement is FALSE.

# Syntax:
#if (test_expression) {
#  statement
#} else {
#  statement
#}

val1 = 10
val2 = 5

if(val1 < val2){
  print("Value 1 is greater than Value 2")
} else if (val1 > val2) {
  print("Value 1 is less than Value 2")
}


# 3.  for loop
# A loop is a sequence of instructions that is repeated until a certain 
# condition is reached. for, while and repeat, with the additional clauses 
# break and next are used to construct loops.

# Example:
# These control structures in R, made of the rectangular box ‘init’ and the 
# diamond. It is executed a known number of times. for is a block that is 
# contained within curly braces.

values <- c(1,2,3,4,5)
for (id in 1:5) {
  print(values[id])
}


# 4.  Nested loop
# It is similar to the standard for loop, which makes it easy to convert for 
# loop to a foreach loop. Unlike many parallel programming packages for R, 
# foreach doesn’t require the body of for loop to be turned into a function. 
# We can call this a nesting operator because it is used to create nested 
# foreach loops.

mat <- matrix(1:10, 2)
for (id1 in seq(nrow(mat))) {
  for (id2 in seq(ncol(mat)))
    print(mat[id1, id2])
}


# 5.  while loop
# The format is while(cond) expr, where cond is the condition to test and expr 
# is an expression.

# R would complain about the missing expression that was supposed to provide 
# the required True or False and in fact, it does not know ‘response’ before 
# using it in the loop. We can also do this because, if we answer right at 
# first attempt, the loop will not be executed at all.

val = 2.987
while(val <= 4.987){
  val = val + 0.987
  print(c(val,val-2,val-1))
}

# Be sure there is a way to exit out of a while loop.


# 6.  repeat and break Statement
# We use break statement inside a loop (repeat, for, while) to stop the 
# iterations and flow the control outside of the loop. While in a nested looping
# situation, where there is a loop inside another loop, this statement exits 
# from the innermost loop that is being evaluated.

# A repeat loop is used to iterate over a block of code, multiple numbers of 
# times. There is no condition check in a repeat loop to exit the loop. We 
# ourselves put a condition explicitly inside the body of the loop and use
# the break statement to exit the loop. Failing to do so will result in an 
# infinite loop.

#Syntax:
#repeat {
#  # simulations; generate some value have an expectation if within some range,
#  # then exit the loop
#  if ((value - expectation) <= threshold) {
    break
#  }
#}

# The repeat loop is an infinite loop and iss used in association with a break statement.

# Example:
val <- 5
repeat {
  print(val)
  val <- val+1
  if (val == 10) {
    break
  }
}

#Example:
values = 1:10
for (id in values) {
  if (id == 8) {
    break
  }
  print(id)
}


# 7.  next Statement
# next jumps to the next cycle without completing a particular iteration. 
# In fact, it jumps to the evaluation of the condition holding the current 
# loop. Next statement enables to skip the current iteration of a loop without
# terminating it.

x = 1: 4
for (i in x) {
  if (i == 2) {
  next
  }
  print(i)
}


# 8.  return Statement
# Many times, we will require some functions to do processing and return back 
# the result. This is accomplished with the return() statement in R.

# Syntax:
# return(expression)

check <- function(x)  {
if (x > 0) {
result <- "Positive"
} else if (x < 0) {
result <- "Negative"
} else {
result <- "Zero"
}
return(result)
}


# - Be careful when you use the repeat statement.
# - Make sure that termination is explicity set by testing a condition or we can
#   end up in an infinite loop.
# - It is better to use one or more function calls within the loop if a loop is
#   getting (too) big.