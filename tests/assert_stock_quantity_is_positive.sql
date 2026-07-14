select *
from {{ ref('mrt_stock_analysis') }}
where stock_quantity < 0