import React from 'react';
import PropTypes from 'prop-types';
import { Link, NavLink, Routes, Route } from 'react-router-dom';
import ProductForm from './ProductForm';

const CategoryList = ( {categories, onSave} ) => {
  const renderCategories = (categories) =>
    categories.map((category) => (
      <li key={category.id}>
        <NavLink to={`/categories/${category.id}`}>
          {category.name}
        </NavLink>
      </li>
      )
    );

  return (
    <div>
      <section>
        <ProductForm onSave={onSave} />
        <h3>Categories</h3>
        <ul>{renderCategories(categories)}</ul>
      </section>
    </div>
  )
};

CategoryList.propTypes = {
  categories: PropTypes.arrayOf(
    PropTypes.shape({
      id: PropTypes.number.isRequired,
      name: PropTypes.string.isRequired,
      products: PropTypes.array
    })
  ).isRequired
};

export default CategoryList;
