class GiftsController < ApplicationController
#  filter_resource_access

  before_filter :find_user, :find_owner
  layout 'application'
 
  # determine which user and related gifts and registries to display.
  # All operations are on @user.  Determine if @user is self as necessary.
  def index
    logger.info "*-*-*-*-* gifts_controller.index current_user #{@user.id}."
    logger.info "*-*-*-*-* gifts_controller.index current_owner #{@owner.id}." unless @owner.nil?
    @gifts = !@owner.nil? ? @owner.gifts.find( :all, :order => "created_at DESC" ) :
                            @user.gifts.find( :all, :order => "created_at DESC" )
    @user = !@owner.nil? ?  @owner : @user 
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
    logger.info("*-*-*-* gifts_controller.select_friend: switch to #{params[:friend]}, :id = #{params[:id]}")

    current_friend = User.find_by_username params[:friend] ||= nil    
    @user.friend_id = current_friend.id
    if @user.update_attributes(:friend_id => @user.friend_id)
      respond_to do |format|
         format.html {redirect_to :action => 'index', :id => @user.id}
#        format.js # for_friend.rjs
       end
     else
      render :text => "Unable to update user with current_friend"
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

  # who's logged on.  If friend is 'self' turn it off.
  def find_user
    @user = current_user
    @user.friend_id = nil if @user.friend_id == @user.id
    @user.save
  end
  
  # who's stuff we're looking at
  def find_owner
    @owner = current_owner
  end

end
 