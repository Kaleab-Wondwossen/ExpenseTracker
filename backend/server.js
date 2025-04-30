import dotenv from 'dotenv';
dotenv.config(); // Should be near top of file


// server.js


import express from 'express';
import mongoose from 'mongoose';
import expenseRoutes from './routes/expenses.js';
import incomeRoutes from './routes/incomes.js';



const app = express();
app.use(express.json());

app.use('/api/expenses', expenseRoutes);
app.use('/api/incomes', incomeRoutes);

app.get('/', (req, res) => {
    res.send('🚀 Expense Tracker API is running');
  });

const PORT = process.env.PORT || 5000;

mongoose.connect("mongodb+srv://kaleabwondwossen12:rbACngaob5XyvJ9g@dastabasedb.rnu5m.mongodb.net/ExpenseTracker?retryWrites=true&w=majority&appName=DastabaseDB ").then(() => {
  
    app.listen(PORT, () => {
      console.log(`🚀 Server running on http://localhost:${PORT}`);
    });
    console.log('Connected to MongoDB Expense Tracker DB')
  }).catch(() => {
    console.log('Connection failed')
  })