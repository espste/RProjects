# In particular, it is a data structure in R that represents cases in 
# which there are a number of observations(rows) or measurements (columns).
#
# A data frame is being used for storing data tables, 
# the vectors that are contained in the form of a list in a data frame are
# of equal length.
#
# The following variable df is a data frame containing three variables vec,
# char_vec and bool_vec.

int_vec <- c(1,2,3)
char_vec <- c("a", "b", "c")
bool_vec <- c(TRUE, FALSE, TRUE)

data_frame <- data.frame(int_vec, char_vec, bool_vec)

# A data frame is an array. Unlike an array, the data we store in the columns 
# of the data frame can be of various types. It means one column might be a 
# numeric variable, another might be a factor, and a third might be a 
# character variable. All columns have to be of the same length.

# Now, let’s discuss the characteristics of data frame in R.
# - The column names should be non-empty.
# - The row names should be unique.
# - The data frame can hold the data wich can be a numeric, character
#   or of factor type.
# - Each column should contain the same number of data items.


# 1. Create Data Frame

employee_data <- data.frame(employee_id = c (1:5), employee_name = c("harry", "Espen", "Jim", "Oliver", "Per"),
                            sal = c(642.3,535.2,681.0,739.0,925.26),
                            join_date = as.Date(c("2013-02-04","2017-06-21","2012-11-14","2018-05-19","2016-03-25")),
                            stringsAsFactors = FALSE)

print(employee_data)

# The structure of the data frame can we see by using the star() function.
str(employee_data)

# By using the name of the column, extract a specific column from the column
output <- data.frame(employee_data$employee_name, employee_data$employee_id)
print(output)

# Extract first two rows
output <- employee_data[1:2,]
print(output)

#Extract 1st and 2nd row with the 3rd and 4th column of the below data.
result <- employee_data[c(1,2),c(3,4)]
result


# Expand R data frame
# Add the "dept" column
employee_data$dept <- c("IT","Finance","Operations","HR","Administration")
out <- employee_data
print(out)

#Add Row
# Create the second R data frame
employee_new_data <- data.frame(employee_id = c (6:8),
                                employee_name = c("Aman", "Pul", "Gaby"),
                                sal = c(523.0,721.3,622.8),
                                join_date = as.Date(c("2015-06-22","2016-04-09","2011-03-17")),
                                stringsAsFactors = FALSE
                                )


# Bind the two data frames
bind_rows(employee_data, employee_new_data)

