class CocktailsController < ApplicationController
before_action :set_cocktail, only: [:show, :edit, :update]

def index
  @cocktails = Cocktail.all
  @cocktails = Cocktail.geocoded

  @markers = @cocktails.map do |cocktail|
      {
        lat: "52,5200",
        lng: "13,4050",
        infoWindow: render_to_string(partial: "info_window", locals: { cocktail: cocktail })
      }
    end
end

def show
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
