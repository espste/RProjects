# https://data-flair.training/blogs/data-science-r-movie-recommendation/

library(recommenderlab)
library(ggplot2)
library(data.table)
library(reshape2)

movie_data <- read.csv("movies.csv",stringsAsFactors = FALSE)
rating_data <- read.csv("ratings.csv")
str(movie_data)

summary(movie_data)
head(movie_data)
summary(rating_data)
head(rating_data)

movie_genre <- as.data.frame(movie_data$genres, stringsAsFactors=FALSE)

library(data.table)

movie_genre2 <- as.data.frame(tstrsplit(movie_genre[,1], '[|]', 
                                        type.convert=TRUE), 
                              stringsAsFactors=FALSE) #DataFlair
colnames(movie_genre2) <- c(1:10)
list_genre <- c("Action", "Adventure", "Animation", "Children", 
                "Comedy", "Crime","Documentary", "Drama", "Fantasy",
                "Film-Noir", "Horror", "Musical", "Mystery","Romance",
                "Sci-Fi", "Thriller", "War", "Western")

genre_mat1 <- matrix(0,10330,18)
genre_mat1[1,] <- list_genre
colnames(genre_mat1) <- list_genre
for (index in 1:nrow(movie_genre2)) {
  for (col in 1:ncol(movie_genre2)) {
    gen_col = which(genre_mat1[1,] == movie_genre2[index,col]) #Author DataFlair
    genre_mat1[index+1,gen_col] <- 1
  }
}
genre_mat2 <- as.data.frame(genre_mat1[-1,], stringsAsFactors=FALSE) #remove first row, which was the genre list
for (col in 1:ncol(genre_mat2)) {
  genre_mat2[,col] <- as.integer(genre_mat2[,col]) #convert from characters to integers
} 
str(genre_mat2)                              

# Create a "search" matrix that will allow us to perform an easy search
# of the films by specifiyn the genre present in our list.
SearchMatrix <- cbind(movie_data[,1:2], genre_mat2[])
head(SearchMatrix)


# We have to convert our matrix into a sparse matrix one as a new class 'realRatingMatrix'.
ratingMatrix <- dcast(rating_data, userId~movieId, value.var = "rating", na.rm=FALSE)

# Removing userIds
ratingMatrix <- as.matrix(ratingMatrix[,-1])

# Convert rating matrix into a recommenderlab sparse matrix
ratingMatrix <- as(ratingMatrix,"realRatingMatrix")
ratingMatrix


# Let us now overview some of the important parameters that provide us
# various options for building recommendation systems for movies
recommendation_model <- recommenderRegistry$get_entries(dataTpe = "realRatingMatrix")
names(recommendation_model)

lapply(recommendation_model, "[[", "description")

# Implementing one of the models - Collaborative filtering 
recommendation_model$IBCF_realRatingMatrix$parameters

# EXPLORING SIMILAR DATA
# Collaborative Filtering involves suggesting movies to the users that are 
# based on collecting preferences from many other users. For example, if a 
# user A likes to watch action films and so does user B, then the movies 
# that the user B will watch in the future will be recommended to A and vice-versa

# Therefore, recommending movies is dependent on creating a relationship 
# of similarity between the two users. With the help of recommenderlab, 
# we can compute similarities using various operators like cosine, 
# pearson as well as jaccard.
similarity_mat <- similarity(ratingMatrix[1:4, ],
                             method = "cosine",
                             which = "users")
as.matrix(similarity_mat)

par("mar")                  ### Fix fra stackoverflow
par(mar=c(1,1,1,1))
image(as.matrix(similarity_mat), main = "User's Similarities")

movie_similarity <- similarity(ratingMatrix[, 1:4], method =
                                 "cosine", which = "items")
as.matrix(movie_similarity)

image(as.matrix(movie_similarity), main = "Movie similarity")

# Let us now extract the most unique ratings
rating_values <- as.vector(ratingMatrix@data)
unique(rating_values) #Extracting unique ratings

# Now we create a table of ratings that will display the most unique ratings
Table_of_Ratings <- table(rating_values)   # Creating a count of movie ratings
Table_of_Ratings


# MOST VIEWED MOVIES VISUALIZATION
# In this section of the machine learning project, we will explore the 
# most viewed movies in our dataset. We will first count the number of 
# views in a film and then organize them in a table that would group them in descending order.

library(ggplot2)

# Count views for each movie
movie_views <- colCounts(ratingMatrix)
table_views <- data.frame(movie = names(movie_views),    ### Create df of views
                          views = movie_views)
table_views <- table_views[order(table_views$views,
                                 decreasing = TRUE), ] # sort by number of views
table_views$title <- NA
for (index in 1:10325){
  table_views[index,3] <- as.character(subset(movie_data,
                                              movie_data$movieId == table_views[index,1])$title)
}
table_views[1:6,]


# Visualize a bar plot for the total number of views of the top films using ggplot2.
ggplot(table_views[1:6,], aes(x = title, y = views)) +
  geom_bar(stat = "identity", fill = 'steelblue') +
  geom_text(aes(label=views), vjust=-0.3, size=3.5) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  
  ggtitle("Total Views of the Top Films")


# HEATMAP OF MOVIE RATINGS
# This heatmap will contain first 25 rows and 25 columns

image(ratingMatrix[1:20, 1:25], axes = FALSE, main = "Heatmap of the first 25 rows and 25 columns")

# We will prepare data in the following three steps
# - Selecting useful data
# - Normalizing data
# - Binarizing the data
# For finding useful data in our dataset, we have set the threshold for the
# minimum number of users who have rated a film as 50. This is also same 
# for minimum number of views that are per film. This way, we have filtered 
# a list of watched films from least-watched ones.

movie_ratings <- ratingMatrix[rowCounts(ratingMatrix) > 50, colCounts(ratingMatrix) > 50]
movie_ratings

# From the above output of ‘movie_ratings’, we observe that there are 420 
# users and 447 films as opposed to the previous 668 users and 10325 films. 
# We can now delineate our matrix of relevant users

min_movies <- quantile(rowCounts(movie_ratings), 0.98)
min_users <- quantile(colCounts(movie_ratings), 0.98)
image(movie_ratings[rowCounts(movie_ratings) > min_movies,
                    colCounts(movie_ratings) > min_users],
main = "Heatmap of the top users and movies")

# Now we will visualize the distribution of the average ratings per user
average_rating <- rowMeans(movie_ratings)
qplot(average_rating, fill=I("steelblue"), col=I("red")) +
  ggtitle("Distribution of average rating per user")


# DATA NORMALIZATION
# In the case of some users, there can be high ratings or low ratings 
# implementing our model. In order to remove this, we normalize our data. 
# Normalization is a data preparation procedure to standardize the 
# numerical values in a column to a common scale value. This is done in 
# such a way that there is no distortion in the range of values. 
# Normalization transforms the average value of our ratings column to 0. 
# We then plot a heatmap that delineates our normalized ratings.

normalized_ratings <- normalize(movie_ratings)
sum(rowMeans(normalized_ratings) > 0.00001)

image(normalized_ratings[rowCounts(normalized_ratings) > min_movies,
                         colCounts(normalized_ratings) > min_users],
main = "Normalized Ratings of the Top users")


# PERFORMING DATA BINARIZATION
# In the final step of our data preparation in this data science project, 
# we will binarize our data. Binarizing the data means that we have two 
# discrete values 1 and 0, which will allow our recommendation systems 
# to work more efficiently. We will define a matrix that will consist 
# of 1 if the rating is above 3 and otherwise it will be 0.

binary_min_movies <- quantile(rowCounts(movie_ratings), 0.95)
binary_min_users <- quantile(colCounts(movie_ratings), 0.95)
#movies_watched <- binarize(movie_ratings, minRating = 1)

good_rated_films <- binarize(movie_ratings, minRating = 3)
image(good_rated_films[rowCounts(movie_ratings) > binary_min_movies,
                       colCounts(movie_ratings) > binary_min_users],
main = "Heatmap of top users and movies")


# COLLABORATIVE FILTERING SYSTEM
# We will develop our very own Item Based Collaborative Filtering System. This type of collaborative 
# filtering finds similarity in the items based on the people’s ratings of them.
# The algorithm first builds a similar-items table of the customers who have 
# purchased them into a combination of similar items. This is then fed into the recommendation system.

# The similarity between single products and related products can be determined with the following algorithm:
# - For each Item i1 present in the product catalog purchased by customer C
# - And, for each item i2 also purchased by the customer C.
# - Create record that the customer purchased items i1 and i2.
# - Calculate the similarity between i1 and i2
# We will build this filtering system by splitting the dataset into 80% training set and 20% test set.

sampled_data <- sample(x = c(TRUE, FALSE), size = nrow(movie_ratings),
                       replace = TRUE, prob = c(0.8,0.2))
training_data <- movie_ratings[sampled_data, ]
testing_data <- movie_ratings[!sampled_data, ]

# BUILDING THE REC SYSTEM
# We will now explore the various parameters of our Item Based Collaborative Filter. 
# These parameters are default in nature. In the first step, k denotes the 
# number of items for computing their similarities. Here, k is equal to 30. 
# Therefore, the algorithm will now identify the k most similar items and store
# their number. We use the cosine method which is the default one.

recommendation_system <- recommenderRegistry$get_entries(dataType ="realRatingMatrix")
recommendation_system$IBCF_realRatingMatrix$parameters

recommen_model <- Recommender(data = training_data,
                              method = "IBCF", 
                              parameter = list(k = 30))
recommen_model

class(recommen_model)

# Let us now explore our data science recommendation system model:
# Using the getModel() function, we will retrieve the recommen_model. 
# We will then find the class and dimensions of our similarity matrix that
# is contained within model_info. Finally, we will generate a heatmap, 
# that will contain the top 20 items and visualize the similarity shared between them.

model_info <- getModel(recommen_model)

class(model_info$sim)

dim(model_info$sim) 

top_items <- 20
image(model_info$sim[1:top_items, 1:top_items],
      main = "Heatmap of the first rows and columns")

# In the next step we will carry out the sum of rows and columns with the 
# similarity of the objects above 0. We will visualize the sum of columns through a distribution

sum_rows <- rowSums(model_info$sim > 0)
table(sum_rows)

sum_cols <- colSums(model_info$sim > 0)
qplot(sum_cols, fill=I("steelblue"),
      col=I("red")) + ggtitle("Distribution of the column count")


# We will create a top_recommendations variable which will be initialized 
# to 10, specifying the number of films to each user. We will then use the 
# predict() function that will identify similar items and will rank them 
# appropriately. Here, each rating is used as a weight. Each weight is multiplied 
# with related similarities. Finally, everything is added in the end.

top_recommendations <- 10   # number of items to recommend to each user
predicted_recommendations <- predict(object = recommen_model,
                                    newdata = testing_data,
                                    n = top_recommendations)
predicted_recommendations

user1 <- predicted_recommendations@items[[1]] # recommendation for the first user
movies_user1 <- predicted_recommendations@itemLabels[user1]
movies_user2 <- movies_user1
for (index in 1:10){
  movies_user2[index] <- as.character(subset(movie_data,
                                             movie_data$movieId == movies_user1[index])$title)
}
movies_user2

recommendation_matrix <- sapply(predicted_recommendations@items,
                                function(x){ as.integer(colnames(movie_ratings)[x]) }) # matrix with the recommendations for each user
dim(recommendation_matrix)
recommendation_matrix[,1:4]














