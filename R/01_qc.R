library(lidR)

las <- readLAS("data/area.las", select = "xyzcrn")
las_check(las)
print(las)
table(las$Classification)
st_crs(las)

las <- classify_noise(las, ivf(res = 5, n = 6))
las <- filter_poi(las, Classification != LASNOISE)

las <- classify_ground(las, algorithm = csf(sloop_smooth = TRUE,
                                            class_threshold = 0.5,
                                            cloth_resolution = 0.5,
                                            rigidness = 1))