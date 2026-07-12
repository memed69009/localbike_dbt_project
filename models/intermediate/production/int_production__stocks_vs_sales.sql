with sales as (

    select
        store_id,
        product_id,
        sum(item_quantity) as total_quantity_sold
    from {{ ref('int_sales__order_items_enriched') }}
    group by store_id, product_id

),

final as (

    select
        {{ dbt_utils.generate_surrogate_key(['st.store_id', 'st.product_id']) }} as stock_sales_id,
        st.store_id,
        st.product_id,
        st.stock_quantity,
        coalesce(sales.total_quantity_sold, 0) as total_quantity_sold

    from {{ref('stg_production__stocks')}} st
    left join sales
        on st.store_id = sales.store_id
        and st.product_id = sales.product_id

)

select * from final