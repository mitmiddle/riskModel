library(tidyverse)
library(mc2d)
library(plotly)

set.seed(1981)

poiPhish <- rpois(n=1000,250)
prtLabor <- rpert(1000,3,10,60,4)
cstLabor <- 110.7
poiBreach <- rpois(1000,0.05)
prtBreachRecords <- rpert(1000,500,3118,50000,5)
cstBreachRecords <- 380

alePhish <- poiPhish * (prtLabor * cstLabor + (poiBreach * (prtBreachRecords * cstBreachRecords)))


p <- plot_ly(x = poiPhish, type="histogram") %>% 
  add_trace(x=fit$x, y=fit$y, type="scatter", mode="lines", fill = "tozeroy", yaxis="y2", name = "Density") %>% 
  layout(yaxis2 = list(overlaying = "y", side = "right"))
