#!/usr/bin/env Rscript
plot_graph <- function() {
  require(ggplot2)
  require(gridExtra)
  setwd('/Users/frbl/Drive/RuG/PhD/papers/2015/Temporal Dynamics of Health and Wellbeing in the Dutch Population/health_psychology')
  number_of_users = read.csv("number_of_users_v1.csv")
  
  print(sum(number_of_users$Created.diary.studies))
  print(sum(number_of_users$Participants))
  
  # Calculate percentages
  number_of_users$Created.diary.studies <- (number_of_users$Created.diary.studies/sum(number_of_users$Created.diary.studies)) * 100
  number_of_users$Participants <- (number_of_users$Participants/sum(number_of_users$Participants)) * 100
  
  print(sum(number_of_users$Created.diary.studies))
  print(sum(number_of_users$Participants))
  
  as.Date(number_of_users$Date, "%d/%m/%y")
  number_of_users$Date <- as.Date(number_of_users$Date, "%d/%m/%y")
  names(number_of_users)
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
    scale_color_manual(values = c("#4477AA", "#CC6677")) +
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

pdf(file = "users-over-time.pdf",
    width=10, height=4)
plot(plot_graph())
dev.off()
