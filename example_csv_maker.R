# an example of taking the dataexamples.md file and making a csv using R
# by David Hood @thoughtfulnz on Twitter

library(dplyr)
library(tidyr)

# read in the lines as 1 line per observation in a vairable
# ID entries by the ``` between them
# split the observations by the colon
# get rid of the ones without colons
# trim any extra whitespace
# use the column of headings as common headings and the details underneath the headings
# save as csv

data.frame(rawlines = readLines("dataexamples.md"), stringsAsFactors = FALSE) %>%
  mutate(entry= cumsum(as.numeric(trimws(rawlines) == "```"))) %>%
  separate(rawlines, into=c("first", "second"), sep=":", extra="merge", fill = "right") %>%
  filter(!is.na(second)) %>%
  mutate(heading = trimws(first), details = trimws(second)) %>%
  select(entry, heading, details) %>%
  spread(heading, details) %>%
  select(-entry) %>%
  write.csv(file = "dataexamples_as_csv.csv", row.names = FALSE)
