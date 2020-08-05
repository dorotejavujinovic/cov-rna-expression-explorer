library(ggplot2)
library(tidyverse)
data_wide <- read.delim("C:/famnit/genialis/data/GSE33267_scl005_EXPRS.txt.gz", 
                        header = TRUE, 
                        stringsAsFactors = FALSE)

xy <- pivot_longer(data_wide, 
                   cols = -probe,
                   names_to = "sample",
                   values_to = "value")

xy1 <- separate(xy, sample, c("sample_name", 
                              "time_point", 
                              "replicate"), sep = "_")

annotations <- read.delim("C:/famnit/genialis/data/GPL4133-12599.txt", comment.char="#")
annotations <- annotations%>%select("NAME", "GENE_SYMBOL")
names(annotations)[names(annotations) == "NAME"] <- "probe"
final <- merge(xy1, annotations, by="probe")
final$time_point <- factor(final$time_point, 
                           levels = c("0H", "3H", "7H", "12H",
                                      "24H", "30H", "36H",
                                      "48H", "54H", "60H", "72H"))


save(final, annotations, file = "data/appdata.RData")

