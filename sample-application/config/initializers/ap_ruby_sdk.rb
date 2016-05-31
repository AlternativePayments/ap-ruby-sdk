if Rails.env.production?
  raise 'Sample app should be only run in test env.'
else
  ApRubySdk.api_key = 'sk_test_sqJojfKHxRJu0jHFac7bNwf4gQ9HlatcJHTGn03o'
end