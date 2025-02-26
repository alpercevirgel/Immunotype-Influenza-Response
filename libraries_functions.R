### libraries
packages = c("tidyverse", 
             "purrr",
             "broom",
             "readxl", 
             "rstatix", 
             "ggpubr", 
             "egg",
             "ggprism", 
             "fitdistrplus",
             "logspline", 
             "gamlss",
             "gamlss.dist",
             "gamlss.add",
             "gamlss.lasso",
             "AID",
             "MASS",
             "car",
             "performance",
             "magrittr",
             "dotwhisker",
             "Matrix",
             'data.table',
             "caTools",
             "Boruta",
             "mlbench",
             "caret",
             "randomForest")

## Now load or install&load all
package.check <- lapply(packages,FUN = function(x) {
  if (!require(x, character.only = TRUE)) {
    install.packages(x, dependencies = TRUE)
    library(x, character.only = TRUE)}})


## directories
dir.create(file.path(analysis.path, "results"), showWarnings = FALSE)
dir.create(file.path(analysis.path, "results/figures"), showWarnings = FALSE)
dir.create(file.path(analysis.path, "results/tables"), showWarnings = FALSE)
dir.create(file.path(analysis.path, "results/figures/day0_HI_levels"),showWarnings = FALSE)
dir.create(file.path(analysis.path, "results/figures/models"),showWarnings = FALSE)
dir.create(file.path(analysis.path, "results/figures/postvac_kinetics"), showWarnings = FALSE)
dir.create(file.path(analysis.path, "results/figures/HI_titer_immunotype"),showWarnings = FALSE)
dir.create(file.path(analysis.path, "results/figures/HI_res_immunotype"),showWarnings = FALSE)
dir.create(file.path(analysis.path, "results/figures/immunotype_comp"),showWarnings = FALSE)
dir.create(file.path(analysis.path, "results/figures/heatmap"),showWarnings = FALSE)

## paths
imm_comp.dir <- file.path(analysis.path, "results/figures/immunotype_comp/")
day0_HI_levels.dir <- file.path(analysis.path, "results/figures/day0_HI_levels/")
HI_titer_immunotype.dir <- file.path(analysis.path, "results/figures/HI_titer_immunotype/")
models.dir <- file.path(analysis.path, "results/figures/models/")
HI_res_immunotype.dir <- file.path(analysis.path, "results/figures/HI_res_immunotype/")
heatmap.dir <- file.path(analysis.path, "results/figures/heatmap/")



### %in& negate
`%!in%` = Negate(`%in%`)

# colorblind friendly colors for immunotypes
cols_cluster <- c("1"= "#77AADD", "2"= "#99DDFF",
                  "3"= "#44BB99", "4"= "#BBCC33",
                  "5"= "#AAAA00", "6"= "#EEDD88",
                  "7"= "#EE8866", "8"= "#FFAABB", 
                  "9"= "#DDDDDD")

# colorblind friendly colors for age groups
cols_agegroup <- c(`25-49` = "#F0E442", `50-64` = "#85C0F9", `65-98` = "#F5793A")


# boxplot with log2 y axis
boxplot_cluster <- function()
{
  p <- ggplot(df_loop, aes(x=Xaxis, y=Yaxis)) +
    geom_boxplot(aes(fill=Groups), alpha=0.9,outlier.size=0,outlier.colour="white") +
    geom_jitter(aes(fill=Groups), alpha=0.4, width = 0.3, shape=21,size=1) +
    scale_fill_manual("Immunotypes", values=cols_cluster) +
    theme_classic()+
    stat_summary(aes(y=Yaxis, x=Xaxis),size=0.2)+  
    scale_y_continuous(limits = yrange, trans = 'log2') + 
    annotation_logticks(sides = "l")
}

