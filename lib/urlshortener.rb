require 'net/http'
class UrlShortener
    $service_url = "https://cutt.ly/scripts/shortenUrl.php"

    def self.shorten(original_url)
        uri = URI($service_url)
        res = Net::HTTP.post_form(uri, "url" => original_url)
        short_url = res.body
        puts short_url
        short_url
    end    
end
