# 💳 Payment Dashboard System

A full-stack Payment Management Dashboard built with Flutter (Frontend) and NestJS (Backend) for managing transactions, simulating payments, and tracking revenue trends.

---

## 📌 Features

### 🔐 Authentication
* Secure login using JWT
* Role-based access (Admin / Viewer)

### 📊 Dashboard
* Today's transactions, revenue, and failed payments
* Weekly revenue chart

### 💼 Transactions
* Paginated list of payments
* Filter by status, method, and date range
* View transaction details

### ➕ Add Payment
* Simulate a payment (amount, receiver, method, status)

### 👥 User Management
* Add new users (Admin or Viewer)
* View all registered users

---

## 🧱 Tech Stack

| Layer      | Technology               |
| :--------- | :----------------------- |
| Frontend   | Flutter (Web)            |
| Backend    | NestJS (Node.js)         |
| Database   | In-memory (Simulated)    |
| Auth       | JWT                      |

---

## 📁 Folder Structure
Okay, I understand! You want the README.md to include your screenshots.

Remember that GitHub README.md files cannot directly link to local file paths like D:\.... For images to appear on GitHub, they need to be part of your repository or hosted online.

Recommendation: Create a folder named screenshots (or assets) inside your main Payment-Dashboard-System project directory (at the same level as your backend and frontend folders), and place all your .png image files there.

Then, you can reference them using relative paths, which will work perfectly on GitHub.

Here's the updated README.md content with the screenshot links, assuming you will place your images in a screenshots/ folder:

Markdown

# 💳 Payment Dashboard System

A full-stack Payment Management Dashboard built with Flutter (Frontend) and NestJS (Backend) for managing transactions, simulating payments, and tracking revenue trends.

---

## 📌 Features

### 🔐 Authentication
* Secure login using JWT
* Role-based access (Admin / Viewer)

### 📊 Dashboard
* Today's transactions, revenue, and failed payments
* Weekly revenue chart

### 💼 Transactions
* Paginated list of payments
* Filter by status, method, and date range
* View transaction details

### ➕ Add Payment
* Simulate a payment (amount, receiver, method, status)

### 👥 User Management
* Add new users (Admin or Viewer)
* View all registered users

---

## 🧱 Tech Stack

| Layer      | Technology               |
| :--------- | :----------------------- |
| Frontend   | Flutter (Web)            |
| Backend    | NestJS (Node.js)         |
| Database   | In-memory (Simulated)    |
| Auth       | JWT                      |

---

## 📁 Folder Structure

Payment-Dashboard-System/
├── backend/            # NestJS backend
├── frontend/           # Flutter frontend
---

## 🚀 Getting Started

### 🔧 Backend Setup

1.  **Navigate to the backend directory:**
    ```bash
    cd backend
    ```

2.  **Install dependencies:**
    ```bash
    npm install
    ```

3.  **Run the backend in development mode:**
    ```bash
    npm run start:dev
    ```

4.  **(Optional) Seed initial data (e.g., admin user, sample payments):**
    ```bash
    npx ts-node src/seed.ts
    ```
    *Ensure `ts-node` is installed globally or locally (`npm install -g ts-node` or `npm install ts-node`).*

### 💻 Frontend Setup

1.  **Navigate to the frontend directory:**
    ```bash
    cd frontend
    ```

2.  **Install Flutter packages:**
    ```bash
    flutter pub get
    ```

3.  **Run the Flutter web app in Chrome:**
    ```bash
    flutter run -d chrome
    ```

---

## 🔐 Sample Credentials

| Role    | Username | Password    |
| :------ | :------- | :---------- |
| Admin   | `admin`  | `admin123`  |
| Viewer  | `viewer1`| `viewer123` |

---

## 📸 Screenshots

*(Place these `.png` files into a `screenshots/` folder in your repository root, e.g., `Payment-Dashboard-System/screenshots/Login.png`)*

* **Login Screen**
    ![Login Screen](screenshots/Login.png)

* **Dashboard**
    ![Dashboard](screenshots/Dashboard.png)

* **Add Payment**
    ![Add Payment](screenshots/Add Payment.png)

* **Manage Users**
    ![Manage Users](screenshots/Manage users.png)

* **Transactions Page**
    *(You mentioned "Transactions Page" in your list but didn't provide a specific image path for it. If you have a screenshot for this, add it here in the same format.)*
    ---

## 📦 Deployment

✅ GitHub Repository: [https://github.com/ANUSHKA1400/Payment-Dashboard-System](https://github.com/ANUSHKA1400/Payment-Dashboard-System)

---

## ✨ Bonus Features (Optional)

| Feature                 | Status |
| :---------------------- | :----- |
| Real-time updates (WS)  | ❌     |
| Export to CSV           | ❌     |
| Cloud deployment        | 🔄     |
| Dockerized backend      | ❌     |
| Unit/E2E Testing        | ❌     |

---

## 📚 Learning Highlights

* JWT Authentication
* RESTful API design
* Flutter State Management
* NestJS Modular Architecture
* Charts with `fl_chart`
* Secure storage with `flutter_secure_storage`

---

## 🙌 Author

**Anushka**
Built as part of a full-stack internship project.
