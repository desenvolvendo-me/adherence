# app/controllers/production_plannings_controller.rb
class ProductionPlanningsController < ApplicationController
  before_action :set_production_planning, only: [:edit, :update, :destroy]

  def index
    @q = ProductionPlanning.ransack(params[:q])
    @production_plannings = @q.result.page(params[:page])
  end

  def new
    @production_planning = ProductionPlanning.new
    @production_planning.production_planning_items.build
  end

  def create
    @production_planning = ProductionPlanning.new(production_planning_params)

    if @production_planning.save
      redirect_to production_plannings_path, notice: 'Planejamento criado com sucesso.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @production_planning.update(production_planning_params)
      redirect_to production_plannings_path, notice: 'Planejamento atualizado com sucesso.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @production_planning.destroy
    redirect_to production_plannings_path, notice: 'Planejamento excluído com sucesso.'
  end

  private

  def set_production_planning
    @production_planning = ProductionPlanning.find(params[:id])
  end

  def production_planning_params
    params.require(:production_planning).permit(
      :planning_date,
      :shift,
      production_planning_items_attributes: [:id, :machine_id, :product_id, :goal, :_destroy]
    )
  end
end