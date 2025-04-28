// controllers/incomeController.js
import Income from '../models/Income.js';

// Add a new income
export const addIncome = async (req, res) => {
  try {
    const income = new Income(req.body);
    await income.save();
    res.status(201).json(income);
  } catch (error) {
    res.status(400).json({ message: error.message });
  }
};

// Get all incomes for a user
export const getIncomes = async (req, res) => {
  try {
    const incomes = await Income.find({ user_id: req.query.user_id });
    res.status(200).json(incomes);
  } catch (error) {
    res.status(400).json({ message: error.message });
  }
};

// Delete an income
export const deleteIncome = async (req, res) => {
  try {
    await Income.findByIdAndDelete(req.params.id);
    res.status(200).json({ message: 'Income deleted successfully' });
  } catch (error) {
    res.status(400).json({ message: error.message });
  }
};
