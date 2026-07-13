select *
from {{ ref('mrt_sales_by_store') }}
where total_revenue < 0