install.packages("cancensus")
install.packages("tidyverse")
install.packages("viridis")
library(cancensus)
library(tidyverse)
library(viridis)

toronto <- get_census(dataset='CA16',
                      regions=list(CMA="35535"),
                      vectors=c("v_CA16_2298","v_CA16_2299","v_CA16_2297"),
                      labels="detailed", geo_format="sf", level='CSD')

Women<-rename(toronto, "women"=`v_CA16_2299: Total - After-tax income groups in 2015 for the population aged 15 years and over in private households - 100% data`)
Women2<-rename(Women, "total"=`v_CA16_2297: Total - After-tax income groups in 2015 for the population aged 15 years and over in private households - 100% data`)

glimpse(Women3)

#my hope with this would be to have each one be it's own thing and then use 
#a data wrapper to put them both onto one chart so they are easier to compare.

Women2%>%
mutate(pct=(women/total)*100)->Women3

ggplot(Women3, aes(geometry=geometry, fill=pct, color="black"))+
  geom_sf(color="black") +
  theme_void() +
  theme(panel.grid.major = element_line(colour = 'white')) +
  scale_fill_distiller(palette="Reds", direction=1, name="%") +
  labs(title="Womens distribution of earnings", caption="2015") +
  NULL
