class PriceRecordsController < ApplicationController
  before_action :set_price_record, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  respond_to :json
  skip_before_filter :verify_authenticity_token
  
  # GET /price_records
  # GET /price_records.json
  def index
    @price_records = PriceRecord.all
  end

  # GET /price_records/1
  # GET /price_records/1.json
  def show
  end

  # GET /price_records/new
  def new
    @price_record = PriceRecord.new
  end

  # GET /price_records/1/edit
  # def edit
  # end

  # POST /price_records
  # POST /price_records.json
  def create
    @price_record = PriceRecord.new(price_record_params)

    respond_to do |format|
      if @price_record.save
        format.html { redirect_to @price_record, notice: 'Price record was successfully created.' }
        format.json { render :show, status: :created, location: @price_record }
      else
        format.html { render :new }
        format.json { render json: @price_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /price_records/1
  # PATCH/PUT /price_records/1.json
  # def update
  #   respond_to do |format|
  #     if @price_record.update(price_record_params)
  #       format.html { redirect_to @price_record, notice: 'Price record was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @price_record }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @price_record.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /price_records/1
  # DELETE /price_records/1.json
  def destroy
    @price_record.destroy
    respond_to do |format|
      format.html { redirect_to price_records_url, notice: 'Price record was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_price_record
      @price_record = PriceRecord.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def price_record_params
      params.require(:price_record).permit(:user_id, :product_id, :psy_price)
    end
end
