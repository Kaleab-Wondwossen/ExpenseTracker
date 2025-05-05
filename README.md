# 💸 Cloud-Based Expense Tracker

A Flutter-powered mobile application to help users — especially young professionals and students — track their income and expenses, visualize analytics, and manage financial habits. The backend is built with Node.js and Express.js, using MongoDB Atlas for cloud-hosted data storage.

---

## 🚀 Features

- 📊 Real-time expense and income tracking
- 📅 Interactive calendar with daily records
- 💳 Flip-style balance card with toggle visibility
- 📈 Financial summary & charts using fl_chart
- ✏️ Edit and delete expenses with swipe gestures
- ☁️ Cloud storage via MongoDB Atlas
- 📱 Flutter mobile UI, responsive and offline-ready

---

## 🛠 Tech Stack

### Frontend

- Flutter
- fl_chart
- flip_card
- HTTP package
- Provider (optional for state)
  
### Backend

- Node.js + Express
- MongoDB Atlas (Cloud DB)
- Render for API hosting

---

## 📦 Folder Structure

```bash
lib/
├── models/              # Expense & Income data models
├── services/            # API service handlers
├── widgets/             # Custom UI widgets
├── screens/             # Pages: Home, Transactions, Add Transaction
├── constants/           # Colors, sizes, and global constants
├── main.dart
```

---

## ⚙️ Setup Instructions

### 📱 Flutter App

```bash
git clone https://github.com/Kaleab-Wondwossen/ExpenseTracker.git
cd expense-tracker

# Install dependencies
flutter pub get

# Run the app
flutter run
```

> Make sure you have a device/emulator connected.

### 🌐 Backend API

- API is deployed on Render:  
  `https://expensetracker-8s9l.onrender.com`

> You can clone or fork the backend repo from [your-backend-repo-link].

---

## 🔐 Environment Variables

No special `.env` is needed for our Flutter frontend. The API URL is hardcoded for this prototype. You can extract it into a config file if deploying to production.

---

## 👨‍🎓 For Educational Use

This project was created as part of a **Cloud Computing Mini-Project** with the goal of integrating cloud services, analytics, and mobile UX design in a real-world scenario.

---

## 📝 License

This project is licensed under the MIT License. Feel free to use, fork, and improve.

---

## 🙌 Acknowledgments

- MongoDB Atlas (Cloud DB)
- Render (Free-tier backend hosting)
- Flutter Community
- Icons8 and fl_chart for UI elements
