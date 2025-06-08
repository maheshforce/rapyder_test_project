const express = require("express");
const router = express.Router();
const Order = require("../models/Order");

// Create an order
router.post("/", async (req, res) => {
  try {
    const { name, email, quantity } = req.body;
    const newOrder = new Order({ name, email, quantity });
    await newOrder.save();
    res.status(201).json({ message: "Order placed successfully" });
  } catch (err) {
    res.status(500).json({ error: "Failed to place order" });
  }
});

module.exports = router;
