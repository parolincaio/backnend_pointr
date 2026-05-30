require('dotenv').config();

const express = require('express');
const routes = require('./routes');
const cors = require('cors');

const app = express();

app.use(express.json());

// ✅ CORS Atualizado (mais permissivo para desenvolvimento)
app.use(cors({
  origin: ['http://localhost:5173', 'http://localhost:3000'], // Vite + React comum
  methods: ['GET', 'POST', 'PUT', 'DELETE'],
  allowedHeaders: ['Content-Type', 'Authorization'],
  credentials: true
}));

app.use('/', routes);

app.get('/', (req, res) => {
  res.send('Backend do PoinTr rodando!');
});

const PORT = process.env.PORT || 3001;
app.listen(PORT, () => {
  console.log(`🚀 Servidor rodando na porta ${PORT}`);
});