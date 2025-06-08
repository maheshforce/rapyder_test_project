import axios from 'axios';

// Using the environment variable to set the API base URL
const api = axios.create({
  baseURL: process.env.REACT_APP_API_URL || 'http://localhost:5000/api',
});

export default api;
