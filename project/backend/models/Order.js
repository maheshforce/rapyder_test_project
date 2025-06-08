const mongoose = require('mongoose');

const orderSchema = new mongoose.Schema({
  name: { type: String, required: true },
  email: { type: String, required: true },
  address: { type: String, required: true },
  products: [
    {
      product: { type: mongoose.Schema.Types.ObjectId, ref: 'Product' },
      quantity: { type: Number, required: true },
      price: { type: Number, required: true },
    },
  ],
  total: { type: Number, required: true },
  date: { type: Date, default: Date.now },
});

const Order = mongoose.model('Order', orderSchema);

module.exports = Order;
