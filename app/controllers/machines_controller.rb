class MachinesController < ApplicationController
  before_action :set_machine, only: [:show, :edit, :update, :destroy]

  def index
    @q = Machine.ransack(params[:q])
    @machines = @q.result.page(params[:page])

    respond_to do |format|
      format.html
      format.turbo_stream {
        render turbo_stream: turbo_stream.update("machines_list",
                                                 partial: "machines_table",
                                                 locals: { machines: @machines }
        )
      }
    end
  end

  def show
  end

  def new
    @machine = Machine.new
  end

  def create
    @machine = Machine.new(machine_params)

    if @machine.save
      redirect_to machines_path, notice: 'Máquina criada com sucesso.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @machine.update(machine_params)
      redirect_to machines_path, notice: 'Máquina atualizada com sucesso.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @machine.destroy
    redirect_to machines_path, notice: 'Máquina removida com sucesso.'
  end

  def products
    @machine = Machine.find(params[:id])
    render json: @machine.products.active.select(:id, :name)
  end

  private

  def set_machine
    @machine = Machine.find(params[:id])
  end

  def machine_params
    params.require(:machine).permit(:code, :name, :status)
  end
end