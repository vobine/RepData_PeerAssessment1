fixNA <- function (stepData, perInterval) {
  which <- is.na (stepData$steps)
  print (sum (which));
  
  fixie <- stepData;
  fixie$steps[which] <-
    perInterval$mst[perInterval$interval == fixie$interval[which]];
  fixie$steps[is.na (fixie$steps)] <- 
    mean (fixie$steps, na.rm=TRUE);
  
  return (fixie);
}