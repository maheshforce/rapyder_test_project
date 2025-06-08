const express = require('express');
const Product = require('../models/Product');
const router = express.Router();

// Get all products
router.get('/', async (req, res) => {
  try {
    const products = await Product.find();
    res.json(products);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

// Add a new product (admin only)
router.post('/', async (req, res) => {
  const { name, description, price, imageUrl } = req.body;

  const newProduct = new Product({
    name,
    description,
    price,
    imageUrl
  });

  try {
    const product = await newProduct.save();
    res.status(201).json(product);
  } catch (err) {
    res.status(400).json({ message: err.message });
  }
});

module.exports = router;
