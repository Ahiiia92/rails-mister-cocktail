class DosesController < ApplicationController
  before_action :set_dose, only: [:edit, :update, :destroy]

  def new
    @cocktail = Cocktail.find(params[:cocktail_id])
    @dose = Dose.new
  end

  def create
    @cocktail = Cocktail.find(params[:cocktail_id])
    @dose = Dose.new(dose_params)
    @dose.cocktail = @cocktail
    if @dose.save
      respond_to do |format|
          format.html { redirect_to cocktail_path(@cocktail) }
          format.js  # <-- will render `app/views/doses/create.js.erb`
        end
    else
    respond_to do |format|
      format.html { render :new }
      format.js  # <-- idem
      end
    end
  end

  def edit
  end

  def update
    if @dose.update(dose_params)
      redirect_to cocktail_path(@cocktail), notice: 'Recipe was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    redirect_to cocktail_path(@cocktail)
  end

  private

  def dose_params
    params.require(:dose).permit(:description, :ingredient_id)
  end

  def set_dose
    @dose = Dose.find(params[:cocktail_id])
  end
end
