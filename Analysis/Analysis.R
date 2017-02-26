setwd(".")
brx <- read.csv("./Data/brx_homes.csv",skip=0,header=TRUE)

#creating column in dataframe for sale price per square feet
SalePricePerSquFt<-((brx$sale.price.n)/(brx$land.sqft))

#adding new column to the data frame
brx<-cbind(brx, SalePricePerSquFt)

str(brx)
library(ggplot2)
library(data.table)

#creating data table for group by function
DT <- data.table(brx)

#Creating data frame "df_groupedby_nbrhd" which is grouped by neighborhood
df_groupedby_nbrhd <- as.data.frame.matrix(DT[, list(mean(SalePricePerSquFt), median(SalePricePerSquFt), as.double(max(SalePricePerSquFt)), as.double(min(SalePricePerSquFt)),mean(sale.price.n), median(sale.price.n),as.double(max(sale.price.n)),as.double(min(sale.price.n)), as.double(mean(land.sqft)), as.double(median(land.sqft)), as.double(max(land.sqft)), as.double(min(land.sqft))), by = neighborhood])

#Renaming column names
colnames(df_groupedby_nbrhd) <- c("neighborhood","mean_saleprice_per_sqft","median_saleprice_per_sqft","max_saleprice_per_sqft","min_saleprice_per_sqft","mean_saleprice","median_saleprice","max_saleprice","min_saleprice","mean_sqft","median_sqft","max_sqft","min_sqft")

#output of analyzed data frame
write.csv(file="./Analysis/groupedby_nbrhd.csv", x=df_groupedby_nbrhd)

#Plotting min max and mean of Sale price per square feet for each neighborhood
ggplot(df_groupedby_nbrhd,aes((df_groupedby_nbrhd$neighborhood),(df_groupedby_nbrhd$mean_saleprice_per_sqft)))+labs(title="Neighborhoods VS Avg sale price per sqft")+geom_bar(stat="identity", fill="steelblue")+xlab("Neighborhood")+ylab("Avg sales price per sqft")+theme( axis.text.x=element_text(angle=90))
ggplot(df_groupedby_nbrhd,aes((df_groupedby_nbrhd$neighborhood),(df_groupedby_nbrhd$max_saleprice_per_sqft)))+labs(title="Neighborhoods VS Max sale price per sqft")+geom_bar(stat="identity", fill="steelblue")+xlab("Neighborhood")+ylab("Max sales price per sqft")+theme( axis.text.x=element_text(angle=90))
ggplot(df_groupedby_nbrhd,aes((df_groupedby_nbrhd$neighborhood),(df_groupedby_nbrhd$min_saleprice_per_sqft)))+labs(title="Neighborhoods VS Min sale price per sqft")+geom_bar(stat="identity", fill="steelblue")+xlab("Neighborhood")+ylab("Min sales price per sqft")+theme( axis.text.x=element_text(angle=90))
