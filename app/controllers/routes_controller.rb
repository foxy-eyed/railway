class RoutesController < ApplicationController
  before_action :set_route, only: [:show, :edit, :update, :destroy, :update_station_position]

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
      redirect_to @route, notice: 'Route was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @route.update(route_params)
      redirect_to @route, notice: 'Route was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @route.destroy
    redirect_to routes_path, notice: 'Route was successfully deleted.'
  end

  def update_station_position
    @railway_stations_route = RailwayStationsRoute.find(stations_route_params[:id])

    if @railway_stations_route.update(stations_route_params)
      redirect_to @route, notice: 'Stations in route was successfully reordered.'
    else
      render :show
    end
  end

  private

  def route_params
    params.require(:route).permit(:name, railway_station_ids: [])
  end

  def stations_route_params
    params.require(:railway_stations_route).permit(:position, :id)
  end

  def set_route
    @route = Route.find(params[:id])
  end
end
