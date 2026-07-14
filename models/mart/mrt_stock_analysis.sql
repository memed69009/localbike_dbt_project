select
        store_id,
        product_id,
        stock_quantity,
        total_quantity_sold,

        -- ratio simple : combien de fois le stock actuel a été tourné par les ventes passées (turnover ratio)
        round(
            safe_divide(total_quantity_sold, nullif(stock_quantity, 0)), 2
        ) as sales_to_stock_ratio,

        -- alerte rupture : plus de stock disponible alors qu'il y a eu de la demande
        case
            when stock_quantity = 0 and total_quantity_sold > 0 then true
            else false
        end as is_stockout_risk

    from {{ ref('int_production__stocks_vs_sales') }}
