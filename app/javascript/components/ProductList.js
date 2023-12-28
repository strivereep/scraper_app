import React from 'react';
import PropTypes from 'prop-types';
import { Link } from 'react-router-dom';

const ProductList = ({ products, categoryId }) => {
  const renderProducts = (productArray, categoryId) =>
    productArray
      .map((product) => (
        <li key={product.id}>
          <Link to={`/categories/${categoryId}/products/${product.id}`}>
            {product.title}
          </Link>
        </li>
      ));

  return (
    <>
      <div>
        <ul>{renderProducts(products, categoryId)}</ul>
      </div>
    </>
  )
}

ProductList.propTypes = {
  products: PropTypes.arrayOf(
    PropTypes.shape({
      id: PropTypes.number.isRequired,
      url: PropTypes.string.isRequired,
      price: PropTypes.string,
      title: PropTypes.string,
      description: PropTypes.string,
      size: PropTypes.string,
      mobile_number: PropTypes.string,
    })
  ).isRequired,
};

export default ProductList;
