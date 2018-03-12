class PurchasesController < ApplicationController
  before_action :set_purchase, only: [:show, :edit, :update, :destroy,:download]
  require 'rubyXL'
  # GET /purchases
  # GET /purchases.json
  def index
    @purchases = current_user.purchases
  end

  # GET /purchases/1
  # GET /purchases/1.json
  def show
  end

  def download
    book = RubyXL::Parser.parse("#{Rails.root}/public/Sample.xlsx")
    sheet = book.worksheets[0]
    sheet[2][2].change_contents(current_user.company)
    sheet[4][0].change_contents(current_user.address)
    sheet[6][1].change_contents(current_user.email)
    sheet[7][1].change_contents(current_user.gst)
    sheet[8][1].change_contents(@purchase.INVOICE_NO)
    sheet[9][1].change_contents(@purchase.INVOICE_DATE)
    sheet[16][1].change_contents(@purchase.PAN)
    sheet[10][4].change_contents(@purchase.REVERSE_CHARGE)
    sheet[17][1].change_contents(@purchase.GSTIN_UIN)
    sheet[17][6].change_contents(@purchase.CIN)
    sheet[11][0].change_contents(@purchase.BUYER_NAME)
    sheet[11][5].change_contents(@purchase.PLACE_OF_SUPPLY)
    sheet[16][6].change_contents(@purchase.VEHICLE_NO)
    sheet[6][6].change_contents(current_user.phone)
    sheet[7][6].change_contents(current_user.phone)
    sheet[38][0].change_contents("Bank: "+ current_user.bankname + " , Branch Code: " +current_user.branchcode+" , Account: "+current_user.accountnumber + " , IFSC: "+current_user.ifsccode)
    sheet[44][1].change_contents(current_user.pan)
    sheet[45][1].change_contents(current_user.cin)
    export_sheet_no = 19
    total_amount = 0
    total_discount = 0
    total_SGST = 0
    total_CGST = 0
    total_IGST = 0
    @purchase.exports.each do |e|
      sheet[export_sheet_no][0].change_contents(e.NAME_OF_GOODS_SERVICES)
      sheet[export_sheet_no][4].change_contents(e.HSNC_ACS)
      sheet[export_sheet_no][5].change_contents(e.QTY)
      #sheet[export_sheet_no][6].change_contents(e.HSNC_ACS)
      sheet[export_sheet_no][7].change_contents(e.RATE_P_U)
      sheet[export_sheet_no][8].change_contents(e.AMOUNT)
      total_amount = total_amount + e.AMOUNT.to_i
      total_discount = total_discount + e.LESS_DISCOUNT_ABATEMENT.to_i
      total_SGST = total_SGST + e.SGST_AMT.to_i
      total_CGST = total_CGST + e.CGST_AMT.to_i
      total_IGST = total_IGST + e.IGST_AMT.to_i
      export_sheet_no = export_sheet_no + 1
    end
    sheet[38][8].change_contents(total_amount)
    sheet[39][8].change_contents(total_discount)
    sheet[40][8].change_contents(total_SGST)
    sheet[41][8].change_contents(total_CGST)
    sheet[42][8].change_contents(total_IGST)
    grand_total = total_amount - total_discount + total_SGST + total_CGST +total_IGST
    sheet[43][8].change_contents(grand_total)
    book.save "#{Rails.root}/public/Report.xlsx"
    send_file "#{Rails.root}/public/Report.xlsx"
  end

  def print
    @purchases = current_user.purchases
    respond_to do |format|
      format.html
      format.csv { send_data @purchases.to_csv }
      format.xls { send_data @purchases.to_csv(col_sep: "\t") }
    end
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
      if @purchase.update(purchase_params)
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
      params.require(:purchase).permit(:GSTIN_UIN, :EMAIL_ID, :CIN, :TELEPHONE_NO, :PAN, :FAX, :REVERSE_CHARGE, :TRANSPORTATION_MODE, :INVOICE_NO, :VEHICLE_NO, :INVOICE_DATE, :DATE_OF_SUPPLY, :STATE, :PLACE_OF_SUPPLY, :STATE_CODE, :BUYER_NAME, :BUYER_ADDRESS, :BUYER_GSTIN_UIN, :BUYER_CIN, :BUYER_STATE, :BUYER_STATE_CODE, :CONSIGNEE_NAME, :CONSIGNEE_ADDRESS, :CONSIGNEE_GSTIN_UIN, :CONSIGNEE_CIN, :CONSIGNEE_STATE, :CONSIGNEE_STATE_CODE, :APPLICATION_NO_FOR_REMOVAL_OF_GOODS, :APPLICATION_DATE_FOR_REMOVAL_OF_GOODS,:comment,:photo,exports_attributes:[:id, :purchase_id,:NAME_OF_GOODS_SERVICES,:HSNC_ACS,:UQM,:QTY,:RATE_P_U,:AMOUNT,:LESS_DISCOUNT_ABATEMENT, :TAXABLE_AMOUNT,:CGST_RATE_OF_TAX,:CGST_AMT,:SGST_RATE_OF_TAX,:SGST_AMT,:IGST_RATE_OF_TAX,:IGST_AMT,:TOTAL_AMOUNT,:_destroy])
    end
end
