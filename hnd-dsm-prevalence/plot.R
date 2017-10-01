#!/usr/bin/env Rscript
require(ggplot2)

lifelines <- c(73, 15, 6, 3, 2, 1, 1, 0,0,0)
hnd <- c(40,28,14,7,4,3,2,1,1,0)


dat <- data.frame(Lifelines = lifelines,
                  HowNutsAreTheDutch = hnd,
                  names = as.factor(seq(0,9)))

# melt the data frame for plotting
data.m <- reshape2::melt(dat, id.vars='names')

# plot everything
the_plot <- ggplot(data.m, aes(names, value)) +
  geom_bar(aes(fill = variable), position = "dodge", stat="identity") + 
  theme(panel.background = element_rect(fill = 'transparent', colour = 'black', size=1)) +
  scale_fill_manual(values=c("#4477AA", "#CC6677")) +
  theme(axis.text.y = element_text(colour = "black") ) +
  labs(x="Number of major depressive disorder DSM symptoms", y="Percentage") +
  theme(axis.text.x = element_text(colour = "black") ) +
  theme(plot.margin = unit( c(0,0,0,0) , "in" ) )+
  scale_y_continuous(expand = c(0, 0.7),
                     breaks = seq(0,100,10),
                     labels = function(x){ paste0(x, "\\%") }) +
  theme(legend.title = element_blank())+
  theme(legend.position="bottom")+
  theme(legend.background = element_rect(colour="transparent"))+
  theme(legend.key = element_rect(fill = "transparent", colour = "transparent")) 

pdf(file = "dsm-symptom-prevalence.pdf", width=6, height=3)
plot(the_plot)
dev.off()

tikzDevice::tikz('dsm-symptom-prevalence.tex', standAlone = FALSE, width=6, height=3)
plot(the_plot)
dev.off()
