#install.packages("cancensus")
#install.packages("tidyverse")
#install.packages("viridis")
install.packages("ggpubr")
library(cancensus)
library(tidyverse)
library(viridis)
library(ggpubr)
options(cancensus.api_key='CensusMapper_e1b9908b65dcb10a0b2a319881b1cfe2')

toronto <- get_census(dataset='CA16',
                          regions=list(CMA="35535"),
                          vectors=c("v_CA16_2298","v_CA16_2299","v_CA16_2297"),
                          labels="detailed", geo_format="sf", level='CSD')

Men2<-rename(toronto, "men"=`v_CA16_2298: Total - After-tax income groups in 2015 for the population aged 15 years and over in private households - 100% data`)
Men3<-rename(Men2, "total"=`v_CA16_2297: Total - After-tax income groups in 2015 for the population aged 15 years and over in private households - 100% data`)


Men3%>%
  mutate(pct=(men/total)*100)->Men4

A<-ggplot(Men4, aes(geometry=geometry, fill=pct, color="black"))+
  geom_sf(color="black") +
  theme_void() +
  theme(panel.grid.major = element_line(colour = 'white')) +
  scale_fill_distiller(palette="Blues", direction=1, name="%") +
  labs(title="Mens distribution of earnings", caption="2015") +
  NULL



Women<-rename(toronto, "women"=`v_CA16_2299: Total - After-tax income groups in 2015 for the population aged 15 years and over in private households - 100% data`)
Women2<-rename(Women, "total"=`v_CA16_2297: Total - After-tax income groups in 2015 for the population aged 15 years and over in private households - 100% data`)

Women2%>%
  mutate(pct=(women/total)*100)->Women3

B<-ggplot(Women3, aes(geometry=geometry, fill=pct, color="black"))+
  geom_sf(color="black") +
  theme_void() +
  theme(panel.grid.major = element_line(colour = 'white')) +
  scale_fill_distiller(palette="Reds", direction=1, name="%") +
  labs(title="Womens distribution of earnings", caption="2015") +
  NULL

theme_set(theme_pubr())
figure <- ggarrange(A, B,
                    labels = c("A", "B"),
                    ncol = 2, nrow = 1)
figure
#what we see from this fighure is that in area's where mens distribution of earnings is low womens is higher.

ggexport(figure, filename = "Distribution comparison.png")
