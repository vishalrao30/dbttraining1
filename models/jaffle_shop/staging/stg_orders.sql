{{ config (materialized = 'incremental' , unique_key = 'order_id') }}
select
        id as order_id,
        user_id as customer_id,
        order_date,
        status,
        _ETL_LOADED_AT
    from raw.jaffle_shop.orders
{% if is_incremental() %}
  -- this filter will only be applied on an incremental run
  where _ETL_LOADED_AT >= (select max(_ETL_LOADED_AT) from {{ this }})
{% endif %}
