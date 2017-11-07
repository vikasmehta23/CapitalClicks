class ExportsController < ApplicationController
	 def create
	    @purchase = Purchase.find(params[:purchase_id])
	    export = @purchase.exports.create(params[:export])
	    redirect_to account_path(@export)
  	end

  	def show
    	@purchase = Purchase.find(params[:purchase_id])
    	@export = Export.find(params[:id])

	    respond_to do |format|
	      format.html # show.html.erb
	      format.xml  { render :xml => @listing }
	    end
  end
end
