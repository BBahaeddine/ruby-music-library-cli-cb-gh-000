class Song
  attr_accessor :name
  attr_reader :artist
  attr_reader :genre
  @@all = []
  def initialize(name, artist = nil, genre = nil)
    @name = name
    if artist != nil
      self.artist = artist
    end
    if genre != nil 
      self.genre = genre
    end
  end
  
  def self.all 
    @@all
  end
  
  def self.destroy_all
    @@all.clear
  end
  
  def save
    @@all << self
  end
  
  def self.create(name)
    song = self.new(name)
    song.save
    song
  end
  
  def artist=(artist)
    artist.add_song(self)
    @artist = artist
  end
  
  def genre=(genre)
    @genre = genre
    if !genre.songs.include?(self)
      genre.songs << self
    end
    @genre
  end
  
  def self.find_by_name(name)
    self.all.each{|song|
      if song.name == name
        return song
      end
    }
    return nil
  end
  
  def self.find_or_create_by_name(name)
    if self.find_by_name(name) == nil
      self.create(name)
    else
      return self.find_by_name(name)
      
    end
  end
  
  def self.new_from_filename(filename)
    array = filename.split(" - ")
    artist, song, genre = array[0], array[1], array[2].gsub(".mp3", "")
    
    artistObj = Artist.find_or_create_by_name(artist)
    genreObj = Genre.find_or_create_by_name(genre)
    self.new(song, artistObj, genreObj)
  end
  
  def self.create_from_filename(filename)
    song = self.new_from_filename(filename)
    song.save
    song
  end
end