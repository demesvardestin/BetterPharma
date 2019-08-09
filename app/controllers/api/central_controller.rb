class Api::CentralController < ActionController::Base
    include TwilioHandler
    include AlertDelegator
    
    def twilio_trigger
        ## Handle TwilioHandler methods, then use Pusher to signal
        ## client-side flag to trigger push notification
        # case params[:trigger_type] # or whatever the parameter is
        # when "incoming"
        #     TwilioHandler.alert_desktop_client
        # end
        puts "reached twilio trigger, processing..."
        pharmacy = Pharmacy.first
        
        from = params[:From]
        req_type, rx = TwilioHandler.parse_twilio_text params[:Body]
        
        AlertDelegator::DesktopClient.send_alert(req_type, rx, 1, from)
        render :layout => false
    end
    
    def alert_mobile_client
        
    end
    
    def save_subscription
        data = params[:data]
        client_type = data[:clientType]
        subscription = JSON.parse data[:subscription]
        
        @mobile_client = if client_type == "desktop"
            @pharmacy = Pharmacy.find data[:pharmacy_id]
            @pharmacy.update(
                subscription_auth: subscription[:auth],
                subscription_p256dh: subscription[:p256dh],
                subscribed_to_push_notification: true
                )
            @pharmacy
        else
            create_mobile_client subscription
        end
        
        TwilioHandler.send_first_time_notification_to @mobile_client
    end
    
    private
    
    def create_mobile_client(subscription)
        return MobileClient.create(
            subscription_auth: subscription[:auth],
            subscription_p256dh: subscription[:p256dh],
            subscribed_to_push_notification: true
            )
    end
end