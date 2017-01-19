class UserController < ApplicationController
	# Individual user page that will load the user's
	# creators or brands/agencies depending on what 
	# the user is
	def index
		# Pass all the users in to populate dropdown
		# account switcher
		@users = User.all
		user = User.find(params[:id])
		@selected = user.id
		if user.kind == 'Agency'
			@company = Agency.find_by user_id: user.id
		elsif user.kind == 'Brand'
			@company = Brand.find_by user_id: user.id
		elsif user.kind == 'Creator'
			@creator = Creator.find_by user_id: user.id
		end
	end

	# Switch accounts 
	def select
		redirect_to '/user/' + params[:user_id].to_s
	end

	# Add creators if user logged in is a brand/agency
	# by passing in a youtube/twitter URL
	def add

		company = current_company
		url = params[:user][:URL]
		input = check_url(url)

		# Reroute back to page if invalid URL
		if input[0] == nil && input[1] == nil && input[2] == nil
			redirect_to '/user/' + params[:id].to_s, notice: "Check if URL is a Youtube/Twitter user!"
		else
			creator = check_creator(input[0], input[1], url, input[2])
			
			# If creator is already associated with brand/agency,
			# give message that says `Creator already added!`
			if company.creators.include? creator
				redirect_to '/user/' + params[:id].to_s, notice: "Creator already added!"
			else
			# Otherwise, link creator and brand/agency
				company.creators << creator
				redirect_to '/user/' + params[:id].to_s
			end
		end
	end

	# Helper functions
	private
		# Return brand/agency to be used to link to creator
		def current_company
			currentUser = User.find(params[:id])
			if currentUser.kind == 'Agency'
				company = Agency.find_by user_id: currentUser.id
			elsif currentUser.kind == 'Brand'
				company = Brand.find_by user_id: currentUser.id
			end

			return company
		end

		# Check to see if URL is a valid Youtube/Twitter user URL
		def check_url(url)
			require 'open-uri'
			begin
				doc = Nokogiri::HTML(open(url))

				# The `type` variable will be used to distinguish whether
				# or not an account is associated with Youtube or Twitter.
				# This is done so that a creator that uses the same username
				# for both social media platforms can with both accounts.

				# Youtube scraping
				if doc.css('.channel-header-profile-image').length > 0
					entry = doc.css('.channel-header-profile-image')[0]
					image = entry['src']
					username = entry['title']
					type = ' [YT]' 
				# Twitter scraping
				elsif doc.css('.ProfileAvatar-image').length > 0
					entry = doc.css('.ProfileAvatar-image')[0]
					image = entry['src']
					username = doc.css('.ProfileHeaderCard-nameLink')[0].text
					type = ' [T]'
				else 
					image = nil
					username = nil
					type = nil
				end
			rescue
				image = nil
				username = nil
				type = nil
			end

			return [username, image, type]
		end

		# Check database if creator exists already. If not,
		# create a new user and creator that are linked to
		# each other.
		def check_creator(username, image, url, type)
			if User.find_by name: '(c) ' + username + type
				user = User.find_by name: '(c) ' + username + type
				creator = Creator.find_by user_id: user.id
			else
				user = User.new(:name => '(c) ' + username + type, :kind => 'Creator')
				creator = Creator.create(:name => username, :propic => image, :link => url)
				user.creator = creator
				user.save
			end

			return creator
		end
end
