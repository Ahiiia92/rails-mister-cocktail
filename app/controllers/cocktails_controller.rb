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
    # @cocktail_api =
    #   [{
    #       strDrink: @cocktail.name,
    #       idDrink: @cocktail.id
    #   }]
  end

  def show
    set_cocktail
    @doses = @cocktail.doses
    @cocktail_api =
      [{
          strDrink: @cocktail.name,
          strInstructions: @cocktail.description_drink,
          idDrink: @cocktail.id,
          # strCategory: @cocktail.category,
          strIngredient1: @cocktail.ingredients
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
