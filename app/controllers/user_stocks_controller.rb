class UserStocksController < ApplicationController
  before_action :set_user_stock, only: [:show, :edit, :update, :destroy]

  # GET /user_stocks
  # GET /user_stocks.json
  def index
    @user_stocks = UserStock.all
  end

  # GET /user_stocks/1
  # GET /user_stocks/1.json
  def show
  end

  # GET /user_stocks/new
  def new
    @user_stock = UserStock.new
  end

  # GET /user_stocks/1/edit
  def edit
  end

  # POST /user_stocks
  # POST /user_stocks.json
  def create
    stock = nil
    stock_id = params[:stock_id]
    user_id = params[:user_id]

    # If we have the stock_id, let's try finding it in the database
    if stock_id.present?
      stock = Stock.find(stock_id)
    end

    # Stock is in database? let's create a @user_stock
    if stock
      @user_stock = UserStock.new(user_id: user_id, stock_id: stock.id)
    # Stock not in the database. Let's search it using yahoo client
    else
      ticker = params[:stock_ticker]
      if ticker.present?
        stock = Stock.new_from_lookup(ticker)
        if stock && stock.save
          @user_stock = UserStock.new(user_id: user_id, stock_id: stock.id)
        end
      end
    end

    respond_to do |format|
      if @user_stock && @user_stock.save
        success_msg = "Stock #{stock.name} has been added to your portfolio"
        format.html { redirect_to(my_portfolio_path, notice: success_msg) }
        format.json { render :show, status: :created, location: @user_stock }
      else
        flash[:error] = "There was an error adding the stock"
        format.html { render :new }
        format.json { render json: @user_stock.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_stocks/1
  # PATCH/PUT /user_stocks/1.json
  def update
    respond_to do |format|
      if @user_stock.update(user_stock_params)
        format.html { redirect_to @user_stock, notice: 'User stock was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_stock }
      else
        format.html { render :edit }
        format.json { render json: @user_stock.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_stocks/1
  # DELETE /user_stocks/1.json
  def destroy
    @user_stock.destroy
    respond_to do |format|
      format.html { redirect_to user_stocks_url, notice: 'User stock was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_stock
      @user_stock = UserStock.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_stock_params
      params.require(:user_stock).permit(:user_id, :stock_id)
    end
end
