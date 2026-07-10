select
    category_id,
    category_name
from {{ source('Local_Bike', 'categories') }}