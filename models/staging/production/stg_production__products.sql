select
    product_id,
    product_name,
    brand_id,
    category_id,
    model_year,
    list_price as unit_price

from {{ source('Local_Bike', 'products') }}