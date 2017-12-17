class SalesController < ApplicationController
  before_action :set_sale, only: [:show, :edit, :update, :destroy]

  # GET /sales
  # GET /sales.json
  def index
    @sales = current_user.sales
  end

  # GET /sales/1
  # GET /sales/1.json
  def show
  end

  # GET /sales/new
  def new
    @sale = Sale.new
  end

  # GET /sales/1/edit
  def edit
  end

  # POST /sales
  # POST /sales.json
  def create
    @sale = Sale.new(sale_params.merge(user_id: current_user.id))
    respond_to do |format|
      if @sale.save
        format.html { redirect_to @sale, notice: 'Sale was successfully created.' }
        format.json { render :show, status: :created, location: @sale }
      else
        format.html { render :new }
        format.json { render json: @sale.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sales/1
  # PATCH/PUT /sales/1.json
  def update
    respond_to do |format|
      if @sale.update(sale_params)
        format.html { redirect_to @sale, notice: 'Sale was successfully updated.' }
        format.json { render :show, status: :ok, location: @sale }
      else
        format.html { render :edit }
        format.json { render json: @sale.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sales/1
  # DELETE /sales/1.json
  def destroy
    @sale.destroy
    respond_to do |format|
      format.html { redirect_to sales_url, notice: 'Sale was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sale
      @sale = Sale.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sale_params
      params.require(:sale).permit(:GSTIN_UIN, :EMAIL_ID, :CIN, :TELEPHONE_NO, :PAN, :FAX, :REVERSE_CHARGE, :TRANSPORTATION_MODE, :INVOICE_NO, :VEHICLE_NO, :INVOICE_DATE, :DATE_OF_SUPPLY, :STATE, :PLACE_OF_SUPPLY, :STATE_CODE, :BUYER_NAME, :BUYER_ADDRESS, :BUYER_GSTIN_UIN, :BUYER_CIN, :BUYER_STATE, :BUYER_STATE_CODE, :CONSIGNEE_NAME, :CONSIGNEE_ADDRESS, :CONSIGNEE_GSTIN_UIN, :CONSIGNEE_CIN, :CONSIGNEE_STATE, :CONSIGNEE_STATE_CODE, :APPLICATION_NO_FOR_REMOVAL_OF_GOODS, :APPLICATION_DATE_FOR_REMOVAL_OF_GOODS,:photo,exportsales_attributes:[:id, :purchase_id,:NAME_OF_GOODS_SERVICES,:HSNC_ACS,:UQM,:QTY,:RATE_P_U,:AMOUNT,:LESS_DISCOUNT_ABATEMENT, :TAXABLE_AMOUNT,:CGST_RATE_OF_TAX,:CGST_AMT,:SGST_RATE_OF_TAX,:SGST_AMT,:IGST_RATE_OF_TAX,:IGST_AMT,:TOTAL_AMOUNT,:_destroy])
    end
end
