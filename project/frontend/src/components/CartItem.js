import React from 'react';

function CartItem({ item, removeFromCart }) {
  return (
    <div className="cart-item">
      <img src={item.imageUrl} alt={item.name} />
      <h3>{item.name}</h3>
      <p>Quantity: {item.quantity}</p>
      <p>${item.price * item.quantity}</p>
      <button onClick={() => removeFromCart(item._id)}>Remove</button>
    </div>
  );
}

export default CartItem;
