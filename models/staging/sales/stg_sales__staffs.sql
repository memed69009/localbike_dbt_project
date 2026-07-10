select
    staff_id,
    store_id,
    SAFE_CAST(manager_id AS INT64) as manager_id,
    first_name as staff_first_name,
    last_name as staff_last_name,
    email as staff_email,
    phone as staff_phone,
    active

from {{ source('Local_Bike', 'staffs') }}

