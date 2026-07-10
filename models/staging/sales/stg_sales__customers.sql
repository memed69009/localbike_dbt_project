select 
    customer_id,
    first_name as customer_first_name,
    last_name as customer_last_name,
    phone as customer_phone,
    email as customer_email,
    street as customer_adress,
    city as customer_city,
    state as customer_state,
    zip_code as customer_zip_code
from {{ source('Local_Bike', 'customers') }}

