import React, { useState } from 'react';
import axios from 'axios';

function CheckoutPage() {
  const [formData, setFormData] = useState({
    name: '',
    email: '',
    address: ''
  });
  const [loading, setLoading] = useState(false);

  const handleChange = (e) => {
    setFormData({
      ...formData,
      [e.target.name]: e.target.value
    });
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    setLoading(true);

    // Here we can send the order details to the backend
    axios.post('http://localhost:5000/api/orders', formData)
      .then(response => {
        setLoading(false);
        alert('Order placed successfully!');
      })
      .catch(error => {
        setLoading(false);
        alert('There was an error placing your order.');
      });
  };

  return (
    <div className="checkout">
      <h2>Checkout</h2>
      <form onSubmit={handleSubmit}>
        <label>
          Name:
          <input
            type="text"
            name="name"
            value={formData.name}
            onChange={handleChange}
            required
          />
        </label>
        <label>
          Email:
          <input
            type="email"
            name="email"
            value={formData.email}
            onChange={handleChange}
            required
          />
        </label>
        <label>
          Address:
          <textarea
            name="address"
            value={formData.address}
            onChange={handleChange}
            required
          ></textarea>
        </label>
        <button type="submit" disabled={loading}>
          {loading ? 'Placing Order...' : 'Place Order'}
        </button>
      </form>
    </div>
  );
}

export default CheckoutPage;
