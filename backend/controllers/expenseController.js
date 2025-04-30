// controllers/expenseController.js
import Expense from '../models/Expense.js';

export const addExpense = async (req, res) => {
  try {
    const expense = new Expense(req.body);
    await expense.save();
    res.status(201).json(expense);
  } catch (error) {
    res.status(400).json({ message: error.message });
  }
};

export const getExpenses = async (req, res) => {
  try {
    const expenses = await Expense.find({ user_id: req.query.user_id });
    res.status(200).json(expenses);
  } catch (error) {
    res.status(400).json({ message: error.message });
  }
};

export const deleteExpense = async (req, res) => {
  try {
    await Expense.findByIdAndDelete(req.params.id);
    res.status(200).json({ message: 'Expense deleted successfully' });
  } catch (error) {
    res.status(400).json({ message: error.message });
  }
};

// ✅ New function to get ALL expenses without user_id filter
export const getAllExpenses = async (req, res) => {
    try {
      const expenses = await Expense.find();
      res.status(200).json(expenses);
    } catch (error) {
      res.status(400).json({ message: error.message });
    }
  };

  export const updateExpense = async (req, res) => {
    try {
      const updatedExpense = await Expense.findByIdAndUpdate(
        req.params.id,
        req.body,
        { new: true } // return updated doc
      );
      res.status(200).json(updatedExpense);
    } catch (error) {
      res.status(400).json({ message: error.message });
    }
  };
  
