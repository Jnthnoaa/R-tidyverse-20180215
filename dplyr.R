library("tidyverse")
gapminder <- gapminder::gapminder
gapminder

# %>%
# %>% comand shift M
gapminder %>% select(country, year, gdpPercap)
gapminder %>% select(-gdpPercap)
year_country_gdp <- gapminder %>%
  select(year,country, gdpPercap)

gapminder %>% 
  filter(year == 2002) %>%
  ggplot(mapping = aes(x=continent, y=pop)) +
  geom_boxplot()

gapminder %>%
  filter(continent == "Europe") %>% 
  select(year, country, gdpPercap)

gapminder %>%
  filter(country == "Norway") %>% 
  select(year, lifeExp, gdpPercap) %>% 
  ggplot(mapping = aes(x=year, y=gdpPercap)) +
  geom_line()

gapminder %>%
  group_by(continent) %>% 
  summarize(mean_gdpPercap = mean(gdpPercap))

#mapping = aes(x=country, y=mean_life)

gapminder %>%
  filter(continent == "Asia") %>% 
  group_by(country) %>% 
  summarize(mean_life = mean(lifeExp)) %>% 
  ggplot() + geom_point(mapping = aes(y=country, x=mean_life))

gapminder %>%
  filter(continent == "Asia") %>% 
  group_by(country) %>% 
  summarize(mean_life = mean(lifeExp)) %>% 
  filter(mean_life == min(mean_life) | mean_life == max(mean_life))

gapminder %>% 
  group_by(continent, year) %>% 
  summarize(mean_gdpPercap = mean(gdpPercap), 
            sd_gdpPercap = sd(gdpPercap),
            mean_pop = mean(pop),
            sd_pop = sd(pop))

gapminder %>% 
  mutate(gdp_billion = gdpPercap * pop / 10^9)

gapminder %>% 
  mutate(gdp_billion = gdpPercap * pop / 10^9) %>%
  filter(year == "1997") %>% 
  group_by(continent) %>% 
  summarize(mean_life = mean(lifeExp), mean_gdp = mean(gdp_billion))
              
gapminder_country_summary <- gapminder %>%
  group_by(country) %>% 
  summarise(mean_lifExp = mean(lifeExp))

gapminder_country_summary

map_data("world") %>%
  rename(country = region) %>% 
  left_join(gapminder_country_summary, by = "country") %>% 
  ggplot()+
  geom_polygon(mapping = aes(x=long,y=lat, group=group, fill = mean_lifExp))

## 14:15

# tidyr
# gather()
# join()
# 

# wide vs long

#see tidyr.R




