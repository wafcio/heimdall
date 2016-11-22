class FindOmniauthUser
  include Interactor

  def call
    user = find_by_uid || find_by_email || User.new
    user.update(user_attributes)
    context.user = user
  end

  private

  def find_by_uid
    User.find_by(google_uid: context[:uid])
  end

  def find_by_email
    User.find_by(email: context[:info][:email])
  end

  def user_attributes
    {
      name:       context[:info][:name],
      email:      context[:info][:email],
      google_uid: context[:uid]
    }
  end
end
