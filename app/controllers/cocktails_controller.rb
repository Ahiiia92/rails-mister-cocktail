class CocktailsController < ApplicationController

def index
  @cocktails = Cocktail.all
end

def show
  @cocktail = Cocktail.find(params[:id])
end

def new
  @cocktail = Cocktail.new
end

def create
  @cocktail = Cocktail.save(cocktail_params)
  if @cocktail.save
  redirect_to root_path, notice: 'Garden was successfully created.'
  else
    render :new
  end
end

def edit
end

def update
    if @cocktail.update(cocktail_params)
      redirect_to @cocktail, notice: 'Garden was successfully updated.'
    else
      render :edit
    end
end

private

def cocktail_params
  params.require(:cocktail).permit(:name, :photo)
end

end
