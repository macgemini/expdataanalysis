##imports
library(ggplot2)

##setup paths
homeDir <- "~/coursera/expdataanalysis"
dataDir <- "exdata_data_NEI_data"
neiFile <- "summarySCC_PM25.rds"
sccFile <- "Source_Classification_Code.rds"
outputPlot <- "plot4.png"
setwd(homeDir)

##read data
nei <- readRDS(file.path(homeDir, dataDir, neiFile))
scc <- readRDS(file.path(homeDir, dataDir, sccFile))


combusRelated <- grepl("comb", scc$SCC.Level.One, ignore.case=TRUE)
coalRelated <- grepl("coal", scc$SCC.Level.Four, ignore.case=TRUE) 
coalCombus <- (combusRelated & coalRelated)
combusScc <- scc[coalCombus,]$SCC
combusNei <- nei[nei$SCC %in% combusScc,]

png(outputPlot,width=480,height=480,units="px")

ggp <- ggplot(combusNei,aes(factor(year),Emissions/10^5)) +
  geom_bar(stat="identity",fill="green",width=0.75) +
  theme_bw() +  guides(fill=FALSE) +
  labs(x="year", y=expression("PM"[2.5]*" Emission (10^5 Tons)")) + 
  labs(title=expression("PM"[2.5]*"Coal Combustion Source Emissions in US [1999-2008]"))

print(ggp)

dev.off()