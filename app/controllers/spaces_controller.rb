class SpacesController < ApplicationController
  before_action :authenticate_user!
	def index
      @user = User.find(current_user.id)
    	@spaces = Space.where(user_id: @user.id)
  	end
	def show
    	@space = Space.find(params[:id])
  	end
	def new
		@space = Space.new
	end
	def edit
  		@space = Space.find(params[:id])
      if @space.user_id != current_user.id
        flash.now[:notice] = 'Not Allowed'
        redirect_to spaces_path
      end

	end

	def create
		@space = Space.new(space_param)
    @space.user_id = current_user.id
  		if @space.save
  			redirect_to @space
  		else
  			render 'new'
  		end
  	end

  	def update
  		@space = Space.find(params[:id])
      if @space.user_id == current_user.id
    		if @space.update(space_params)
      		redirect_to @space
    		else
      		render 'edit'
    		end
      else 
        flash.now[:notice] = 'Not Allowed'
        redirect_to spaces_path
      end
	end
	
  	def destroy
      @space = Space.find(params[:id])
      if @space.user_id == current_user.id
    		@space.destroy
   
    		redirect_to spaces_path
      else 
        flash.now[:notice] = 'Not Allowed'
        redirect_to spaces_path
      end
	end
  	private
  		def space_param
  			params.require(:space).permit(:title, :text)
  		end
end
