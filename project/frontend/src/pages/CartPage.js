import React from 'react';
import { Link } from 'react-router-dom';
import Cart from '../components/Cart';

function CartPage() {
  return (
    <div className="cart-page">
      <Cart />
      <Link to="/checkout">
        <button>Proceed to Checkout</button>
      </Link>
    </div>
  );
}

export default CartPage;
