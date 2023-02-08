class User < ApplicationRecord
  has_secure_password
  
  validates :email, presence: true, uniqueness: true
  
  def create
    @user = User.new(user_params)
    if @user.save
      # Handle successful user creation
    else
      # Handle unsuccessful user creation
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end




