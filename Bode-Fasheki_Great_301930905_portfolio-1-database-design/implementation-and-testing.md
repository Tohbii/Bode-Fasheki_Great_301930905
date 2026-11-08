# Fashek Store — Database Implementation and Testing

## 1. Implementation Environment

- **DBMS:** PostgreSQL 18
- **Database:** `fashek_store`
- **Administration tool:** pgAdmin 4
- **Schema:** `public`

## 2. Tables Implemented

Five relational tables were created:

1. `customers`
2. `products`
3. `orders`
4. `order_items`
5. `payments`

Primary keys uniquely identify records, while foreign keys establish relationships between related tables.

## 3. Sample Data and Query Testing

Sample records were inserted for three customers and three products. Two orders were created for one customer, followed by an order item and a payment record.

A JOIN query was executed to retrieve the customer name, product name, quantity, unit price and calculated item total for an order.

## 4. Integrity Constraint Testing

### Test 1: Foreign-Key Constraint

**Test:** Attempted to insert an order referencing customer ID `9999`.

**Expected result:** PostgreSQL rejects the insertion if the customer does not exist.

**Observed result:** The insertion was rejected, and a follow-up query confirmed that the invalid order was not inserted.

### Test 2: CHECK Constraint

**Test:** Attempted to insert a product with a price of zero.

**Expected result:** PostgreSQL rejects the insertion because product prices must be greater than zero.

**Observed result:** The insertion was rejected, and a follow-up query confirmed that the invalid product was not inserted.

## 5. Conclusion

The implementation demonstrates relational database design, table creation, sample-data insertion, JOIN queries, referential integrity and CHECK constraint enforcement.

Screenshots of query results and constraint violations will provide additional evidence of the practical work.