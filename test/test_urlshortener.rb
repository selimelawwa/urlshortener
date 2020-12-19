require 'minitest/autorun'
require 'urlshortener'
require 'net/http'

class UrlShortenerTest < Minitest::Test
  def test_shorten
    test_url = "https://robustastudio.com/"
    short_url = UrlShortener.shorten(test_url)

    assert_equal(test_url, unshorten_url(short_url))
  end


  def unshorten_url(uri_str, limit = 10)
    #This method calls the shortened url and follows the redirect till get actual [long] url
    raise ArgumentError, 'too many HTTP redirects' if limit == 0
  
    response = Net::HTTP.get_response(URI(uri_str))
  
    case response
    when Net::HTTPSuccess then
      response.uri.to_s
    when Net::HTTPRedirection then
      location = response['location']
      unshorten_url(location, limit - 1)
    else
      response.uri.to_s
    end
  end
end