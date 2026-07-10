select 
    {{ dbt_utils.generate_surrogate_key([
        'order_id',
        'item_id',
        'product_id'
    ]) }} as order_item_id,
    order_id,
    item_id,
    product_id,
    quantity as item_quantity,
    list_price as unit_price,
    discount,
    (quantity*list_price) - ( quantity*list_price*discount) as total_order_item_amount
from {{ source('Local_Bike', 'order_items') }}
