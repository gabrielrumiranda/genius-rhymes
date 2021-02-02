class Api::SyllablesController < ApplicationController
  before_action :must_be_author, except: [:index, :show, :create]

  def index
    @syllables = Syllable
                .where(rhyme_id: params[:rhyme_id])
                .includes(:author)
                .order(:start_index)
  end

  def show
    @syllable = Syllable.includes(:author)
                        .find(params[:id])
  end

  def create
    @rhyme = Rhyme.find(params[:rhyme_id])
    @syllable = @rhyme.create!(syllable_params)
    render :show
  end

  def update
    @syllable = Syllable.find(params[:_id])
    @syllable.update!(syllable_params)
    render :show
  end

  def destroy
    @syllable = Syllable.find(params[:id])
    @syllable.destroy!
    render :show
  end

  private
  def syllable_params
    params.require(:syllable).permit(
      :rhyme_id,
      :body,
      :start_index,
      :end_index
    )
  end

  def must_be_author
    @syllable = Syllable.find(params[:id])
    current_api_user.id == @syllable.author_id
  end
end
