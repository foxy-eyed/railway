class Admin::RoutesController < Admin::BaseController
  before_action :set_route, only: [:show, :edit, :update, :destroy]

  def index
    @routes = Route.all
  end

  def show
  end

  def new
    @route = Route.new
  end

  def create
    @route = Route.new(route_params)

    if @route.save
      redirect_to admin_route_path(@route), notice: t('.notice')
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @route.update(route_params)
      redirect_to admin_route_path(@route), notice: t('.notice')
    else
      render :edit
    end
  end

  def destroy
    @route.destroy
    redirect_to admin_routes_path, notice: t('.notice')
  end

  private

  def route_params
    params.require(:route).permit(:name, railway_station_ids: [])
  end

  def set_route
    @route = Route.find(params[:id])
  end
end
