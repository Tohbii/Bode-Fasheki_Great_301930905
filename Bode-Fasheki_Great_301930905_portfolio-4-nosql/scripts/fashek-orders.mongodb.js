
// =====================================================
// FASHEK STORE — MONGODB NOSQL IMPLEMENTATION
// Portfolio 4: NoSQL and Advanced Data Models
// Database: fashek_store_nosql
// =====================================================

use("fashek_store_nosql");

// STEP 1: Create collections if they do not exist
if (!db.getCollectionNames().includes("orders")) {
    db.createCollection("orders");
}

if (!db.getCollectionNames().includes("customers")) {
    db.createCollection("customers");
}

// STEP 2: Insert an embedded order document
// Customer information is stored inside the order.

db.orders.updateOne(
    { order_id: 101 },
    {
        $setOnInsert: {
            customer: {
                name: "Tobi",
                email: "tobi@example.com"
            },
            items: [
                {
                    product: "Vintage Shirt",
                    quantity: 2,
                    unit_price: 15000
                }
            ],
            total_amount: 30000,
            status: "shipped",
            order_date: new Date()
        }
    },
    { upsert: true }
);

// STEP 3: Create a separate customer document
// The customer has a stable, explicitly assigned _id.

const customerId = ObjectId("6ae489580ab334d8bc7ea903");

db.customers.updateOne(
    { _id: customerId },
    {
        $set: {
            name: "Tobi",
            email: "great@example.com",
            phone: "08012345678"
        }
    },
    { upsert: true }
);

// STEP 4: Insert an order referencing the customer

db.orders.updateOne(
    { order_id: 102 },
    {
        $setOnInsert: {
            customer_id: customerId,
            items: [
                {
                    product: "Native Shirt",
                    quantity: 1,
                    unit_price: 25000
                }
            ],
            total_amount: 25000,
            status: "paid",
            order_date: new Date()
        }
    },
    { upsert: true }
);

// STEP 5: Read and filter documents

db.orders.find();
db.orders.findOne({ order_id: 101 });
db.orders.find({ status: "shipped" });

// STEP 6: Retrieve an order with its customer details
// $lookup performs a join-like aggregation.

db.orders.aggregate([
    { $match: { order_id: 102 } },
    {
        $lookup: {
            from: "customers",
            localField: "customer_id",
            foreignField: "_id",
            as: "customer_details"
        }
    }
]);

// STEP 7: Update an order

db.orders.updateOne(
    { order_id: 101 },
    { $set: { status: "shipped" } }
);

// STEP 8: Update customer information

db.customers.updateOne(
    { _id: customerId },
    { $set: { email: "great@example.com" } }
);

// STEP 9: Demonstrate deletion using a temporary document

db.orders.updateOne(
    { order_id: 999 },
    {
        $setOnInsert: {
            customer: { name: "Test Customer" },
            status: "test"
        }
    },
    { upsert: true }
);

db.orders.deleteOne({ order_id: 999 });

// STEP 10: Verify final records

db.orders.find();
db.customers.find();
