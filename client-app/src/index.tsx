import ReactDOM from 'react-dom/client';
import 'semantic-ui-css/semantic.min.css'
import 'react-calendar/dist/Calendar.css'
import 'react-toastify/dist/ReactToastify.min.css'
import 'react-datepicker/dist/react-datepicker.css'
import './App/layout/styles.css';
import reportWebVitals from './reportWebVitals';
import { store, StoreContext } from './App/stores/store';
import { RouterProvider } from 'react-router-dom';
import { router } from './App/router/Routes';

const root = ReactDOM.createRoot(
  document.getElementById('root') as HTMLElement
);
root.render(
  <StoreContext.Provider value={store}>
      <RouterProvider router={router} />
  </StoreContext.Provider>
);

reportWebVitals();
