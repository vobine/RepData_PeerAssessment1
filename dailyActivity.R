dailyActivity <- function (stepData) {
  stepsPerInterval <- ddply (stepData,
                             .(interval), 
                             summarize, 
                             mst=mean(steps, na.rm=TRUE))
  
  plot (stepsPerInterval$interval,
        stepsPerInterval$mst,
        type="l")
  
  return (stepsPerInterval)
}