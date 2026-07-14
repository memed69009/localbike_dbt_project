with customer_orders as (

    select
        customer_id,
        count(distinct order_id) as total_orders,
        sum(total_order_item_amount) as total_revenue,
        min(order_date) as first_order_date,
        max(order_date) as last_order_date

    from {{ ref('int_sales__order_items_enriched') }}
    group by customer_id

) 

select
    c.customer_id, 
    c.customer_first_name,
    c.customer_last_name,
    c.customer_city,
    c.customer_state,
    coalesce(co.total_orders, 0) as total_orders,
    coalesce(co.total_revenue, 0) as total_revenue,
    round(
        safe_divide(co.total_revenue, nullif(co.total_orders, 0)), 2
    ) as avg_order_value,
    co.first_order_date,
    co.last_order_date,

    -- segmentation simple basée sur le nombre de commandes
    case
        when coalesce(co.total_orders, 0) = 0 then 'no_purchase'
        when co.total_orders = 1 then 'one_time'
        when co.total_orders between 2 and 4 then 'recurring'
        else 'loyal'
    end as customer_segment

from {{ ref('stg_sales__customers') }} as c
left join customer_orders as co
    on c.customer_id = co.customer_id