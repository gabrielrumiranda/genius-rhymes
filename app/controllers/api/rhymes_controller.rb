class Api::RhymesController < ApplicationController
  before_action :must_be_author, except: [:index, :show, :create]

  def index
    @rhymes = Rhymes
              .where(song_id: params[:song_id])
              .includes(:author)
              .order(:created_at)
  end

  def show
    @rhyme = Rhyme
            .includes(
              :author,
              :comments,
              :votes,
              comments: [:author]
            ).find(params[:id])
  end

  def create
    @rhyme = current_api_user.rhymes.create!(rhyme_params)
    render :show
  end

  def update
    @rhyme = Rhyme.find(params[:id])
    @rhyme.update!(rhyme_params)
    render :show
  end

  def destroy
    @rhyme = Rhyme.find(params[:id])
    @rhyme.destroy!
    render :show
  end

  private
  def rhyme_params
    params.require(:rhyme).permit(
      :song_id,
      :body,
      :color
    )
  end

  def must_be_author
    @rhyme = Rhyme.find(params[:id])
    current_api_user.id == @rhyme.author_id
  end
end
