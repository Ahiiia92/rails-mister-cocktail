class CocktailsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_cocktail, only: [:show, :edit, :update]

  def index
    if params[:query].present?
      sql_query = "name ILIKE :query OR description_drink ILIKE :query"
      @cocktails = Cocktail.where(sql_query, query: "%#{params[:query]}%")
    else
        @cocktails = Cocktail.all
    end
  end

  def show
    @cocktail = Cocktail.find(params[:id])
    @doses = @cocktail.doses
    @cocktail_api =
      [{
          strDrink: @cocktail.name,
          strInstructions: @cocktail.description_drink
      }]
  end

  def new
    @cocktail = Cocktail.new
  end

  def create
    @cocktail = Cocktail.new(cocktail_params)
    if @cocktail.save
    redirect_to cocktail_path(@cocktail), notice: 'Cocktail was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @cocktail.update(cocktail_params)
        redirect_to @cocktail, notice: 'Cocktail was successfully updated.'
    else
        render :edit
    end
  end

private

  def cocktail_params
    params.require(:cocktail).permit(:name, :description_drink, :photo)
  end

  def set_cocktail
      @cocktail = Cocktail.find(params[:id])
  end
end
