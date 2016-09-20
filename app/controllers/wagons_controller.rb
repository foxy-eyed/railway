class WagonsController < ApplicationController
  before_action :set_wagon, only: [:show, :edit, :update, :destroy]
  before_action :set_train, only: [:index, :new, :create]

  def index
    redirect_to @train
  end

  def show
  end

  def new
    @wagon = Wagon.new
  end

  def create
    if Wagon::TYPES.key?(params[:wagon][:type].to_sym)
      wagon_class = params[:wagon][:type].constantize
      @wagon = wagon_class.new(wagon_params(wagon_class))
      @wagon.train = @train
      if @wagon.save
        redirect_to @train, notice: 'Wagon was successfully created.'
      else
        render :new
      end
    else
      redirect_to new_train_wagon_path, alert: 'Unknown type of Wagon'
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
    train = @wagon.train
    @wagon.destroy
    redirect_to train, notice: 'Wagon was successfully deleted.'
  end

  private

  def wagon_params(wagon_class)
    params.require(:wagon).permit(wagon_class.permitted_params)
  end

  def set_wagon
    @wagon = Wagon.find(params[:id])
  end

  def set_train
    @train = Train.find(params[:train_id])
  end
end
