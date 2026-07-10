select
    {{ dbt_utils.generate_surrogate_key([
        'store_id',
        'product_id'
    ]) }} as stock_id,
    store_id,
    product_id,
    quantity as stock_quantity

from {{ source('Local_Bike', 'stocks') }}