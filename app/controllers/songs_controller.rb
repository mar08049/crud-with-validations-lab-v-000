class SongsController < ApplicationController
  def index
    @songs = Song.all
  end

  def show
    @song = set_song!
  end

  def edit
    @song = set_song!
  end

  def update
	  @song = set_song!
	  @song.update(song_params(:title, :released, :released_year, :artist_name, :genre))
    if @song.valid?
	     redirect_to song_path(@song)
    else
      render :edit
    end
	end

  def new
    @song = Song.new
  end

  def create
    @song = Song.new(song_params(:title, :released, :released_year, :artist_name, :genre))
    if @song.valid?
      @song.save
      redirect_to song_path(@song)
    else
      render :new
    end
  end

  def destroy
    set_song!.destroy
    redirect_to songs_url
  end

  private

  def song_params(*args)
    params.require(:song).permit(*args)
  end

  def set_song!
    @song = Song.find(params[:id])
  end
end
