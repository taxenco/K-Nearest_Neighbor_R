require(class)
setwd('C:/Users/carlo/Desktop/Data science/ASDM/KNN')
occupancy_data<-read.table("datatraining.txt", sep = ",")


#explore the dataset
names(occupancy_data)
head(occupancy_data)
tail(occupancy_data)
summary(occupancy_data)
str(occupancy_data)

# Removing date since it is not necessary for building the model

new_occupancy_data <- subset( occupancy_data, select = -date )

head(new_occupancy_data)
str(new_occupancy_data)
table(new_occupancy_data$Occupancy)



# Normalize data 

new_occupancy_data$Temperature<- (new_occupancy_data$Temperature-min(new_occupancy_data$Temperature))/(max(new_occupancy_data$Temperature)-min(new_occupancy_data$Temperature))
new_occupancy_data$Humidity<- (new_occupancy_data$Humidity-min(new_occupancy_data$Humidity))/(max(new_occupancy_data$Humidity)-min(new_occupancy_data$Humidity))
new_occupancy_data$Light<- (new_occupancy_data$Light-min(new_occupancy_data$Light))/(max(new_occupancy_data$Light)-min(new_occupancy_data$Light))
new_occupancy_data$CO2<- (new_occupancy_data$CO2-min(new_occupancy_data$CO2))/(max(new_occupancy_data$CO2)-min(new_occupancy_data$CO2))
new_occupancy_data$HumidityRatio<- (new_occupancy_data$HumidityRatio-min(new_occupancy_data$HumidityRatio))/(max(new_occupancy_data$HumidityRatio)-min(new_occupancy_data$HumidityRatio))
summary(new_occupancy_data)


# train and validate(test) data from our data. Divide 80% Training and 20% Validation parts for implementing our KNN
set.seed(1234)
pd <-sample(2,nrow(new_occupancy_data),replace=TRUE, prob=c(0.8,0.2))
train <-new_occupancy_data[pd==1,]
validate <-new_occupancy_data[pd==2,]
dim(train)
dim(validate)

# Building KNN Algo
occupancy_data <- subset( occupancy_data, select = Occupancy )
data_train_target <- occupancy_data[1:6526,] 
data_test_target <- occupancy_data[6527:8143,] 


m1<- knn(train=train, test =validate, cl=data_train_target,k=13 )

#Creating a tabular results of categorical variables

tab <-table(data_test_target,m1)
tab
#Calculate classification accuracy
sum(diag(tab))/sum(tab)
# Calculate classification error
1-sum(diag(tab))/sum(tab)