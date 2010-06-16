# friend registries
def XXXXindex_of_friend
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


# gifts for @registry passed in
 def index_for_friend_registry
   logger.info "*-*-*-*-* gifts_controller.index_for_friend_registry :id => #{params[:registry_id]}."
   @registry = Registry.find(params[:registry_id])
   @gifts = @registry.gifts
#   @current_friend = User.find(@user.friend_id)
   
   respond_to do |format|
     format.html { }
     format.xml  { render :xml => @gifts }
   end
 end

 def XXXXregistry_toggle
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