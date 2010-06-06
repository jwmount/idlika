class GiftsController < ApplicationController
#  filter_resource_access

  before_filter :find_user
  layout 'application'
  
  def index
    logger.info("*-*-*-* .index: :id => #{params[:id]}")
    @user = User.find params[:id] ||= current_user 
    
    # Default to logical registry 'Recently Added' if :registry not in response
    # Always get recently_added_gifts
    @recently_added_gifts = @user.gifts.find( :all, :order => "created_at DESC", :limit => 9 )
  
    if !params[:registry_id].nil? 
      @registry = Registry.find params[:registry_id]
      @gifts = @registry.gifts.find :all
    else # user wants to see recently added gifts
      @gifts = @recently_added_gifts
    end
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @gifts }
    end
  end

  def index_of_friend
    @user = User.find_by_username params[:friend]
    logger.info("*-*-*-* .index_of_friend: switch to #{params[:friend]}")
    @gifts = User.find_by_username(params[:friend]).gifts.find(:all)
    
    respond_to do |format|
      format.js # for_friend.rjs
     end
  end
  
  def show
    @gift = Gift.find params[:id]
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @gift }
    end
  end


  def new
    @gift = @user.gifts.new
  end


  def edit
    @gift = Gift.find params[:id]
  end

  def images
  end
  
  def create
    @gift = @user.gifts.new(params[:gift])
    respond_to do |format|
      if @gift.save
        flash[:notice] = 'Gift was been added to your collection.'
        format.html { redirect_to( edit_gift_path(@gift) ) }
        format.xml  { render :xml => @gift, :status => :created, :location => @gift }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @gift.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    
    @gift = Gift.find params[:id]
  
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
  
  def registry_toggle
    @gift = Gift.find params[:gift_id]
    @registry = Registry.find_by_name params[:field].tr('_', ' ')
    @gift.registry_id = @registry.id
    if @gift.save
      logger.info "\n*-*-*-*-* Put #{@gift.name} into #{@registry.name}.\n"
    else
      format.xml  { render :xml => @gift.errors, :status => :unprocessable_entity }
    end
    redirect_to edit_user_gift_path(@user, @gift)
  end
  

 
#= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =

  def find_user
    logger.info "\n*-*-*-*-* find_user: for :id => #{params[:id]}.\n"
    @user = current_user
  end

end
