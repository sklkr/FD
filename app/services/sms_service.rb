class SmsService
 require 'net/http'

  def initialize(mobile, message, route= 4)
    @mobile = mobile
    @message = message
    @auth = '82791AzjPaCRC55378077'
    @sender_id = 'FIPAPA'
    @route = route
  end

  def send_sms
    begin
      # send the request
      uri = initiate_sms
      uri.query = URI.encode_www_form(attributes)
      resp, data = Net::HTTP.get_response(uri)
    rescue
      false
    end
  end

  def initiate_sms
     # get the url that we need to get to
    URI('http://api.msg91.com/api/sendhttp.php')
  end

  def attributes
    {
      mobiles: @mobile,
      message: @message,
      authkey: @auth, 
      sender: 'FIPAPA',
      route: @route,
    }
  end

end