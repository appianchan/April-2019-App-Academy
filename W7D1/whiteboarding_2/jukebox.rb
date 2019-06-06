class Jukebox
    attr_accessor :music

    def initialize(music = [])
        @music = music
        already_played = []
    end

    def play_music(track)
        @music << track
        already_played << track
        track
    end

    def play_next
        music.each do |song|
            if !already_played.include?(song)
                play_music(song) 
                break
            end
        end
        nil
    end

    def random_song
        track = @music.sample
    end

    def add_music(track)
        @music << track
    end

end

j = Jukebox.new
j.add_music("anything")

__________________________
class Jukebox
  attr_accessor :user
  attr_reader :current_track

  def initialize(player, user)
    @player = player
    @user = user
    @current_track = nil
  end
end

class Player
  attr_accessor :album, :playlist

  def initialize(album, playlist)
    @album = album
    @playlist = playlist
  end

  def play_track(track)
    # Begin playing...
  end
end

class Playlist
  def initialize
    @queue = []
  end

  def add_track(track)
    @queue.push(track)
  end

  def shift
    @queue.shift
  end
end

class Album
  # Information about the album
end

class Track
  # Information about the track, including album
end

class User
  # Information about the user.
end


____________________________________________________________

