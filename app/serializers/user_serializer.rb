class UserSerializer
  include JSONAPI::Serializer
  attributes :email, :first_name, :last_initial

  attribute :token do |user, params|
    params[:token]
  end
end
