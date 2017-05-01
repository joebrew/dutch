library(tidyverse)
library(gsheet)

# Read in michel thomas phrases
# mt <- read_csv('data/vocab.csv')
mt_url <- 'https://docs.google.com/spreadsheets/d/1XeRK8FOn2TB-cExvCxostDGcyBrPozV0vV2twXVxfC8/edit?usp=sharing'
mt <- gsheet2tbl(mt_url)

# Make sure all rows are populated
mt <- mt %>%
  filter(!is.na(en),
         !is.na(nl))

# Define function for picking a phrase
subset_data <- function(data = mt,
                        disc_number = NULL,
                        track_number = NULL,
                        to = 'nl'){
  # Filter down if necessary
  if(!is.null(disc_number)){
    data <- data %>%
      filter(disc %in% disc_number)
  }
  if(!is.null(track_number)){
    data <- data %>%
      filter(track %in% track_number)
  }
  out <- data
  # Format based on language
  if(to == 'nl'){
    out <- out %>%
      rename(answer = nl,
             question = en) %>%
      dplyr::select(question, answer)
  } else {
    out <- out %>%
      rename(answer = en,
             question = nl) %>%
      dplyr::select(question, answer)
  }
  # Return
  return(out)
}
