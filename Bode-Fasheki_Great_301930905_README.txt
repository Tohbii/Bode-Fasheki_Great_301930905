# MIT 8103 - Advanced Database Systems

## Project Overview

This repository contains my practical portfolio for the MIT 8103 Advanced Database Systems course at Miva Open University.

The portfolio demonstrates practical knowledge of relational database design, query processing and optimisation, transaction management, NoSQL data modelling, and distributed and cloud database systems.

## Case Study: Fashek Store

Fashek Store is a retail business used as the consistent case study across all five portfolio components.

The database models customers, products, orders, order items, and payments. This case study provides a practical context for exploring relational database design, data integrity, query performance, transaction processing, document databases, and distributed database architecture.

## Portfolio Components

1. **Portfolio 1 - Database Design and Modelling:** Relational schema design, entity-relationship modelling, normalisation, constraints, and PostgreSQL implementation.

2. **Portfolio 2 - Query Processing and Optimisation:** Query execution plans, indexing experiments, sequential scans, and performance analysis using PostgreSQL.

3. **Portfolio 3 - Transactions and Concurrency:** Transaction control, COMMIT, ROLLBACK, READ COMMITTED, REPEATABLE READ, and concurrency experiments.

4. **Portfolio 4 - NoSQL and Advanced Data Models:** MongoDB document modelling, CRUD operations, embedded and referenced documents, and aggregation using `$lookup`.

5. **Portfolio 5 - Distributed and Cloud Database Exercise:** MongoDB Atlas deployment, replica set inspection, replication verification, read and write concerns, consistency, availability, and conceptual sharding analysis.

## Technologies and Tools

- PostgreSQL 18
- pgAdmin 4
- MongoDB 8.0
- MongoDB Atlas
- MongoDB Shell (mongosh)
- Visual Studio Code
- Git and GitHub

## Project Progress

- [x] GitHub repository created and configured
- [x] PostgreSQL environment configured
- [x] Portfolio 1: Database Design and Modelling
- [x] Portfolio 2: Query Processing and Optimisation
- [x] Portfolio 3: Transactions and Concurrency
- [x] Portfolio 4: NoSQL and Advanced Data Models
- [x] Portfolio 5: Distributed and Cloud Database Exercise
- [ ] Final documentation, reflection, and submission report

## Repository Structure

```text
advanced-database-portfolio/
|
|-- portfolio-1-database-design/
|   |-- sql/
|   |-- Evidence/
|
|-- portfolio-2-query-optimisation/
|   |-- sql/
|   |-- Evidence/
|
|-- portfolio-3-transactions-concurrency/
|   |-- sql/
|   |-- Evidence/
|
|-- portfolio-4-nosql/
|   |-- scripts/
|   |-- documentation/
|   |-- Evidence/
|
|-- portfolio-5-distributed-cloud/
|   |-- scripts/
|   |-- documentation/
|   |-- evidence/
|
|-- README.md
```

## Implementation Scope and Limitations

- PostgreSQL was used for relational database implementation, query optimisation, and transaction experiments.
- MongoDB Atlas was used for cloud-hosted document database implementation and replica set exploration.
- Replication and consistency behaviour were examined through database operations and verification scripts.
- Sharding was explored conceptually; 