require_relative File.join('..', 'csvs', 'purchase_order_c_s_v.rb')
class WishlistsController < ApplicationController
  before_filter :authenticate_product_manager!, :except => [:detail, :create]

  def sample_order
    session = GoogleDrive.login(ENV['GOOGLE_DRIVE_USERNAME'], ENV['GOOGLE_DRIVE_PASSWORD'])

    sample_sheet = session.spreadsheet_by_key(ENV['GOOGLE_DRIVE_ORDER_SPREADSHEET_KEY']).worksheets[3]
    
    @wishlist = Wishlist.find params[:id]
    
    row = 1
    row_marker_text = "Don't delete or edit this - it is a marker for the order feed from littlehippie.com"
    while sample_sheet[row, 1] != row_marker_text
      row = row + 1
      puts "on row #{row}"
    end
    
    order_detail_position_for = {"Charge Number" => 1, "Customer Order Date" => 2, "Order Submission Date" => 3,"Buyer Name" => 4,
      "Phone Number" => 5, "Buyer Email" => 6, "Ship To Address" => 7, "Ship To City" => 8, "Ship To State" => 9, "Ship To Zip Code" => 10, "Country" => 11,
      "Item Ordered" => 12, "Color" => 13, "Size" => 14, "LH Product Code" => 15, "Old Glory SKU Number" => 16, "Quantity" => 17,
      "Promo Code" => 18, "Promo Discount" => 19, "Item Sale Price" => 20, "Shipping Price" => 21, "Order Total" => 22,
      "Gift Note" => 23, "Ship Method" => 24, "Ship Date" => 25, "Tracking Number" => 26, "Shipment Notes" => 27}
    
    @wishlist.wishlist_items.each do |item|
      puts "item #{item.id}"
      begin
        sample_sheet[row, order_detail_position_for["Item Ordered"]] = item.product.name
        sample_sheet[row, order_detail_position_for["Color"]] = item.color.name
        sample_sheet[row, order_detail_position_for["Size"]] = item.size.code
        sample_sheet[row, order_detail_position_for["LH Product Code"]] = item.product.code
        sample_sheet[row, order_detail_position_for["Old Glory SKU Number"]] = item.product_color.og_code
        sample_sheet[row, order_detail_position_for["Quantity"]] = 1
        # sample_sheet[row, order_detail_position_for["Item Sale Price"]] = item.final_cost
        sample_sheet[row, order_detail_position_for["Customer Order Date"]] = Date.today.strftime("%m/%d/%y")
        
        row = row + 1
      rescue StandardError => error
        puts error.inspect
      end
    end
    
    sample_sheet[row, 1] = row_marker_text
    sample_sheet.save
    
    redirect_to @wishlist, :notice => 'The sample order has been placed.'
  end
  
  # def convert_to_po
  #   @wishlist = Wishlist.find params[:id]
  #   filename = "wishlist_#{@wishlist.id}.csv"
  #   @purchase_order = PurchaseOrderCSV.new @wishlist
  #   @purchase_order.write_csv filename
  #   
  #   respond_to do |format|
  #     format.html { send_file File.join(Rails.root, "tmp", filename) }
  #   end
  # end
  
  def detail
    @wishlist = Wishlist.find params[:id]
    render :layout => 'customer'
  end
  
  # GET /wishlists
  # GET /wishlists.json
  def index
    @wishlists = Wishlist.order('created_at desc').page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @wishlists }
    end
  end

  # GET /wishlists/1
  # GET /wishlists/1.json
  def show
    @wishlist = Wishlist.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @wishlist }
    end
  end

  # GET /wishlists/new
  # GET /wishlists/new.json
  def new
    @wishlist = Wishlist.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @wishlist }
    end
  end

  # GET /wishlists/1/edit
  def edit
    @wishlist = Wishlist.find(params[:id])
  end

  # POST /wishlists
  # POST /wishlists.json
  def create
    @wishlist = Wishlist.new(params[:wishlist])

    respond_to do |format|
      if @wishlist.save
        format.html { redirect_to @wishlist, notice: 'Wishlist was successfully created.' }
        format.json { render json: @wishlist, status: :created, location: @wishlist }
      else
        format.html { render action: "new" }
        format.json { render json: @wishlist.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /wishlists/1
  # PUT /wishlists/1.json
  def update
    @wishlist = Wishlist.find(params[:id])

    respond_to do |format|
      if @wishlist.update_attributes(params[:wishlist])
        format.html { redirect_to @wishlist, notice: 'Wishlist was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @wishlist.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wishlists/1
  # DELETE /wishlists/1.json
  def destroy
    @wishlist = Wishlist.find(params[:id])
    @wishlist.destroy

    respond_to do |format|
      format.html { redirect_to wishlists_url }
      format.json { head :no_content }
    end
  end
end
