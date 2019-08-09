module TwilioHandler
    ACCOUNT_SID = 'AC76546f466d979a5a36523904a37f90d2'
    AUTH_TOKEN = 'a92aa07b335906f598c7dd75ff875514'
    CLIENT = Twilio::REST::Client.new(ACCOUNT_SID, AUTH_TOKEN)
    
    def self.alert_mobile_client(alert)
        from = '+19143400580'
        to = '13473362973' # @alert.client_phone_number
        
        CLIENT.messages.create(
            from: from,
            to: to,
            body: alert.status
        )
    end
    
    def self.send_first_time_notification_to(client)
        ## Use Twilio to send text alert to mobile client, letting them know
        ## that they are now enrolled in BetterPharma's alert system
        puts "sending alert to client...done!"
    end
    
    def self.parse_twilio_text(text)
        type, rx = text.split(" ")
        
        if type != "status" || type != "refill"
            type_match = FuzzyMatch.new(['status', 'refill']).find(type)
            return type_match, rx
        end
        
        return type, rx
            
    end
end