class GiftsController < ApplicationController
#  filter_resource_access

  before_filter :find_user
  layout 'application'
 
  # gifts for @user, effectively ALL gifts 
  def index
    logger.info "*-*-*-*-* gifts_controller.index :id => #{params[:id]}."
    @gifts = @user.gifts.find( :all, :order => "created_at DESC" )

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @gifts }
    end
  end

  # gifts for @registry passed in
  def index_for_registry
    logger.info "*-*-*-*-* gifts_controller.index_for_registry :id => #{params[:id]}."
    @gifts = Registry.find(params[:registry_id]).gifts
    
    respond_to do |format|
      format.html { render :action=>'index'}# index.html.erb
      format.xml  { render :xml => @gifts }
    end
  end
    
  def select_friend
    debugger
    logger.info("*-*-*-* gifts_controller.select_friend: switch to #{params[:friend]}")
    @current_friend = User.find_by_username params[:friend] ||= nil    
    @user.current_friend_id = @current_friend.id
    if @user.update_attributes(:current_friend_id => @user.current_friend_id)
      respond_to do |format|
        format.js # for_friend.rjs
       end
     else
       render :text => "Unable to update user with current_friend"
     end
  end
 
  # gifts for @registry passed in
   def index_for_friend_registry
     logger.info "*-*-*-*-* gifts_controller.index_for_friend_registry :id => #{params[:registry_id]}."
     @registry = Registry.find(params[:registry_id])
     @gifts = @registry.gifts
     @current_friend = User.find(@user.current_friend_id)
     
     respond_to do |format|
       format.html { }
       format.xml  { render :xml => @gifts }
     end
   end
  
  # friend registries
  def index_of_friend
    logger.info "*-*-*-*-* gifts_controller.friend :id => #{params[:user]}."
    if params[:registry_id].nil?
      @gifts = @user.gifts.find( :all, :order => "created_at DESC" )
    else
      @registry = Registry.find(params[:registry_id])
      @gifts = @user.gifts.find( :all, :order => "created_at DESC" )
    end
    
    respond_to do |format|
      format.html 
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
  

 
# = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =

  def find_user
    @user = current_user
    logger.info "*-*-*-*-* gifts_controller.find_user. username = #{@user.username}, :registry_id = #{params[:registry_id]}."
  end

end
 