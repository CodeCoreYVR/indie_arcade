json.extract!(
  user,
  :id,
  :company,
  :email,
  :password,
  :password_confirmation,
  :logo,
  :employees,
  :genres,
  :website,
  :twitter,
  :admin,
  :created_at,
  :updated_at
)

json.url user_url(user, format: :json)
