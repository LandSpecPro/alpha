module PaypalHelper

	include ActiveMerchant::Billing

	private
	def gateway
		@gateway ||= PaypalExpressGateway.new(
			:login => ENV['PAYPAL_LOGIN'],
			:password => ENV['PAYPAL_PASSWORD'],
			:signature => ENV['PAYPAL_SIGNATURE']
		)
	end


end