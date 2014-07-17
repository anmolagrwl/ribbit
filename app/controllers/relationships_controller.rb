class RelationshipsController < ApplicationController

	def create
		relationship = Relationship.new(relationship_params)
		relationship.follower = current_user
		if relationship.save
			redirect_to relationship.followed
		else
			flash[:error] = "Couldn't follow"
			redirect_to relationship.followed
		end
	end

	def destroy
		relationship = Relationship.find(params[:id])
		user = relationship.followed
		relationship.destroy
		redirect_to user
	end

	private

		def relationship_params
			params.require(:relationship).permit!
		end
end
