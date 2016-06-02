# =====================================================================================================================
# TEXT MINING
# =====================================================================================================================

# GRAB SOME TEXT DATA -------------------------------------------------------------------------------------------------

library(rplos)

# Use plosabstract() to query PLoS and gather abstracts relating to a topic of your choice.

# CREATE CORPUS -------------------------------------------------------------------------------------------------------

library(tm)

# 1. Use VectorSource() and Corpus() to create a corpus.
# 2. Retrieve a single document from the corpus. You might need to use as.character().

# APPLY TRANSFORMATIONS -----------------------------------------------------------------------------------------------

# Use tm_map() to apply the following transformations:
#
# - convert to lower case [this might require content_transformer()];
# - remove punctuation;
# - remove numbers;
# - remove stop words;
# - remove extra white space.

getTransformations()

# STEMMING ------------------------------------------------------------------------------------------------------------

library(SnowballC)
getStemLanguages()

# Use tm_map() and stemDocument() to stem all documents in the corpus.

# DOCUMENT TERM MATRIX ------------------------------------------------------------------------------------------------

# 1. Create a Document Term Matrix.
# 2. Find the most frequent term in a single document.
# 3. Find the most frequent term across the entire corpus.
# 4. Use findAssocs() to find associated terms.

# TF-IDF --------------------------------------------------------------------------------------------------------------

# Create a Term Frequency-Inverse Document Frequency matrix. Do the data make sense?

# VISUALISATION -------------------------------------------------------------------------------------------------------

# Make a word cloud.

library(wordcloud)
require(RColorBrewer)
