// routes/expenses.js
import express from 'express';
import { addExpense, getExpenses, deleteExpense, getAllExpenses, updateExpense } from '../controllers/expenseController.js';

const router = express.Router();

router.post('/', addExpense);
router.get('/', getExpenses);
router.delete('/:id', deleteExpense);
router.get('/all', getAllExpenses);
router.put('/:id', updateExpense);


export default router;
