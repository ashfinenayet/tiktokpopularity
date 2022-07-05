library(dplyr)
library(tidyr)
library(GGally)
library(gridExtra)
library(factoextra)
library(FactoMineR)
library(plotly)
library(ggplot2)
library(readxl)


modifiedtiktok2 <- read_excel("~/Documents/Datasets/modifiedtiktok2.xlsx")
# convert from numeric to factor
modifiedtiktok2$track_id <- as.factor(modifiedtiktok2$track_id)
modifiedtiktok2$track_name <- as.factor(modifiedtiktok2$track_name)
modifiedtiktok2$artist_id <- as.factor(modifiedtiktok2$artist_id)
modifiedtiktok2$artist_name <- as.factor(modifiedtiktok2$artist_name)
modifiedtiktok2$album_id <- as.factor(modifiedtiktok2$album_id)
modifiedtiktok2$playlist_id <- as.factor(modifiedtiktok2$playlist_id)
modifiedtiktok2$playlist_name <- as.factor(modifiedtiktok2$playlist_name)
modifiedtiktok2$genre <- as.factor(modifiedtiktok2$genre)
modifiedtiktok2$release_date <- as.factor(modifiedtiktok2$release_date)
modifiedtiktok2$popularity <- as.factor(modifiedtiktok2$popularity)

modifiedtiktok2 %>% 
  is.na() %>% 
  colSums()

#Delete Columns because we dont need the informations
tiktok_clean <-modifiedtiktok2[,!(colnames(modifiedtiktok2) %in%c("track_id", 
                                                        "artist_id",  "album_id", "playlist_id", 
                                                      "playlist_name", "key", "mode", "genre" ))]

summary(tiktok_clean)

tiktok_pop <- tiktok_clean
head(tiktok_pop, 2)

tail(tiktok_pop, 2)

#show the Bottom 5 tiktok songs and tiktok artists with the most popularity
tiktok_pop$popularity <- as.numeric(tiktok_pop$popularity)
top<- tiktok_pop %>% 
  select(track_name, artist_name, popularity) %>% 
  arrange(track_name, desc(popularity)) %>% 
  filter(popularity < 30) %>% 
  head(5)
top

#show the top 6 tiktok songs and tiktok artists with the most popularity
pop<- tiktok_pop %>% 
  select(track_name, artist_name, popularity) %>% 
  arrange(track_name, desc(popularity)) %>% 
  filter(popularity > 90) %>% 
  head(20)
pop

top_art <- group_by(pop, artist_name)
top_art1<- dplyr::summarise(top_art, count=n())
top_art1<- arrange(top_art1, desc(count))
top_art2<- filter(top_art1, count>0)

#
grap_pop <- ggplot(top_art2, aes(x=reorder(artist_name,count), y=count))+
  geom_bar(aes(y=count, fill=artist_name), stat = "identity")+
  labs(x="Artists", y="Number of Songs",
       title = "Popular Artist On Tiktok")+
  theme(legend.position = "none", axis.text.x = element_text(angle=20, hjust=1))

grap_pop

#Corelation
ggcorr(tiktok_clean, label = T)