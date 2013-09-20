class PaymentsController < ApplicationController
	include ActiveMerchant::Billing::Integrations
  	require 'active_merchant/billing/integrations/action_view_helper'
	ActionView::Base.send(:include, ActiveMerchant::Billing::Integrations::ActionViewHelper)

	def notify
    notify = Paypal::Notification.new(request.raw_post)

    location = Location.find(params[:invoice])

    if notify.acknowledge
        if notify.complete?
          @location = Location.find(notify.invoice)
          @location.is_subscribed_to_inventory = true
          @location.save
        else
          logger.error("Failed to verify Paypal's notification, please investigate")
        end
    else
    	logger.error("Paypal didn't acknowledge!")
    end

    render :nothing => true

  end

end