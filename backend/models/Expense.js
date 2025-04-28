// models/Expense.js
import mongoose from 'mongoose';

const ExpenseSchema = new mongoose.Schema({
  user_id: { type: mongoose.Schema.Types.ObjectId, required: true, ref: 'User' },
  amount: { type: Number, required: true },
  category: { type: String, required: true }, // e.g., Food, Transport, Entertainment
  description: { type: String },
  date: { type: Date, default: Date.now }
});

export default mongoose.model('Expense', ExpenseSchema);
