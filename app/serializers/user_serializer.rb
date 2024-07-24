class UserSerializer
  include JSONAPI::Serializer

  attributes :user_name
end