module AutodiscoverPlus
  class PoxResponse

    VERSIONS = {
      8 => {
        0 => "Exchange2007",
        1 => "Exchange2007_SP1",
        2 => "Exchange2007_SP1",
        3 => "Exchange2007_SP1",
      },
      14 => {
        0 => "Exchange2010",
        1 => "Exchange2010_SP1",
        2 => "Exchange2010_SP2",
        3 => "Exchange2010_SP2",
      },
      15 => {
        0 => "Exchange2013",
        1 => "Exchange2013_SP1",
      }
    }

    RESPONSE_SCHEMA = "http://schemas.microsoft.com/exchange/autodiscover/outlook/responseschema/2006a"

    attr_reader :xml

    def initialize(response)
      @xml = Nokogiri::XML(response)
    end

    def exchange_version
      hexver = xml.xpath("//s:ServerVersion", s: RESPONSE_SCHEMA)[0].text
      ServerVersionParser.new(hexver).exchange_version
    end

    def ews_url
      v = xml.xpath("//s:EwsUrl[../s:Type='EXPR']", s: RESPONSE_SCHEMA).text
      v.empty? ? nil : v
    end

  end
end
