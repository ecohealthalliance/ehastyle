## code to prepare `speakerLocation` dataset goes here

fetch_all <- function(app_id, table, ...) {
  out <- list()
  out[[1]] <- air_get(app_id, table, combined_result = FALSE,...)
  offset <- get_offset(out[[1]])
  while (!is.null(offset)) {
    out <- c(out, list(air_get(app_id, table, combined_result = FALSE, offset = offset, ...)))
    offset <- get_offset(out[[length(out)]])
  }
  out <- bind_rows(out)
  cbind(id = out$id, out$fields, createdTime = out$createdTime,
        stringsAsFactors = FALSE)
}

app_id <- "appwlxIzmQx5njRtQ" # ID for the base we are fetching.

speakers <- fetch_all(app_id, "SPEAKERS") %>%
  janitor::clean_names()

institutions <- speakers %>%
  distinct_at("affiliation") %>%
  filter(!is.na(affiliation))

cities <- c("Manhattan, New York",
            "Marseille, France",
            "Dhaka, Bangladesh",
            "Missoula, Montana",
            "Bronx, New York",
            "Pretoria, South Africa",
            "Rochester, New York",
            "London, England")

geoCodedCities <- oc_forward(cities,limit = 1)


cityLatLng <- purrr::map_dfr(geoCodedCities,.f = function(x){
  lat <- purrr::pluck(x,"oc_lat")
  lng <- purrr::pluck(x, "oc_lng")
  return(tibble(lat,lng))
}
)

locDf <- tibble(institutions, cities)

locations <- cbind(locDf,cityLatLng)

talksPer <- speakers %>%
  group_by(affiliation) %>%
  summarise(totalTalks = sum(length(talks_given)))

speakerLocations <- left_join(locations,talksPer,"affiliation") %>%
  mutate(label = glue("{affiliation} has provided {totalTalks} speakers to EHA meetings"))


usethis::use_data(speakerLocation, overwrite = TRUE)
