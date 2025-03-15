const express = require('express');
const bodyParser = require('body-parser');
const mysql = require('mysql2');
const session = require('express-session');
const patientRoutes = require('./routes/patient_routes');
const vaccineRoutes = require('./routes/vaccine_routes');
const supplierRoutes = require('./routes/supplier_routes');
const administerRoutes = require('./routes/administer_routes');

const app = express();
const port = 3000;

app.use(bodyParser.json());
app.use(express.static('public'));
app.use(session({
  secret: 'your_secret_key',
  resave: false,
  saveUninitialized: true
}));

const db = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: '',
  database: 'db_paseos',
  multipleStatements: true
});

db.connect(err => {
  if (err) {
    console.error('Database connection failed:', err.stack);
    return;
  }
  console.log('Connected to database');
});

app.use('/patients', patientRoutes);
app.use('/vaccines', vaccineRoutes);
app.use('/suppliers', supplierRoutes);
app.use('/administers', administerRoutes);

app.post('/patients', (req, res) => {
  console.log('Request body:', req.body);
  const { PatientName, VaccineName, Quantity, PurchaseDate } = req.body;

  if (!PatientName || !VaccineName || !Quantity || !PurchaseDate) {
    return res.status(400).json({ message: 'All fields are required' });
  }

  const sql = `
    INSERT INTO patient (PatientName, VaccineName, Quantity, PurchaseDate)
    VALUES (?, ?, ?, ?)
  `;

  db.query(sql, [PatientName, VaccineName, Quantity, PurchaseDate], (err, result) => {
    if (err) {
      console.error('Error adding patient record:', err);
      return res.status(500).json({ message: 'Failed to add patient record' });
    }
    res.status(201).json({ message: 'Patient record added successfully' });
  });
});

app.post('/login', (req, res) => {
  const { username, password } = req.body;

  const doctorQuery = 'SELECT * FROM doctor WHERE dr_License = ? AND password = ?';
  const assistantQuery = 'SELECT * FROM assistant WHERE username = ? AND password = ?';

  db.query(doctorQuery, [username, password], (err, doctorResults) => {
    if (err) {
      console.error('Database query error:', err);
      res.status(500).send('Server error');
      return;
    }

    if (doctorResults.length > 0) {
      req.session.role = 'doctor';
      res.json({ redirect: '/Doctor_DashBoard/Manage_Suppliers/index.html', role: 'Doctor' });
      return;
    }
    
    db.query(assistantQuery, [username, password], (err, assistantResults) => {
      if (err) {
        console.error('Database query error:', err);
        res.status(500).send('Server error');
        return;
      }

      if (assistantResults.length > 0) {
        req.session.role = 'secretary';
        res.json({ redirect: '/Assistant_DashBoard/Manage_Patients/index.html', role: 'Secretary' });
      } else {
        res.status(401).send('Invalid username or password');
      }
    });
  });
});

app.get('/user-role', (req, res) => {
  const role = req.session.role;
  if (role) {
    res.json({ role });
  } else {
    res.status(401).json({ message: 'Not logged in' });
  }
});

app.post('/vaccines', (req, res) => {
  const { VaccineName, OpeningStock, Purchased, Dispensed, OrderDate, ExpirationDate } = req.body;
  const totalStock = Number(OpeningStock) + Number(Purchased);
  const closingStock = totalStock - Number(Dispensed);

  const sql = `
    INSERT INTO vaccine (vaccine_name, opening_stock, purchased, total_stock, dispensed, closing_stock, order_date, expiration_date)
    VALUES (?, ?, ?, ?, ?, ?, ?, ?)
  `;

  db.query(sql, [VaccineName, OpeningStock, Purchased, totalStock, Dispensed, closingStock, OrderDate, ExpirationDate], (err, result) => {
    if (err) {
      console.error('Error adding vaccine record:', err);
      res.status(500).json({ message: 'Failed to add vaccine record' });
    } else {
      res.status(201).json({ message: 'Vaccine record added successfully' });
    }
  });
});

app.post('/suppliers', (req, res) => {
  const { supplier_name, contact, location } = req.body;

  if (!supplier_name || !contact || !location) {
    return res.status(400).json({ message: 'All fields are required' });
  }

  const sql = `
    INSERT INTO supplier (supplier_name, contact, location)
    VALUES (?, ?, ?)
  `;

  db.query(sql, [supplier_name, contact, location], (err, result) => {
    if (err) {
      console.error('Error adding supplier record:', err);
      return res.status(500).json({ message: 'Failed to add supplier record' });
    }
    res.status(201).json({ message: 'Supplier record added successfully' });
  });
});


app.get('/test', (req, res) => {
  res.send('Test route is working!');
});

app.get('/doctors', (req, res) => {
  const sql = `
    SELECT d.doctor_ID, d.effectivity_date, d.dr_License, 
           p.dr_firstname, p.dr_Middlename, p.dr_Surname, 
           p.dr_Gender, p.dr_age, p.dr_number, p.dr_address
    FROM doctor d
    JOIN person p ON d.doctor_ID = p.Person_ID
  `;
  db.query(sql, (err, results) => {
    if (err) {
      console.error('Error fetching doctors:', err);
      return res.status(500).json({ message: 'Failed to fetch doctor records' });
    }
    console.log('Doctors:', results);
    res.status(200).json(results);
  });
});

app.get('/assistants', (req, res) => {
  const sql = 'SELECT * FROM assistant';
  db.query(sql, (err, results) => {
    if (err) {
      console.error('Error fetching assistants:', err);
      return res.status(500).json({ message: 'Failed to fetch assistant records' });
    }
    console.log('Assistants:', results);
    res.status(200).json(results);
  });
});

app.get('/stock_out', (req, res) => {
  const sql = `
    SELECT so.stockout_ID, v.vaccine_name, so.quantity, a.username AS assistant_name, so.stockout_date
    FROM stock_out AS so
    JOIN vaccine AS v ON so.vaccine_ID = v.vaccine_ID
    JOIN assistant AS a ON so.assistant_ID = a.assistant_ID
    ORDER BY so.stockout_ID;
  `;

  db.query(sql, (err, results) => {
    if (err) return res.status(500).json({ error: err.message });
    res.json(results);
  });
});

app.get('/administer', (req, res) => {
  const sql = 'SELECT * FROM administer';
  db.query(sql, (err, results) => {
    if (err) return res.status(500).json({ error: err.message });
    res.json(results);
  });
});

app.post('/administer', async (req, res) => {
  const { patientId, vaccineId, assistantId, doctorId, administerDate } = req.body;

  // Check if patient ID exists
  const patientQuery = 'SELECT * FROM patient WHERE patient_ID = ?';
  db.query(patientQuery, [patientId], (err, patientResult) => {
    if (err) {
      console.error('Error querying patient:', err);
      return res.status(500).json({ message: 'Server error' });
    }

    if (patientResult.length === 0) {
      return res.status(400).json({ message: 'Patient ID does not exist' });
    }

    // Check if vaccine ID exists
    const vaccineQuery = 'SELECT * FROM vaccine WHERE vaccine_ID = ?';
    db.query(vaccineQuery, [vaccineId], (err, vaccineResult) => {
      if (err) {
        console.error('Error querying vaccine:', err);
        return res.status(500).json({ message: 'Server error' });
      }

      if (vaccineResult.length === 0) {
        return res.status(400).json({ message: 'Vaccine ID does not exist' });
      }

      // If both patient and vaccine IDs are valid, proceed with administering
      const insertQuery = `
        INSERT INTO administer (patient_ID, vaccine_ID, assistant_ID, doctor_ID, date)
        VALUES (?, ?, ?, ?, ?)
      `;
      db.query(insertQuery, [patientId, vaccineId, assistantId, doctorId, administerDate], (err, result) => {
        if (err) {
          console.error('Error inserting administer record:', err);
          return res.status(500).json({ message: 'Server error' });
        }

        return res.status(200).json({ message: 'Vaccine administered successfully' });
      });
    });
  });
});

app.delete('/administer/:id', (req, res) => {
  const { id } = req.params;
  const sql = 'DELETE FROM administer WHERE Administer_ID = ?';
  db.query(sql, [id], (err, result) => {
    if (err) return res.status(500).json({ error: err.message });
    res.json({ message: 'Record deleted successfully' });
  });
});

app.post('/order', (req, res) => {
  const { doctor_ID, assistant_ID, supplier_ID, order_date, total } = req.body;
  const sql = 'INSERT INTO `order` (doctor_ID, assistant_ID, supplier_ID, order_date, total) VALUES (?, ?, ?, ?, ?)';
  db.query(sql, [doctor_ID, assistant_ID, supplier_ID, order_date, total], (err, result) => {
    if (err) return res.status(500).json({ error: err.message });
    res.status(201).json({ message: 'Order created successfully' });
  });
});

// Endpoint to get orders
app.get('/order', (req, res) => {
  const sql = `
    SELECT o.order_ID, o.doctor_ID, o.assistant_ID, o.supplier_ID, o.order_date, o.total
    FROM \`order\` o
  `;
  db.query(sql, (err, result) => {
    if (err) return res.status(500).json({ error: err.message });
    res.status(200).json(result);
  });
});

app.post('/order', (req, res) => {
  const { doctor_ID, assistant_ID, supplier_ID, order_date, total } = req.body;
  const sql = `
    INSERT INTO \`order\` (doctor_ID, assistant_ID, supplier_ID, order_date, total) 
    VALUES (?, ?, ?, ?, ?)
  `;
  db.query(sql, [doctor_ID, assistant_ID, supplier_ID, order_date, total], (err, result) => {
    if (err) return res.status(500).json({ error: err.message });
    res.status(201).json({ message: 'Order created successfully' });
  });
});

// Delete order endpoint
app.delete('/order/:id', (req, res) => {
  const { id } = req.params;
  const sql = 'DELETE FROM `order` WHERE order_ID = ?';
  db.query(sql, [id], (err, result) => {
    if (err) return res.status(500).json({ error: err.message });
    res.status(200).json({ message: 'Order deleted successfully' });
  });
});

app.listen(port, () => {
  console.log(`Server running on http://localhost:${port}`);
});
