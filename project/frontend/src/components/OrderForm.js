import React, { useState } from 'react';

function OrderForm() {
  const [order, setOrder] = useState({
    name: '',
    email: '',
    quantity: 1,
  });

  const handleSubmit = (e) => {
    e.preventDefault();
    // Call the backend to place the order
    fetch('http://65.0.93.232:5000/api/orders', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(order),
    })
      .then((res) => res.json())
      .then((data) => {
        alert('Order placed successfully!');
        setOrder({ name: '', email: '', quantity: 1 });
      });
  };

  return (
    <section id="order" className="order">
      <h2>Order Your Fresh Coconut Today</h2>
      <form onSubmit={handleSubmit}>
        <label>Your Name:</label>
        <input
          type="text"
          value={order.name}
          onChange={(e) => setOrder({ ...order, name: e.target.value })}
          required
        />
        <label>Email:</label>
        <input
          type="email"
          value={order.email}
          onChange={(e) => setOrder({ ...order, email: e.target.value })}
          required
        />
        <label>Quantity:</label>
        <input
          type="number"
          value={order.quantity}
          onChange={(e) => setOrder({ ...order, quantity: e.target.value })}
          required
          min="1"
        />
        <button type="submit">Place Order</button>
      </form>
    </section>
  );
}

export default OrderForm;
