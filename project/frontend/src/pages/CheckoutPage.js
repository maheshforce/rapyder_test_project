import React, { useState } from 'react';
import axios from 'axios';

function CheckoutPage() {
  const [formData, setFormData] = useState({ name: '', email: '', address: '' });
  const [loading, setLoading] = useState(false);

  const handleChange = e => {
    setFormData({ ...formData, [e.target.name]: e.target.value });
  };

  const handleSubmit = async e => {
    e.preventDefault();
    setLoading(true);
    try {
      const response = await axios.post('http://localhost:5000/api/orders', formData);
      alert('Order placed successfully!');
    } catch (error) {
      alert('Error placing order');
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="checkout-page">
      <h2>Checkout</h2>
      <form onSubmit={handleSubmit}>
        <input
          type="text"
          name="name"
          placeholder="Name"
          value={formData.name}
          onChange={handleChange}
          required
        />
        <input
          type="email"
          name="email"
          placeholder="Email"
          value={formData.email}
          onChange={handleChange}
          required
        />
        <textarea
          name="address"
          placeholder="Address"
          value={formData.address}
          onChange={handleChange}
          required
        />
        <button type="submit" disabled={loading}>
          {loading ? 'Placing Order...' : 'Place Order'}
        </button>
      </form>
    </div>
  );
}

export default CheckoutPage;
