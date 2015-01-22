##imports
library(ggplot2)

##setup paths
homeDir <- "~/coursera/expdataanalysis"
dataDir <- "exdata_data_NEI_data"
neiFile <- "summarySCC_PM25.rds"
sccFile <- "Source_Classification_Code.rds"
outputPlot <- "plot5.png"
setwd(homeDir)

##read data
nei <- readRDS(file.path(homeDir, dataDir, neiFile))
scc <- readRDS(file.path(homeDir, dataDir, sccFile))


veh <- grepl("vehicle", scc$SCC.Level.Two, ignore.case=TRUE)
vehScc <- scc[veh,]$SCC
vehNei <- nei[nei$SCC %in% vehScc,]

balVehNei <- vehNei[vehNei$fips==24510,]

png(outputPlot,width=480,height=480,units="px")

ggp <- ggplot(balVehNei,aes(factor(year),Emissions)) +
  geom_bar(stat="identity",fill="blue",width=0.75) +
  theme_bw() +  guides(fill=FALSE) +
  labs(x="year", y=expression("PM"[2.5]*" Emission [Tons]")) + 
  labs(title=expression("PM"[2.5]*" Motor Vehicle Emissions in Baltimore [1999-2008]"))

print(ggp)

dev.off()