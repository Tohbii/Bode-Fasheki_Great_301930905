# Fashek Store — Relational Schema

## 1. CUSTOMERS
CUSTOMERS(
    customer_id PK,
    full_name,
    phone,
    email
)

## 2. ORDERS
ORDERS(
    order_id PK,
    customer_id FK → CUSTOMERS.customer_id,
    order_date,
    status
)

## 3. PRODUCTS
PRODUCTS(
    product_id PK,
    product_name,
    size,
    colour,
    price
)

## 4. ORDER_ITEMS
ORDER_ITEMS(
    order_item_id PK,
    order_id FK → ORDERS.order_id,
    product_id FK → PRODUCTS.product_id,
    quantity,
    unit_price
)

## 5. PAYMENTS
PAYMENTS(
    payment_id PK,
    order_id FK → ORDERS.order_id,
    amount,
    payment_date,
    status
)

## Key Definitions

- PK (Primary Key): uniquely identifies each record in a table.
- FK (Foreign Key): references a primary key in another table.
- The foreign keys maintain relationships between customers, orders,
  products, order items, and payments.

## Design Notes

- A customer can place multiple orders.
- An order can contain multiple order items.
- A product can appear in multiple order items.
- An order can have multiple payment records, allowing for partial
  payments or payment attempts.
- The unit_price in ORDER_ITEMS records the price charged at the time
  of the sale, while PRODUCTS.price stores the current catalogue price.