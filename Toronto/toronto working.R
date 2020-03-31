#install.packages("cancensus")
install.packages("tidyverse")
library(cancensus)
library(tidyverse)
options(cancensus.api_key='CensusMapper_e1b9908b65dcb10a0b2a319881b1cfe2')

toronto <- get_census(dataset='CA16',
                          regions=list(CMA="35535"),
                          vectors=c("v_CA16_2298","v_CA16_2299","v_CA16_2297"),
                          labels="detailed", geo_format="sf", level='DA')

toronto2<-rename(toronto, "men"=`v_CA16_2298: Total - After-tax income groups in 2015 for the population aged 15 years and over in private households - 100% data`)
toronto3<-rename(toronto2, "women"=`v_CA16_2299: Total - After-tax income groups in 2015 for the population aged 15 years and over in private households - 100% data`)
toronto4<-rename(toronto3, "total"=`v_CA16_2297: Total - After-tax income groups in 2015 for the population aged 15 years and over in private households - 100% data`)

glimpse(toronto4)

#my hope with this would be to have each one be it's own thing and then use 
#a data wrapper to put them both onto one chart so they are easier to compare.

toronto4%>%
  mutate(pct=(men/total)*100)->toronto5
  #mutate(pct2=(women/total)*100)

ggplot(toronto5, aes(geometry=geometry, fill=pct, color="black"))+
  geom_sf(color="black") +
  theme_void() +
  theme(panel.grid.major = element_line(colour = 'white')) +
  scale_fill_distiller(palette="Reds", direction=1, name="%") +
  labs(title="Mens distribution of earnings", caption="2015") +
  NULL
  #what I would love is for the gradient to be two colors.
  #I tried usinng a scale_color_gradient of low=blue, High=red
  #but that wouldnt work


#this was my try at bringing them together.
#toronto5%>%
 #gather(Sex, n, men, women)->toronto6
#ggplot(toronto5, aes(geometry=geometry, fill="total"))+facet_wrap(~Sex)+geom_sf()
