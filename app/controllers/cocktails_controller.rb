class CocktailsController < ApplicationController
before_action :set_cocktail, only: [:show, :edit, :update]
require 'open-uri'

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
  descript = JSON.load(open("https://www.thecocktaildb.com/api/json/v1/1/search.php?s=mojito"))
  @cocktail_iba = descript["drinks"][1]['strIBA']
  @cocktail_glass = descript["drinks"][1]['strGlass']
  @cocktail_instructions = descript["drinks"][1]['strInstructions']
  # @cocktail_description =
  #   [{
  #       strIBA: @cocktail.category,
  #       strGlass: @cocktail.glass,
  #       strInstructions: @cocktail.instructions
  #   }]
end

def new
  @cocktail = Cocktail.new
end

def create
  @cocktail = Cocktail.new(cocktail_params)
  if @cocktail.save
  redirect_to root_path, notice: 'Cocktail was successfully created.'
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
