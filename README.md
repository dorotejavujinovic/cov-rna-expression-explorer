# My first Shiny app

The app I produced is tool that should help domain scientists explore and generate hypotheses based on RNA expression data from lung cells infected with SARS-CoV.

## Data

In 2007, [Sims et al.](https://pubmed.ncbi.nlm.nih.gov/17451829/) published a time series dataset where they inoculated cultured human lung cells with a virus designated SARS-CoV and measured RNA expression for 72 hours. This dataset is available online under reference [GSE33267](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE33267). 

First, I had to transform data from wide to long format. This is the result: 

|probe        |sample_name |time_point |replicate |    value|
|:------------|:-----------|:----------|:---------|--------:|
|A_23_P100001 |DORF6       |0H         |1         | 10.14091|
|A_23_P100001 |DORF6       |0H         |2         | 10.21428|
|A_23_P100001 |DORF6       |0H         |3         | 10.21319|
|A_23_P100001 |DORF6       |3H         |1         | 10.28294|
|A_23_P100001 |DORF6       |3H         |2         |  9.97440|
|A_23_P100001 |DORF6       |3H         |3         | 10.12804|

Expressions are reported for regions that do not have pretty gene symbol names, so I translated that into something human readable. Dataset with nice gene symbols can be found [here](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GPL4133).

In the end, completely transformed dataset looks like this:

|probe        |sample_name |time_point |replicate |    value|GENE_SYMBOL |
|:------------|:-----------|:----------|:---------|--------:|:-----------|
|A_23_P100001 |DORF6       |0H         |1         | 10.14091|FAM174B     |
|A_23_P100001 |DORF6       |0H         |2         | 10.21428|FAM174B     |
|A_23_P100001 |DORF6       |0H         |3         | 10.21319|FAM174B     |
|A_23_P100001 |DORF6       |3H         |1         | 10.28294|FAM174B     |
|A_23_P100001 |DORF6       |3H         |2         |  9.97440|FAM174B     |
|A_23_P100001 |DORF6       |3H         |3         | 10.12804|FAM174B     |








