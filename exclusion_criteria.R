# Exclusion criteria is failing both attention checks and completing
# in under half the median time 

# This code was used to check for if any responses needed to be rejected
# from Qualtrics (only justifiable if both attention checks failed)

# This data set cannot be accessed due to anonymity. 

attention <- read.csv("data/attention_check.csv")

attention <- attention %>%
  slice(-(1:2))

# identifying exclusions

fail_both <- attention %>%
  dplyr::select(PROLIFIC_PID, attention_sa, attention_sd) %>%
  filter(attention_sa != "Somewhat agree" & 
           attention_sd != "Strongly disagree")

# sanity check

table(attention$attention_sa)
table(attention$attention_sd)

fail_one <- attention %>%
  dplyr::select(PROLIFIC_PID, attention_sa, attention_sd) %>%
  filter(attention_sa != "Somewhat agree" | 
           attention_sd != "Strongly disagree")

# no participant failed both, 21 failed one

# checking median time

attention$Duration..in.seconds. <- as.numeric(attention$Duration..in.seconds.)

summary(attention$Duration..in.seconds.)

#median is 635.5 seconds

cutoff <- median(attention$Duration..in.seconds., na.rm = TRUE) / 2

time <- attention %>%
  dplyr::select(PROLIFIC_PID, Duration..in.seconds.) %>%
  filter(Duration..in.seconds. < cutoff)

# 27 observations for exclusion
