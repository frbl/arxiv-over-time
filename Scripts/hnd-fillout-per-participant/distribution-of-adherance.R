#!/usr/bin/env Rscript
require(ggplot2)
values <- c(rep(0,83),
  rep(5, 59),
  rep(10, 39 ),
  rep(15, 22),
  rep(20, 22),
  rep(25, 12),
  rep(30, 13),
  rep(35, 11),
  rep(40, 13),
  rep(45, 15),
  rep(50, 10),
  rep(55, 25),
  rep(60, 23),
  rep(65, 38),
  rep(70, 46),
  rep(75, 63),
  rep(80, 75),
  rep(85, 42),
  rep(90, 10))

#setwd('/Users/frbl/vault/Datasets/HoeGekIsNL/Diary_v1')
#dat <- foreign::read.spss('mad_diary_2014_12_13_for_Frank.sav')

#dd <- as.data.frame(dat)


#dd <- dd[dd$period == 'real period', ]
#dd <- dd[dd$start_after15nov == 'finished', ]

#res <- (aggregate(dat$compl, by = list(Category = dat$patient_id_num), FUN = sum))
#names(res)
#setwd(tempwd)
#sum(dd$observations < 10) / length(dd$observations)

#dd[is.na(dd$observations), ] <- (0)
#min(dd$observations)

#pdf(file = "/tmp/bimodal-distribution-in-adherance.pdf", width=5, height=3)
#ggplot(dd, aes(observations)) +
  #geom_histogram(binwidth = 5)
##hist(dd$observations, breaks = 18)
#dev.off()

#attributes(number_of_users)
  #print(sum(number_of_users$Created.diary.studies))
  #print(sum(number_of_users$Participants))
  
  ## Calculate percentages
  #number_of_users$Created.diary.studies <- (number_of_users$Created.diary.studies/sum(number_of_users$Created.diary.studies)) * 100
  #number_of_users$Participants <- (number_of_users$Participants/sum(number_of_users$Participants)) * 100
  
  #print(sum(number_of_users$Created.diary.studies))
  #print(sum(number_of_users$Participants))

dat <- data.frame(xx = values-2.5, y = rep('a', length(values)))

margin <- 10
myplot <- ggplot(dat, aes(x=xx)) + 
    #geom_histogram(data = subset(dat,yy='a'), breaks=seq(0, 15, by = 1), fill="#4477AA", alpha=.3) + 
    geom_histogram(breaks=seq(-2.6, 92.5, by = 5), col="black", fill="#5E81AC") + 
    #geom_histogram(data = subset(dat,yy='c'), breaks=seq(0, 15, by = .01), fill="#CC6677", alpha=.3) + 
    theme(panel.background = element_rect(fill = 'transparent', colour = 'black', size=1)) +
    theme(axis.text.y = element_text(colour = "black") ) +
    labs(x="Assessments", y="Frequency") +
    #theme( plot.margin = unit( c(0.1,0.1,0.1,0.1) , "in" ) )+
    scale_y_continuous(limits = c(-2.0,83 + margin), expand = c(0, 0)) +
    scale_x_continuous( expand = c(0.01, 0)) +
    theme(axis.text.x = element_text(colour = "black") ) +
    #theme(axis.title.x = element_text(vjust = -1.5)) +
    theme(legend.title = element_blank())+
    theme(legend.position="bottom")+
    theme(legend.background = element_rect(colour="transparent"))+
    theme(legend.key = element_rect(fill = "transparent", colour = "transparent")) +
    theme(legend.key.size= unit(3,"lines"))

pdf(file = "bimodal-distribution-in-adherance.pdf", width=5, height=3)
plot(myplot)
dev.off()

tikzDevice::tikz('bimodal-distribution-in-adherance.tex', standAlone = FALSE, width=5, height=3)
plot(myplot)
dev.off()
