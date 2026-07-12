select
    -- clés / grain : une ligne = un produit vendu au sein d'une commande
    oi.order_item_id,
    oi.order_id,
    oi.product_id,

    -- infos commande
    o.customer_id,
    o.store_id,
    o.staff_id,
    o.order_status,
    o.order_date,

    -- infos magasin ( performance par magasin)
    s.store_name,
    s.store_city,
    s.store_state,

    -- infos produit (analyse produit)
    p.product_name,
    p.brand_id,
    b.brand_name,
    p.category_id,
    c.category_name,

    -- mesures (vente)
    oi.item_quantity,
    oi.unit_price,
    oi.discount,
    oi.total_order_item_amount

from  {{ ref('stg_sales__order_items') }} oi
left join  {{ ref('stg_sales__orders') }} o
    on oi.order_id = o.order_id
left join  {{ ref('stg_sales__stores') }} s
    on o.store_id = s.store_id
left join {{ ref('stg_production__products') }} p
    on oi.product_id = p.product_id
left join {{ ref('stg_production__brands') }} b
    on p.brand_id = b.brand_id
left join {{ ref('stg_production__categories') }} c
    on p.category_id = c.category_id
