class ComparesController < ApplicationController
  before_action :set_compare, only: [:show, :edit, :update, :destroy]
  autocomplete :car, :name, full: true

  def show
  end

  def new
    @compare = Compare.new
  end

  def create
    @compare = Compare.new(compare_params)
    @compare.model_ids = [params[:model_id_1], params[:model_id_2]]

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
