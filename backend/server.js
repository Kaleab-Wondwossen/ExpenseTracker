// server.js
import express from 'express';
import mongoose from 'mongoose';
import dotenv from 'dotenv';
import expenseRoutes from './routes/expenses.js';
import incomeRoutes from './routes/incomes.js';
import incomeRoutes from './routes/incomes.js';


dotenv.config();

const app = express();
app.use(express.json());

app.use('/api/expenses', expenseRoutes);
app.use('/api/incomes', incomeRoutes);


const PORT = process.env.PORT || 5000;

mongoose.connect(process.env.MONGO_URI, { useNewUrlParser: true, useUnifiedTopology: true })
  .then(() => app.listen(PORT, () => console.log(`Server running on port ${PORT}`)))
  .catch((err) => console.log(err));
