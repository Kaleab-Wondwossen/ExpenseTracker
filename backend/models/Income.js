// models/Income.js
import mongoose from 'mongoose';

const IncomeSchema = new mongoose.Schema({
  user_id: { type: mongoose.Schema.Types.ObjectId, required: true, ref: 'User' },
  amount: { type: Number, required: true },
  source: { type: String, required: true }, // e.g., Salary, Freelance, Other
  description: { type: String },
  date: { type: Date, default: Date.now }
});

export default mongoose.model('Income', IncomeSchema);
