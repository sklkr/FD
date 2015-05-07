class PayuService
attr_reader :key, :txnid, :amount, :productinfo, :firstname, :email, :phone, :surl, :furl, :service_provider, :hash
  def initialize(order, current_user, success_url, failure_url)
    @order = order
    @key = Figaro.env.payu_key
    @txnid = @order.number
    @amount = @order.total_amount.to_f
    @productinfo = "FitnessPapa"
    @firstname = current_user.first_name || "Anonymous"

    @email = current_user.customer.email
    @phone = current_user.phone || "000"
    @surl = success_url
    @furl = failure_url
      
    @service_provider = 'payu_paisa'
    @hash = generate_hash
  end

  
  private
    def generate_hash
      fields = "#{@key}|#{@txnid}|#{@amount}|#{@productinfo}|#{@firstname}|#{@email}|||||||||||#{Figaro.env.payu_secret}"
      Digest::SHA2.new(512).hexdigest fields
    end

    def checksum(hash, fields)
      #{ }"hash" == Digest::SHA2.new(512).hexdigest fields
    end
end