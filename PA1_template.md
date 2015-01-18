# Reproducible Research: Peer Assessment 1


```r
library (plyr)
```

## Loading and preprocessing the data

Assignment data set is included in the Git repository, forked from https://github.com/rdpeng/RepData_PeerAssessment1, in the file activity.zip. In my repository I've manually unpacked that to activity.csv. Load it:


```r
acts <- read.csv ('activity.csv')
```

The result is usable as is.

## What is mean total number of steps taken per day?

Plyr is a convenient tool to add up the steps taken in each day.


```r
spd <- ddply (acts,
              .(date), 
              summarize, 
              stepSum=sum (steps, na.rm=TRUE))
```

Display the result.


```r
hist (spd$stepSum, breaks=13)
```

![](PA1_template_files/figure-html/unnamed-chunk-4-1.png) 

The subject took a mean of `{r} mean (spd$stepSum)` steps and median of `{r}median (spd$stepSum)` steps per day.

## What is the average daily activity pattern?

Once again, Plyr is our friend.


```r
spi <- ddply (acts,
              .(interval), 
              summarize, 
              stepMean = mean(steps, na.rm=TRUE))
```

Display it:


```r
plot (spi$interval, spi$stepMean, type='l')
```

![](PA1_template_files/figure-html/unnamed-chunk-6-1.png) 

The busiest interval of the subject's day, on average was
`{r} spi$interval[which.max (spi$stepMean)]`.

## Imputing missing values


```r
which <- is.na (acts$steps)
```

The data set comprises many missing step count values: a total of
`{r} sum (which)`, or
`{r} 100.0 * sum (which) / length (which)`
percent of the total.

We use a two-stage strategy for imputing missing values to the data. First, we replace an NA at interval `i` with the mean number of steps in that interval over the rest of the data set. Unfortunately, many intervals are NA over the entire series; for those we impute the grand mean over all non-NA data.


```r
fixie <- acts
fixie$steps[which] <-
  spi$stepMean[spi$interval == fixie$interval[which]]
fixie$steps[is.na (fixie$steps)] <- 
  mean (acts$steps, na.rm=TRUE)
```

Fixed! Did it change anything? Here's the new histogram:

```r
hist (ddply (fixie,
              .(date), 
              summarize, 
              stepSum=sum (steps))$stepSum,
      breaks=13)
```

![](PA1_template_files/figure-html/unnamed-chunk-9-1.png) 

## Are there differences in activity patterns between weekdays and weekends?
