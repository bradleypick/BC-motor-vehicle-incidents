---
title: "BC Motor Vehicle Incident Analysis"
author: "Bradley Pick"
date: "December 8, 2017"
output: github_document
---




```
## Error: '../results/data/speed.csv' does not exist in current working directory ('/home/bradley/mds/522/BC-motor-vehicle-incidents').
```

```
## Error: '../results/data/drug.csv' does not exist in current working directory ('/home/bradley/mds/522/BC-motor-vehicle-incidents').
```

```
## Error: '../results/data/distract.csv' does not exist in current working directory ('/home/bradley/mds/522/BC-motor-vehicle-incidents').
```

## Introduction

On any given week there are frequent news stories discussing the impact that distracted driving has on road safety. In particular, many of these stories focus on the advent of smartphones and texting while driving. We hope to identify general trends in the number of fatalities and injuries that occur on British Columbia's roads. Furthermore, we seek to relate trends in the overall number of fatalities and injuries to the number of cases that involve drugs/alcohol, speed, or distraction.

#### The Big Picture

It may not seem so, but the number of fatalities and injuries on British Columbia's roads decreased between 2004 and 2015:


```
## Error in eval(lhs, parent, parent): object 'speed' not found
```

```
## Error in eval(lhs, parent, parent): object 'speed' not found
```

```
## Error in eval_bare(dot$expr, dot$env): object 'total_in' not found
```

```
## Error in colnames(total_out) <- c("Total Change in Injuries", "Total Change in Fatalities"): object 'total_out' not found
```

```
## Error in inherits(x, "list"): object 'total_out' not found
```


#### Speed

Speeding has long been a concern on roads around the world. Previous studies have illustrated that increases in speed result in an increase in the number of and severity of accidents (1).
It is beyond the scope of our analysis to investigate the reasons for the decrease in the number of fatalities where speed was involved. We can see from the following plot that the number of fatalities where speed was involved has decreased.   


![Incidents Involving Speed](../results/img/speed-plot.png)

If we wish to be precise, the number of fatalities resulting from crashes that involved speeding dropped by 58 between 2004 and 2015 (similarly, injuries involving speeding dropped by 288).


```
## Error in eval(lhs, parent, parent): object 'speed' not found
```

```
## Error in eval(lhs, parent, parent): object 'speed_out' not found
```

```
## Error in kable(speed_out, caption = "2004-2015"): object 'speed_out' not found
```

#### Drugs and Alcohol

To this day the impact that impaired driving has on communities is difficult to understate. There has been a concerted effort on the part of the police and other community groups to reduce the number of incidents that occur as a result of imparied driving. In he following plot we can see that from 2004-2015 British Columbia saw a drop in the number of fatalities and injuries sustained in motor vehicle incidents.

![Incidents Involving Drugs or Alcohol](../results/img/drug-plot.png)

Like speeding involved incidents, there as been much emphasis placed on keeping drivers from participating in this type of dangerous behaviour over that last few decades. The exact numbers show that the dropin fatalities and injuries has been of a similar magnitude to speeding involved incidents. The number of fatalities involving drugs dropped by 56 and the number of injuries involving drugs dropped by 186.


```
## Error in eval(lhs, parent, parent): object 'drug' not found
```

```
## Error in eval(lhs, parent, parent): object 'drug_out' not found
```

```
## Error in kable(drug_out, caption = "2004-2015"): object 'drug_out' not found
```

#### Distraction

More recently than either alcohol/drugs or speed, distracted driving has become a major focus of public attention. The following plots illustrate that it is likely for good reason. Distracted driving does not appear to follow the same trend as other factors like speed and drugs/alcohol.

![Incidents Involving Distraction](../results/img/distract-plot.png)

In fact, we are seeing a small trend in the opposite direction. The number of distraction involved injuries and fatalities has increased from 2004-2015. This confirms our suspicions that distracted driving was not following the same declining trend as other factors in motor vehicle incidents. The number of fatalities where distraction was a factor increases by 12 between 2004 and 2015. Similarly, the number of injuries where distraction was a factor increased by 5.


```
## Error in eval(lhs, parent, parent): object 'distract' not found
```

```
## Error in eval(lhs, parent, parent): object 'distract_out' not found
```

```
## Error in kable(distract_out, caption = "2004-2015"): object 'distract_out' not found
```


### Conclusion

Overall, we saw that the number of fatalities and injuries on BC roads has declined over that last 11 years. Furthermore, we saw that while speeding involved incidents and drug/alcohol involced incidents have dropped, distraction has not only failed to drop but has slightly increased.

#### Sources

(1) [The Guardian](https://www.theguardian.com/news/datablog/2013/may/13/speed-limits-reduce-number-road-deaths)
