class  Admin::StocksController < AdminController
  before_action :find_product
  before_action :set_stock, only: %i[ show edit update destroy ]

  # GET /admin/products/1/stocks or /admin/products/1/stocks.json
  def index
    @stocks = @product.stocks.all
  end

  # GET /admin/stocks/1 or /admin/stocks/1.json
  def show
  end

  # GET /admin/products/1/stocks/new
  def new
    @stock = @product.stocks.build
  end

  # GET /admin/stocks/1/edit
  def edit
  end

  # POST /admin/products/1/stocks or /admin/products/1/stocks.json
  def create
    @stock = @product.stocks.new(stock_params)

    respond_to do |format|
      if @stock.save
        format.html { redirect_to admin_product_stocks_url(@product), notice: "Stock was successfully created." }
        format.json { render :show, status: :created, location: @stock }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @stock.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/stocks/1 or /admin/stocks/1.json
  def update
    respond_to do |format|
      if @stock.update(stock_params)
        format.html { redirect_to admin_product_stocks_url(@product), notice: "Stock was successfully updated." }
        format.json { render :show, status: :ok, location: @stock }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @stock.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/stocks/1 or /admin/stocks/1.json
  def destroy
    @stock.destroy!

    respond_to do |format|
      format.html { redirect_to admin_product_stocks_url(@product), notice: "Stock was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stock
      @stock = Stock.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def stock_params
      params.require(:stock).permit(:size, :amount)
    end

    def find_product
      @product = Product.find(params[:product_id])
    end
end
