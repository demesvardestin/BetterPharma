module PharmaciesHelper
    
    def alerts
        current_pharmacy.patient_alerts
    end
    
    def alerts_received
        alerts.count
    end
    
    def alerts_resolved
        alerts.resolved.count
    end
    
    def response_rate
        rate = (alerts_resolved.to_f/alerts_received * 100).round(2)
        if rate.nan?
            return "0.00%"
        end
        return rate.to_s
    end
    
    def responsiveness
        ## for each alert
        ## => time += subtract(time_responded, time_received)
        ## end
        ## return time/total_alerts
        time = 0
        alerts.each do |a|
            time += (a.updated_at - a.created_at).to_i
        end
        ((time.to_f/(alerts.size * 60))).round(2)
    end
    
end
