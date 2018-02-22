#strings
library(tidyverse)
gapminder <- gapminder::gapminder
#gapminder

gapminder %>% filter(str_detect(country,"Rep")) %>% 
  select(country) %>% 
  distinct()

dr_string <- "Congo, Dem. Rep."
dr_string

dr_pattern <- ", Dem\\. Rep\\."

str_detect(dr_string, dr_pattern)

str_replace(dr_string, dr_pattern, "")

str_c("Democratic Republic of", str_replace(dr_string, dr_pattern,""))

start <- str_locate(dr_string, dr_pattern)[1,1]      

str_sub(dr_string,end = start-1)

#https://www.gapminder.org/wp-content/themes/gapminder/cronJobs/json.js

line <- read_lines("https://www.gapminder.org/wp-content/themes/gapminder/cronJobs/json.js")
start <- str_locate(line,"\\{")[1,1]
str_sub(line, start =start) %>% 
 str_length()

line <- str_sub(line, start =start)
#str_locate_all(line,"\\{")
#install.packages("jsonlite")
#jsonlite::fromJSON()
json <- str_c("[",line,"]")
jlist <- jsonlite::fromJSON(json, simplifyVector = FALSE)

#install.packages("glue")
glue::glue("[{txt}]", txt=line)

jlist %>% View()

jlist[[1]] %>% View()
jlist <- jlist[[1]]

jlist %>% View()

jlist[[1]]$dataprovider_link

purrr::map(jlist,`[[`, "indicatorName")
purrr::map(jlist, "indicatorName")

map(jlist,`[[`, "indicatorName") %>% View()
map(jlist,`[[`,5) %>% View()

map(jlist,`[[`, "indicatorName") %>% simplify() %>% typeof()

indicatorName <- map(jlist,`[[`, "indicatorName")

t_gap <- tibble(indicatorName=map(jlist,"indicatorName")%>% simplify(),
       category=map(jlist,"category")%>% simplify(),
       subcategory=map(jlist,"subcategory")%>% simplify(),
       dataprovider=map(jlist,"dataprovider")%>% simplify(),
       dataprovider_link=map(jlist,"dataprovider_link")%>% simplify()
       )

t_gap <- tibble(indicatorName=map_chr(jlist,"indicatorName"),
       category=map_chr(jlist,"category"),
       subcategory=map_chr(jlist,"subcategory"),
       dataprovider=map_chr(jlist,"dataprovider"),
       dataprovider_link=map_chr(jlist,"dataprovider_link"))

write_csv(t_gap,"t_gap.csv")


v <- c(a="a",b=1,c=2.2)
attr(v, "names")
names(v)

t_gap <- tibble(sheet_id=names(jlist),
          indicatorName=map_chr(jlist,"indicatorName"),
       category=map_chr(jlist,"category"),
       subcategory=map_chr(jlist,"subcategory"),
       dataprovider=map_chr(jlist,"dataprovider"),
       dataprovider_link=map_chr(jlist,"dataprovider_link")) %>% write_csv("gapminder_datasources.csv")
