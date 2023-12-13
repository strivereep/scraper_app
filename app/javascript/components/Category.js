import React, { useState } from 'react';
import { useParams, useNavigate, Routes, Route } from 'react-router-dom';
import PropTypes from 'prop-types';
import ProductList from './ProductList';
import Product from './Product';
import ProductNotFound from './ProductNotFound';
import ProductForm from './ProductForm';

const Category = ({ categories }) => {
  const { id } = useParams();
  const navigate = useNavigate();
  const category = categories.find((category) => category.id === Number(id)) || {};
  if (!category) return <ProductNotFound />

  const updateProduct = async (updatedProduct) => {
    try {
      const response = await window.fetch(
        `/api/products/${updatedProduct.id}.json`, {
          method: 'PUT',
          body: JSON.stringify(updatedProduct),
          headers: {
            Accept: 'application/json',
            'Content-Type': 'application/json'
          }
        }
      );

      if (!response.ok) throw Error(response.statusText);

      const newProducts = category.products;

      alert('Product Updated!');
      navigate(window.location.pathname.replace('/edit', ''));
    } catch(error) {
      alert(error);
    }
  };

  const deleteProduct = async (productId) => {
    const sure = window.confirm('Are you sure?');

    if (sure) {
      try {
        const response = await window.fetch(`/api/products/${productId}.json`,{
          method: 'DELETE'
        });

        if (!response.ok) throw Error(response.statusText);

        alert('Product Deleted!');
        navigate('/categories');
      } catch(error) {
        alert(error);
      }
    }
  }

  return (
    <div>
      <h2>{category.name}</h2>
      <ProductList products={category.products || []} categoryId={category.id} />
      <Routes>
        <Route path="products/:id" element={<Product products={category.products} onDelete={deleteProduct}/>} />
        <Route path="products/:id/edit" element={<ProductForm products={category.products || []} onSave={updateProduct} />} />
      </Routes>
    </div>
  )
}

Category.propTypes = {
  categories: PropTypes.arrayOf(
    PropTypes.shape({
      id: PropTypes.number.isRequired,
      name: PropTypes.string.isRequired,
      products: PropTypes.array
    })
  ).isRequired
};

export default Category;
