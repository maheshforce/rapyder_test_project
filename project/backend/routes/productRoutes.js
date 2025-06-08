const express = require('express');
const router = express.Router();
const { getAllProducts, getProductById } = require('../controllers/productController');

// GET all products
router.get('/', getAllProducts);

// GET product by ID
router.get('/:id', getProductById);

module.exports = router;
