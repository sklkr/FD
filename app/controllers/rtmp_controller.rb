class RtmpController < ApplicationController
  def index
   parsed_uri = URI.parse('http://dkv8md9go69g2.cloudfront.net') 
   url = "#{parsed_uri.scheme}://#{parsed_uri.host}#{parsed_uri.path}/nghia.mp4"   
   @video_path = sign(url)
   @flash_path = signed_flash
  end

  def signed_flash
   rtmp_url = "rtmp://s2kj5stk8cuu5x.cloudfront.net"
   rtmp_path = sign("/nghia.mp4")
   full_url = "#{rtmp_url}#{rtmp_path}"
  end  


  def sign(url="")
    # 1 hour expiration on the URL
    url = SIGNER.sign(url.to_s, :ending => Time.now + 100)
  end
end
