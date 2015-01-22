##imports
library(ggplot2)

##setup paths
homeDir <- "~/coursera/expdataanalysis"
dataDir <- "exdata_data_NEI_data"
neiFile <- "summarySCC_PM25.rds"
outputPlot <- "plot3.png"
setwd(homeDir)

##read data
nei <- readRDS(file.path(homeDir, dataDir, neiFile))
balNei <- nei[nei$fips=="24510",]

## aggregate emmisions
aggVal <- aggregate(Emissions ~ year, balNei, sum)

png(outputPlot,width=480,height=480,units="px")

ggp <- ggplot(balNei,aes(factor(year),Emissions,fill=type)) +
  geom_bar(stat="identity") +
  guides(fill=FALSE)+
  facet_grid(.~type,scales = "free",space="free") + 
  coord_flip() +
  labs(x="year", y=expression("PM"[2.5]*" Emission [Tons]")) + 
  labs(title=expression("PM"[2.5]*" Emissions, Baltimore City by Source Type [1999-2008]"))

print(ggp)

dev.off()