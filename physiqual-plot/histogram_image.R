#!/usr/bin/env Rscript
library("ggplot2")
rm(list=ls(pos='.GlobalEnv',all=TRUE),pos='.GlobalEnv')
source("multiplot.R")
set.seed(21341)

top_hat_kernel <- function(k, data) {
  ourmethod <- c()
  for(i in 1:length(data)) {
    current <- data[i]
    for(value in -k:k) {
      ourmethod <- c(ourmethod, (current - value)) 
    }
  }
  ourmethod
}

Mode <- function(x) {
  ux <- unique(x)
  # Single value
  #ux[which.max(tabulate(match(x, ux)))]
  ux[(tabulate(match(x, unique(x))) == max(tabulate(match(x, unique(x)))))]
}

determine_top_hat <- function(data) {
  candidates <- Mode(data)
  if(length(candidates) == 1) return(candidates)
  candidates_centered <- as.vector(abs(scale(candidates, scale=FALSE)))
  candidates <- candidates[!is.na(match(candidates_centered, min(candidates_centered)))]
  if(length(candidates) == 1) return(candidates)
  mean(candidates)
}

generate_graph <- function(k, raw, title) {
  angle <- 45
  offset <- 2.5
  offsety <- 2
  
  ourmethod <- top_hat_kernel(k = k, data = raw)  
  
  heartrate.df <- data.frame(ourmethod)
  our <<-heartrate.df
  # Normalize
  heartrate <- rep(raw, k)
  heartrate.dfold <- data.frame(heartrate)

  y_offset <- 20
  top_hat_kernel_offset <- y_offset+offsety
  mean_offset <- y_offset+offsety
  median_offset <- y_offset+offsety
  mode_offset <- y_offset+offsety
  
  print('plotting')
  th_frame <- data.frame(th = determine_top_hat(ourmethod) - 0.5)

  merge <- ggplot(heartrate.dfold) + 
    labs(title=title) +
    geom_histogram(data = heartrate.dfold, aes(heartrate), 
                   breaks=seq(60, 125, by = 1), 
                   col="#000000", 
                   fill="#4477AA", 
                   alpha = .5)+
    
    labs(x="Heart rate", y="Frequency") +
    geom_vline(aes(xintercept= mean(heartrate)-0.5), linetype='dashed', col=1) +
    annotate("text", x = mean(heartrate)+ offset , y = mean_offset, ymin = 0, ymax = 0, colour = "black", label = 'Mean', angle = angle)+
    
    geom_vline(aes(xintercept= median(heartrate) -0.5), linetype='dashed', col=1) +
    annotate("text", x = median(heartrate)+ offset , y = median_offset, ymin = 0, ymax = 0, colour = "black", label = 'Median', angle = angle)+
    
    geom_vline(data = th_frame, aes(xintercept=th), linetype='dashed', col=1) +
    annotate("text", x = th_frame$th + offset , y = top_hat_kernel_offset, ymin = 0, ymax = 0, colour = "black", label = 'Top hat\n KDE', angle = angle)
  
    
    for(current_mode in Mode(heartrate.dfold$heartrate)) {
      merge <- merge + geom_vline(data = data.frame(current_mode = current_mode), aes(xintercept=current_mode-0.5), linetype='dashed', col=1) +
      annotate("text", x = current_mode + offset , y = mode_offset, ymin = 0, ymax = 0, colour = "black", label = 'Mode', angle = angle)
    }
  
  print(table(heartrate))
  print(paste('Mean:',mean(heartrate)))
  print(paste('Mode:', Mode(heartrate)))
  print(paste('Median:',median(heartrate)))   
  print(paste('Th:',th_frame$th))   
    merge <- merge + theme_bw() +
    theme(axis.line = element_line(colour = "black"),
          panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(),
          panel.border = element_blank(),
          panel.background = element_blank())
  
  merge
}

## Normal example
raw <- rep(c(seq(60,125), round(rnorm(60,73,5)), round(runif(100,60,125)), rep(110, 13)))
normal_example <- generate_graph(k = 2, raw = raw, title= "")
library('plyr')
count(raw)

plot(normal_example)

