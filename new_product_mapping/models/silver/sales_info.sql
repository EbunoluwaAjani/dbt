WITH sales as
(
    Select sales_id, product_sk,
    customer_sk, gross_amount,
    {{multiply('unit_price', 'quantity')}} as Price,
    payment_method
    from {{ref ("bronze_sales") }}
),

product as
(
    select product_sk, category
    from {{ref ("bronze_product") }}
),

customer as
(
    select customer_sk,
    gender
    from {{ref ("bronze_customer") }}
)

select sales.sales_id, sales.price,
product.product_sk, product.category,
    customer.customer_sk, customer.gender, sales.gross_amount
from sales
join product
    on sales.product_sk = product.product_sk
join customer
    on sales.customer_sk = customer.customer_sk
