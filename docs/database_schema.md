# 🧩 Database Schema

This document outlines the database schemas used in the **Advanced SQL Querying & Optimization** university project. The project utilizes both real-world sample databases and a custom-created one for advanced querying and analysis.

---

## 📦 Databases Used

1. **AdventureWorks2017**
2. **Northwind**
3. **Pubs**
4. **Custom Database** (`OrdersManagementDB`)

---

## 📁 Schema Overview

### 🏭 AdventureWorks2017

AdventureWorks is a comprehensive Microsoft sample database modeling a manufacturing company. It includes schemas for sales, purchasing, production, and human resources.

#### Key Tables Used:
- `Sales.SalesOrderHeader`
- `Sales.SalesOrderDetail`
- `Sales.Customer`
- `Person.Person`
- `Production.Product`
- `Production.ProductSubcategory`
- `Production.ProductCategory`
- `HumanResources.Employee`
- `Person.Address`
- `Sales.Store`
- `Sales.SalesTerritory`

---

### 🛍 Northwind

Northwind is a classic e-commerce sample database featuring products, customers, orders, and shipping.

#### Key Tables Used:
- `Orders`
- `Order Details`
- `Customers`
- `Products`
- `Suppliers`
- `Employees`
- `Shippers`
- `Categories`

---

### 📚 Pubs

The Pubs database simulates a publishing company. It includes data about authors, books, publishers, and sales.

#### Key Tables Used:
- `Titles`
- `Publishers`
- `Sales`
- `Stores`
- `Authors`
- `TitleAuthor`
- `Employee`
- `Discounts`

---

### 🧪 Custom Database — `OrdersManagementDB`

This document provides a detailed overview of the custom database schema used in the project. The schema is designed to manage employee orders, product information, and customer order items.

#### 📂 Tables Overview

The database includes the following tables:

- **Employees**: Stores employee personal data and assigned territories.
- **Orders**: Contains order records associated with employees and customers.
- **Products**: Lists product details including supplier and category.
- **OrderItems**: Represents individual items within an order, including price, quantity, and discounts.

---

## 🔍 Table Definitions

### 📄 Employees

| Column           | Data Type     | Description                           |
|------------------|---------------|---------------------------------------|
| EmployeeID       | INT (PK)      | Unique identifier for the employee    |
| FirstName        | NVARCHAR(10)  | Employee's first name                 |
| LastName         | NVARCHAR(20)  | Employee's last name                  |
| BirthDate        | DATETIME2     | Employee's birth date                 |
| TotalTerritories | INT           | Total number of assigned territories  |

---

### 📄 Orders

| Column               | Data Type     | Description                             |
|----------------------|---------------|-----------------------------------------|
| OrderID              | INT (PK)      | Unique identifier for each order        |
| EmployeeID           | INT (FK)      | References the employee who created the order |
| OrderDate            | DATETIME2     | Date of the order                       |
| CustomerCompanyName  | NVARCHAR(40)  | Customer’s company name                 |
| CustomerAddress      | NVARCHAR(60)  | Customer’s address                      |
| TotalOrderItems      | INT           | Total number of items in the order      |

**Foreign Key**:  
- `EmployeeID → Employees(EmployeeID)`

---

### 📄 Products

| Column               | Data Type     | Description                            |
|----------------------|---------------|----------------------------------------|
| ProductID            | INT (PK)      | Unique identifier for the product      |
| ProductName          | NVARCHAR(40)  | Name of the product                    |
| SupplierCompanyName  | NVARCHAR(40)  | Supplier’s company name                |
| CategoryName         | NVARCHAR(15)  | Product category                       |

---

### 📄 OrderItems

| Column     | Data Type   | Description                                |
|------------|-------------|--------------------------------------------|
| OrderID    | INT (PK, FK)| References the order                       |
| ProductID  | INT (PK, FK)| References the product                     |
| Price      | MONEY       | Price per product unit                     |
| Quantity   | SMALLINT    | Quantity ordered                           |
| Discount   | REAL        | Discount applied to this product           |

**Foreign Keys**:
- `OrderID → Orders(OrderID)`
- `ProductID → Products(ProductID)`

**Primary Key**: Composite (`OrderID`, `ProductID`)

---

## 🗺️ Entity Relationships (ER Overview)

- Each **Employee** can create multiple **Orders**.
- Each **Order** can include multiple **OrderItems**.
- Each **OrderItem** is associated with one **Product**.

---

## 🔗 Relationships & Constraints

- **AdventureWorks2017**: Complex normalized structure with **foreign keys**, **surrogate keys**, and **multiple schemas**.
- **Northwind**: Moderate normalization with **many-to-many** relationships (e.g. `Orders` ↔ `Products` via `Order Details`).
- **Pubs**: Includes **composite keys** (e.g. `TitleAuthor`) and **hierarchical publishing data**.
- **OrdersManagementDB**: Demonstrates **manual relationship creation**, **joins**, and **indexing**.

---

## 🎯 Notes

- All databases are hosted on **Microsoft SQL Server 2017**.
- Foreign key relationships were crucial for JOIN operations across most queries.
- Normalization levels vary: from highly normalized (AdventureWorks) to flat/simple (custom DB).
- Custom stored procedures, views, and indexes were implemented primarily in `OrdersManagementDB`.

---

## 🧠 Purpose of Including Multiple Schemas

Using various database structures allows for:

- Practicing diverse SQL patterns  
- Adapting queries to different schema complexities  
- Demonstrating a broad understanding of relational data modeling

---
