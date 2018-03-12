class SalesController < ApplicationController
  before_action :set_sale, only: [:show, :edit, :update, :destroy,:download]
  require 'rubyXL'
  # GET /sales
  # GET /sales.json
  def index
    @sales = current_user.sales
    @saleshasharray = Array.new
    @sales.each do |sale|
      saleshash = Hash.new
      saleshash['id']=sale.id
      saleshash['BUYER_GSTIN_UIN']=sale.BUYER_GSTIN_UIN
      saleshash['INVOICE_NO']=sale.INVOICE_NO
      saleshash['INVOICE_DATE']=sale.INVOICE_DATE.strftime("%d/%m/%Y")      
      total_amount = 0
      total_discount = 0
      total_SGST = 0
      total_CGST = 0
      total_IGST = 0
      sale.exportsales.each do |e|
        total_amount = total_amount + e.AMOUNT.to_i
        total_discount = total_discount + e.LESS_DISCOUNT_ABATEMENT.to_i
        total_SGST = total_SGST + e.SGST_AMT.to_i
        total_CGST = total_CGST + e.CGST_AMT.to_i
        total_IGST = total_IGST + e.IGST_AMT.to_i
      end

      saleshash['total_amount']=total_amount
      saleshash['PLACE_OF_SUPPLY']=sale.PLACE_OF_SUPPLY
      saleshash['Tax_Amount']=total_amount-total_discount
      saleshash['total_CGST']=total_CGST
      saleshash['total_SGST']=total_SGST
      saleshash['total_IGST']=total_IGST
      saleshash['SaleObject']=sale
      @saleshasharray.push saleshash
    end
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
    @user = current_user
  end

    def download
    book = RubyXL::Parser.parse("#{Rails.root}/public/Sample.xlsx")
    sheet = book.worksheets[0]
    sheet[2][2].change_contents(current_user.company)
    sheet[4][0].change_contents(current_user.address)
    sheet[6][1].change_contents(current_user.email)
    sheet[7][1].change_contents(current_user.gst)
    sheet[8][1].change_contents(@sale.INVOICE_NO)
    sheet[9][1].change_contents(@sale.INVOICE_DATE.strftime("%d/%m/%Y"))
    sheet[16][1].change_contents(@sale.PAN)
    sheet[10][4].change_contents(@sale.REVERSE_CHARGE)
    sheet[17][1].change_contents(@sale.BUYER_GSTIN_UIN)
    sheet[17][6].change_contents(@sale.BUYER_CIN)
    sheet[11][0].change_contents("Bill To: " + @sale.BUYER_NAME + ", "+ @sale.BUYER_ADDRESS)
    sheet[11][5].change_contents("Place of Supply: " + @sale.CONSIGNEE_NAME + ", "+ @sale.CONSIGNEE_ADDRESS)
    sheet[16][6].change_contents(@sale.VEHICLE_NO)
    sheet[6][6].change_contents(current_user.landline)
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
    grand_total =0
    @sale.exportsales.each do |e|
      sheet[export_sheet_no][0].change_contents(e.NAME_OF_GOODS_SERVICES + " ("+ e.remark + ")")
      sheet[export_sheet_no][4].change_contents(e.HSNC_ACS)
      sheet[export_sheet_no][5].change_contents(number_with_precision(e.QTY,precision: 2))
      sheet[export_sheet_no][6].change_contents(number_with_precision(e.gstper, precision:2))
      sheet[export_sheet_no][7].change_contents(number_with_precision(e.RATE_P_U, precision:2))
      sheet[export_sheet_no][8].change_contents(number_with_precision(e.AMOUNT, precision:2))
      total_amount = total_amount + e.AMOUNT.to_i
      total_discount = total_discount + e.LESS_DISCOUNT_ABATEMENT.to_i
      total_SGST = total_SGST + e.SGST_AMT.to_i
      total_CGST = total_CGST + e.CGST_AMT.to_i
      total_IGST = total_IGST + e.IGST_AMT.to_i
      grand_total = grand_total + e.TOTAL_AMOUNT.to_i
      export_sheet_no = export_sheet_no + 1
    end
    sheet[44][6].change_contents("For "+current_user.company)
    sheet[38][8].change_contents(number_with_precision(total_amount,precision: 2))
    sheet[39][8].change_contents(number_with_precision(total_discount,precision: 2))
    sheet[40][8].change_contents(number_with_precision(total_SGST, precision:2))
    sheet[41][8].change_contents(number_with_precision(total_CGST,precision: 2))
    sheet[42][8].change_contents(number_with_precision(total_IGST,precision: 2))
    sheet[43][8].change_contents(number_with_precision(grand_total,precision:2))
    sheet[41][0].change_contents(to_words(grand_total))

    book.save "#{Rails.root}/public/Report.xlsx"
    send_file "#{Rails.root}/public/Report.xlsx"
  end



    def downloadsummary
    book = RubyXL::Parser.parse("#{Rails.root}/public/SummarySample.xlsx")
    sheet = book.worksheets[0]
    @sales = current_user.sales
    row_no = 1
    @sales.each do |sale|
      sheet.add_cell(row_no,0,sale.BUYER_GSTIN_UIN)
      sheet.add_cell(row_no,1,sale.BUYER_NAME)
      sheet.add_cell(row_no,2,sale.INVOICE_NO)
      sheet.add_cell(row_no,3,sale.INVOICE_DATE.strftime("%d/%m/%Y"))
      
      total_amount = 0
      total_discount = 0
      total_SGST = 0
      total_CGST = 0
      total_IGST = 0
      sale.exportsales.each do |e|
        total_amount = total_amount + e.AMOUNT.to_i
        total_discount = total_discount + e.LESS_DISCOUNT_ABATEMENT.to_i
        total_SGST = total_SGST + e.SGST_AMT.to_i
        total_CGST = total_CGST + e.CGST_AMT.to_i
        total_IGST = total_IGST + e.IGST_AMT.to_i
      end
      sheet.add_cell(row_no,4,total_amount)
      sheet.add_cell(row_no,5,sale.PLACE_OF_SUPPLY)
      sheet.add_cell(row_no,6,total_amount-total_discount)
      sheet.add_cell(row_no,7,total_CGST)
      sheet.add_cell(row_no,8,total_SGST)
      sheet.add_cell(row_no,9,total_IGST)
      row_no = row_no + 1
    end

    book.save "#{Rails.root}/public/SummaryReport.xlsx"
    send_file "#{Rails.root}/public/SummaryReport.xlsx"
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

  def to_words(num)
  numbers_to_name = {
      10000000 => "crore",
      100000 => "lakh",
      1000 => "thousand",
      100 => "hundred",
      90 => "ninety",
      80 => "eighty",
      70 => "seventy",
      60 => "sixty",
      50 => "fifty",
      40 => "forty",
      30 => "thirty",
      20 => "twenty",
      19=>"nineteen",
      18=>"eighteen",
      17=>"seventeen", 
      16=>"sixteen",
      15=>"fifteen",
      14=>"fourteen",
      13=>"thirteen",              
      12=>"twelve",
      11 => "eleven",
      10 => "ten",
      9 => "nine",
      8 => "eight",
      7 => "seven",
      6 => "six",
      5 => "five",
      4 => "four",
      3 => "three",
      2 => "two",
      1 => "one"
    }

  log_floors_to_ten_powers = {
    0 => 1,
    1 => 10,
    2 => 100,
    3 => 1000,
    4 => 1000,
    5 => 100000,
    6 => 100000,
    7 => 10000000
  }

  num = num.to_i
  return '' if num <= 0 or num >= 100000000

  log_floor = Math.log(num, 10).floor
  ten_power = log_floors_to_ten_powers[log_floor]

  if num <= 20
    numbers_to_name[num]
  elsif log_floor == 1
    rem = num % 10
    [ numbers_to_name[num - rem], to_words(rem) ].join(' ')
  else
    [ to_words(num / ten_power), numbers_to_name[ten_power], to_words(num % ten_power) ].join(' ')
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
      params.require(:sale).permit(:GSTIN_UIN, :EMAIL_ID, :CIN, :TELEPHONE_NO,:landline, :PAN, :FAX, :REVERSE_CHARGE, :TRANSPORTATION_MODE, :INVOICE_NO, :VEHICLE_NO, :INVOICE_DATE, :DATE_OF_SUPPLY, :STATE, :PLACE_OF_SUPPLY, :STATE_CODE, :BUYER_NAME, :BUYER_ADDRESS, :BUYER_GSTIN_UIN, :BUYER_CIN, :BUYER_STATE, :BUYER_STATE_CODE, :CONSIGNEE_NAME, :CONSIGNEE_ADDRESS, :CONSIGNEE_GSTIN_UIN, :CONSIGNEE_CIN, :CONSIGNEE_STATE, :CONSIGNEE_STATE_CODE, :APPLICATION_NO_FOR_REMOVAL_OF_GOODS, :APPLICATION_DATE_FOR_REMOVAL_OF_GOODS,:comment,:photo,exportsales_attributes:[:id, :purchase_id,:NAME_OF_GOODS_SERVICES,:HSNC_ACS,:UQM,:QTY,:gstper,:remark,:RATE_P_U,:AMOUNT,:LESS_DISCOUNT_ABATEMENT, :TAXABLE_AMOUNT,:CGST_RATE_OF_TAX,:CGST_AMT,:SGST_RATE_OF_TAX,:SGST_AMT,:IGST_RATE_OF_TAX,:IGST_AMT,:TOTAL_AMOUNT,:_destroy])
    end
end
