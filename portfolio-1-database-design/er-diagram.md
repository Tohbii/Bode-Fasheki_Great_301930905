# Fashek Store — ER Diagram

```mermaid
erDiagram
    CUSTOMERS ||--o{ ORDERS : places
    ORDERS ||--o{ ORDER_ITEMS : contains
    PRODUCTS ||--o{ ORDER_ITEMS : includes
    ORDERS ||--o{ PAYMENTS : receives

    CUSTOMERS {
        int customer_id PK
        string full_name
        string phone
        string email
    }

    ORDERS {
        int order_id PK
        int customer_id FK
        date order_date
        string status
    }

    PRODUCTS {
        int product_id PK
        string product_name
        string size
        string colour
        decimal price
    }

    ORDER_ITEMS {
        int order_item_id PK
        int order_id FK
        int product_id FK
        int quantity
        decimal unit_price
    }

    PAYMENTS {
        int payment_id PK
        int order_id FK
        decimal amount
        date payment_date
        string status
    }
```