$ ->
  $('.edit_reseller').validate
    rules:
      'reseller[tax_id]':
        required: true
      'reseller[name]':
        required: true
      'reseller[business_name]':
        required: true
      'reseller[delivery_address_attributes][first_name]':
        required: true
      'reseller[delivery_address_attributes][last_name]':
        required: true
      'reseller[delivery_address_attributes][city]':
        required: true
      'reseller[delivery_address_attributes][state_id]':
        required: true
