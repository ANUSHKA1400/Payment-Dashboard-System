# 💳 Payment Dashboard System

A full-stack Payment Management Dashboard built with **Flutter (Frontend)** and **NestJS (Backend)** for managing transactions, simulating payments, and tracking revenue trends.

---

## 📌 Features

### 🔐 Authentication
- Secure login using JWT
- Role-based access (Admin / Viewer)

### 📊 Dashboard
- Today's transactions, revenue, and failed payments
- Weekly revenue chart using `fl_chart`

### 💼 Transactions
- Paginated list of payments
- Filter by:
  - ✅ Status (success, failed, pending)
  - ✅ Payment Method (card, UPI, bank)
  - ✅ Date Range
- Click to view transaction details

### ➕ Add Payment
- Simulate a payment: amount, receiver, method, status

### 👥 User Management
- Add new users (Admin / Viewer)
- View all registered users

---

## 🧱 Tech Stack

| Layer      | Technology           |
|------------|----------------------|
| Frontend   | Flutter (Web)        |
| Backend    | NestJS (Node.js)     |
| Database   | In-memory (Simulated)|
| Auth       | JWT                  |

---

## 📁 Folder Structure
Payment-Dashboard-System/
├── backend-payment-dashboard/ # NestJS backend
└── payment_dashboard/ # Flutter frontend

---

## 🚀 Getting Started

### 🔧 Backend Setup

```bash
cd backend-payment-dashboard
npm install
npm run start:dev
npx ts-node src/seed.ts   # (optional) Seed data
cd payment_dashboard
flutter pub get
flutter run -d chrome
| Role   | Username | Password  |
| ------ | -------- | --------- |
| Admin  | admin    | admin123  |
| Viewer | viewer1  | viewer123 |

Deployment
✅ GitHub Repo: ANUSHKA1400/Payment-Dashboard-System


