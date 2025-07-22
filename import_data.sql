-- Import data from CSV
.mode csv
.import --skip 1 data/artists.csv artists
.import --skip 1 data/albums.csv albums
.import --skip 1 data/songs.csv songs
.import --skip 1 data/listeners.csv listeners
.import --skip 1 data/plays.csv plays