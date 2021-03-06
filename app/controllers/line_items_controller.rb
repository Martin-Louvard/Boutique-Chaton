class LineItemsController < ApplicationController
  include CurrentCart
  before_action :authenticate_user!
  before_action :set_line_item, only: [:update, :destroy, :add_quantity, :remove_quantity]
  before_action :set_cart, only: [:create]

  def create
    product = Product.find(params[:product_id])
    @line_item = @cart.add_product(product)

    respond_to do |format|
      if @line_item.save
        format.html { redirect_to @line_item.cart, notice: "L'article a bien été ajouté à ton panier" }
        format.json { render :show, status: :created, location: @line_item }
      else
        format.html { render :new }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def add_quantity
    @line_item.quantity += 1
    @line_item.save
    respond_to do |format|
      if @line_item.save
        format.html { redirect_to @line_item.cart }
        format.js{}
        format.json { render :show, status: :ok, location: @line_item }
      else
        format.html { render :edit }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def remove_quantity
    @line_item.quantity -= 1
    @line_item.save
    respond_to do |format|
      if @line_item.save
        format.html { redirect_to @line_item.cart }
        format.js{ }
        format.json { render :show, status: :ok, location: @line_item }
      else
        format.html { render :edit }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @line_item.destroy
    respond_to do |format|
      format.html { redirect_to @line_item.cart, notice: "L'article a bien été supprimé de votre panier" }
      format.json { head :no_content }
    end
  end

  private

    def set_line_item
      @line_item = LineItem.find(params[:id])
    end

    def line_item_params
      params.require(:line_item).permit(:quantity)
    end
end
