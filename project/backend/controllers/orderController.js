const Order = require('../models/Order');
const Product = require('../models/Product');

// Create a new order
const createOrder = async (req, res) => {
  const { name, email, address, products } = req.body;

  // Validate if products array is not empty
  if (!products || products.length === 0) {
    return res.status(400).json({ message: 'No products in the order' });
  }

  // Calculate total price
  let totalPrice = 0;
  const orderProducts = [];

  for (let productItem of products) {
    const product = await Product.findById(productItem.productId);
    if (!product) {
      return res.status(400).json({ message: 'Product not found' });
    }

    const price = product.price * productItem.quantity;
    totalPrice += price;

    orderProducts.push({
      product: product._id,
      quantity: productItem.quantity,
      price: price,
    });
  }

  try {
    const order = new Order({
      name,
      email,
      address,
      products: orderProducts,
      total: totalPrice,
    });

    await order.save();
    res.status(201).json(order);
  } catch (err) {
    res.status(500).json({ message: 'Error placing order' });
  }
};

module.exports = { createOrder };
