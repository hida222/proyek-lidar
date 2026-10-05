library(sf)
library(DBI)
library(ggplot2)

con <- dbConnect(RPostgres::Postgres(),
                 host = "localhost", port = 5433,
                 dbname = "proyek_lidar", user = "postgres",
                 password = Sys.getenv("PGPASSWORD"))

stat <- st_read(con, query = "SELECT * FROM statistik_petak")

ggplot(stat) +
  geom_sf(aes(fill = pohon_per_ha), color = "white") +
  scale_fill_viridis_c(name = "Pohon/ha") +
  labs(title = "Kerapatan pohon per petak") +
  theme_minimal()
ggsave("output/peta_kerapatan.png", width = 7, height = 6, dpi = 200)

write.csv(st_drop_geometry(stat), "output/ringkasan_petak.csv", row.names = FALSE)
dbDisconnect(con)
