create table artists(
  artist_id integer primary key,
  name text,
  country text,
  debut_year integer,
  genre text
);

create table albums(
  album_id integer primary key,
  title text,
  artist_id integer,
  release_date date,
  foreign key(artist_id) references artists(artist_id)
);

create table songs(
  song_id integer primary key,
  title text,
  album_id integer,
  foreign key(album_id) references albums(album_id)
);

create table listeners (
  listener_id integer primary key,
  name text,
  birthdate date
);

create table plays(
  play_id integer primary key,
  song_id integer, 
  listener_id integer,
  played_date date,
  foreign key(song_id) references songs(song_id)
  foreign key(listener_id) references listeners(listener_id)
);
