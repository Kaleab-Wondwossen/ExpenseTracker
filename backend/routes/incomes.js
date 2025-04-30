// routes/incomes.js
import express from 'express';
import { addIncome, getIncomes, deleteIncome, getAllIncomes, updateIncome } from '../controllers/incomeController.js';

const router = express.Router();

router.post('/', addIncome);
router.get('/', getIncomes);
router.delete('/:id', deleteIncome);
router.get('/all', getAllIncomes);
router.put('/:id', updateIncome);


export default router;
