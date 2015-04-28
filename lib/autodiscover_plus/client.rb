module AutodiscoverPlus
  class Client

    attr_reader :domain, :email, :http

    def initialize(email:, password:)
      @email = email
      @domain = @email.split("@").last
      @http = HTTPClient.new
      @http.set_auth(nil, @email, password)
    end

    def autodiscover(type: :pox)
      available_urls.each do |url|
        begin
          response = http.post(url, pox_request, {'Content-Type' => 'text/xml; charset=utf-8'})
          return PoxResponse.new(response.body) if good_response?(response)
        rescue Exception => e
          next
        end
      end
    end


    private


    def good_response?(response)
      response.status == 200
    end

    def available_urls(&block)
      return to_enum(__method__) unless block_given?
      formatted_https_urls.each {|url|
        yield url
      }
      yield redirected_http_url
    end

    def formatted_https_urls
      @formatted_urls ||= %W{
        https://#{domain}/autodiscover/autodiscover.xml
        https://autodiscover.#{domain}/autodiscover/autodiscover.xml
      }
    end

    def redirected_http_url
      @redirected_http_url ||=
        begin
          response = http.get("http://autodiscover.#{domain}/autodiscover/autodiscover.xml")
          (response.status == 302) ? response.headers["Location"] : nil
        end
    end

    def pox_request(mailbox: email)
      Nokogiri::XML::Builder.new do |xml| 
        xml.Autodiscover('xmlns' => 'http://schemas.microsoft.com/exchange/autodiscover/outlook/requestschema/2006') {
          xml.Request {
            xml.EMailAddress mailbox
            xml.AcceptableResponseSchema 'http://schemas.microsoft.com/exchange/autodiscover/outlook/responseschema/2006a'
          }
        }
      end.to_xml
    end

  end
end
