require 'paypal/recurring'

class PaymentNotificationsController < ApplicationController

	include PaymentNotificationsHelper
	include ActiveMerchant::Billing

	ActiveMerchant::Billing::Base.mode = :test

	protect_from_forgery :except => [:create]

	def create
		PaymentNotification.create!(:params => params, :location_id => params[:invoice], :status => params[:payment_status], :transaction_id => params[:txn_id])
		render :nothing => true
	end

	def checkout

		PayPal::Recurring.sandbox = true
		
		response = gateway.setup_purchase(2000, {
			:return_url => purchase_inventory_url(:id => @locid, :addons => true, :confirm_purchase => true),
			:cancel_return_url => locations_edit_url(:id => @locid, :addons => true, :cancel_purchase => true),
			:ipn_url => home_url,
			:description => 'Inventory Subscription',
			:amount => "20.00",
			:currency => "USD"
			})

		redirect_to gateway.redirect_url_for(response.token)

	end

	def purchase

		response = gateway.purchase(2000, {:token => params[:token], :payer_id => params[:PayerID], :frequency => '30', :period => 'MONTH', })

		if response.success?
			@location = Location.find(params[:id])
			@location.is_subscribed_to_inventory = true

			if @location.save
				redirect_to locations_edit_url(:id => params[:id], :addons => true, :confirm_purchase => true)
			else
				redirect_to oops_url # todo err_code to catch location not saving. need to email me? automatically?
			end
		else
			redirect_to oops_url(:err_code => 1) # todo err_code here too for something
		end

	end

	def notify

	end
	
end