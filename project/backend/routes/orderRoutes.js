const express = require('express');
const router = express.Router();
const { createOrder } = require('../controllers/orderController');

// POST to create an order
router.post('/', createOrder);

module.exports = router;
