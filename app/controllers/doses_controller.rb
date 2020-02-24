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

def edit
  set_dose
end

def update
  set_dose
  if @dose.update(dose_params)
    rediret_to cocktail_path(@cocktail), notice: 'Recipe was successfully updated.'
  else
    render :edit
  end
end

def destroy
  @dose = Dose.find(params[:cocktail_id])
  rediret_to cocktail_path(@cocktail)
end

private

def dose_params
  params.require(:dose).permit(:description, :ingredient_id)
end

def set_dose
  @dose = Dose.find(params[:cocktail_id])
end
end
