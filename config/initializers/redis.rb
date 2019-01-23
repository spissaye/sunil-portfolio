$redis_url ||=
    if Rails.env.production?
      "redis://localhost:6379"
    elsif Rails.env.staging?
      "redis://localhost:6379"
    elsif Rails.env.development?
      "redis://localhost:6379/0"
    elsif Rails.env.test?
      db = ENV.fetch('TEST_ENV_NUMBER', 0).to_i + 1
      "redis://localhost:6379/#{db}"
    else
      ENV["REDISTOGO_URL"]
    end

uri = URI.parse($redis_url)
db = uri.path.split("/").last.to_i
$redis = Redis.new(host: uri.host, port: uri.port, password: uri.password, db: db)