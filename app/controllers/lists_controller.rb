class ListsController < ApplicationController
  before_action :set_list, only: %i[ show edit update destroy ]

  def index
    @lists = List.where(author_id: @current_user.id)
  end

  def show
    # NOTE: 自身で作成したリスト以外は閲覧不可
    redirect_to lists_path unless @list.author == @current_user

    @new_item = Item.new(list: @list)
  end

  def new
    @list = List.new
  end

  def edit
  end

  def create
    @list = List.new(list_params)

    if @list.save
      redirect_to @list, notice: 'リストを作成しました！🎉'
    else
      render :new, status: :unprocessable_entity
    end
  end
  def update
    if @list.update(list_params)
      redirect_to @list, notice: 'リストを更新しました！🎉'
    else
      render :edit
    end
  end

  def destroy
    @list.destroy
    redirect_to lists_path, notice: "リストを削除しました"
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_list
    @list = List.find(params[:id])
  end

  # Only allow a lists of trusted parameters through.
  def list_params
    params.require(:list).permit(:list_name, :due_date, :author_id, :buyer_id, :store, :memo, :draft, :complete)
  end
end
