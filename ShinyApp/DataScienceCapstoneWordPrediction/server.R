#
# title: "Capstone Project"
# author: "Amal"
## date: "March 05, 2019"


library(shiny)
library(stringr)
library(tm)

# Loading the n gram data sets created earlier
bg <- readRDS("bigram.RData") 
tg <- readRDS("trigram.RData")
qd <- readRDS("quadgram.RData")

message <- ""

# Creating functions
fnBigram <- function(inputWord) {
  if (identical(character(0),as.character(head(bg[bg$word1 == inputWord[1], 2], 1)))) {
    message<<-"If we are unable to find a suitable match, the commonly used word 'the' is returned" 
    as.character(head("the",1))
  }
  else {
    message <<- "Prediction word generated using bigram frequency matrix"
    as.character(head(bg[bg$word1 == inputWord[1],2], 1))
  }
}

fnTrigram <- function(inputWord) {
  if (identical(character(0),as.character(head(tg[tg$word1 == inputWord[1]
                                                  & tg$word2 == inputWord[2], 3], 1)))) {
    as.character(predictWord(inputWord[2]))
  }
  else {
    message<<- "Prediction word generated using trigram frequency matrix"
    as.character(head(tg[tg$word1 == inputWord[1]
                         & tg$word2 == inputWord[2], 3], 1))
  }
}
########################################################################
fnQuadgram <- function(inputWord) {
  # testing print(the_word)
  if (identical(character(0),as.character(head(qd[qd$word1 == inputWord[1]
                                                  & qd$word2 == inputWord[2]
                                                  & qd$word3 == inputWord[3], 4], 1)))) {
    as.character(predictWord(paste(inputWord[2],inputWord[3],sep=" ")))
  }
  else {
    message <<- "Prediction word generated using quadgram frequency matrix"
    as.character(head(qd[qd$word1 == inputWord[1] 
                         & qd$word2 == inputWord[2]
                         & qd$word3 == inputWord[3], 4], 1))
  }       
}

# Core Function predicting the next word
predictWord <- function(inputWord) {
  cleanWord <- stripWhitespace(removeNumbers(removePunctuation(tolower(inputWord),preserve_intra_word_dashes = TRUE)))
  finalWord <- strsplit(cleanWord, " ")[[1]]
  n <- length(finalWord)

  if (n == 1) {
    inputWord <- as.character(tail(finalWord,1))
    fnBigram(finalWord)
    }
  
  else if (n == 2) {
    inputWord <- as.character(tail(finalWord,2))
    fnTrigram(finalWord)
    }

  else if (n >= 3) {
    inputWord <- as.character(tail(finalWord,3))
    fnQuadgram(finalWord)
    }
}


## ShinyServer main code
shinyServer(function(input, output) {
  output$prediction <- renderPrint({
    result <- predictWord(input$inputText)
    output$sentence2 <- renderText({message})
    result
  });
  output$sentence1 <- renderText({
    input$inputText});
}
)