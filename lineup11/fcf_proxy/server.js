const express = require('express');
const cors = require('cors');

const app = express();

app.use(cors());

const PORT = 3000;

const FCF_BASE_URL = 'https://www.fcf.cat/api/competition';

app.get('/api/classificacio', async (req, res) => {
  try {
    const grupId = req.query.grupId;

    if (!grupId) {
      return res.status(400).json({
        error: 'Falta el parámetro grupId',
      });
    }

    const url =
      `${FCF_BASE_URL}/classificacio?grupId=${encodeURIComponent(grupId)}`;

    console.log('Consultando FCF:', url);

    const response = await fetch(url);

    if (!response.ok) {
      return res.status(response.status).json({
        error: `FCF respondió con ${response.status}`,
      });
    }

    const data = await response.json();

    res.json(data);
  } catch (error) {
    console.error(error);

    res.status(500).json({
      error: 'Error consultando la FCF',
      message: error.message,
    });
  }
});

app.listen(PORT, () => {
  console.log(`FCF Proxy funcionando en http://localhost:${PORT}`);
});