library(dplyr)
#LOAD DATA BACI
BACI_2022 = read.csv("BACI_HS92_Y2022_V202401.csv") #REZAGO

#Sacar media de exportaciones

BACI_sum1 = BACI_2022 %>%                                  
  group_by(i, k, t) %>% 
  dplyr::summarise(suma_xprodut  = sum(v, na.rm = TRUE),count= n())

BACI_sum2 = BACI_2022 %>%                                  
  group_by(i, k) %>% 
  dplyr::summarise(suma_xyears  = sum(v, na.rm = TRUE),count= n())

BACI_sum2=cbind(BACI_sum2, Periodos=rep(1))
Mean_exports=BACI_sum2$ExportsMean=BACI_sum2$suma_xyears/BACI_sum2$Periodos
write.csv(BACI_sum2, file = "BACI_2022.csv")

#Merge data final

green_products = read.csv("country_codes_V202401.csv")
all_products = read.csv("BACI_2022.csv")
merged.full <-  merge(all_products, green_products, by="country_code", all.x= T)
write.csv(merged.full, file = "exportaciones_mundiales_2022.csv")


