
#install.packages("rsample")
library(rsample)
library(tidyverse)
gapminder <- gapminder::gapminder

train_df <- gapminder %>% rsample::vfold_cv() %>% 
  slice(1) %>%  pull(splits) %>% 
  analysis()

train_df <- gapminder %>% rsample::vfold_cv() %>% 
  slice(1) %>%  pull(splits) %>% 
  assessment()

?assessment

train_df <- gapminder %>% 
  rsample::vfold_cv() %>% 
  mutate(mod=map(splits,
                 ~lm(formula = lifeExp ~year, data=analysis(.x))
                 ))

gapminder %>% 
  rsample::vfold_cv() %>% 
  mutate(mod=full = map(splits,
                 ~lm(formula = lifeExp ~year, data=.x)),
                 rmse=map2_dbl(mod_full, splits,
                               ~modelr::rmse(.x, .y)),
         mod_analysis=map(splits,
                          ~lm(formula = lifeExp ~year, data=analysis(.x))),
                          rmse=map2_dbl(mod_analysis, splits, 
                                        ~modelr::rmse(.x, assessment(.y))) 
                        
                              
  )

