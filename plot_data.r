plot_graph <- function() {
  require(ggplot2)
  require(gridExtra)
  data = read.csv("data.csv")
  
  print(sum(number_of_users$Created.diary.studies))
  print(sum(number_of_users$Participants))
  
  # Calculate percentages
  
  number_of_users$Date <- as.Date(number_of_users$Date, "%y-%m")
  number_of_users$subs <- factor(rep("% of total HowNutsAreTheDutch participants", each = nrow(number_of_users)))
  number_of_users$type <- factor(rep('% of total EMA Study participants', each = nrow(number_of_users)))
  
  dates <- c(as.Date("20/12/13", "%d/%m/%y"))
  dates <- append(as.Date("23/03/14", "%d/%m/%y"), dates)
  dates <- append(as.Date("19/04/14", "%d/%m/%y"), dates)
  dates <- append(as.Date("22/05/14", "%d/%m/%y"), dates)
  dates <- append(as.Date("07/07/14", "%d/%m/%y"), dates)
  dates <- append(as.Date("23/10/14", "%d/%m/%y"), dates)
  dates <- append(as.Date("18/11/14", "%d/%m/%y"), dates)
  dates <- rev(dates)
  
  plot <- ggplot(number_of_users, aes(x = Date)) + 
    geom_line(data=number_of_users, aes(y = Created.diary.studies, color = type, linetype= type), size = 0.5, show.legend = TRUE) +
    geom_line(aes(y = Participants, color = subs, linetype = subs), size = 0.5) +
    scale_linetype_manual(values = c("dashed", "solid")) +
    #scale_color_manual(values = c("orange", "blue")) +
    scale_color_manual(values = c("black", "black")) +
    theme(panel.background = element_rect(fill = 'transparent', colour = 'black', size=1)) +
    scale_fill_brewer(palette="Set1")+
    scale_y_continuous(name="Percentage")+
    theme(axis.text.y = element_text(colour = "black") ) +
    theme(axis.text.x = element_text(colour = "black") ) +
    theme(axis.title.x = element_text(vjust = -0.5)) + 
    theme(legend.title = element_blank())+
    theme(legend.position="bottom")+
    theme(legend.background = element_rect(colour="white"))+
    theme(legend.key =        element_rect(fill = "white", colour = "white")) +
    theme(legend.key.size= unit(3,"lines"))
  
  offset <- 1
  for (i in 1:length(dates)) {
    val <- number_of_users$Date == dates[i]
    x <- number_of_users[val,]
    y <- max(x$Created.diary.studies, x$Participants)
  
    plot <- plot + annotate("text", x = dates[i]+5, y = y+offset/1.1, label = i) +
    annotate("pointrange", x = dates[i], y = y+offset-offset/3, ymin = 0, ymax = 0, colour = "black", size = .2)
  }
  return(plot)
}
#######################

histfunc <- function() {
  require(gridExtra)
  setwd('/Users/frbl/Documents/Datasets/HoeGekIsNL/Diary_v1')
  dataset = read.csv("mad_diary_2014-12-13.csv", sep=';')
  
  # Convert to the correct format
  dataset$mad_diary_completed_at<-strptime(dataset$mad_diary_completed_at, "%d-%m-%Y %H:%M:%S")
  dataset$mad_diary_invited_at<-strptime(dataset$mad_diary_invited_at, "%d-%m-%Y %H:%M:%S")
  dataset$mad_diary_started_at<-strptime(dataset$mad_diary_started_at, "%d-%m-%Y %H:%M:%S")
  
  # Calculate the difference
  dataset$completed_at_invited_at <- unclass(difftime(dataset$mad_diary_completed_at, dataset$mad_diary_invited_at, units="secs"))
  dataset$started_at_invited_at <- unclass(difftime(dataset$mad_diary_started_at, dataset$mad_diary_invited_at, units="secs"))
  dataset$completed_at_started_at <- unclass(difftime(dataset$mad_diary_completed_at, dataset$mad_diary_started_at, units="secs"))
  
  # Test is the set is a subset
  are_subsets <- all((!is.na(dataset$started_at_invited_at) & !is.na(dataset$completed_at_invited_at)) == !is.na(dataset$started_at_invited_at))
  are_subsets <- are_subsets && all((!is.na(dataset$completed_at_started_at) & !is.na(dataset$completed_at_invited_at)) == !is.na(dataset$completed_at_started_at)) == TRUE
  
  if(are_subsets) {
    # Remove all measurements > 1 hour, and convert to minutes
    started_at_invited_at <- subset(dataset$started_at_invited_at, dataset$completed_at_invited_at < 3600)/60
    completed_at_started_at <- subset(dataset$completed_at_started_at, dataset$completed_at_invited_at < 3600)/60
    completed_at_invited_at <- subset(dataset$completed_at_invited_at, dataset$completed_at_invited_at < 3600)/60
    
    # Remove NA
    completed_at_invited_at <- completed_at_invited_at[!is.na(completed_at_invited_at)]
    started_at_invited_at <- started_at_invited_at[!is.na(started_at_invited_at)]
    completed_at_started_at <- completed_at_started_at[!is.na(completed_at_started_at)]
    
    if(all(completed_at_invited_at > 0) &&
          all(started_at_invited_at > 0) &&
          all(completed_at_started_at > 0)){
      print('All date differences are positive')
    }
    
    printstats(completed_at_invited_at, 'completed_at_invited_at')
    printstats(started_at_invited_at, 'started_at_invited_at')
    printstats(completed_at_started_at, 'completed_at_started_at')
    
    p1 <- qplot(completed_at_invited_at, binwidth=.5)
    p2 <- qplot(started_at_invited_at, binwidth=.5)
    p3 <- qplot(completed_at_started_at, binwidth=.5)
    grid.arrange(p1, p2, p3, ncol=3)  
  }
}

printstats <- function(dataset, name) {
  print(name)
  print('Mean:')
  print(mean(dataset))
  print('STDev:')
  print(sd(dataset))
  print('Median:')
  print(median(dataset))
  print('Range:')
  print(range(dataset))
  print('')
}
pdf(file = "figure_1_bw.pdf",
    width=11.75, height=5.47)
plot(plot_graph())
dev.off()
