class GiftsController < ApplicationController
#  filter_resource_access

  before_filter :find_user 
  layout 'application'
 
  # determine which user and related gifts and registries to display.
  # All operations are on @user.  Determine if @user is self as necessary.
  # Also, determine if @user has granted viewing rights and if not, do not display gift.
  def index
    logger.info "*-*-*-*-* gifts_controller.index current_user #{current_user[:id]}, id: #{@user.id}, friend: #{@user.friend_id}."
    @gifts = @user.gifts.find( :all, :order => "created_at DESC" )
  end

  # gifts for @registry passed in
  def index_for_registry
    logger.info "*-*-*-*-* gifts_controller.index_for_registry :registry_id => #{params[:registry_id]}."
    @gifts = Registry.find(params[:registry_id]).gifts
    
    respond_to do |format|
      format.html { render :action=>'index'}# index.html.erb
      format.xml  { render :xml => @gifts }
    end
  end
    
  # Update current_user ONLY!!!  NEVER the friend!!!
  def select_friend
    logger.info("*-*-*-* gifts_controller.select_friend: switch to #{params[:friend]}.")
    friend = User.find_by_username params[:friend] 
    owner = User.find current_user
    # is it owner?  If so, clear friend_id, otherwise set friend_id to friend.id
    if owner.update_attribute(:friend_id, friend.id == current_user[:id] ? nil : friend.id)
      logger.info("*-*-*-* gifts_controller.select_friend: id: #{@user.id}, set friend_id: #{@user.friend_id}.")
      respond_to do |format|
         format.html {redirect_to :action => 'index', :id => @user.friend_id}
#        format.js # for_friend.rjs
       end
     else
      render :text => "Unable to update user with current_friend"
     end
  end
 
  
  # @gift identifies its user via friend_id; this user is a friend if different from @user.id
  def show
    logger.info("*-*-*-* gifts_controller.show: user: #{@user.id}, friend:  #{@user.friend_id}")
    @gift = Gift.find params[:id]
    if @gift.user.id != @user.id
      @user = User.find @gift.user.id
    end
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
  
  # invoked from edit view to control granting & revoking view privledges by friends
  def gift_toggle

    @gift = Gift.find params[:gift_id]

    # .nil? doesn't seem to work here?
    if params[params[:friend]] == "null"
      # turn disallow viewing, so find it, if found, destroy it
      # they can't see gift nn owned by user uu
      @friend_allowed = User.find_by_username( params[:friend], :select => :id )
      @donors = Donor.find_all_by_user_id_and_gift_id( @friend_allowed.id, @gift.id )

      # if Donor.destroy_all(["'user_id' = ? AND  'gift_id' = ?", @friend_allowed.id, @gift.id])
      @donors.each do |d|
        d.delete
        logger.info( "\n*-*-*-*-* gifts_controller.gift_toggle -- DENY permission to view gift_id #{@gift.id} to user_id #{@friend_allowed.id}, by user: #{@user.id}.\n")
      end
    else
      @donor = Donor.new
      @donor.user_id = @user.id
      @friend_allowed = User.find_by_username( params[params[:friend]], :select => :id )
      @donor.user_id = @friend_allowed.id
      @donor.gift_id = params[:gift_id]
      if @donor.save
        logger.info( "\n*-*-*-*-* gifts_controller.gift_toggle --  GRANT permission to view gift_id #{@gift.id} to user_id #{@friend_allowed.id}, by user: #{@user.id}.\n")
      end
    end

    # Here is maintained the hash of friends and permissions
    # Logically this may be redundant with the Donor model, t.b.d.    
    # redirect at bottom is NOT expendable!
    @gift = Gift.find params[:gift_id]
    friend = User.find_by_username params[:friend]

    @value = params[:friend]
    @value = params[@value]
    @permit = params[@value].nil? ? {friend.username, 'no'} : {friend.username, 'yes'}    

    @gift.who_can_see = {}
    @gift.who_can_see.merge! @permit
    
    if @gift.save
        logger.info( "\n*-*-*-*-* gifts_controller.gift_toggle -- gift_id #{@gift.id}, user_id #{friend.id}, @gift.who_can_see: #{@gift.who_can_see}.\n")
      else
        format.xml  { render :xml => @gift.errors, :status => :unprocessable_entity }
    end
    redirect_to edit_user_gift_path(@user, @gift)
  end
  
  def registry_toggle
    @gift = Gift.find params[:gift_id]
    @registry = Registry.find_by_name params[:field].tr('_', ' ')
    @gift.registry_id = @registry.id
    if @gift.save
      logger.info "\n*-*-*-*-* gifts_controller.registry_toggle #{@gift.name} into #{@registry.name}.\n"
    else
      format.xml  { render :xml => @gift.errors, :status => :unprocessable_entity }
    end
    redirect_to edit_user_gift_path(@user, @gift)
  end
 
# = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =

  # who's logged on.  If friend is 'self' turn it off.
  def find_user
    @user = current_user
    @user = User.find @user.friend_id unless @user.friend_id.nil?
    @user.friend_id = nil if (@user.friend_id == current_user[:id])
    @user.save
  end
      
end
 