class UsersController < ApplicationController
	
	get '/users/:slug' do 
		@user = User.find_by_slug(params[:slug])
		erb :'/users/show'
	end

	get '/signup' do 
		if !logged_in?
			erb :'/users/create_user'
		else
			redirect "/tweets"
		end
	end

	post '/signup' do
		if params[:username] == "" || params[:email] == "" || params[:password] == ""
			redirect "/signup"
		else
			@user = User.new(:email => params[:email], :username => params[:username], :password => params[:password])
			if @user.save
				session[:user_id] = @user.id
				redirect "/tweets"
			else
				erb :'/users/create_user'
			end
		end
	end

	get '/login' do 
		if !logged_in? 
			erb :'/users/login'
		else
			redirect "/tweets"
		end
	end

	post '/login' do 
		user = User.find_by(:username => params[:username])
		if user && user.authenticate(params[:password])
			session[:user_id] = user.id 
			redirect "/tweets"
		else
			redirect "/signup"
		end
	end

	get '/logout' do 
		if logged_in? 
			session.destroy
			redirect "/login"
		else
			redirect "/"
		end
	end
end
