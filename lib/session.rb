require 'json'
require 'byebug'

class Session
  # find the cookie for this app
  # deserialize the cookie into a hash
  def initialize(req)
    # check for cookies
    cookie = req.cookies[cookie_name]

    if cookie
      @data_store = JSON.parse(cookie)
    else
      @data_store = {}
    end
  end

  def cookie_name
    '_rails_lite_app'
  end

  def [](key)
    @data_store[key]
  end

  def []=(key, val)
    @data_store[key] = val
  end

  # serialize the hash into json and save in a cookie
  # add to the responses cookies
  def store_session(res)
    cookie = @data_store.to_json
    res.set_cookie(cookie_name, cookie )
  end
end
