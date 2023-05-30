library(idendr0)
# hierarchical clustering
hc <- hclust(dist(iris[, 1:4]))
# dendrogram
idendro(hc)
idendro(hc,hscale=10,vscale=3)
idendro(hc,maxClusterCount=15)
# dendrogram + heat map
idendro(hc, iris)

# customizing idendro: a gray heat map will occupy 50% of space:
idendro(hc, iris, heatmapColors = gray.colors(25), heatmapRelSize = .5)
########################


# dendrogram + heat map, integrated with a scatter plot
plot(iris$Sepal.Length, iris$Sepal.Width, pch = 19)
colorizeCallback <- function(clr) {
  clusterColors <- c('black', 'red', 'green', 'blue', 'yellow', 'magenta',
                     'cyan', 'darkred', 'darkgreen', 'purple', 'darkcyan')
  plot(iris$Sepal.Length, iris$Sepal.Width,
       col = clusterColors[clr + 1], pch = 19)
}
idendro(hc, iris, colorizeCallback = colorizeCallback)

demo(idendroWithScatterAndParcoord)


