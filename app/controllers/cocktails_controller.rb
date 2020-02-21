class CocktailsController < ApplicationController

def index
  @cocktails = Cocktail.all
end

def show
  @cocktail = Cocktail.find(params[:id])
end

def new
  @cocktail = Cocktail.new
  if @cocktail.save
    redirect_to root_path
  else
    render :new
  end
end

def create
  @cocktail = Cocktail.create(cocktail_params)
  redirect_to root_path
end

private

def cocktail_params
  params.require(:cocktail).permit(:name)
end

end
