# Portfolio 4: NoSQL and Advanced Data Models

## 1. Introduction

This portfolio exercise explores the implementation of a NoSQL database using MongoDB for the Fashek Store application.

The purpose of the exercise was to understand how document-oriented databases store and manage data, implement basic database operations, and compare NoSQL data modelling approaches with the relational database structure previously developed using PostgreSQL.

The implementation uses MongoDB Atlas as the cloud database platform and MongoDB Shell (`mongosh`) to execute database commands.

### Objectives

The objectives of this exercise were to:

- Create and configure a MongoDB database and collections.
- Implement Create, Read, Update and Delete (CRUD) operations.
- Design documents using embedded and referenced data models.
- Retrieve related information using MongoDB's `$lookup` aggregation stage.
- Examine data duplication and consistency challenges.
- Compare MongoDB's document-oriented approach with PostgreSQL's relational model.

## 2. Database Setup and Configuration

MongoDB Atlas was selected as the cloud-hosted NoSQL database platform for this exercise.

The following configuration was used:

| Configuration | Details |
|---|---|
| Database platform | MongoDB Atlas |
| Cluster name | Cluster0 |
| Database version | MongoDB 8.0.34 |
| Cloud provider | Amazon Web Services (AWS) |
| Deployment | Single-region cluster |
| Database name | `fashek_store_nosql` |
| Collections | `orders`, `customers` |
| Database interface | MongoDB Shell (`mongosh`) |
| Shell version | 2.14.1 |
| Cluster tier | Free |

The database connection was established through MongoDB Shell. The `fashek_store_nosql` database was selected, and the required collections were created.

The `orders` collection stores order records, while the `customers` collection stores customer information separately for the referenced data model.

**Note:** MongoDB uses a flexible document structure, so documents within the same collection do not necessarily need identical fields.

Although MongoDB supports flexible document structures, schema validation rules can be configured to enforce data types and required fields where necessary.

## 3. Document Structure and Implementation

The Fashek Store database was designed using MongoDB's document-oriented data model. Two collections were implemented: `orders` and `customers`.

### 3.1 Orders Collection

The `orders` collection stores individual customer orders. Each document contains order information, including the order ID, customer information or reference, purchased items, total amount, order status and date.

Two different modelling approaches were implemented.

**Embedded Document Model**

The first order (order ID: 101) used an embedded document structure. Customer information and purchased items were stored directly inside the order document.

The structure included:

- Order ID: 101
- Customer name: Tobi
- Customer email: tobi@example.com
- Product: Vintage Shirt
- Quantity: 2
- Unit price: ₦15,000
- Total amount: ₦30,000
- Status: shipped

This approach allows related order information to be retrieved together without requiring a separate lookup operation.

**Referenced Document Model**

The second order (order ID: 102) used a referenced document structure. Instead of embedding customer information, the order stored the customer's unique MongoDB ObjectId in a field called `customer_id`.

The customer's name, email and phone number were maintained separately in the `customers` collection.

This approach reduces unnecessary duplication when customer information is shared across multiple orders.

## 4. CRUD Operations

CRUD operations represent the four fundamental operations used to manage records in a database: Create, Read, Update and Delete.

The following operations were implemented and tested using MongoDB Shell.

### 4.1 Create

The `insertOne()` method was used to insert documents into the `orders` and `customers` collections.

An embedded order document was inserted into the `orders` collection, while a separate customer document was inserted into the `customers` collection.

### 4.2 Read

The `find()` and `findOne()` methods were used to retrieve documents.

The `find()` method retrieved documents matching a specified condition, while `findOne()` returned a single matching document.

A filtering operation was also performed to retrieve orders with a specific status using:

`db.orders.find({ status: "paid" })`

### 4.3 Update

The `updateOne()` method was used to modify existing documents.

The status of order 101 was changed from `paid` to `shipped`. Customer information was also updated by changing the email address from `tobi@example.com` to `great@example.com`.

The update results confirmed that the targeted documents were successfully modified.

### 4.4 Delete

The `deleteOne()` method was used to demonstrate document deletion.

A temporary test order with order ID 999 was created and subsequently deleted. A verification query returned `null`, confirming that the document was no longer present.

These experiments demonstrated the successful implementation of the four basic MongoDB CRUD operations.

## 5. Embedding and Referencing

MongoDB supports different approaches to modelling relationships between data. Two approaches explored in this exercise were embedding and referencing.

### 5.1 Embedded Documents

Embedding involves storing related information directly inside a parent document.

In this implementation, order 101 contained the customer's name and email, as well as the purchased product details.

**Advantages:**
- Related information can be retrieved in a single document query.
- Reduces the need for additional lookup operations.
- Suitable for data that is frequently accessed together.

**Disadvantages:**
- Can lead to data duplication when the same information is embedded in multiple documents.
- Changes to duplicated information may require updates to several documents.
- Can increase document size.

### 5.2 Referenced Documents

Referencing involves storing related information separately and connecting documents using unique identifiers.

In this implementation, order 102 stored the customer's ObjectId in the `customer_id` field. The customer's personal information was maintained in the separate `customers` collection.

**Advantages:**
- Reduces duplication of shared customer information.
- Makes independent updates to customer records easier.
- Supports reusable customer records across multiple orders.

**Disadvantages:**
- Retrieving related information may require additional queries or aggregation operations.
- Requires careful management of references because MongoDB does not automatically enforce foreign-key constraints.

### 5.3 Aggregation Using `$lookup`

The `$lookup` aggregation stage was implemented to retrieve customer information associated with order 102.

The operation matched the order's `customer_id` field with the customer's `_id` field in the `customers` collection.

The resulting document contained a `customer_details` array with the matching customer information.

### 5.4 Data Consistency Experiment

To examine the benefits of referencing, the customer's email address was changed from `tobi@example.com` to `great@example.com` in the `customers` collection.

The aggregation query was executed again, and the updated email address appeared in the retrieved order information without modifying the order document.

This demonstrated how referencing can reduce update anomalies when customer information is shared across multiple orders.

## 6. Comparison Between PostgreSQL and MongoDB

PostgreSQL and MongoDB use different data models and approaches to storing and managing information.

PostgreSQL is a relational database management system that stores data in structured tables, while MongoDB is a document-oriented NoSQL database that stores data in flexible BSON documents.

The following comparison is based on the Fashek Store implementations.

| Feature | PostgreSQL | MongoDB |
|---|---|---|
| Data model | Relational | Document-oriented |
| Data storage | Tables and rows | Collections and documents |
| Schema | Structured schema | Flexible document schema |
| Relationships | Primary and foreign keys | Embedding and referencing |
| Related data retrieval | SQL JOIN operations | `$lookup` aggregation or separate queries |
| Data integrity | Supports foreign-key constraints | References are not automatically enforced as foreign keys |
| Query language | SQL | MongoDB Query API |
| Typical use case | Structured relational data | Flexible and document-oriented data |

### 6.1 Observations

In the PostgreSQL implementation, customer, order, product, order item and payment information were stored in separate related tables. Primary keys and foreign keys maintained relationships between the records.

In the MongoDB implementation, related information could be embedded within a single order document or maintained separately using references.

The embedded approach simplified retrieval of complete order information, while the referenced approach reduced duplication of customer information.

### 6.2 Design Considerations

Neither database model is universally better than the other.

PostgreSQL is suitable when structured relationships, referential integrity and complex relational queries are important.

MongoDB is useful when flexible document structures and retrieving related information together are important.

The choice between them depends on application requirements, data relationships, consistency needs and expected query patterns.
## 7. Results and Discussion

The MongoDB implementation was successfully completed using MongoDB Atlas and MongoDB Shell.

The following results were achieved:

1. Successfully connected to the MongoDB Atlas cluster.
2. Created the `fashek_store_nosql` database with `orders` and `customers` collections.
3. Inserted and retrieved documents using MongoDB Shell.
4. Successfully implemented Create, Read, Update and Delete operations.
5. Implemented both embedded and referenced document structures.
6. Retrieved related customer information using the `$lookup` aggregation stage.
7. Demonstrated how referencing supports updates to shared customer information without modifying individual order documents.

The experiments provided practical experience with document-oriented database design and demonstrated the advantages and limitations of different data-modelling approaches.

## 8. Conclusion

This exercise provided practical experience in implementing a NoSQL database using MongoDB.

The implementation demonstrated how MongoDB stores information in flexible documents and supports CRUD operations, embedded documents, referenced documents and aggregation queries.

Comparing the MongoDB implementation with the PostgreSQL relational database developed in previous portfolio exercises provided a clearer understanding of the differences between relational and document-oriented database systems.

The exercise also demonstrated that database design decisions should consider data relationships, duplication, consistency, query requirements and application needs.

Overall, the exercise improved practical understanding of NoSQL database implementation and the application of advanced data-modelling concepts.