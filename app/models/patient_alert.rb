class PatientAlert < ApplicationRecord
    belongs_to :pharmacy
    
    scope :resolved, -> { where(resolved: true) }
    scope :unresolved, -> { where.not(resolved: true) }
    scope :status_requests, -> { where(alert_type: "status") }
    scope :refill_requests, -> { where(alert_type: "refill") }
end
