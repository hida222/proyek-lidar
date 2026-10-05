dtm  <- rasterize_terrain(las, res = 1, algorithm = tin())
nlas <- normalize_height(las, dtm)
nlas <- filter_poi(nlas, Z >= 0)

chm <- rasterize_canopy(nlas, res = 1,
                        algorithm = p2r(subcircle = 0.2, na.fill = tin()))
chm_s <- terra::focal(chm, w = 3, fun = "mean", na.rm = TRUE)

terra::plot(chm_s)
terra::writeRaster(chm_s, "output/chm.tif", overwrite = TRUE)
