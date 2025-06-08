import React, { useEffect, useState } from 'react';
import { useParams } from 'react-router-dom';
import axios from 'axios';

function ProductPage() {
  const { productId } = useParams();
  const [product, setProduct] = useState(null);

  useEffect(() => {
    axios.get(`http://localhost:5000/api/products/${productId}`)
      .then(res => setProduct(res.data))
      .catch(err => console.log(err));
  }, [productId]);

  if (!product) return <div>Loading...</div>;

  return (
    <div className="product-page">
      <img src={product.imageUrl} alt={product.name} />
      <h2>{product.name}</h2>
      <p>{product.description}</p>
      <p>${product.price}</p>
    </div>
  );
}

export default ProductPage;
