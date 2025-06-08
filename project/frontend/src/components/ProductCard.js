import React from 'react';
import { Link } from 'react-router-dom';
import { useCart } from '../context/CartContext';

function ProductCard({ product }) {
  const { addToCart } = useCart();

  return (
    <div className="product-card">
      <img src={product.imageUrl} alt={product.name} />
      <h3>{product.name}</h3>
      <p>{product.description}</p>
      <p>${product.price}</p>
      <button onClick={() => addToCart(product)}>Add to Cart</button>
      <Link to={`/product/${product._id}`}>
        <button>View Product</button>
      </Link>
    </div>
  );
}

export default ProductCard;
