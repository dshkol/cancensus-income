# Richmond income distribution

richmond_income <- get_census(dataset='CA16', regions=list(CSD="5915015"), 
                          vectors=c("v_CA16_2258","v_CA16_2261","v_CA16_2264","v_CA16_2267","v_CA16_2270","v_CA16_2273","v_CA16_2276",
                                    "v_CA16_2279","v_CA16_2282","v_CA16_2285","v_CA16_2291","v_CA16_2294"), 
                          level='Regions', labels = "short")

richmond_tidy <- richmond_income %>% 
  tidyr::gather(key = `Income Group`, value = Count, v_CA16_2258:v_CA16_2294) %>%
  mutate(`Income Group` = as.factor(gsub("^.*: ","",`Income Group`))) %>%
  levels(richmond_tidy$`Income Group`) = census_vectors(richmond_income)$Detail

ggplot(richmond_tidy, aes(x = `Income Group`, y = Count)) + 
  geom_bar(stat= "identity") + 
  coord_flip() + 
  theme_minimal() + xlab("") + ylab("Number of Census households") + 
  labs(title = "Household Income, Total, Census 2015",
       subtitle = "Richmond Census Subdividison",
       caption = "Census 2015 data via R cancensus package")
