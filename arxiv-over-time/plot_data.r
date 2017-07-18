#!/usr/bin/env Rscript
plot_graph <- function() {
  require(ggplot2)
  google_search_data = read.csv("google_data_search.csv")
  google_news_data = read.csv("google_data_news_ml.csv")

  publication_data = read.csv("papers.csv")
  publication_data <- cbind(publication_data, google_search_data['google_search_total'])
  publication_data <- cbind(publication_data, google_news_data['google_news_total'])

  # Set the labels
  publication_data$total_label <- factor(rep("Popularity on ArXiv", each = nrow(publication_data)))
  publication_data$precentage_label <- factor(rep("Normalized popularity on ArXiv", each = nrow(publication_data)))
  publication_data$google_search_label <- factor(rep('Popularity on Google Searches', each = nrow(publication_data)))
  publication_data$google_news_label <- factor(rep('Popularity on Google News', each = nrow(publication_data)))

  # Normalize the data
  publication_data$total <- publication_data$total / max(publication_data$total) * 100
  publication_data$percentage <- publication_data$percentage / max(publication_data$percentage) * 100
  publication_data$google_search_total <- publication_data$google_search_total / max(publication_data$google_search_total) * 100
  publication_data$google_news_total <- publication_data$google_news_total / max(publication_data$google_news_total) * 100

  # Convert the data
  publication_data$Date <- as.Date(publication_data$Date, "%d/%m/%Y")

  plot <- ggplot(publication_data, aes(x = Date)) +
    geom_line(aes(y = google_search_total, color = google_search_label, linetype = google_search_label), size = 0.5, show.legend = TRUE) +
    geom_line(aes(y = google_news_total, color = google_news_label, linetype = google_news_label), size = 0.5, show.legend = TRUE) +
    geom_line(aes(y = percentage, color = precentage_label, linetype = precentage_label), size = 0.5) +
    scale_linetype_manual(values = c("solid", "dotted", "dashed")) +
    scale_color_manual(values = c("#DDCC77", "#4477AA", "#CC6677")) +
    #scale_color_manual(values = c("black", "black", "black")) +
    theme(panel.background = element_rect(fill = 'transparent', colour = 'black', size=1)) +
    scale_fill_brewer(palette="Set1")+
    scale_y_continuous(name="Popularity")+
    theme(axis.text.y = element_text(colour = "black") ) +
    theme(axis.text.x = element_text(colour = "black") ) +
    theme(axis.title.x = element_text(vjust = -0.5)) +
    theme(legend.title = element_blank())+
    theme(legend.position="bottom")+
    theme(legend.background = element_rect(colour="transparent"))+
    theme(legend.key = element_rect(fill = "transparent", colour = "transparent")) +
    theme(legend.key.size= unit(3,"lines"))

  return(plot)
}
#######################
pdf(file = "ml-google-trends.pdf",
    width=10, height=4)
plots <- plot_graph()
plot(plots)
dev.off()

# Qualitative color schemes by Paul Tol
# https://www.r-bloggers.com/the-paul-tol-21-color-salute/
#tol1qualitative=c("#4477AA")
#tol2qualitative=c("#4477AA", "#CC6677")
#tol3qualitative=c("#4477AA", "#DDCC77", "#CC6677")
#tol4qualitative=c("#4477AA", "#117733", "#DDCC77", "#CC6677")
#tol5qualitative=c("#332288", "#88CCEE", "#117733", "#DDCC77", "#CC6677")
#tol6qualitative=c("#332288", "#88CCEE", "#117733", "#DDCC77", "#CC6677","#AA4499")
#tol7qualitative=c("#332288", "#88CCEE", "#44AA99", "#117733", "#DDCC77", "#CC6677","#AA4499")
#tol8qualitative=c("#332288", "#88CCEE", "#44AA99", "#117733", "#999933", "#DDCC77", "#CC6677","#AA4499")
#tol9qualitative=c("#332288", "#88CCEE", "#44AA99", "#117733", "#999933", "#DDCC77", "#CC6677", "#882255", "#AA4499")
#tol10qualitative=c("#332288", "#88CCEE", "#44AA99", "#117733", "#999933", "#DDCC77", "#661100", "#CC6677", "#882255", "#AA4499")
#tol11qualitative=c("#332288", "#6699CC", "#88CCEE", "#44AA99", "#117733", "#999933", "#DDCC77", "#661100", "#CC6677", "#882255", "#AA4499")
#tol12qualitative=c("#332288", "#6699CC", "#88CCEE", "#44AA99", "#117733", "#999933", "#DDCC77", "#661100", "#CC6677", "#AA4466", "#882255", "#AA4499")
 
#pal(tol7qualitative)
