# 💳 Payment Dashboard System

A full-stack Payment Management Dashboard built with **Flutter (Frontend)** and **NestJS (Backend)** for managing transactions, simulating payments, and tracking revenue trends.

---

## 📌 Features

### 🔐 Authentication
- Secure login using JWT
- Role-based access (Admin / Viewer)

### 📊 Dashboard
- Today's transactions, revenue, and failed payments
- Weekly revenue chart

### 💼 Transactions
- Paginated list of payments
- Filter by status, method, and date range
- View transaction details

### ➕ Add Payment
- Simulate a payment (amount, receiver, method, status)

### 👥 User Management
- Add new users (Admin or Viewer)
- View all registered users

---

## 🧱 Tech Stack

| Layer     | Technology                |
|-----------|---------------------------|
| Frontend  | Flutter (Web)             |
| Backend   | NestJS (Node.js)          |
| Database  | In-memory (Simulated)     |
| Auth      | JWT                       |

---

## 📁 Folder Structure
Payment-Dashboard-System/
├── backend-payment-dashboard/ # NestJS backend
└── payment_dashboard/ # Flutter frontend

---

## 🚀 Getting Started

### 🔧 Backend Setup

1. Navigate to backend:
    ```bash
    cd backend-payment-dashboard
    ```

2. Install dependencies:
    ```bash
    npm install
    ```

3. Run the backend:
    ```bash
    npm run start:dev
    ```

4. (Optional) Seed data:
    ```bash
    npx ts-node src/seed.ts
    ```

---

### 💻 Frontend Setup

1. Navigate to frontend:
    ```bash
    cd payment_dashboard
    ```

2. Install packages:
    ```bash
    flutter pub get
    ```

3. Run in Chrome:
    ```bash
    flutter run -d chrome
    ```

---

## 🔐 Sample Credentials

| Role   | Username | Password    |
|--------|----------|-------------|
| Admin  | admin    | admin123    |
| Viewer | viewer1  | viewer123   |

---

## 📸 Screenshots

> Add these after taking them from the browser
- [ ] Login Screen
- [ ] Dashboard
- [ ] Transactions Page
- [ ] Add Payment
- [ ] Manage Users

---

## 📦 Deployment
- ✅ GitHub: [github.com/ANUSHKA1400/Payment-Dashboard-System](https://github.com/ANUSHKA1400/Payment-Dashboard-System)

---

## ✨ Bonus Features (Optional)

| Feature                | Status |
|------------------------|--------|
| Real-time updates (WS) | ❌     |
| Export to CSV          | ❌     |
| Cloud deployment       | 🔄     |
| Dockerized backend     | ❌     |
| Unit/E2E Testing        | ❌     |

---

## 📚 Learning Highlights

- JWT Authentication
- RESTful API design
- Flutter State Management
- NestJS Modular Architecture
- Charts with `fl_chart`
- Secure storage with `flutter_secure_storage`

---

## 🙌 Author

**Anushka**  
Built as part of a full-stack internship project.

---

