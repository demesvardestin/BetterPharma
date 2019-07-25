# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

10.times.each do
    50.times.each do |t|
        i = rand(0..1)
        rx = rand(100000..999999)
        alert_types = ["status", "refill"]
        receipt_types = [true, false]
        
        PatientAlert.create(alert_type: alert_types[i], resolved: receipt_types[i], pharmacy_id: 1, evaluation_number: rx)
    end
    
    sleep 3
end
