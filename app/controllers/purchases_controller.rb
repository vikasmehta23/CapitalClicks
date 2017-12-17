class PurchasesController < ApplicationController
  before_action :set_purchase, only: [:show, :edit, :update, :destroy]

  # GET /purchases
  # GET /purchases.json
  def index
    @purchases = current_user.purchases
  end

  # GET /purchases/1
  # GET /purchases/1.json
  def show
  end

  # GET /purchases/new
  def new
    @purchase = Purchase.new
    @purchase.exports.build
  end

  # GET /purchases/1/edit
  def edit
  end

  # POST /purchases
  # POST /purchases.json
  def create
    @purchase = Purchase.new(purchase_params.merge(user_id: current_user.id))
    respond_to do |format|
      if @purchase.save
        format.html { redirect_to @purchase, notice: 'Purchase was successfully created.' }
        format.json { render :show, status: :created, location: @purchase }
      else
        format.html { render :new }
        format.json { render json: @purchase.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /purchases/1
  # PATCH/PUT /purchases/1.json
  def update
    respond_to do |format|
      if @purchase.update_attributes(purchase_params)
        format.html { redirect_to @purchase, notice: 'Purchase was successfully updated.' }
        format.json { render :show, status: :ok, location: @purchase }
      else
        format.html { render :edit }
        format.json { render json: @purchase.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /purchases/1
  # DELETE /purchases/1.json
  def destroy
    @purchase.destroy
    respond_to do |format|
      format.html { redirect_to purchases_url, notice: 'Purchase was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_purchase
      @purchase = Purchase.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def purchase_params
      params.require(:purchase).permit(:GSTIN_UIN, :EMAIL_ID, :CIN, :TELEPHONE_NO, :PAN, :FAX, :REVERSE_CHARGE, :TRANSPORTATION_MODE, :INVOICE_NO, :VEHICLE_NO, :INVOICE_DATE, :DATE_OF_SUPPLY, :STATE, :PLACE_OF_SUPPLY, :STATE_CODE, :BUYER_NAME, :BUYER_ADDRESS, :BUYER_GSTIN_UIN, :BUYER_CIN, :BUYER_STATE, :BUYER_STATE_CODE, :CONSIGNEE_NAME, :CONSIGNEE_ADDRESS, :CONSIGNEE_GSTIN_UIN, :CONSIGNEE_CIN, :CONSIGNEE_STATE, :CONSIGNEE_STATE_CODE, :APPLICATION_NO_FOR_REMOVAL_OF_GOODS, :APPLICATION_DATE_FOR_REMOVAL_OF_GOODS,:photo,exports_attributes:[:id, :purchase_id,:NAME_OF_GOODS_SERVICES,:HSNC_ACS,:UQM,:QTY,:RATE_P_U,:AMOUNT,:LESS_DISCOUNT_ABATEMENT, :TAXABLE_AMOUNT,:CGST_RATE_OF_TAX,:CGST_AMT,:SGST_RATE_OF_TAX,:SGST_AMT,:IGST_RATE_OF_TAX,:IGST_AMT,:TOTAL_AMOUNT,:_destroy])
    end
end
