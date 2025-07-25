-- //////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////
/* SETUP SECTION 
Don't change any code in this section!
*/

/* Setup Step  1:
  Run the statements in the file `create_tables.sql` in order to create the empty tables we need.
*/
.read create_tables.sql

/* Setup Step 2: 
  Run the statements in the file `import_data.sql` to load the data from CSVs into the tables created in Setup Step 1.
*/
.read import_data.sql

/* Setup Step 3: 
  Set print mode to qbox for pretty printing.
*/
.mode qbox

-- //////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////

/* Code-along 0:
  Open the file `import_data.sql` and add a line to import the plays.csv data. Delete the following 6 lines when this is done. */

  
/* Code-along 1: -------------------------
How many total albums are in the database? */
.print '### CA1 - Total number of albums in the database:'

select count(*) from albums;

.print ''

/* Code-along 2: -------------------------
How many total artists are there in the database? */
.print '### CA2 - Total number of artists in the database:'

  select count(*) from artists;

.print ''

/* Code-along 3: -------------------------
Which albums came out after 2015? Print only the title of the albums.*/
.print '### CA3 - List of album titles released after 2015:'

select title from albums where release_date > '2015-12-31';

.print ''

/* Code-along 4: -------------------------
What are all the genres present in the database? Don't print duplicates.*/
.print '### CA4 - List of genres:'
  
select distinct genre from artists;

.print ''

/* Code-along 5: -------------------------
Which artists are classified as R&B artists? Print the artist name and debut year.*/
.print '### CA5 - List of R&B artists with debut year:'

select name, debut_year 
  from artists 
  where genre = 'R&B' ;

.print ''

/* Code-along 6: -------------------------
Which artists are classified as Rock artists and debuted before the year 1980? Print the artist name and debut year.*/
.print '### CA6 - List of Rock artists who debuted before 1980:'

SELECT name, debut_year
  FROM artists
  WHERE genre = 'Rock'
  AND debut_year < '1980';

.print ''

/* Code-along 7: -------------------------
Which artists are classified as Pop or debuted before 1980? Print the artist name, genre, and debut_year.*/
.print '### CA7 - List of artists classified as Pop or debuted before 1980:'

  SELECT name, genre, debut_year
  FROM artists
  WHERE genre = 'Pop'
  OR debut_year < '1980';

.print ''

/* Code-along 8: -------------------------
Which artists are classified as either Pop or Funk/Soul? Print the artist name and genre.*/
.print '### CA8 - List of artists classified as either Pop or Funk/Soul:'
  
 SELECT name, genre
  FROM artists
  WHERE genre in ('Pop', 'Funk/Soul'); 

.print ''
  
/* Code-along 9: -------------------------
Which artists are NOT classified as 'Pop'? Print the artist name and genre.*/
.print '### CA9 - List of artists not classified as "Pop":'

select name, genre
  from artists
  where not genre = 'Pop';
  
.print ''

/* Code-along 10: -------------------------
Which artists are NOT classified as 'Pop' or 'Funk/Soul'? Print the artist name and genre.*/
.print '### CA10 - List of artists not classified as "Pop" or "Funk/Soul":'

  select name, genre
  from artists
  where not genre in ('Pop', 'Funk/Soul') ;

.print ''

/* Code-along 11: -------------------------
Which song titles contain the word, 'you'?*/
.print '### CA11 - List of song titles that contain the word "you":'

  select title
    from songs
    where title like '% you %';

.print ''
--'% you %', anything can happen before/after 'you' word
/* Code-along 12: -------------------------
Order all albums by release date, from oldest to newest (ascending). Print the album name and release date. */
.print '### CA12 - Albums ordered by release date, from oldest to newest (ascending):'

  select title, release_date
  from albums
  order by release_date asc;

.print ''

/* Code-along 13: -------------------------
Order all albums by release date, from newest to oldest (descending). Print the album name and release date. */
.print '### CA13 - Albums ordered by release date, from newest to oldest (descending):'

  select title, release_date
  from albums
  order by release_date desc;


.print ''

/* Code-along 14: -------------------------
Count the number of plays for each song. Print the song ID and the total times it has been played.*/
.print '### CA14 - Number of plays per song:'

select song_id, count(*)
  from plays
  group by song_id;

.print ''

/* Code-along 15: -------------------------
Building off of CA14, modify your query to print the song title instead of the song ID.*/
.print '### CA15 - Number of plays per song, with titles:'

select s.title, count(*)
  from plays as p
  join songs as s 
  on p.song_id = s.song_id
  group by p.song_id;
  

.print ''

/* Code-along 16: -------------------------
Building off of CA15, modify your query to print the songs in order from most plays to least plays.*/
.print '### CA16 - Number of plays per song, with title, in descending order:'

  select s.title, count(*) as play_count
  from plays as p
  join songs as s 
  on p.song_id = s.song_id
  group by p.song_id
  order by play_count asc;

.print ''

/* Code-along 17: -------------------------
Building off of CA16, modify your query to also print the album for each song.*/
.print '### CA17 - Number of plays per song, including song title and album title, in descending order:'

  select s.title as song_title, alb.title as album_title, count(*) as play_count
   from plays as p
   join songs as s on p.song_id = s.song_id
   join albums as alb on s.album_id = alb.album_id
   group by p.song_id
   order by play_count desc;

.print ''

/* Code-along 18: -------------------------
Building off of CA17, modify your query to also print the artist for each song.*/
.print '### CA18 - Number of plays per song, including song title and artist name, in descending order:'

  select s.title as song_title, art.name as artist_name, alb.title as album_title, count(*) as play_count
   from plays as p
   join songs as s on p.song_id = s.song_id
   join albums as alb on s.album_id = alb.album_id
   join artists as art on alb.artist_id = art.artist_id
   group by p.song_id
  order by play_count desc;

.print ''

/* Code-along 19: -------------------------
Print all of Bertha's song plays. You can hardcode her ID (2). "Hardcoding" means to use the ID directly in your query. No need to print the names of the songs — so no need to join on another table. */
.print '### CA19 - Berthas plays (hardcoded ID):'

select * from plays
  where listener_id = 2;

.print ''

/* Code-along 20: -------------------------
Print all of Bertha's song plays. Don't hardcode her ID (Don’t use her ID directly). No need to print the names of the songs — so no need to join on another table. */
.print '### CA20 - Berthas plays:'

  select * from plays
    where listener_id = (
      select listener_id from listeners
      where name = 'Bertha'
    );

  
.print ''

/* Code-along 21: -------------------------
What is Bertha's favorite genre?
Count how many times Bertha has listened to a song in each genre. Order from most plays to least.*/
.print '### CA21 - Berthas plays by genre:'

  select genre, count(*) as genre_count
  from plays as p
  join songs as s on p.song_id = s.song_id
  join albums as alb on s.album_id = alb.album_id
  join artists as art on alb.artist_id = art.artist_id
  where p.listener_id = (
         select listener_id from listeners where name = 'Bertha'
   )
   group by art.genre
   order by genre_count desc;

.print ''

/* Code-along 22: -------------------------
What is Bertha's favorite album?
Count how many times Bertha has listened to a song in each album. Order from most plays to least.*/
.print '### CA22 - Berthas plays by album:'

  select alb.title, count(*) as album_play_count 
  from plays as p
  join songs as s on p.song_id = s.song_id
  join albums as alb on s.album_id = alb.album_id
  where p.listener_id = (
    select listener_id 
      from listeners 
      where name = 'Bertha'
  )
  group by alb.title
  order by album_play_count desc;

.print ''

/* Code-along 23: -------------------------
What songs did Esperanza listen to during the summer of 2024? Print the song title and played_date. Order them by played_date from earliest to latest.*/
.print '### CA23 - Esperanzas summer hits, ordered by date, ascending:'

  select s.title, played_date
    from plays as p
    join songs as s on p.song_id = s.song_id
   where listener_id = (
   select listener_id from listeners where name = 'Esperanza'
   )
   and p.played_date between '2024-06-20' and '2024-09-22'
   order by p.played_date asc;

.print ''

/* Code-along 24: -------------------------
What is the first date that Disha listened to a song?*/
.print '### CA24 - The first date Disha listened to a song:'

  select min(played_date)
   from plays where listener_id = (
   select listener_id from listeners where name = 'Disha'
   );

.print ''

/* Code-along 25: -------------------------
What is the last date that Alex listened to a song?*/
.print '### CA25 - The last date Alex listened to a song:'

  select max(played_date)
   from plays where listener_id = (
   select listener_id from listeners where name = 'Alex'
   );

.print ''