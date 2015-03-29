source("tokenizer.R")

system.time(data <- readLines("../data/twitter.txt"))

#system.time(tokens <- sapply(data, function(x) {get_tokens(x)}))

library(parallel)

#system.time(tokens <- mclapply(data, function(x) {get_tokens(x)}))


library(snow)
cl <- makeCluster(16)
#registerDoSNOW(cl)
clusterEvalQ(cl, source("tokenizer.R"))
clusterEvalQ(cl, library(qdap))

#system.time(tokens <- clusterApply(cl, data, function(x) {get_tokens(x)}))
#system.time(tokens <- clusterApplyLB(cl, data, function(x) {get_tokens(x)}))
system.time(tokens  <- parSapply(cl, data[1:1000], function(x) {get_tokens(x)}))
system.time(n_grams <- parSapply(cl, my_tokens, function(x) {ngrams(x)}))
#registerDoSEQ()
stopCluster(cl)

system.time(tokens  <- lapply(data[1:100000], function(x) {get_tokens(x)}))
system.time(n_grams <- lapply(my_tokens, function(x) {ngrams(x)}))


library(qdap)
#https://dl.dropboxusercontent.com/u/61803503/packages/qdap_vignette.html#tools
system.time(word_counts <- word_list(data[1:10000]))
system.time(freqs <- freq_list(data[1:10000]))
system.time(freqs <- word_stats(data[1:10000]))
system.time(stems <- stemmer(data[1:10000]))




# New start
library(snow)
library(qdap)

twitter_file <- "../data/twitter.txt"
news_file    <- "../data/news.txt"
blogs_file    <- "../data/blogs.txt"

# In serial
# Reading the files
system.time(twitter <- readLines(twitter_file))
system.time(news    <- readLines(news_file))
system.time(blogs   <- readLines(blogs_file))

# In paralell


