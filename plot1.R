##setup paths
homeDir <- "~/coursera/expdataanalysis"
dataDir <- "exdata_data_NEI_data"
neiFile <- "summarySCC_PM25.rds"
outputFile <- "plot1.png"
par(mar=c(3,5,3,3))
setwd(homeDir)

##read data
nei <- readRDS(file.path(homeDir, dataDir, neiFile))

## aggregate emmisions
aggVal <- aggregate(Emissions ~ year, nei, sum)

png("plot1.png",width=480,height=480,units="px")

barplot(
  (aggVal$Emissions)/10^6,
  names.arg=aggVal$year,
  xlab="Year",
  ylab="PM2.5 Emissions [Tons]",
  main="US Total PM2.5 Emissions",
  col=3
)

dev.off()



