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

  # API Calls (by name and by id)

  def request_api(url)
    # response = Unirest.get(
    #   url,
    #   headers: {
    #     'X-RapidAPI-Host' => URI.parse(url).host,
    #     'X-RapidAPI-Key' => '4366a1912fmshd1d7e9998aa8e7dp17909ejsn3f89795ba815'
    #   }
    # )
    # return nil if response.status != 200
    # JSON.parse(response.body)

    require 'uri'
    require 'net/http'
    require 'openssl'
    link = URI(url)

    http = Net::HTTP.new(link.host, link.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(link)
    request["x-rapidapi-host"] = 'the-cocktail-db.p.rapidapi.com'
    request["x-rapidapi-key"] = '4366a1912fmshd1d7e9998aa8e7dp17909ejsn3f89795ba815'

    response = http.request(request)
    return response.read_body
  end

  def find_cocktail_by_name(name)
    request_api("https://the-cocktail-db.p.rapidapi.com/search.php?s=#{name}")

    # require 'uri'
    # require 'net/http'
    # require 'openssl'

    # url = URI("https://the-cocktail-db.p.rapidapi.com/search.php?i=#{name}")

    # http = Net::HTTP.new(url.host, url.port)
    # http.use_ssl = true
    # http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    # request = Net::HTTP::Get.new(url)
    # request["x-rapidapi-host"] = 'the-cocktail-db.p.rapidapi.com'
    # request["x-rapidapi-key"] = '4366a1912fmshd1d7e9998aa8e7dp17909ejsn3f89795ba815'

    # response = http.request(request)
    # puts response.read_body
  end

  def find_cocktail_by_id(id)
    query = URI.encode("#{id}")

    request_api("https://the-cocktail-db.p.rapidapi.com/lookup?i=#{query}.php")
  end
end
