ttops <- locate_trees(chm_s, lmf(ws = 5, hmin = 2))

pohon <- ttops
pohon$id     <- pohon$treeID
pohon$tinggi <- pohon$Z
pohon <- pohon[, c("id", "tinggi")]

nrow(pohon)
summary(pohon$tinggi)

terra::plot(chm_s)
plot(sf::st_geometry(pohon), add = TRUE, pch = 3, cex = 0.5)