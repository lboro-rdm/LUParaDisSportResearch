# Keywords related to sport
keywords_sport <- c(
  '"elite disability" AND "sport"', 
  '"grassroots disability" AND "sport"', 
  '"community disability" AND "sport"', 
  '"school disability" AND "sport"', 
  '"paralympic" AND "sport"', 
  '"paralympics"', 
  '"parasport"', 
  '"wheelchair" AND "sport"', 
  '"accessibility in" AND "sport"', 
  '"accessibility in physical activity"', 
  '"rehabilitation"', 
  '"inclusive physical education"', 
  '"inclusive school" AND "sport"', 
  '"adapted physical activity"', 
  '"wheelchair athletes"', 
  '"impairment" AND "sport"', 
  '"special olympics"', 
  '"unified sports"'
)

# Condition-related keywords combined with "sport"
conditions_sport <- c(
  '"hearing impairment" AND "sport"', 
  '"deaf" AND "sport"', 
  '"neurodiversity" AND "sport"', 
  '"autism" AND "sport"', 
  '"visual impairment" AND "sport"', 
  '"blind" AND "sport"', 
  '"intellectual disability" AND "sport"', 
  '"physical impairment" AND "sport"', 
  '"musculoskeletal impairment" AND "sport"', 
  '"spinal cord injury" AND "sport"', 
  '"amputee" AND "sport"'
)

# Condition-related keywords combined with "athlete"
conditions_athlete <- c(
  '"hearing impairment" AND "athlete"', 
  '"deaf" AND "athlete"',  
  '"neurodiversity" AND "athlete"', 
  '"autism" AND "athlete"', 
  '"visual impairment" AND "athlete"', 
  '"blind" AND "athlete"', 
  '"intellectual disability" AND "athlete"', 
  '"physical impairment" AND "athlete"', 
  '"musculoskeletal impairment" AND "athlete"', 
  '"spinal cord injury" AND "athlete"', 
  '"amputee" AND "athlete"'
)

# Condition-related keywords combined with "elite"
conditions_elite <- c(
  '"hearing impairment" AND "elite"', 
  '"deaf" AND "elite"',  
  '"neurodiversity" AND "elite"', 
  '"autism" AND "elite"',  
  '"visual impairment" AND "elite"', 
  '"blind" AND "elite"', 
  '"intellectual disability" AND "elite"', 
  '"physical impairment" AND "elite"', 
  '"musculoskeletal impairment" AND "elite"', 
  '"spinal cord injury" AND "elite"', 
  '"amputee" AND "elite"'
)

# Combining all keywords into a single vector if needed
keywords <- c(keywords_sport, conditions_sport, conditions_athlete, conditions_elite)
print(keywords)