class CocktailsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_cocktail, only: [:show, :edit, :update]

  def index
    if params[:query].present?
      sql_query = "name ILIKE :query OR description_drink ILIKE :query"
      @cocktails = Cocktail.where(sql_query, query: "%#{params[:query]}%")
      @cocktails_api = find_cocktail_by_name(params[:query])
    else
      @cocktails = Cocktail.all
      @cocktails_api = []
      16.times do
        random_cocktail = find_random_cocktail
        @cocktails_api << random_cocktail
      end
    end
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
    if set_cocktail != nil
      @dose = Dose.new
      if Cocktail.exists?(params[:id])
        @doses = @cocktail.doses
        beginning_of_name = @cocktail.name.split(' ')
        # @cocktail ? @doses = @cocktail.doses : false
        if find_cocktail_by_name(@cocktail.name) == nil
          if find_cocktail_by_name(beginning_of_name[0]) != nil
            @ingredients = find_cocktail_by_name(beginning_of_name[0])[0]
            find_from_api(@ingredients)
          end
        # else
        #   @ingredients = find_cocktail_by_name(@cocktail.name)[0]
        #   binding.pry
        #   find_from_api(@ingredients)
        end
      else
        @ingredients = find_cocktail_by_name(@cocktail[0]['strDrink'])[0]
        find_from_api(@ingredients)
      end
    # elsif
    #   @cocktail = find_cocktail_by_id(params[:id].to_i)[0]["strDrink"]
    #   binding.pry
    #   @ingredients = find_cocktail_by_name(@cocktail)
    #   find_from_api(@ingredients)
    else
      redirect_to root_path, notice: 'Cocktail couldn\'t be found.'
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
    # If this cocktail is saved in our database then .find
    if Cocktail.exists?(params[:id])
      @cocktail = Cocktail.find(params[:id])
    # else the cocktail is coming entirely from an API call
    else
      @cocktail = find_cocktail_by_id(params[:id].to_i)
    end
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
    result_api = request_api("https://www.thecocktaildb.com/api/json/v1/1/search.php?s=#{name}")
    if result_api == nil
      redirect_to root_path, notice: 'Not results found'
    else
      result_api['drinks']
    end
  end

  def find_cocktail_by_id(id)
    query = URI.encode("#{id}")

    result_api = request_api("https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=#{query}")
    if result_api == nil
      redirect_to root_path, notice: 'Not results found'
    end
    result_api['drinks']
  end

  def find_from_api(ing)
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

  def find_random_cocktail
    result_api = request_api("https://www.thecocktaildb.com/api/json/v1/1/random.php")
    if result_api == nil
      redirect_to root_path, notice: 'Not results found'
    end
    result_api['drinks']
  end
end
