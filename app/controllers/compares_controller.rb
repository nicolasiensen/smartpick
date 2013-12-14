class ComparesController < ApplicationController
  before_action :set_compare, only: [:show, :edit, :update, :destroy]
  autocomplete :car, :name, full: true

  def show
    model1 = Hash.new
    @compare.cars[0].models.order(:name).each{|m| model1.merge!({m.year => m.value})}

    model2 = Hash.new
    @compare.cars[1].models.order(:name).each{|m| model2.merge!({m.year => m.value})}

    model3 = Hash.new
    @compare.cars[2].models.order(:name).each{|m| model3.merge!({m.year => m.value})}

    @models = model2
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
