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

dat <- data.frame(xx = values-2.5, y = rep('a', length(values)))

margin <- 10
myplot <- ggplot(dat, aes(x=xx)) + 
            #geom_histogram(data = subset(dat,yy='a'), breaks=seq(0, 15, by = 1), fill="#4477AA", alpha=.3) + 
            geom_histogram(breaks=seq(-2.6, 87.5, by = 5), fill="#4477AA") + 
            #geom_histogram(data = subset(dat,yy='c'), breaks=seq(0, 15, by = .01), fill="#CC6677", alpha=.3) + 
            theme(panel.background = element_rect(fill = 'transparent', colour = 'black', size=1)) +
            theme(axis.text.y = element_text(colour = "black") ) +
            labs(x="Assessments", y="Frequency") +
            scale_y_continuous(limits = c(0,83 + margin), expand = c(0, 0.7)) +
            theme(axis.text.x = element_text(colour = "black") ) +
            theme(axis.title.x = element_text(vjust = -0.5)) +
            theme(legend.title = element_blank())+
            theme(legend.position="bottom")+
            theme(legend.background = element_rect(colour="transparent"))+
            theme(legend.key = element_rect(fill = "transparent", colour = "transparent")) +
            theme(legend.key.size= unit(3,"lines"))
pdf(file = "bimodal-distribution-in-adherance.pdf", width=5, height=3)
plot(myplot)
dev.off()
