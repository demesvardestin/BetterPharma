module ApplicationHelper
    def navbar
        if current_patient
            "layouts/patient_navbar"
        elsif current_pharmacy
            "layouts/pharmacy_navbar"
        else
            "layouts/base_navbar"
        end
    end
    
    def body
        if current_patient
            "layouts/patient_body"
        elsif current_pharmacy
            "layouts/pharmacy_body"
        else
            "layouts/base_body"
        end
    end
    
    def footer
        if current_patient || current_pharmacy
            "layouts/no_footer"
        else
            "layouts/footer"
        end
    end
    
    def is_active(nav)
        if request.original_url.include?(nav)
            "active"
        end
    end
    
    def path_info
        request.env['PATH_INFO']
    end
end
