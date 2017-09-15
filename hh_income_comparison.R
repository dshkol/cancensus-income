# Variables:
# Pre-tax: v_CA16_2207, v_CA16_2397, v_CA16_2400, v_CA16_2403
# After-tax: v_CA16_2213, v_CA16_2398, v_CA16_2401, v_CA16_2404
# HH-size: v_CA16_419, v_CA16_420, v_CA16_421, v_CA16_422, v_CA16_423, v_CA16_425

# Question 1: How do 2016 CMA compare for household income

library(cancensus)
cma <- list_census_regions("CA16") %>% 
  filter(level=='CMA') %>%
  as_census_region_list

pretax_v <- c("v_CA16_2207", "v_CA16_2397", "v_CA16_2400", "v_CA16_2403")
aftertax_v <- c("v_CA16_2213", "v_CA16_2398", "v_CA16_2401", "v_CA16_2404")
hhsize_v <- c("v_CA16_419", "v_CA16_420", "v_CA16_421", "v_CA16_422", "v_CA16_423", "v_CA16_425")

pretax_inc <- get_census(dataset = "CA16", regions = cma_list, vectors = pretax_v,level = "CMA", geo_format = NA, labels = "short")
aftertax_inc <- get_census(dataset = "CA16", regions = cma_list, vectors = aftertax_v,level = "CMA", geo_format = NA, labels = "short")

pretax_tidy <- pretax_inc %>%
  tidyr::gather(key = `Income Type`, value = `Amount`, v_CA16_2207:v_CA16_2403) %>%
  mutate(`Income Type` = as.factor(`Income Type`))

levels(pretax_tidy$`Income Type`) = census_vectors(pretax_inc)$Detail

ggplot(pretax_tidy, aes(x = Amount, y = `Region Name`, colour = `Income Type`)) + geom_point()
