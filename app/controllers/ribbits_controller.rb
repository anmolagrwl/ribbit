class RibbitsController < ApplicationController
def index
	@ribbits = Ribbit.all
	@ribbit = Ribbit.new
end


def create
	ribbit = Ribbit.new(ribbit_params)
	ribbit.user_id = current_user.id
	flash[:error] = "Your Ribbit was over 140 characters" unless ribbit.save
	redirect_to root_path
end
private

	def ribbit_params
		params.require(:ribbit).permit(:content)
	end
end
