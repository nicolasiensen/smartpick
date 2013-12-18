class ComparesController < ApplicationController
  before_action :set_compare, only: [:show, :edit, :update, :destroy]
  autocomplete :car, :name, full: true

  def show
    @models = []
    @compare.cars.each do |car|
      car_hash = {name: car.name, data: {}}
      models = car.models.order("name DESC")
      4.times do |i|
        car_hash[:data].merge!({(Date.today.year - i) => (models[i].present? ? models[i].value.to_i : 0)})
      end
      @models << car_hash
    end
  end

  def new
    @compare = Compare.new
  end

  def create
    @compare = Compare.new(compare_params)
    @compare.car_ids = [params[:car_id_1], params[:car_id_2], params[:car_id_3]]

    respond_to do |format|
      if @compare.save
        format.html { redirect_to @compare, notice: 'Compare was successfully created.' }
        format.json { render action: 'show', status: :created, location: @compare }
      else
        format.html { render action: 'new' }
        format.json { render json: @compare.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  def set_compare
    @compare = Compare.find(params[:id])
  end

  def compare_params
    params[:compare]
  end
end
