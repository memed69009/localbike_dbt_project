select 
    order_id,
    customer_id,
    store_id,
    staff_id,
    order_status, 
    order_date,
    required_date as estimated_shipping_date,
    SAFE_CAST(shipped_date AS DATE) as shipped_date

from {{ source('Local_Bike', 'orders') }}