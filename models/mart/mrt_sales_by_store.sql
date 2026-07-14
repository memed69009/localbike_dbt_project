with sales_by_store_month as (

    select
        store_id,
        store_name,
        store_city,
        store_state,
        date_trunc(order_date, month) as order_month,
        count(distinct order_id) as total_orders,
        sum(total_order_item_amount) as total_revenue

    from {{ ref('int_sales__order_items_enriched') }}
    group by store_id, store_name, store_city, store_state, order_month

)

select
    store_id,
    store_name,
    store_city,
    store_state,
    order_month,
    total_orders,
    total_revenue,
    round(total_revenue / nullif(total_orders, 0), 2) as avg_order_value

from sales_by_store_month
