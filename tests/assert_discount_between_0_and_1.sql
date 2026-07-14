select *
from {{ ref('stg_sales__order_items') }}
where discount < 0 or discount > 1