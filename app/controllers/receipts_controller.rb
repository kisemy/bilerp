class ReceiptsController < ApplicationController
  before_action :set_receipt, only: %i[ show edit update destroy ]
 before_action :find_receipt, only: [:show, :edit, :update, :destroy]

  # GET /receipts or /receipts.json
  def index
    @receipts = Receipt.all
  end

  # GET /receipts/1 or /receipts/1.json
  def show
  end

  # GET /receipts/new
  def new
    @receipt = Receipt.new
    @banks = Bank.all
  @receipt.receipt_lines.build
  end

  # GET /receipts/1/edit
  def edit
  @banks = Bank.all
  end

  # POST /receipts or /receipts.json
  def create
    @receipt = Receipt.new(receipt_params)
    
    @receipt.received_by = current_user.email 
    respond_to do |format|
      if @receipt.save
        format.html { redirect_to receipt_url(@receipt), notice: "Receipt was successfully created." }
        format.json { render :show, status: :created, location: @receipt }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @receipt.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /receipts/1 or /receipts/1.json
  def update
  
  @receipt.received_by = current_user.email 
    respond_to do |format|
      if @receipt.update(receipt_params)
        format.html { redirect_to receipt_url(@receipt), notice: "Receipt was successfully updated." }
        format.json { render :show, status: :ok, location: @receipt }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @receipt.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /receipts/1 or /receipts/1.json
  def destroy
    @receipt.destroy

    respond_to do |format|
      format.html { redirect_to receipts_url, notice: "Receipt was successfully destroyed." }
      format.json { head :no_content }
    end
  end
  
  
  def fetch_accountno
    case params[:account_type]
    when 'customer'
      accounts = Customer.pluck(:customer_name)
        logger.debug "Fetching accounts from Customer"
    when 'vendor'
      accounts = Vendor.pluck(:id)
        logger.debug "Fetching accounts from vendor"
    when 'gl_account'
      accounts = GLAccount.pluck(:id)
    when 'bank'
      accounts = Bank.pluck(:bank_name)
        logger.debug "Fetching accounts from Bank"
    when 'fixed_asset'
      accounts = FixedAsset.pluck(:id)
    else
      accounts = []
    end
    
   render json: { accountno_options: accounts }
  
  
  end
  
  
 def insert_into_rcgledger
 
    # Get the payment_id from the form or request params
     
     receipt_id = params[:id]
     
     
    # Fetch all payment lines that belong to the specified payment_id
   
     receipt_lines = ReceiptLine.where(receipt_id: receipt_id)
    # Loop through each payment_line and perform the insert into gledger
    receipt_lines.each do |receipt_line|
      # Assume you're using data from payment_line to insert into gledger
      Gledger.create(
      
      
      accountno: receipt_line.account_no,
      description: receipt_line.account_name,
      sourceno: receipt_line.account_no,
      amount: receipt_line.amount,
     
      
      )
    end

    # Redirect to a relevant path or render a response after the loop
    redirect_to payments_path, notice: "PaymentLines successfully inserted into Gledger."
  end 
  
  
  
  
  
  
  
  
  
  
  
  
  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_receipt
      @receipt = Receipt.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def receipt_params
      params.require(:receipt).permit(:receipt_date, :bank_code, :description, :received_by, :receipt_by, :receipt_mode, :receipt_description, :status, :document_no, :amount, :received_from, :account_type, :accountno, receipt_lines_attributes: [:receipt_date, :receipt_account, :account_type, :account_no, :account_name, :amount, :invoiceno, :receipt_id, :_destroy])
end

def find_receipt
   @receipt = Receipt.find_by(id: params[:id])
  end
end
