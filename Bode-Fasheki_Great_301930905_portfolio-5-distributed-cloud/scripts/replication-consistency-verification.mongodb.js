
// Portfolio 5: Distributed and Cloud Database
// Fashek Store — Replication and Consistency Verification

// Confirm the database
use("fashek_store_nosql");

print("\n1. REPLICA SET STATUS");
printjson(rs.status());

print("\n2. SECONDARY-PREFERRED READ");
db.getMongo().setReadPref("secondary");
printjson(db.orders.findOne({ order_id: 503 }));

print("\n3. PRIMARY READ");
db.getMongo().setReadPref("primary");
printjson(db.orders.findOne({ order_id: 503 }));

print("\n4. MAJORITY READ CONCERN");
printjson(
  db.orders.find({ order_id: 503 })
    .readConcern("majority")
    .toArray()
);

print("\n5. ORDER COLLECTION INDEXES");
printjson(db.orders.getIndexes());

print("\n6. ORDER ID DUPLICATE CHECK");
printjson(
  db.orders.aggregate([
    {
      $group: {
        _id: "$order_id",
        count: { $sum: 1 }
      }
    },
    {
      $match: {
        count: { $gt: 1 }
      }
    }
  ]).toArray()
);

print("\nVERIFICATION COMPLETED");
