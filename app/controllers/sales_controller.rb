class SalesController < ApplicationController
  before_action :set_sale, only: [:show, :edit, :update, :destroy,:download]
  require 'rubyXL'
  require 'numbers_in_words'
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
    @user = current_user
  end

  def buyergst
    parameter = params[:gst]
    # do something with some_parameter and return the results

    @sale=Sale.find_by BUYER_GSTIN_UIN: parameter.to_s
    respond_to do |format|
      format.json { render json: @sale }
    end
  end

  # GET /sales/1/edit
  def edit
  end

    def download
    book = RubyXL::Parser.parse("#{Rails.root}/public/Sample.xlsx")
    sheet = book.worksheets[0]
    sheet[2][2].change_contents(current_user.company)
    sheet[4][0].change_contents(current_user.address)
    sheet[6][1].change_contents(current_user.email)
    sheet[7][1].change_contents(current_user.gst)
    sheet[8][1].change_contents(@sale.INVOICE_NO)
    sheet[9][1].change_contents(@sale.INVOICE_DATE)
    sheet[16][1].change_contents(@sale.PAN)
    sheet[10][4].change_contents(@sale.REVERSE_CHARGE)
    sheet[17][1].change_contents(@sale.GSTIN_UIN)
    sheet[17][6].change_contents(@sale.CIN)
    sheet[11][0].change_contents(@sale.BUYER_NAME)
    sheet[11][5].change_contents(@sale.PLACE_OF_SUPPLY)
    sheet[16][6].change_contents(@sale.VEHICLE_NO)
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
    @sale.exportsales.each do |e|
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
    sheet[41][0].change_contents(NumbersInWords.in_words(grand_total))

    book.save "#{Rails.root}/public/Report.xlsx"
    send_file "#{Rails.root}/public/Report.xlsx"
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
      params.require(:sale).permit(:GSTIN_UIN, :EMAIL_ID, :CIN, :TELEPHONE_NO,:landline, :PAN, :FAX, :REVERSE_CHARGE, :TRANSPORTATION_MODE, :INVOICE_NO, :VEHICLE_NO, :INVOICE_DATE, :DATE_OF_SUPPLY, :STATE, :PLACE_OF_SUPPLY, :STATE_CODE, :BUYER_NAME, :BUYER_ADDRESS, :BUYER_GSTIN_UIN, :BUYER_CIN, :BUYER_STATE, :BUYER_STATE_CODE, :CONSIGNEE_NAME, :CONSIGNEE_ADDRESS, :CONSIGNEE_GSTIN_UIN, :CONSIGNEE_CIN, :CONSIGNEE_STATE, :CONSIGNEE_STATE_CODE, :APPLICATION_NO_FOR_REMOVAL_OF_GOODS, :APPLICATION_DATE_FOR_REMOVAL_OF_GOODS,:comment,:photo,exportsales_attributes:[:id, :purchase_id,:NAME_OF_GOODS_SERVICES,:HSNC_ACS,:UQM,:QTY,:RATE_P_U,:AMOUNT,:LESS_DISCOUNT_ABATEMENT, :TAXABLE_AMOUNT,:CGST_RATE_OF_TAX,:CGST_AMT,:SGST_RATE_OF_TAX,:SGST_AMT,:IGST_RATE_OF_TAX,:IGST_AMT,:TOTAL_AMOUNT,:_destroy])
    end
end
