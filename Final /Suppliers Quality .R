library("tidyverse")
library("sqldf")
library("readxl")
library("writexl")



# Import sheets 
sheets <- excel_sheets("Desktop/Suppliers Quality Analaysis (1).xlsx")

# get each sheet as df
for (sheet in sheets) {
  assign(paste0("df_", sheet), read_excel("Desktop/Suppliers Quality Analaysis (1).xlsx", sheet = sheet))
}


# Join Category with Defected items
FIN <- left_join(`df_Defected Items`, df_Category,c("Sub Category ID"="Sub Category ID"))


# Join FIN with defect type
FIN_2 <- left_join(FIN, `df_Defect Type`,c("Defect Type ID"="Defect Type ID"))


# Join FIN_2 with df defects
FIN_3 <- left_join(FIN_2,df_Defects,c("Defect ID"="Defect ID"))


# Join FIN_3 with df dfMaterial Type
FIN_4 <- left_join(FIN_3,`df_Material Type`,c("Material Type ID"="Material Type ID"))


# Join FIN_4 with df Plant
FIN_5 <- left_join(FIN_4,df_Plant,c("Plant ID"="Plant ID"))


# Join FIN_5 with df Vendor
FIN_6 <- left_join(FIN_5,df_Vendor,c("Vendor ID"="Vendor ID"))

x <- FIN_6 %>% filter(`Vendor ID` %in% c(113,80))

writexl::write_xlsx(FIN_6,"Data.xlsx")




