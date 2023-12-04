import React from 'react';
import { Routes, Route } from 'react-router-dom';
import Home from './Home';

const App = () => (
  <>
    <Routes>
      <Route path="/categories/*" element={<Home />} />
    </Routes>
  </>
);

export default App;
