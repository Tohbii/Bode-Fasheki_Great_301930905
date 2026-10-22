# Fashek Store — Normalisation and Constraints

## 1. Introduction

Normalisation is the process of organising database tables to reduce
unnecessary data duplication and prevent insertion, update, and deletion
anomalies.

For the Fashek clothing store database, normalisation helps ensure that
customer information, product details, orders, order items, and payments
are stored in appropriate tables.

The database design uses five main tables:
- CUSTOMERS
- ORDERS
- PRODUCTS
- ORDER_ITEMS
- PAYMENTS

## 2. First Normal Form (1NF)

A table satisfies First Normal Form when each field contains a single,
atomic value and there are no repeating groups.

Application to Fashek:
- Each customer record stores one customer's details.
- Each product record stores one product variant.
- Each order item represents one product line within an order.
- Multiple products in an order are stored as separate ORDER_ITEMS rows,
  rather than as a list in one field.

## 3. Second Normal Form (2NF)

A table satisfies Second Normal Form when it is in 1NF and every
non-key attribute depends on the whole of each candidate key, rather
than only part of a composite key.

Application to Fashek:
- The proposed tables use single-column primary keys.
- Non-key attributes are assigned to the tables describing the
  relevant entity.
- ORDER_ITEMS stores order-specific details such as quantity and
  unit_price alongside references to the order and product.

The functional dependencies and candidate keys should be reviewed
when implementing the schema to confirm formal 2NF compliance.

## 4. Third Normal Form (3NF)

A table satisfies Third Normal Form when it is in 2NF and non-key
attributes do not depend transitively on a candidate key.

Application to Fashek:
- Customer names, phone numbers, and email addresses are stored in
  CUSTOMERS rather than repeated in ORDERS.
- Product names and current catalogue prices are stored in PRODUCTS.
- Order dates and statuses are stored in ORDERS.
- Quantities and sale-time prices are stored in ORDER_ITEMS.
- Payment details are stored in PAYMENTS.

This separation reduces duplication and helps prevent inconsistent
updates. Formal 3NF compliance will be confirmed by checking the
functional dependencies in the implemented schema.

## 5. Planned Database Constraints

The PostgreSQL implementation will use:
- PRIMARY KEY constraints to uniquely identify records.
- FOREIGN KEY constraints to preserve relationships between tables.
- NOT NULL constraints for required fields.
- CHECK constraints to enforce valid prices, quantities, and statuses.
- UNIQUE constraints where the business requires unique values,
  such as customer email addresses when provided.

## 6. Design Decisions

- A customer can place multiple orders.
- An order can contain multiple order items.
- A product can appear in multiple order items.
- An order may have multiple payment records to support partial
  payments or separate payment attempts.
- ORDER_ITEMS.unit_price records the price charged at the time of sale,
  while PRODUCTS.price stores the current catalogue price.

These rules will be implemented and tested in PostgreSQL.