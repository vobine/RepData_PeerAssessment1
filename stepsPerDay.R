stepsPerDay <- function (stepData) {
  spd <- ddply (act,
                .(date), 
                summarize, 
                mst=sum(steps, na.rm=TRUE))
  print (mean (spd$mst))
  print (median (spd$mst))
  hist (spd$mst)
  
  return (spd)
}