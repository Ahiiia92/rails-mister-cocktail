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

  def search
    drinks = find_cocktail_by_name(params[:drinks])
    unless drinks
      flash[:alert] = 'Cocktail not found'
      return render action: :index
    end
    @cocktail = drinks.first
    @drink = find_cocktail_by_id(@drinks['idDrink'])
  end

  def show
    set_cocktail
    @doses = @cocktail.doses
    # @cocktail_api =
    #   [{
    #       strDrink: @cocktail.name,
    #       strInstructions: @cocktail.description_drink,
    #       idDrink: @cocktail.id,
    #       # strCategory: @cocktail.category,
    #       strIngredient1: @cocktail.ingredients
    #   }]
    beginning_of_name = @cocktail.name.split(' ')
    @ingredients = find_cocktail_by_name(beginning_of_name[0])['drinks'][0]
    ingredients = []
    quantities = []
    @hash_ing_qty = {}
    @ingredients.each do |key, value|
      if value != nil && key.include?("strIngredient")
        ingredients << value
      end
      if value != nil && key.include?("strMeasure")
        quantities << value
      end
    end
    ingredients.each_with_index do |item, index|
      @hash_ing_qty[item] = quantities[index]
    end
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

  # API Calls (by name and by id)
  def request_api(url)
    require 'json'
    require 'net/http'
    require 'uri'

    uri = URI(url)
    response = Net::HTTP.get(uri)
    JSON.parse(response)
  end

  def find_cocktail_by_name(name)
    request_api("https://www.thecocktaildb.com/api/json/v1/1/search.php?s=#{name}")
  end

  def find_cocktail_by_id(id)
    query = URI.encode("#{id}")

    request_api("https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=#{query}")
  end
end
