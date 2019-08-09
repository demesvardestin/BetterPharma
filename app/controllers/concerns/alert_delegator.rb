module AlertDelegator
    class Request
        def self.generate_new_request(type, rx, pharma_id, from)
            @alert = PatientAlert.create(alert_type: type, pharmacy_id: pharma_id, evaluation_number: rx)
        end
    end
    
    class DesktopClient
        def self.send_alert(type, rx, pharma_id, from)
            puts "reached pusher..."
            Pusher.trigger('sms-stream', 'desktop-alert', {
                type: type,
                rx: rx,
                receiverID: pharmacy.id,
                from: from
            })
        end
    end
end