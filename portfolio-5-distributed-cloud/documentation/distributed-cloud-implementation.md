# Portfolio 5: Distributed and Cloud Database Implementation

## 1. Introduction

This portfolio explores distributed database concepts using the Fashek Store case study. The implementation uses MongoDB Atlas, a cloud-hosted MongoDB database service, to examine replication, consistency, availability, and deployment.

The practical work focuses on inspecting a replica set, testing read preferences, applying majority write and read concerns, and enforcing data integrity through a unique index. Sharding is also examined conceptually, with a proposed design based on the application's order-management workload.

## 2. Objectives

The objectives of this portfolio are to:

1. Deploy and connect to a cloud-hosted MongoDB database using MongoDB Atlas.
2. Examine replica-set topology and understand primary and secondary members.
3. Test read preferences and majority write/read concerns.
4. Understand how replication supports database availability and fault tolerance.
5. Evaluate sharding and propose a suitable shard key for Fashek Store.
6. Document practical results, limitations, and lessons learned.

## 3. Cloud Database Deployment

### 3.1 MongoDB Atlas Setup

MongoDB Atlas was used to host the Fashek Store NoSQL database in the cloud. A free M0 cluster named `Cluster0` was configured, and the database was accessed through the MongoDB Shell (`mongosh`).

The database used for this exercise was:

- **Database:** `fashek_store_nosql`
- **Collection:** `orders`
- **Cloud platform:** MongoDB Atlas
- **Cluster tier:** M0 Free
- **MongoDB server version:** 8.0.36 (as reported by mongosh during the Portfolio 5 session)
- **MongoDB Shell version:** 2.14.1

The successful shell connection confirmed that the cloud-hosted database was accessible.

### 3.2 Deployment Verification

The deployment was verified by connecting to the Atlas cluster through `mongosh` and accessing the existing `fashek_store_nosql` database. Existing order records from Portfolio 4 were retained, and additional test orders were used for the distributed database experiments.

## 4. Database Replication

### 4.1 Replica-Set Configuration

MongoDB Atlas uses replication to maintain multiple copies of data across replica-set members. The replica-set status was inspected using:

```javascript
rs.status()
```

The output identified a replica set named `atlas-c2v44d-shard-0`, containing three healthy voting members:

| Member | State | Health |
|---|---|---|
| Member 0 | SECONDARY | 1 |
| Member 1 | SECONDARY | 1 |
| Member 2 | PRIMARY | 1 |

The output also reported:

- `votingMembersCount: 3`
- `writeMajorityCount: 2`
- `majorityVoteCount: 2`

This confirms that the inspected replica set had one primary and two secondary members. All three members reported healthy status.


### 4.2 How Replication Works

The primary member accepts write operations and records changes in its operation log. Secondary members replicate those changes and maintain copies of the database.

If the primary becomes unavailable, eligible secondary members can participate in an election to select a new primary, provided the voting majority is available.

Replication improves availability and fault tolerance, although an election can temporarily interrupt write operations.

### 4.3 Replication Test

A test order with `order_id: 503` was inserted into the `orders` collection using majority write concern.

The document was then queried using secondary-preferred and primary read preferences. Both queries returned the same retained order document.

This demonstrated successful reads through the configured read preferences. The output did not identify which specific secondary member served the secondary-preferred read.

# Evidence
01-replica-set-status.png 
02-replication-test-order-inserted.png
03-secondary-read-test.png
04-primary-read-test.png 



## 5. Consistency and Data Integrity

### 5.1 Majority Write Concern

Majority write concern was tested when inserting documents into the `orders` collection.

The test used:

```javascript
{ writeConcern: { w: "majority", wtimeout: 5000 } }
```

This setting requires the write to be acknowledged by a majority of voting replica-set members before MongoDB reports success. The `wtimeout` value specifies a maximum wait of 5,000 milliseconds for the requested acknowledgement. A timeout does not necessarily mean the write was rolled back.

### 5.2 Majority Read Concern

Majority read concern was tested using:

```javascript
db.orders.find(
  { order_id: 503 }
).readConcern("majority")
```

The query returned the retained order document.

Majority read concern ensures that returned data reflects writes acknowledged by a majority of voting members. It helps prevent reading data that could later be rolled back, although it does not guarantee that a read always returns the newest possible data.

### 5.3 Unique Index and Data Integrity

During testing, the same business order ID was inserted more than once because the test insertion command was executed multiple times.

The duplicate records were identified and removed, leaving one document with `order_id: 503`.

To prevent the same issue in future operations, a unique index was created:

```javascript
db.orders.createIndex(
  { order_id: 1 },
  { unique: true }
)
```

The index was verified using:

```javascript
db.orders.getIndexes()
```

The output confirmed the existence of the unique `order_id_1` index.

This experiment demonstrated that MongoDB's default uniqueness constraint applies to the `_id` field, while a separate unique index is required to enforce uniqueness on a custom business identifier.

#   Evidence
05-majority-write-concern.png
06-majority-read-concern.png
07-order-id-unique-index.png

## 6. Availability and Fault Tolerance

### 6.1 Automatic Failover

MongoDB replica sets support automatic failover. If the primary member becomes unavailable, the remaining eligible voting members can hold an election to select a new primary.

In the inspected Atlas replica set, there were three voting members, with a majority requiring two votes. Therefore, the two remaining members can form a voting majority if one member becomes unavailable.

During an election, write operations may be temporarily interrupted until a new primary is elected.

### 6.2 Availability Benefits

The replica-set architecture provides the following benefits:

- **Fault tolerance:** Multiple members maintain copies of the database.
- **Automatic elections:** Eligible members can elect a replacement primary when necessary.
- **Read availability:** Applications configured with suitable read preferences may continue reading from available secondary members.
- **Data protection:** Majority write concern helps ensure that acknowledged writes are replicated to a majority of voting members.

### 6.3 Practical Limitation

The replica-set configuration was inspected through `rs.status()`. A manual failure or forced election was not performed during this exercise.

Therefore, automatic failover was studied based on the observed replica-set configuration and MongoDB's election mechanism, rather than demonstrated through a controlled failure test.

# Evidence
01-replica-set-status.png — Shows the three healthy voting members and current primary.


## 7. Sharding and Distributed Data Design

### 7.1 Understanding Sharding

Sharding is a database architecture that distributes data across multiple servers called shards. Unlike replication, which maintains copies of the same data across replica-set members, sharding partitions data across multiple shards.

A sharded MongoDB deployment typically uses:

- **Shards:** Store portions of the database.
- **Mongos router:** Directs application queries to the appropriate shards.
- **Config servers:** Store metadata about the sharded cluster.

### 7.2 Proposed Sharding Design for Fashek Store

As Fashek Store grows, its order collection could become large enough to benefit from distributing data across multiple shards.

A possible shard key for the order workload is a hashed `customer_id` field.

This choice is based on the expected workload, where customers frequently retrieve their order histories. Hashing the customer identifier can distribute customers across shards and reduce the risk of concentrating all writes on a narrow range of sequential identifiers.

However, hashed sharding has trade-offs. Queries that do not include `customer_id` may need to access multiple shards, and the distribution and query patterns should be evaluated before deployment.

### 7.3 Replication Versus Sharding

| Feature | Replication | Sharding |
|---|---|---|
| Main purpose | Availability and redundancy | Horizontal scalability |
| Data arrangement | Copies of data across members | Data partitions across shards |
| Main benefit | Fault tolerance | Distributes storage and workload |
| Example | Primary and secondary members | Multiple shards storing different data |

### 7.4 Implementation Limitation

The Fashek Store deployment used MongoDB Atlas M0 Free, and the inspected cluster was a replica set rather than a sharded cluster.

Sharding was therefore discussed as a proposed architecture and was not configured or tested practically in this portfolio.


## 8. Results and Discussion

The practical exercise demonstrated how MongoDB Atlas supports cloud database deployment and distributed database capabilities.

The replica-set inspection confirmed three healthy voting members, consisting of one primary and two secondary members. Read-preference tests successfully retrieved the retained test order through primary and secondary-preferred reads.

Majority write concern and majority read concern were also tested. These settings demonstrated how MongoDB can improve write acknowledgement reliability and protect reads from data that has not been committed by a voting majority.

The duplicate order-ID issue identified during testing highlighted the importance of enforcing business-level data integrity. Creating a unique index on `order_id` provided an additional constraint to prevent duplicate business identifiers.

Sharding was evaluated conceptually, with a hashed `customer_id` proposed for distributing customer order data. However, the M0 deployment did not include a configured sharded cluster, and no manual failover test was performed.

## 9. Challenges and Limitations

The exercise involved some practical challenges:

1. **Connection issues:** Initial MongoDB Atlas connection attempts encountered connection and authentication errors before a successful shell connection was established.
2. **Duplicate test records:** Repeated execution of an insertion command created duplicate business order IDs. These records were identified and cleaned up before creating a unique index.
3. **Free-tier limitations:** The M0 deployment was used to inspect replica-set behaviour, but sharding was not configured.
4. **Failover testing:** Automatic failover was studied through replica-set configuration and election concepts, but no controlled failure was performed.

These limitations helped distinguish between features that were practically tested and those that were evaluated conceptually.

## 10. Conclusion

This portfolio demonstrated the practical use of MongoDB Atlas for cloud database deployment, replication inspection, consistency testing, and data integrity enforcement.

The experiments improved my understanding of replica sets, read preferences, write concerns, read concerns, automatic elections, and sharding architecture.

The exercise also showed that distributed database design requires more than selecting a database platform. It requires understanding application workloads, availability requirements, consistency expectations, and the trade-offs associated with distributing data across multiple servers.

## 11. Verification Script

A MongoDB Shell verification script named `replication-consistency-verification.mongodb.js` was created in the `scripts/` directory.

The script automates the verification of:

1. Replica-set status and member health.
2. Secondary-preferred reads.
3. Primary reads.
4. Majority read concern.
5. Collection indexes.
6. Duplicate order-ID detection.

The script was executed successfully against the MongoDB Atlas deployment using `mongosh`. All six verification sections completed without errors.

The final duplicate check returned an empty result, confirming that no duplicate `order_id` values remained in the collection. The index inspection also confirmed that the unique index on `order_id` was active.

The script provides a repeatable way to inspect the database configuration and verify the consistency-related tests without inserting or deleting records.

