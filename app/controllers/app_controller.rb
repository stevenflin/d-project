class AppController < ApplicationController
	# Homepage with register and login
	def index
		@users = User.all
	end

	# Register a new account (brand/agency)
	def create
		# Form parameters
		username = params[:user][:name]
		desc = params[:user][:description]
		type = params[:user][:kind]

		taken = check_user(username, type)
		if taken # Route back to homepage
			redirect_to '/', notice: "Company taken!"
		else
			# If username not taken, create a new user and
			# brand/agency depending on params. Then, link
			# the user to brand/agency

			# The `t` variable will be used to distinguish a
			# user between brand or agency
			@user = User.new
			if params[:user][:kind] == 'Agency'
				t = '(a) '
				@agency = Agency.create(:name => username, :description => desc) 
				@user.agency = @agency 
			else
				t = '(b) '
				@brand = Brand.create(:name => username, :description => desc)
				@user.brand = @brand
			end
			# Username created based on company type
			@user.name = t + username 
			@user.kind = type
			@user.save

			# Route to new user
			redirect_to '/user/' + @user.id.to_s
		end
	end

	# Helper functions
	private
		# Check to see if username is taken depending
		# on whether or not the user is a brand or agency
		def check_user(username, type)
			if type == 'Agency'
				t = '(a) '
			else
				t = '(b) '
			end
			if User.find_by name: t + username
				return true
			else
				return false
			end
		end
end
