library(shiny)

#Managing database file
if (!file.exists('hospital.rds')){
    df<-read.csv("outcome-of-care-measures.csv", colClasses = "character")
    #Create string for display
    df$str<-paste(df[,'Address.1'],
                         df[,'City'],sep=', ')
    saveRDS(df,file='hospital.rds')
}

#state is 7
#heart attack 11
#hearth failure 17
#pneumonia 23
#hospital name is 2
df <- readRDS('hospital.rds')

#Set state names list
state_names <-unique(df$State)


#Rank hospital function
rankhospital<-function(city,state,outcome){


    #Check state
    if (!(state %in% df[,7])){
        stop('Invalid State')
    }

    #Check outcome
    valid_outcome <- c('heart attack', 'heart failure', 'pneumonia')
    index<-0
    if(outcome=='heart attack') index<-11
    else if(outcome=='heart failure') index<-17
    else if(outcome=='pneumonia') index<-23
    else stop('Invalid Outcome')

    #Narrow down by state and city
    state_df <-subset(df,State==state&City==city)

    #Convert rates to numeric
    state_df[,index]<-as.numeric(state_df[,index])

    #Rank
    ranking <-order(state_df[,index],state_df[,2],na.last = NA)

    result<-data.frame(Name=state_df[ranking,'Hospital.Name'],
               Tel=state_df[ranking,'Phone.Number'],
               Address=state_df[ranking,'str'])
    result<-cbind(Rank=1:dim(result)[1],result)
    return(result)
}
