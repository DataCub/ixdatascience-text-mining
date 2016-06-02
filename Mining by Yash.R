# =====================================================================================================================
# TEXT MINING
# =====================================================================================================================

# GRAB SOME TEXT DATA -------------------------------------------------------------------------------------------------

library(rplos)

# Use plosabstract() to query PLoS and gather abstracts relating to a topic of your choice.

papers <- plosabstract(q = "biology", fl = c("id", "abstract"), limit = 100)
names(papers)
papers$data$abstract

# CREATE CORPUS -------------------------------------------------------------------------------------------------------

library(tm)

# 1. Use VectorSource() and Corpus() to create a corpus.

corpus <- Corpus(VectorSource(papers$data$abstract))
names(corpus)

# 2. Retrieve a single document from the corpus. You might need to use as.character().

str(corpus[[1]]) #shows the structure of the corpus whenever you're confused 
corpus[[89]]$content #content of the 89th corpus 
as.character(corpus[[89]])
# APPLY TRANSFORMATIONS -----------------------------------------------------------------------------------------------

# Use tm_map() to apply the following transformations:
#
# - convert to lower case [this might require content_transformer()];
# - remove punctuation;
# - remove numbers;
# - remove stop words;
# - remove extra white space

getTransformations() #shows us the possible transformations

corpus <- tm_map(corpus, content_transformer(tolower)) #lower case conversion 
as.character(corpus[[7]]) #check

corpus <- tm_map(corpus, removePunctuation) #remove punctuation 
as.character(.Last.value[[7]])
as.character(corpus[[7]])

corpus <- tm_map(corpus, removeNumbers) #remove numbers
as.character(corpus[[7]])

corpus <- tm_map(corpus, removeWords, stopwords("english")) #remove stop words 
as.character(corpus[[7]])

corpus <- tm_map(corpus, stripWhitespace) #strip whitespace 
as.character(corpus[[7]])

# STEMMING ------------------------------------------------------------------------------------------------------------

library(SnowballC)
getStemLanguages()

#stem example 
as.character(corpus[[1]])
as.character(stemDocument(corpus[[1]]))

# Use tm_map() and stemDocument() to stem all documents in the corpus.
corpus <- tm_map(corpus, stemDocument)
as.character(corpus[[70]])

# DOCUMENT TERM MATRIX ------------------------------------------------------------------------------------------------

# 1. Create a Document Term Matrix.

inspect(DocumentTermMatrix(corpus[1:3])) #see if it works 
dtm <- DocumentTermMatrix(corpus) #assign to a dtm variable 
as.matrix(dtm)

# 2. Find the most frequent term in a single document.

dtm_max <- max(as.matrix(dtm, 1,))

# 3. Find the most frequent term across the entire corpus.

dtm_max <- max(as.matrix(dtm))

# 4. Use findAssocs() to find associated terms.

# I need to go over this part with someone

# TF-IDF --------------------------------------------------------------------------------------------------------------

# Create a Term Frequency-Inverse Document Frequency matrix. Do the data make sense?

tfidf <- DocumentTermMatrix(corpus, control = list(weighting = weightTfIdf))
tfidf <- as.matrix(tfidf)

sort(colSums(as.matrix(tfidf)))

# VISUALISATION -------------------------------------------------------------------------------------------------------

# Make a word cloud.
#this doesn't work for some reason 

library(dplyr)

freq.terms = tail(data.frame(term = names(freq.terms), occurrences = freq.terms, row.names = NULL), 50)
freq.terms = transform(freq.terms, term = factor(term, levels = term))

library(ggplot2)
ggplot(freq.terms) +
  geom_bar( aes(term, occurrences), stat = "identity") +
  theme(axis.text.x=element_text(angle = 45, hjust = 1))

library(wordcloud)
require(RColorBrewer)
wordcloud(freq.terms$term, freq.terms$occurrences, min.freq = 1, colors = brewer.pal(8, "Dark2"), random.order = FALSE)


library(wordcloud)
require(RColorBrewer)
