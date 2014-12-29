class YoutubesController < ApplicationController
  layout "application"
  def index
    @youtubes = current_user.youtubes
  end

  def show
    youtube = current_user.youtubes.where(youtube_id: params["show_youtube"]["youtube_id"]).first
    if youtube.present?
      @youtube_id = youtube.youtube_id
    else
      @youtube_id = 'dbsgT3d1dOQ'
    end
    render 'show'
  end

  def new
  end

  def edit
  end

  def create
    youtube = current_user.youtubes.where youtube_id: params["youtube"]["youtube_id"]
    if youtube.present?
      @is_created = true
      @title = "This video has been added"
    else
      youtube = current_user.youtubes.build youtube_params
      if youtube.save
        @is_created = true
        @title = "This video has been created"
      else
        @is_created = false
        @title = "Failed!!! "
      end
    end
    @youtubes = current_user.youtubes
    render 'create'
  end

  def update
  end

  def destroy
    youtube = current_user.youtubes.where(youtube_id: params["delete_youtube"]["youtube_id"]).first
    if youtube.destroy
      @destroy = true
    else
      @destroy = false
    end
    @youtubes = current_user.youtubes
    render 'create'
  end

  private

  def youtube_params
    params.require(:youtube).permit :youtube_id, :description, :owner, :title,
      :duration
  end
end