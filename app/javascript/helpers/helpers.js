export const isEmptyObject = (obj) => Object.keys(obj).length === 0;

export const validateProduct = (product) => {
  const errors = {};
  const flipkartUrl = 'flipkart.com'

  if (product.url === '') {
    errors.product_type = 'You must enter a product url';
  }

  // check the url is valid or not
  // for validation check, we can use url-validation packages
  // for simplicity, just check if the url has flipkart.com or not
  if (!product.url.toLowerCase().includes(flipkartUrl)) {
    errors.product_type = 'You must enter valid url';
  }

  return errors;
};