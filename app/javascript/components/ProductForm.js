import React, { useCallback, useEffect, useState } from 'react';
import { useParams, Link } from 'react-router-dom';
import PropTypes from 'prop-types';
import ProductNotFound from './ProductNotFound';
import { isEmptyObject, validateProduct } from '../helpers/helpers';

const ProductForm = ({ products, onSave }) => {
  const { id } = useParams();
  const initialProductState = useCallback(
    () => {
      const defaults = {
        url: '',
        price: '',
        title: '',
        description: '',
        size: '',
        mobile_number: ''
      };
      const currProduct = id ? (products.find((product) => product.id === Number(id)) || {}) : {};
      return { ...defaults, ...currProduct }
    },
    [products, id]
  );

  const [product, setProduct] = useState(initialProductState);
  const [formErrors, setFormErrors] = useState({});

  const updateProduct = (name, value) => {
    setProduct((prevProduct) => ({...prevProduct, [name]: value}));
  };

  useEffect(() => {
    setProduct(initialProductState);
  }, [products, initialProductState]);

  const renderErrors = () => {
    if (isEmptyObject(formErrors)) return null;

    return (
      <>
        <h3>Errors while saving the product:</h3>
        <ul>
          {Object.values(formErrors).map((formError) => (
            <li key={formError}>{formError}</li>
          ))}
        </ul>
      </>
    );
  }

  const handleInputChange = (event) => {
    const { name, value } = event.target;

    updateProduct(name, value)
  }

  const handleSubmit = (event) => {
    event.preventDefault();
    const errors = validateProduct(product);

    if (!isEmptyObject(errors)) {
      setFormErrors(errors);
    } else {
      onSave(product);
    }
  }

  const cancelUrl = product.id ? window.location.pathname.replace('/edit', '') : '/categories';

  if (id && !product.id) return <ProductNotFound />;

  return (
    <div>
      {renderErrors()}
      {product.id && <p>Editing: {product.title} </p>}
      <form onSubmit={handleSubmit}>
        <div>
          <label htmlFor="url">
          <input
            type="text"
            id="url"
            name="url"
            placeholder="Product Url"
            onChange={handleInputChange}
            value={product.url}
          />
          </label>
          <button type="submit">{product.id ? 'Update' : 'Add'}</button>
          {product.id && <Link to={cancelUrl}>Cancel</Link>}
        </div>
      </form>
      {
        product.id && <ul>
          <li><strong>URL:</strong> {product.url}</li>
          <li><strong>Title:</strong> {product.title}</li>
          <li><strong>Description:</strong> {product.description}</li>
          <li><strong>Price:</strong> {product.price}</li>
          <li><strong>Mobile Number:</strong> {product.mobile_number}</li>
          <li><strong>Size:</strong> {product.size}</li>
          <li>{product.product_images && product.product_images.map(image => <img src={image} alt="product" />)}</li>
        </ul>
      }
    </div>
  );
}

ProductForm.propTypes = {
  products: PropTypes.arrayOf(
    PropTypes.shape({
      id: PropTypes.number.isRequired,
      url: PropTypes.string.isRequired,
      price: PropTypes.number,
      title: PropTypes.string,
      description: PropTypes.string,
      size: PropTypes.string,
      mobile_number: PropTypes.string
    })
  ),
  onSave: PropTypes.func.isRequired
}

export default ProductForm;
