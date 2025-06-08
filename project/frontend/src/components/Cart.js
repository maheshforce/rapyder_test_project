import React from 'react';
import CartItem from './CartItem';
import { useCart } from '../context/CartContext';

function Cart() {
  const { cart, removeFromCart } = useCart();

  return (
    <div className="cart">
      <h2>Your Cart</h2>
      {cart.length === 0 ? (
        <p>Your cart is empty.</p>
      ) : (
        cart.map(item => (
          <CartItem key={item._id} item={item} removeFromCart={removeFromCart} />
        ))
      )}
    </div>
  );
}

export default Cart;
