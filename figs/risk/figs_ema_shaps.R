#####################################
# Set up environment
#####################################

library(tidyverse)
theme_set(theme_classic()) 
devtools::source_url("https://github.com/jjcurtin/lab_support/blob/main/format_path.R?raw=true",
                     sha1 = "a58e57da996d1b70bb9a5b58241325d6fd78890f")
path_data <- "data/risk"
path_mak <- "mak/risk"

####################################
# load data
####################################
source(here::here(path_mak, "mak_ema_shaps.R"))
global <- read_csv(here::here(path_data, "ema_shaps_global.csv"), 
                   show_col_types = FALSE)


####################################################
# Global SHAP Plot
####################################################
fig_global_all <- global |>
  mutate(group = reorder(variable_grp, mean_value, sum)) |>
  mutate(window = fct(window, levels = c("week", "day", "hour"))) |> 
  ggplot() +
  geom_bar(aes(x = group, y = mean_value, fill = window), stat = "identity") +
  ylab("Mean |SHAP| value (in Log-Odds)") +
  xlab("") +
  coord_flip() +
  scale_fill_manual(values = c("orange","green","blue"))


fig_global_day <- global |>
  filter(window == "day") |> 
  filter(str_detect(variable_grp, "EMA")) |>
  mutate(group = reorder(variable_grp, mean_value, sum)) |>
  ggplot() +
  geom_bar(aes(x = group, y = mean_value), stat = "identity", fill  = "green") +
  ylab("Mean |SHAP| value (in Log-Odds)") +
  xlab("") +
  coord_flip()
