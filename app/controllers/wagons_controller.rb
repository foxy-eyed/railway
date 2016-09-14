class WagonsController < ApplicationController
  before_action :set_wagon, only: [:show, :edit, :update, :destroy]

  def index
    @wagons = Wagon.all
  end

  def show
  end

  def new
    @wagon = Wagon.new
  end

  def create
    if Wagon::TYPES.key?(params[:wagon][:type])
      wagon_class = params[:wagon][:type].constantize
      @wagon = wagon_class.new(wagon_params(wagon_class))
      if @wagon.save
        redirect_to wagon_path(@wagon), notice: 'Wagon was successfully created.'
      else
        render :new
      end
    else
      redirect_to new_wagon_path, alert: 'Unknown type of Wagon'
    end
  end

  def edit
  end

  def update
    if @wagon.update(wagon_params(@wagon.class))
      redirect_to wagon_path(@wagon), notice: 'Wagon was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @wagon.destroy
    redirect_to wagons_path, notice: 'Wagon was successfully deleted.'
  end

  private

  def wagon_params(wagon_class)
    params.require(:wagon).permit(wagon_class.permitted_params)
  end

  def set_wagon
    @wagon = Wagon.find(params[:id])
  end
end
