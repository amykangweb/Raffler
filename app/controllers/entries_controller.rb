class EntriesController < ApplicationController
  respond_to :json

  def index
    render :json => Entry.all
  end

  def show
    respond_with Entry.find(params[:id])
  end

  def create
    render :json => Entry.create(safe_params)
  end

  def update
    render :json => Entry.update(params[:id], params[:entry])
  end

  def destroy
    render :json => Entry.destroy(params[:id])
  end

  private

  def safe_params
    params.require(:entry).permit(:name, :winner, :id, :entry)
  end
end
