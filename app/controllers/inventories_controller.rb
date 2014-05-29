class InventoriesController < ApplicationController
  before_filter :authenticate_product_manager!, :except => [:browse, :detail]
  
  def browse
    @page = ContentPage.find_by_slug('home')
    @categories = @page.categories.active[0..6] || []
    @bulletins = @page.bulletins.active || []
    @popular_products = ProductColor.selection_of_popular
    render :layout => 'customer'
  end
  
  def update_old_glory_inventory
    
  end
  
  def deliver_old_glory
    csv = CSV.open(File.join(Rails.root, 'tmp', 'current_inventory.csv'), 'wb')
    csv << [
      'Code',
      'Design',
      'BodyStyle',
      'Color',
      'Size',
      'Quantity'
    ]
    
    inventory = Nokogiri::XML(params[:xml][:file].tempfile.open)
    inventory.xpath('//Product').each do |product_xml|
      full_og_code = product_xml.xpath('SKU').first.content
      product_color_code = full_og_code[/\d+/]
      product_color = ProductColor.find_by_og_code product_color_code
      next unless product_color
      full_og_code =~ /\-(.*)/
      size = Size.translation $1
      quantity = product_xml.xpath('Quantity').first.content
      
      if size
        garment = product_color.garments.of_size(size.id).of_color(product_color.color_id).first
        if garment
          Rails.logger.info "updating inventory of #{garment.name} to #{quantity}"
          garment.set_inventory quantity
        
          csv << [
            garment.product_color.og_code,
            garment.design.name,
            garment.body_style.name,
            garment.color.name,
            garment.size.name,
            quantity
          ]
        else
          Rails.logger.info "garment not found: #{product_xml.xpath('ProductName').first.content}"
        end
      end
    end
    csv.close
    
    send_file File.join(Rails.root, 'tmp', 'current_inventory.csv')
  end
  
  def detail
    @inventory = Inventory.find params[:id]
  end
  
  # GET /inventories
  # GET /inventories.json
  def index
    @inventories = Inventory.order('amount desc').where('amount > 0').page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @inventories }
    end
  end

  # GET /inventories/1
  # GET /inventories/1.json
  def show
    @inventory = Inventory.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @inventory }
    end
  end

  # GET /inventories/new
  # GET /inventories/new.json
  def new
    @inventory = Inventory.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @inventory }
    end
  end

  # GET /inventories/1/edit
  def edit
    @inventory = Inventory.find(params[:id])
  end

  # POST /inventories
  # POST /inventories.json
  def create
    @inventory = Inventory.new(params[:inventory])

    respond_to do |format|
      if @inventory.save
        format.html { redirect_to @inventory, notice: 'Inventory has been created.' }
        format.json { render json: @inventory, status: :created, location: @inventory }
      else
        format.html { render action: "new" }
        format.json { render json: @inventory.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /inventories/1
  # PUT /inventories/1.json
  def update
    @inventory = Inventory.find(params[:id])

    respond_to do |format|
      if @inventory.update_attributes(params[:inventory])
        format.html { redirect_to @inventory, notice: 'Inventory has been updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @inventory.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /inventories/1
  # DELETE /inventories/1.json
  def destroy
    @inventory = Inventory.find(params[:id])
    @inventory.destroy

    respond_to do |format|
      format.html { redirect_to inventories_url }
      format.json { head :no_content }
    end
  end
end
