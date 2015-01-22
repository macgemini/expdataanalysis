##imports
library(ggplot2)
library(grid)

##setup paths
homeDir <- "~/coursera/expdataanalysis"
dataDir <- "exdata_data_NEI_data"
neiFile <- "summarySCC_PM25.rds"
sccFile <- "Source_Classification_Code.rds"
outputPlot <- "plot6.png"
setwd(homeDir)

##read data
nei <- readRDS(file.path(homeDir, dataDir, neiFile))
scc <- readRDS(file.path(homeDir, dataDir, sccFile))


veh <- grepl("vehicle", scc$SCC.Level.Two, ignore.case=TRUE)
vehScc <- scc[veh,]$SCC
vehNei <- nei[nei$SCC %in% vehScc,]

balVehNei <- vehNei[vehNei$fips==24510,]
balVehNei$city <- "Baltimore"
laVehNei <- vehNei[vehNei$fips=="06037",]
laVehNei$city <- "LA"
combNei <- rbind(balVehNei,laVehNei)

png(outputPlot,width=600,height=600,units="px")

ggp <- ggplot(combNei, aes(x=factor(year), y=Emissions, fill=city)) +
  geom_bar(aes(fill=city),stat="identity") +
  facet_grid(scales="free", space="free", .~city) +
  guides(fill=FALSE) + 
  theme_bw() +
  theme(plot.margin = unit(c(2,2,2,2), "cm")) + 
  labs(x="year", y=expression("PM"[2.5]*" Emission (KT)")) + 
  labs(title=expression("PM"[2.5]*" Motor Vehicle Emissions in Baltimore and Los Angeles [1999-2008]"))

print(ggp)

dev.off()