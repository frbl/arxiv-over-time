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
  publication_data$google_search_label <- factor(rep('Popularity on Google Searches', each = nrow(publication_data)))
  publication_data$google_news_label <- factor(rep('Popularity on Google News', each = nrow(publication_data)))

  # Normalize the data
  publication_data$total <- publication_data$total / max(publication_data$total)
  publication_data$percentage <- publication_data$percentage / max(publication_data$percentage)
  publication_data$google_search_total <- publication_data$google_search_total / max(publication_data$google_search_total)
  publication_data$google_news_total <- publication_data$google_news_total / max(publication_data$google_news_total)

  # Convert the data
  publication_data$Date <- as.Date(publication_data$Date, "%d/%m/%Y")

  plot <- ggplot(publication_data, aes(x = Date)) +
    geom_line(aes(y = google_search_total, color = google_search_label, linetype = google_search_label), size = 0.5, show.legend = TRUE) +
    geom_line(aes(y = google_news_total, color = google_news_label, linetype = google_news_label), size = 0.5, show.legend = TRUE) +
    geom_line(aes(y = percentage, color = total_label, linetype = total_label), size = 0.5) +
    scale_linetype_manual(values = c("solid", "dotted", "dashed")) +
    scale_color_manual(values = c("blue", "black", "red")) +
    #scale_color_manual(values = c("black", "black", "black")) +
    theme(panel.background = element_rect(fill = 'transparent', colour = 'black', size=1)) +
    scale_fill_brewer(palette="Set1")+
    scale_y_continuous(name="Popularity")+
    theme(axis.text.y = element_text(colour = "black") ) +
    theme(axis.text.x = element_text(colour = "black") ) +
    theme(axis.title.x = element_text(vjust = -0.5)) +
    theme(legend.title = element_blank())+
    theme(legend.position="bottom")+
    theme(legend.background = element_rect(colour="white"))+
    theme(legend.key = element_rect(fill = "white", colour = "white")) +
    theme(legend.key.size= unit(3,"lines"))

  return(plot)
}
#######################
pdf(file = "ml-google-trends.pdf",
    width=11.75, height=5.47)
plots <- plot_graph()
plot(plots)
dev.off()
