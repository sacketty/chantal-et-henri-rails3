AWS::S3::Base.establish_connection!(
    :access_key_id     => ENV['AWS_ACCESS_KEY_ID'],
    :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
)

BUCKET = 'chantal-et-henri.playlist'