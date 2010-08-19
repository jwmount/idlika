class GiftsController < ApplicationController

#  filter_resource_access

  before_filter :find_user, :find_friend, :find_registry
  layout 'application'
 
  # Display gifts user is permitted to see; owner can see all.
  def index
      @gifts = @registry.gifts
  end

  # gifts for @registry passed in
  def index_for_registry
    
    begin
      session[:current_registry] = Registry.find params[:registry_id]
    rescue
      session[:current_registry] = Registry.find( :first, :conditions => ["user_id = ? AND name = 'Recently Added'", @user.id ] )
    end
    
    logger.info "*-*-*-*-* gifts_controller.index_for_registry :current_registry => #{session[:current_registry].name}."
    redirect_to :action => 'index'
  end
    
  # Switch to selected friend.  At this point we only know the friend by name
  def select_friend
      session.clear
      session[:current_friend] = User.find_by_username params[:friend_name]
      logger.info("*-*-*-* gifts_controller.select_friend: id: #{@user.id}, owned by: #{session[:current_friend] }" )
      redirect_to :action => 'index_for_registry'
  end
     
  def set_to_self
    session[:current_user] = current_user
    redirect_to :action => 'index'
  end
  
  # @gift identifies its user via session[:friend].
  def show
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
  
  def test_URL
      @url = "https://graph.facebook.com/19292868552"
      begin
        result = Net::HTTP.get(URI.parse(@url))
        logger.info "*-*-*-*_* tropo record_call uri:  uri = #{@url}"
        call_to_record_success(@sender.id, filename, params[:keywords]) if result.match /(<session><success>true<success>)/
      rescue
        logger.info "*-*-*-*_* attempt to record_call uri:  uri = #{@url} FAILED."
      end
      render :show
    end
  
  # Default registry for new gifts is 'Recently Added'
  def create
    @gift = @user.gifts.new(params[:gift])
    @registries = @user.registries
    @registries.each do |registry|
      @gift.registry_id = registry.id if registry.name == "Recently Added"
    end

    respond_to do |format|
      if @gift.save
        flash[:notice] = 'Gift is now part of your collection.'
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
      @donors = Donor.find_all_by_gift_id( @gift.id, :conditions => [ "allow_id = ?", @friend_allowed.id ] )

      # if Donor.destroy_all(["'user_id' = ? AND  'gift_id' = ?", @friend_allowed.id, @gift.id])
      @donors.each do |d|
        d.delete
        logger.info( "\n*-*-*-*-* gifts_controller.gift_toggle -- DENY permission to view gift_id #{@gift.id} to user_id #{@friend_allowed.id}, by user: #{@user.id}.\n")
      end
    else
      @donor = Donor.new
      @donor.allow_id = @user.id
      @friend_allowed = User.find_by_username( params[params[:friend]], :select => :id )
      @donor.allow_id = @friend_allowed.id
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
 
  def idlik12
    @idlik12 = flash["idlik12"]
    @gift = Gift.find @idlik12
    @mine = Gift.create( @gift.attributes )
    @mine.user_id = current_user[:id]
    @mine.who_can_see = nil
  
    respond_to do |format|
      if @mine.save
        flash[:notice] = 'Gift was been added to my collection.'
        format.html { redirect_to( gifts_path ) }
        format.xml  { render :xml => @mine, :status => :created, :location => @mine }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @mine.errors, :status => :unprocessable_entity }
      end
    end
  end
   
  def give_gift
  end
# = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =

  def find_friend
    begin
      @friend = User.find session[:current_friend]
    rescue
      @friend = nil
    end
  end
  
  def find_registry
    begin
      @registry = Registry.find session[:current_registry].id
      session[:current_registry] = @registry
    rescue
      
      begin
        @registry = Registry.find :first, :conditions => ["user_id = ? AND name = 'Recently Added'", @user.id ]
      rescue
        @registry = nil
      end
      
    end
    session[:current_registry] = @registry
  end
  
  # current_user is person logged on.
  def find_user
    begin
      @user = Gift.find session[:current_user].id
    rescue
      @user = current_user
    end
    @user_session = UserSession.find
      
  end #find_user
      
end
 