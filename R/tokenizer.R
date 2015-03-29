# Takes a string of text and returns a vector of word tokens

tokenize <- function(text) {
  # Assum anything surrounded by spaces is a word.
  strsplit(text, " ")	
}

lower_case <- function(text) {
  # Inputs a string and returns the string with all lowercase letters
  tolower(text)
}

remove_numbers <- function(text) {
  # Not using this now. I wantto leave numbers in
}

remove_punctuation <- function(text) {
  # Removes any punctuation from a string of text
  gsub("[^\\w\\s]", "", text, perl=TRUE)
}

remove_profanity <- function(text) {
  # Swear words pulled from http://www.bannedwordlist.com/lists/swearWords.txt
  # Regex is my own with lots of help from Google
  # !!! Be sure to run lower_case first, as this regex assumes lower case

  profane_regex <- paste("shit(ty)?\\b\\s?|",
                         "fuck(ing)?(ed)?(en)?\\b\\s?|",
                         "cunt\\b\\s?|",
                         "\\bpussy\\b\\s?|",
                         "\\bass\\b\\s?|",
                         "asshole\\b\\s?|",
                         "blowjob\\b\\s?|",
                         "blow job\\b\\s?|",
                         sep="")
  gsub(profane_regex, "", text, perl=TRUE)  
}

get_tokens <- function(text) {
  lower <- lower_case(text)
  clean <- remove_profanity(lower)
  non_punctuated <- remove_punctuation(clean)
  tokenize(non_punctuated)
}

