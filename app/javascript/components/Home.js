import React, { useState, useEffect } from 'react';
import { Routes, Route, useNavigate } from 'react-router-dom';
import Header from './Header';
import CategoryList from './CategoryList';
import Category from './Category';

const Home = () => {
  const [isLoading, setIsLoading] = useState(false);
  const [categories, setCategories] = useState([]);
  const navigate = useNavigate();

  const addProduct = async (newProduct) => {
    try {
      const response = await window.fetch('/api/products.json', {
        method: 'POST',
        body: JSON.stringify(newProduct),
        headers: {
          Accept: 'application/json',
          'Content-Type': 'application/json'
        }
      });

      if (!response.ok) throw Error(response.statusText);

      alert('Product Created!');
      navigate('/categories');
    } catch (error) {
      alert(error);
    }
  }
  
  useEffect(() => {
    const fetchCategoriesData = async () => {
      try {
        const response = await window.fetch('/api/categories.json');
        if (!response.ok) throw Error(response.statusText);

        const categoriesData = await response.json();
        setCategories(categoriesData);
      } catch {
        alert(error)
      }
      setIsLoading(false);
    };

    fetchCategoriesData();
  }, []);

  return (
    <>
      <Header />
      {isLoading ? (
        <p className='loading'>Loading...</p>
      ) : (
        <div>
          <CategoryList categories={categories} onSave={addProduct}/>
          <Routes>
            <Route path=":id/*" element={<Category categories={categories} />} />
          </Routes>
        </div>
      )}
    </>
  )
}

export default Home;
