library(tidyverse)
library(readxl)

list.files(pattern = "xlsx$")

# the name or full path of the file
path <- "Analysis results for all variates 2022-04-29.xlsx"

df <- path %>% 
  excel_sheets() %>% # the names of all the sheets in a workbook
  str_detect(pattern = 'Results') %>% # sheets with 'Results' in their name
  which() %>% # positions of sheets that match pattern
  map_df(
    .x = ., # list over which to loop the function
    .f = read_excel, # the function
    path = path, # argument for the function
    col_names = FALSE,
    .id = "source" # the coln storing the sheet IDs in the final data frame
  )

# row numbers which contain 'Treatments' in col "Treatment/Factor Means Summary"
start <- df %>% pluck("...1") %>% str_which("Source")

# row numbers which contain 'Main Plot Error'
stop <- df %>% pluck("...1") %>% str_which("Main Plot Error") # %>% 
# "[" indexes all elements of the vector (.) but the 1st %>% subtracts 1 %>% appends the total no. rows at end
# "["(. = -1) %>% -1 %>% c(., nrow(test2))


df <- df %>% slice( # slice out the following rows
  map2(.x = start, .y = stop, .f = seq) %>% # produce sequences 
                                            # using objects start & stop as args
    unlist() # combine all sequences into a single vector
  ) %>% 
  janitor::remove_empty("cols") %>% # remove empty colns
  filter(!is.na(...1)) # remove rows with NA in col '...1'