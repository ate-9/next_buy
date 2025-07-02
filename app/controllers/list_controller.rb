class ListController < ApplicationController
  before_action :set_list, only: %i[ show edit update destroy ]
  before_action :set_items, only: %i[ index show edit update destroy ]

  def index
    @lists = List.all
  end

  def show
  end

  def new
    @list = List.new
  end

  def edit
  end

  def create
    @list = List.new(list_params)
  end
  def update
  end

  def destroy
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_list
    @list = List.find(params.expect(:id))
  end

  # Only allow a lists of trusted parameters through.
  def list_params
    params.fetch(:list, {})
  end

  def set_items
    @items = Item.all
  end
end
