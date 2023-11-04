library(venn); library(tidyverse); library(stringr); 

p_th = 0.0;

data <- read_csv("caseolap.csv")
data

venn = 
  list(CM = 
         data %>% 
         filter(CM > p_th) %>% 
         .$protein,
       ARR = 
         data %>% 
         filter(ARR > p_th) %>% 
         .$protein,
       CHD = 
         data %>% 
         filter(CHD > p_th) %>% 
         .$protein,
       VD = 
         data %>% 
         filter(VD > p_th) %>% 
         .$protein,
       IHD = 
         data %>% 
         filter(IHD > p_th) %>% 
         .$protein,
       CCS = 
         data %>% 
         filter(CCS > p_th) %>% 
         .$protein,
       VOO = 
         data %>% 
         filter(VOO > p_th) %>% 
         .$protein,
       OHD = 
         data %>% 
         filter(OHD > p_th) %>% 
         .$protein);
      

png("ven.png", width = 800, height = 800)

venn.result =
  venn(venn, ilabels = TRUE, 
       zcolor = "style", size = 25, cexil = 1.2, cexsn = 1.5, ilcs = 2, sncs = 2);


dev.off()
