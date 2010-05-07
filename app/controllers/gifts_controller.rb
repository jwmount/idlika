class GiftsController < ApplicationController
#  filter_resource_access

  before_filter :find_user
  layout = 'gifts'
  
  def index
    # Default to logical registry 'Recently Added' if :registry not in response
    if !params[:registry_id].nil? 
      @registry = Registry.find params[:registry_id]
      @gifts = @registry.gifts.find( :all ) 
    else
      @registry = Registry.new(:user_id => @user.id, :name => "Recently added") 
      @gifts = @user.gifts.find( :all, :order => :created_at, :limit => 9 )
    end
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @gifts }
    end
  end

  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @gift }
    end
  end


  def new
    @gift = @user.gifts.new
  end


  def edit
  end

  def create
    @gift = @user.gifts.new(params[:gift])
    respond_to do |format|
      if @gift.save
        Description.create( :gift_id => @gift.id, :description=>@gift.description, :image_url=>nil)
        flash[:notice] = 'Gift was been added to your collection.'
        format.html { redirect_to( gifts_path ) }
        format.xml  { render :xml => @gift, :status => :created, :location => @gift }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @gift.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @gift.update_attributes(params[:gift])
        flash[:notice] = 'Gift was successfully updated.'
        format.html { redirect_to(@gift) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @gift.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    Gift.destroy params[:id]
    respond_to do |format|
      format.html { redirect_to(gifts_url) }
      format.xml  { head :ok }
    end
  end
#= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =

  def find_user
    @user = current_user
  end
  
end
