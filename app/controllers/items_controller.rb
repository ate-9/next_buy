class ItemsController < ApplicationController
  before_action :set_list

  def edit
    @item = @list.items.find(params[:id])
  end

  def create
    @item = @list.items.build(item_params)

    if @item.save
      redirect_to list_path(@list), notice: 'アイテムを追加しました！🎉'
    else
      render list_path(@list), notice: 'アイテム追加に失敗しました...'
    end
  end
  def update
    if @item.update(list_params)
      redirect_to list_path(@list), notice: 'アイテムを更新しました！🎉'
    else
      flash.new[:alert] = '更新に失敗しました...'
      render 'lists/show'
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    redirect_back fallback_location: lists_path, notice: "アイテムを削除しました"
  end

  private

  def set_list
    @list = List.find(params[:list_id])
  end

  # def set_item
  #   @item = @list.items.find(params[:id])
  # end

  def item_params
    params.require(:item).permit(:name, :price, :amount, :bought)
  end
end
