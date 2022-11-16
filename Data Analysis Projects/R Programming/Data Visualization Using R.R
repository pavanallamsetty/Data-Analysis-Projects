install.packages("dplyr")
library(dplyr)
install.packages('nycflights13')
library('nycflights13')

View(flights)
head(flights)

# Subset dataset using filter()

f1<- filter(flights,month==07)
f1
View(f1)

f2<- filter(flights,month==07,day==3)
f2
View(f2)

View(filter(flights,month==09,day==2,origin=='LGA'))

#OR

head(flights[flights$month==09 & flights$day==2 & flights$origin=='LGA' ,])

#Slice() allows us to select rows by position

slice(flights,1:5)
slice(flights,5:10)

# mutate() is used to add new column

over_delay<- mutate(flights,overall_delay=arr_delay-dep_delay)
View(over_delay)
head(over_delay)

# transmute() function is used to show only new column

over_delay<- transmute(flights,overall_delay=arr_delay-dep_delay)
View(over_delay)

# summarise() used to find descriptive statistics

summarise(flights,avg_air_time=mean(air_time,na.rm=T))
summarise(flights,total_air_time=sum(air_time,na.rm=T))
summarise(flights,stdev_air_time=sd(air_time,na.rm=T))
summarise(flights,avg_air_time=mean(air_time,na.rm=T),total_air_time=sum(air_time,na.rm=T))

# group by calculation using group_by() 

# Example 1:
View(mtcars)
head(mtcars)

by_gear<- mtcars %>% group_by(gear)
by_gear
View(by_gear)

a<- summarise(by_gear,gear1=sum(gear),gear2=mean(gear))
a

summarise(group_by(mtcars,cy1), mean(gear,na.rm = TRUE))

b<- by_gear %>% summarise(gear1=sum(gear),gear2=mean(gear))
b

# Example 2:

by_cyl<- mtcars %>% group_by(cyl)

by_cyl %>% summarise(gear=mean(gear),hp=mean(hp))
head(by_cyl)

# Sample_n() and sample_frac for creating samples--------

sample_n(flights,15) # It gives 15 random samples
sample_frac(flights,0,4) # returns 40% of the total data

# arrange() used to sort dataset

View(arrange(flights,year,dep_time))
head(arrange(flights,year,dep_time))

# Usage of pipe operator %>% 

df<- mtcars
df
View(mtcars)

# Nesting

result<-arrange(sample_n(filter(df,mpg>20),size=5),desc(mpg))
View(result)

# multiple assignment

a<-filter(df,mpg>20)
b<-sample_n(a,size=5)
result<-arrange(b,desc(mpg))
result

# same using pipe operator

# Syntax- data %>% op1 %>% op2 %>% op3

result<-df %>% filter(mpg>20) %>% sample_n(size=10) %>% arrange(desc(mpg))
result

df
df_mpg_hp_cyl = df %>% select(mpg,hp,cyl)
head(df_mpg_hp_cyl)


#----------Data manipulation using Tidyr---------

install.packages("tidyr")
library('tidyr')

n=10

wide<-data.frame(ID = c(1:n),Face.1 = c(411,723,325,456,579,612,709,513,527,379),Face.2 = c(123,300,400,500,600,654,789,906,413,567),Face.3 = c(1457,1000,569,896,956,2345,780,599,1023,678))
View(wide)

# Gather() - Reshaping data from wide format to long format

long<- wide %>% gather(Face,ResponseTime,Face.1:Face.3)
View(long)

# Separate() - Spilts a single column into multiple columns

long_separate<- long %>% separate(Face,c("Target","Number"))
View(long_separate)

# Unite() - Combines multiple columns into a single column

long_unite<- long_separate %>% unite(Face,Target,Number,sep=",")
View(long_unite)

# spread() - takes two columns (key & value) and spreads into multiple columns
#It makes "long" data wider

back_to_wide<- long_unite %>% spread(Face,ResponseTime)
View(back_to_wide)

# Data Visualization in R

install.packages("ggplot2")
plot(ChickWeight)

#Base Graphics

library(MASS)
plot(UScereal$sugars,UScereal$calories)
title("Plot(UScereal$sugars,UScereal$calories)")
x<-UScereal$sugars
y<-UScereal$calories
library(grid)

#Grid graphics
pushViewport(plotViewport())
pushViewport(dataViewport(x,y))
grid.rect()
grid.xaxis()
grid.yaxis()
grid.points(x,y)
grid.text("UScereal$calories", x=unit(-3,"lines"), rot = 90)
grid.text("UScereal$calories", y=unit(-3,"lines"), rot = 0)
popViewport(2)

# Pie Chart for different products and units sold

# Create data for the graph

count_1<-c(33,45,70,110)
labels<-c("Soap","Detergent","Oil","Shampoo")
# Plot the chart
pie(count_1,labels)
pie_labels<-paste0(round(100*count_1/sum(count_1),1),"%")
count_1<-c(33,45,70,110)
pie(count_1, labels = pie_labels)
pie(count_1,labels = paste0(count_1,"%"))

# RColorBrewer Package
install.packages("RColorBrewer")
library(RColorBrewer)

# 3D piechart

# Get the Library
install.packages("plotrix")
library(plotrix)

count_1<-c(33,45,70,110)
lbl<-c("Soap","Detergent","Oil","Shampoo")

# Plot the chart
pie3D(count_1,labels = lbl,explode = 0.1, main = "Pie Chart of Countries")

# Create data for the graph
v<-c(9,13,21,8,36,22,12,41,31,33,19)

# Create the histogram
hist(v,xlab = "weight",col = "green",border = "red")
hist(v,xlab = "weight",col = "green",border = "red",xlim = c(0,40),ylim = c(0,5),breaks = 5)
data("airquality")
View(airquality)

# Use the plot function to draw scatter plots

# Plot a graph between the Ozone and wind values
plot(airquality$Ozone,airquality$Wind)
plot(airquality$Ozone,airquality$Wind,col='red')
plot(airquality$Ozone,airquality$Wind, type = 'h', col='blue') # Histogram
plot(airquality)

# Assign labels to the plot
plot(airquality$Ozone,xlab = 'Ozone Concentration',ylab = 'No of Instances',main = 'Ozone levels in NY city',col='green')

# Histogram
hist(airquality$Solar.R)
hist(airquality$Solar.R,main = 'Solar Radiation values in air',xlab = 'Solar radiation',ylab = 'No of Instances')
Temperature<-airquality$Temp
hist(Temperature)

# Histogram with labels
h<-hist(Temperature,ylim = c(0,40))
text(h$mids,h$counts,labels = h$counts,adj = c(0.5,-0.5))

# Histogram with non uniform width
hist(Temperature,main = "Maximum daily temperature at La Guarida Airport",xlab = "Temperature in degrees Fahrenheit",xlim = c(50,100),col = "chocolate",border = "brown",breaks = c(55,60,70,75,80,100))

# Box Plot

boxplot(airquality$Solar.R)

# Multiple Box Plots
boxplot(airquality[0:4], main='Multiple Box Plots')

# Using ggplot2 library to analyse mtcars dataset
attach(mtcars)
pl<-plot(mtcars)
boxplot(mtcars$mpg)
boxplot(mtcars$cyl)

# Create factors with value labels

mtcars$gear<-factor(mtcars$gear,levels = c(3,4,5),labels = c("3gears","4gears","5gears"))
mtcars$am<-factor(mtcars$am,levels = c(0,1),labels = c("Automatic","Manual"))
mtcars$cyl<-factor(mtcars$cyl,levels = c(4,6,8),labels = c("4cyl","6cyl","8cyl"))

# Scatter Plots

