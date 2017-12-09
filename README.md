# BC Motor Vehicle Incident Analysis

### Usage

From the root folder of project directory:
```
make all
```
If you wish to clean up after yourself:
```
make clean
```

The `Makefile` dependency graph looks like this:

![](./Makefile.png)

### Dependencies

Every effort has been made to use `packrat` to manage dependencies. As far
as I can tell, this means you should only need to have packrat installed. Until
we learn more about package management I have also included a very rough outline
of necessary dependencies at the end of the readme.  

If you'd rather not use packrat, the packages that are loaded or used in the
scripts and Makefile explicitly are:
`readr`, `tidyr`, `stringr`, `dplyr`, `ggplot2`, and `ezknitr`.

### Identify Dataset

This project accesses data from the Government of British Columbia
[catalogue](https://catalogue.data.gov.bc.ca/dataset).

In particular we download and analyze 8 datasets that all involve fatalities
or injuries sustained in a motor vehicle incident:

- https://catalogue.data.gov.bc.ca/dataset/motor-vehicle-fatalities-with-distraction-involvement
- https://catalogue.data.gov.bc.ca/dataset/motor-vehicle-serious-injuries-with-distraction-involvement
- https://catalogue.data.gov.bc.ca/dataset/motor-vehicle-serious-injuries-by-role
- https://catalogue.data.gov.bc.ca/dataset/motor-vehicle-serious-injuries-with-speeding-involvement
- https://catalogue.data.gov.bc.ca/dataset/motor-vehicle-fatalities-with-speeding-involvement
- https://catalogue.data.gov.bc.ca/dataset/motor-vehicle-fatalities-by-role
- https://catalogue.data.gov.bc.ca/dataset/motor-vehicle-serious-injuries-with-alcohol-and-or-drug-involvement
- https://catalogue.data.gov.bc.ca/dataset/motor-vehicle-fatalities-with-alcohol-and-or-drug-involvement

### Question

The objectives of this analysis include investigating the following questions:

- Has the number of fatalities and/or injuries sustained in motor vehicle
incidents in BC increased or decreased in the last decade?

- Has the trend (if present) been driven by any of the factors we have access
to in the data?

### Hypotheses

The objectives of this analysis include investigating the following hypotheses
about the above questions:

- We posit that the number of injuries/fatalities resulting from motor vehicle
incidents has declined over tha last decade.

- We posit the downward trend is caused by drop in all causes *except*
distracted driving.

We investigate this using data on fatalities/injuries involving
drugs and alcohol, speeding, and distracted driving.

### Plan of action

We will plot the overall number of injuries and fatalities against time for
previous decade.

We will plot the aggregated data from the last ten years in such a way as
to illustrate which causes have become more frequent and which have become
less frequent.

### Dependencies

This project is being constructed using Rstudio (version `1.1.383`):

Identified using `sessionInfo()` in `download_data.R`:

```
R version 3.4.2 (2017-09-28)
Platform: x86_64-pc-linux-gnu (64-bit)
Running under: Ubuntu 14.04.3 LTS

Matrix products: default
BLAS: /usr/lib/libblas/libblas.so.3.0
LAPACK: /usr/lib/lapack/liblapack.so.3.0

locale:
 [1] LC_CTYPE=en_CA.UTF-8       LC_NUMERIC=C              
 [3] LC_TIME=en_CA.UTF-8        LC_COLLATE=en_CA.UTF-8    
 [5] LC_MONETARY=en_CA.UTF-8    LC_MESSAGES=en_CA.UTF-8   
 [7] LC_PAPER=en_CA.UTF-8       LC_NAME=C                 
 [9] LC_ADDRESS=C               LC_TELEPHONE=C            
[11] LC_MEASUREMENT=en_CA.UTF-8 LC_IDENTIFICATION=C       

attached base packages:
[1] stats     graphics  grDevices utils     datasets  base     

other attached packages:
[1] readr_1.1.1

loaded via a namespace (and not attached):
[1] compiler_3.4.2 R6_2.2.2       hms_0.3        tools_3.4.2    curl_3.0      
[6] tibble_1.3.4   Rcpp_0.12.13   methods_3.4.2  rlang_0.1.4
```

Using `sessionInfo()` in `merge_data.R`:

```
R version 3.4.2 (2017-09-28)
Platform: x86_64-pc-linux-gnu (64-bit)
Running under: Ubuntu 14.04.3 LTS

Matrix products: default
BLAS: /usr/lib/libblas/libblas.so.3.0
LAPACK: /usr/lib/lapack/liblapack.so.3.0

locale:
 [1] LC_CTYPE=en_CA.UTF-8       LC_NUMERIC=C              
 [3] LC_TIME=en_CA.UTF-8        LC_COLLATE=en_CA.UTF-8    
 [5] LC_MONETARY=en_CA.UTF-8    LC_MESSAGES=en_CA.UTF-8   
 [7] LC_PAPER=en_CA.UTF-8       LC_NAME=C                 
 [9] LC_ADDRESS=C               LC_TELEPHONE=C            
[11] LC_MEASUREMENT=en_CA.UTF-8 LC_IDENTIFICATION=C       

attached base packages:
[1] stats     graphics  grDevices utils     datasets  base     

other attached packages:
[1] bindrcpp_0.2 dplyr_0.7.4  tidyr_0.7.2  readr_1.1.1

loaded via a namespace (and not attached):
 [1] Rcpp_0.12.13     assertthat_0.2.0 R6_2.2.2         magrittr_1.5    
 [5] rlang_0.1.4      tools_3.4.2      glue_1.2.0       purrr_0.2.4     
 [9] hms_0.3          compiler_3.4.2   pkgconfig_2.0.1  bindr_0.1       
[13] tidyselect_0.2.2 methods_3.4.2    tibble_1.3.4    

```

Using `sessionInfo()` in `plot_data.R`:

```
R version 3.4.2 (2017-09-28)
Platform: x86_64-pc-linux-gnu (64-bit)
Running under: Ubuntu 14.04.3 LTS

Matrix products: default
BLAS: /usr/lib/libblas/libblas.so.3.0
LAPACK: /usr/lib/lapack/liblapack.so.3.0

locale:
 [1] LC_CTYPE=en_CA.UTF-8       LC_NUMERIC=C              
 [3] LC_TIME=en_CA.UTF-8        LC_COLLATE=en_CA.UTF-8    
 [5] LC_MONETARY=en_CA.UTF-8    LC_MESSAGES=en_CA.UTF-8   
 [7] LC_PAPER=en_CA.UTF-8       LC_NAME=C                 
 [9] LC_ADDRESS=C               LC_TELEPHONE=C            
[11] LC_MEASUREMENT=en_CA.UTF-8 LC_IDENTIFICATION=C       

attached base packages:
[1] stats     graphics  grDevices utils     datasets  base     

other attached packages:
[1] bindrcpp_0.2  stringr_1.2.0 ggplot2_2.2.1 dplyr_0.7.4   readr_1.1.1  

loaded via a namespace (and not attached):
 [1] Rcpp_0.12.13     digest_0.6.12    assertthat_0.2.0 plyr_1.8.4      
 [5] grid_3.4.2       R6_2.2.2         gtable_0.2.0     magrittr_1.5    
 [9] scales_0.5.0     stringi_1.1.5    rlang_0.1.4      lazyeval_0.2.1  
[13] labeling_0.3     tools_3.4.2      glue_1.2.0       munsell_0.4.3   
[17] hms_0.3          compiler_3.4.2   colorspace_1.3-2 pkgconfig_2.0.1
[21] bindr_0.1        methods_3.4.2    tibble_1.3.4
```
