// routes/incomes.js
import express from 'express';
import { addIncome, getIncomes, deleteIncome } from '../controllers/incomeController.js';

const router = express.Router();

router.post('/', addIncome);
router.get('/', getIncomes);
router.delete('/:id', deleteIncome);

export default router;
