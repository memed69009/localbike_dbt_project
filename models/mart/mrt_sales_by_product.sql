with sales_by_product as (

    select
        product_id,
        product_name,
        brand_id,
        brand_name,
        category_id,
        category_name,
        sum(item_quantity) as total_quantity_sold,
        sum(total_order_item_amount) as total_revenue,
        avg(discount) as avg_discount,
        avg(unit_price) as avg_unit_price_sold

    from {{ ref('int_sales__order_items_enriched') }}
    group by
        product_id, product_name,
        brand_id, brand_name,
        category_id, category_name
)

select
    product_id,
    product_name,
    brand_id,
    brand_name,
    category_id,
    category_name,
    total_quantity_sold,
    total_revenue,
    round(avg_discount, 4) as avg_discount,
    round(avg_unit_price_sold, 2) as avg_unit_price_sold

from sales_by_product