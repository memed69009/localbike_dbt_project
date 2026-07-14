

with sales as (

    select
        product_id,
        sum(item_quantity) as total_quantity_sold,
        sum(total_order_item_amount) as total_revenue,
        avg(discount) as avg_discount,
        avg(unit_price) as avg_unit_price_sold

    from {{ ref('int_sales__order_items_enriched') }}
    group by product_id

)

select
    p.product_id,
    p.product_name,
    p.brand_id,
    b.brand_name,
    p.category_id,
    ca.category_name,

    coalesce(s.total_quantity_sold, 0) as total_quantity_sold,
    coalesce(s.total_revenue, 0) as total_revenue,
    round(s.avg_discount, 4) as avg_discount,
    round(s.avg_unit_price_sold, 2) as avg_unit_price_sold

from {{ ref('stg_production__products') }} p 
left join {{ ref('stg_production__brands') }} b 
    on p.brand_id = b.brand_id
left join {{ ref('stg_production__categories') }} ca
    on p.category_id = ca.category_id
left join sales s 
    on p.product_id = s.product_id



