library(sf)
library(terra)

e  <- ext(chm_s)
bb <- st_bbox(c(xmin = xmin(e), xmax = xmax(e), ymin = ymin(e), ymax = ymax(e)),
              crs = st_crs(pohon))
grid <- st_make_grid(st_as_sfc(bb), cellsize = 50)
petak_grid <- st_sf(petak_id = sprintf("P%03d", seq_along(grid)), geometry = grid)
petak_grid <- st_intersection(petak_grid, st_as_sfc(bb))


library(DBI)

dsn <- paste0("PG:host=localhost port=5433 dbname=proyek_lidar user=postgres password=",
              Sys.getenv("PGPASSWORD"))

unique(st_geometry_type(pohon))
unique(st_geometry_type(petak_grid))
st_crs(pohon)$epsg
st_crs(petak_grid)$epsg

st_write(pohon, dsn = dsn, layer = "pohon_terdeteksi",
         delete_layer = TRUE,
         layer_options = "GEOMETRY_NAME=geometry")

st_write(petak_grid, dsn = dsn, layer = "petak_grid",
         delete_layer = TRUE,
         layer_options = "GEOMETRY_NAME=geometry")

