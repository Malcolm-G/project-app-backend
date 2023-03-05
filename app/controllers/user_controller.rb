# frozen_string_literal: true

class UserController < AppController

  # @helper: read JSON body
  before do
    begin
      @user = user_data
    rescue
      @user = nil
    end
  end

  #@method: create a new user
  post '/auth/register' do
    begin
      if User.find_by(username:@user['username'])
        json_response(code: 422, data: { message: "The Username is aready taken" })
      elsif User.find_by(email:@user['email'])
        json_response(code: 422, data: { message: "The email already exists, try logging in if it is yours" })
      else
        x = User.create(@user)
        json_response(code: 201, data: x)
      end
    rescue => e
      error_response(422, e)
    end
  end

  #@method: log in user using email and password
  post '/auth/login' do
    begin
      user_data = User.find_by(email: @user['email'])
      if user_data.password == @user['password']
        json_response(code: 200, data: {
          id: user_data.id,
          name:user_data.name,
          email: user_data.email,
          username: user_data.username
        })
        # json_response(code: 200, data:user_data)
      else
        json_response(code: 422, data: { message: "Your email/password combination is not correct" })
      end
    rescue => e
      # error_response(422, e)
      json_response(code: 422, data: { message: "The email does not exist. Please Register" })
    end
  end

  private

  # @helper: parse user JSON data
  def user_data
    JSON.parse(request.body.read)
  end

end
