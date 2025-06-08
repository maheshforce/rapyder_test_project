const express = require('express');
const Order = require('../models/Order');
const router = express.Router();

// Place an order
router.post('/', async (req, res) => {
  const { products, totalAmount, user, address } = req.body;

  const newOrder = new Order({
    products,
    totalAmount,
    user,
    address
  });

  try {
    const order = await newOrder.save();
    res.status(201).json(order);
  } catch (err) {
    res.status(400).json({ message: err.message });
  }
});

// Get all orders (for admin)
router.get('/', async (req, res) => {
  try {
    const orders = await Order.find().populate('products.product');
    res.json(orders);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

module.exports = router;
