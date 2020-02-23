class DosesController < ApplicationController

def new
  @cocktail = Cocktail.find(params[:cocktail_id])
  @dose = Dose.new
end

def create
  @cocktail = Cocktail.find(params[:cocktail_id])
  @dose = Dose.new(dose_params)
  @dose.cocktail = @cocktail
  if @dose.save
    redirect_to cocktail_path(@cocktail)
  else
    render :new
  end
end

def destroy
  @dose = Dose.find(params[:cocktail_id])
  rediret_to root_path
end

private

def dose_params
  params.require(:dose).permit(:description, :ingredient_id, :photo)
end
end
