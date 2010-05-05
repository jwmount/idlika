class ItemsController < ApplicationController
  before_filter :find_gift_and_registry
  
  # GET /items
  # GET /items.xml
  def index
    @items = @gift.items.find( :all )

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @items }
    end
  end

  # GET /items/1
  # GET /items/1.xml
  def show
    @item = @gift.items.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @item }
    end
  end

  # GET /items/new
  # GET /items/new.xml
  def new
    @item = @gift.items.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @item }
    end
  end

  # GET /items/1/edit
  def edit
    @item = @gift.items.find(params[:id])
  end

  # POST /items
  # POST /items.xml
  def create
    @item = @gift.items.new(params[:item])

    respond_to do |format|
      if @item.save
        flash[:notice] = 'Item was successfully created.'
        format.html { redirect_to( [@gift,@item] ) }
        format.xml  { render :xml =>  @item, :status => :created, :location => [@gift, @item] }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /items/1
  # PUT /items/1.xml
  def update
    @item = @gift.items.find(params[:id])

    respond_to do |format|
      if @item.update_attributes(params[:item])
        flash[:notice] = 'Item was successfully updated.'
        format.html { redirect_to( [@gift, @item] ) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.xml
  def destroy
    @item = @gift.items.find(params[:id])
    @item.destroy

    respond_to do |format|
      format.html { redirect_to(gift_items_url(@gift)) }
      format.xml  { head :ok }
    end
  end
#  + + + + + + + + + + + + + + + + + + + + + + + + + + + + +
  private

    def find_gift_and_registry
      @registry = Registry.find( params[:registry_id] )
      @gift = Gift.find( params[:gift_id] )
    end


end
