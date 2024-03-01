require './input_functions'


module Genre
  POP, CLASSIC, JAZZ, ROCK  = *1..5
end

$genre_names = ['Null', 'Pop', 'Classic', 'Jazz', 'Rock','HipHop']

class Album

  attr_accessor :artist, :title, :genre, :tracks, :year

  def initialize(artist, title, year, genre, tracks)

    @artist = artist

    @title = title

    @genre = genre

    @year = year 

    @tracks = tracks

  end

end


class Track
  attr_accessor :name, :location

  def initialize(name, location)
    @name = name
    @location = location

  end

end



def read_track(music_file)

  track_name = music_file.gets
  track_location = music_file.gets
  track = Track.new(track_name, track_location)
  return track

end



def read_tracks(music_file)
  count = music_file.gets.chomp.to_i
  tracks = []

  while count > 0

    track = read_track(music_file)
    tracks << track
    count -= 1

  end
  return tracks

end



def read_album(music_file)

  artist = music_file.gets
  title = music_file.gets
  year = music_file.gets.chomp
  genre = music_file.gets.chomp
  tracks = read_tracks(music_file)
  album = Album.new(artist, title, year, genre, tracks)

  return album

end



def read_albums()

  filename = read_string("Enter a file path to an album: ")
  music_file = File.new(filename, "r")
  count = music_file.gets.chomp.to_i
  albums = Array.new()
while count > 0

    album = read_album(music_file)
    albums << album
    count -= 1

  end

  music_file.close()

  puts("The albums have been loaded.")
  read_string("Press enter to continue.")
  return albums

end



def display_albums(albums)
  if (!albums)
     puts('Please enter the album first')
      return

  end

  puts("\nDisplay albums menu: ")

  puts("1. Display all Albums")

  puts("2. Display albums by Genre")

  puts("3. Back to the main menu ")

  choice = read_integer_in_range('Please select', 1, 3)

  case choice 

  when 1 
      display_all_albums(albums)
  when 2
      display_genre(albums)
  when 3
      return 

  else 
      puts'Invalid choice'

  end 

end



def display_all_albums(albums)
    total_albums = albums.length
    puts("\nThere are #{total_albums} albums: " )


  for i in 0..albums.length()-1
    puts("Album ID: #{i+1}")
    display_album(albums[i])

  end

end
def display_album(album)
  puts(" Title: #{album.title.chomp}. Artist: #{album.artist.chomp}. Year: #{album.year.to_i}. Genre: #{$genre_names[album.genre.to_i]}")

end


def display_genre(albums)
	index = 1
	puts "\nSelect genre"
	while index < $genre_names.length
		puts (index.to_s + ". " + $genre_names[index])
		index += 1
	end
  



  genre = read_integer_in_range("\nPlease enter your choice:", 1, 5)

  genre = genre.to_s

  display_albums_genre(genre, albums)

  puts ""

end



def display_albums_genre(genre, albums) 

 no_track = true 
  for i in 0..albums.length - 1
    if albums[i].genre == genre
      no_track = false 
      puts("\nAlbum ID: #{i+1}") 
      display_album(albums[i])
      puts ""
    end

  end

  if no_track 

    puts "\nNo albums found for the selected genre."

  end

end



def play_an_album(albums)

  if (!albums)
      puts('Please enter the album first')
      return

  end

  for i in 0..albums.length() - 1
    puts("Album ID: #{i+1}") 
    display_album(albums[i])

  end


  albumID = read_integer_in_range("Enter Album Id:", 1, albums.length())
  track_count = albums[albumID - 1].tracks.length
  if track_count == 0
      puts ("No track to play in this album")

      return

  end



    puts ("There are #{track_count} track")

    for i in 0..track_count - 1 
      puts("#{i + 1}. #{albums[albumID -  1].tracks[i].name}")
    end

    choice =  read_integer_in_range("Choose a track to play:", 1, track_count)
    puts "Playing #{albums[albumID -  1].tracks[choice - 1].name.chomp}" + " from album #{albums[albumID  - 1].title}"
    read_string("Press enter to stop")

end
def display_menu(albums)



  finished = false 
  while not finished
     puts "Main menu:"

      puts "1. Read in Albums"

      puts "2. Display Albums"

      puts "3. Select an Album to play"

      puts "4. Exit the application "

      choice = read_integer_in_range("Enter your choice", 1, 4)



      case choice 

      when 1 
          albums = read_albums()
      when 2 
          display_albums(albums)
      when 3
          play_an_album(albums)
      when 4 
          finished = true 

      else 

          puts "Please choose again"

      end 

  end 

end

def main()
  albums = nil
  display_menu(albums)

end

main()