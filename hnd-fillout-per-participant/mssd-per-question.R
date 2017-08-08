#!/usr/bin/env Rscript
require(ggplot2)

mssds <- c(1246.91, 1016.78, 845.40, 766.47, 761.93, 653.28, 556.81, 556.41, 542.23, 540.10, 530.92, 521.40, 493.17, 488.83, 466.18, 443.32, 422.30, 420.80, 413.91, 404.42, 399.93, 397.20, 395.84, 390.55,
            383.96, 379.62, 376.74, 347.27, 308.72, 257.35, 257.26, 203.98, 157.38, 157.09)
questionnaire_items <- c(40, 41,  16,  39,  3  , 38,  10,  4  , 36,  35,  7  , 42,  12,  14,  20,  31,  9  , 19,  22,  25,  23,  15,  17,  11,  37,  5  , 6,   26,  18,  21,  1  , 8,   24,  27) 

dat <- data.frame(xx = factor(questionnaire_items),
                  yy = mssds)

margin <- 100
p3 <- ggplot(dat, aes(x= reorder(xx, -yy))) + 
            #geom_histogram(data = subset(dat,yy='a'), breaks=seq(0, 15, by = 1), fill="#4477AA", alpha=.3) + 
            geom_bar(aes(weight = yy), fill="#4477AA" ) +
            #geom_histogram(data = subset(dat,yy='c'), breaks=seq(0, 15, by = .01), fill="#CC6677", alpha=.3) + 
            theme(panel.background = element_rect(fill = 'transparent', colour = 'black', size=1)) +
            theme(axis.text.y = element_text(colour = "black") ) +
            labs(x="Diary item", y="Mean Squared Successive Difference") +
            theme(axis.text.x = element_text(colour = "black") ) +
            theme( plot.margin = unit( c(0,0,0,0) , "in" ) )+
            scale_y_continuous(limits = c(0,max(mssds) + margin), expand = c(0, 0)) +
            #theme(axis.title.x = element_text(vjust = -0.5)) +
            theme(legend.title = element_blank())+
            theme(legend.position="bottom")+
            theme(legend.background = element_rect(colour="transparent"))+
            theme(legend.key = element_rect(fill = "transparent", colour = "transparent")) +
            theme(legend.key.size= unit(3,"lines"))

pdf(file = "mssd-in-hgi.pdf", width=10, height=4)
plot(p3)
dev.off()
