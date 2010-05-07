class DescriptionsController < ApplicationController
  filter_resource_access
  before_filter :find_gift


  def index
    @descriptions = @gift.descriptions.find( :all )

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @descriptions }
    end
  end

  # GET /descriptions/1
  # GET /descriptions/1.xml
  def show
    @description = @gift.descriptions.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @description }
    end
  end

  # GET /descriptions/new
  # GET /descriptions/new.xml
  def new
    @description = @gift.descriptions.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @description }
    end
  end

  # GET /descriptions/1/edit
  def edit
    @description = @gift.descriptions.find(params[:id])
  end

  # POST /descriptions
  # POST /descriptions.xml
  def create
    @description = @gift.descriptions.new(params[:description])

    respond_to do |format|
      if @description.save
        flash[:notice] = 'Description was successfully created.'
        format.html { redirect_to([ @gift,@description ]) }
        format.xml  { render :xml => @description, :status => :created, :location => [@gift, @description] }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @description.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /descriptions/1
  # PUT /descriptions/1.xml
  def update
    @description = @gift.descriptions.find(params[:id])

    respond_to do |format|
      if @description.update_attributes(params[:description])
        flash[:notice] = 'Description was successfully updated.'
        format.html { redirect_to( [@gift, @item] ) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @description.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /descriptions/1
  # DELETE /descriptions/1.xml
  def destroy
    @description = @gift.descriptions.find(params[:id])
    @description.destroy

    respond_to do |format|
      format.html { redirect_to(@gift_descriptions_url) }
      format.xml  { head :ok }
    end
  end
# + + + + + + + + + + + + + + + + + + + + + + + + + + + + +
  private

    def find_gift
      @user = User.find( params[:gift_id] )
    end

end
