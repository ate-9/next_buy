class ItemsController < ApplicationController
  before_action :set_list
  before_action :set_item, only: %i[ edit update destroy ]

  def edit
  end

  def create
    @item = @list.items.build(item_params)

    if @item.save
      redirect_to list_path(@list), notice: 'アイテムを追加しました！🎉'
    else
      render 'lists/show', status: :unprocessable_entity
    end
  end

  def update
    if @item.update(item_params)
      redirect_to list_path(@list), notice: 'アイテムを更新しました！🎉'
    else
      flash.now[:alert] = '更新に失敗しました...'
      render 'lists/show', status: :unprocessable_entity
    end
  end

  def destroy
    @item.destroy
    redirect_back fallback_location: lists_path, notice: "アイテムを削除しました"
  end

  private

  def set_list
    @list = List.find(params[:list_id])
  end

  def set_item
    @item = @list.items.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :price, :amount, :bought)
  end
end
