const express = require('express');
const mysql = require('mysql2/promise');

const routes = express.Router();

const db = mysql.createPool({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
  port: parseInt(process.env.DB_PORT) || 3306,
});

// POST - LOGIN (Gestor)
routes.post('/login', async (req, res) => {
  const { email, senha } = req.body;

  try {
    const [rows] = await db.query(
      'SELECT * FROM gestor WHERE email = ? AND senha = ?',
      [email, senha]
    );

    if (rows.length > 0) {
      const { senha: _, ...safeUser } = rows[0];
      return res.status(200).json(safeUser);
    }
    return res.status(401).json({ message: 'dados invalidos' });
  } catch (e) {
    console.error(e);
    return res.status(500).json({ message: 'erro interno' });
  }
});

// POST - CRIAR GESTOR
routes.post('/register', async (req, res) => {
  const { nome_completo, cpf, email, senha } = req.body;

  if (!nome_completo || !email || !senha)
    return res.status(400).json({ message: 'preencha os campos obrigatórios' });

  try {
    const [result] = await db.query(
      'INSERT INTO gestor (nome_completo, cpf, email, senha) VALUES (?, ?, ?, ?)',
      [nome_completo, cpf, email, senha]
    );

    const [rows] = await db.query('SELECT * FROM gestor WHERE id_gestor = ?', [result.insertId]);
    const { senha: _, ...safeUser } = rows[0];
    return res.status(201).json(safeUser);
  } catch (e) {
    console.error(e);
    if (e.code === 'ER_DUP_ENTRY')
      return res.status(409).json({ message: 'email ou cpf ja cadastrado' });
    return res.status(500).json({ message: 'erro interno' });
  }
});

// PUT - EDITAR GESTOR
routes.put('/gestor/:id', async (req, res) => {
  const id = parseInt(req.params.id);
  const { nome_completo, email, senha } = req.body;

  try {
    await db.query(
      `UPDATE gestor SET 
        nome_completo = COALESCE(?, nome_completo),
        email = COALESCE(?, email),
        senha = COALESCE(?, senha)
      WHERE id_gestor = ?`,
      [nome_completo, email, senha, id]
    );

    const [rows] = await db.query('SELECT * FROM gestor WHERE id_gestor = ?', [id]);
    const { senha: _, ...safeUser } = rows[0];
    return res.status(200).json(safeUser);
  } catch (e) {
    console.error(e);
    return res.status(500).json({ message: 'erro interno' });
  }
});

// GET - LISTAR EMPRESAS DO GESTOR
routes.get('/empresas/:id_gestor', async (req, res) => {
  const id_gestor = parseInt(req.params.id_gestor);

  try {
    const [rows] = await db.query(
      'SELECT * FROM empresa WHERE id_gestor = ?',
      [id_gestor]
    );
    return res.status(200).json(rows);
  } catch (e) {
    console.error(e);
    return res.status(500).json({ message: 'erro interno' });
  }
});

// POST - CRIAR EMPRESA
routes.post('/empresas', async (req, res) => {
  const { id_gestor, nome_empresa, cnpj, telefone, email } = req.body;

  if (!id_gestor || !nome_empresa || !cnpj)
    return res.status(400).json({ message: 'preencha os campos obrigatórios' });

  try {
    const [result] = await db.query(
      'INSERT INTO empresa (id_gestor, nome_empresa, cnpj, telefone, email) VALUES (?, ?, ?, ?, ?)',
      [id_gestor, nome_empresa, cnpj, telefone, email]
    );

    const [rows] = await db.query(
      'SELECT * FROM empresa WHERE id_empresa = ?',
      [result.insertId]
    );
    return res.status(201).json(rows[0]);
  } catch (e) {
    console.error(e);
    if (e.code === 'ER_DUP_ENTRY')
      return res.status(409).json({ message: 'cnpj ja cadastrado' });
    return res.status(500).json({ message: 'erro interno' });
  }
});

// PUT - EDITAR EMPRESA
routes.put('/empresas/:id_empresa', async (req, res) => {
  const id_empresa = parseInt(req.params.id_empresa);
  const { nome_empresa, cnpj, telefone, email, nivel_assinatura } = req.body;

  try {
    await db.query(
      `UPDATE empresa SET 
        nome_empresa = COALESCE(?, nome_empresa),
        cnpj = COALESCE(?, cnpj),
        telefone = COALESCE(?, telefone),
        email = COALESCE(?, email),
        nivel_assinatura = COALESCE(?, nivel_assinatura)
      WHERE id_empresa = ?`,
      [nome_empresa, cnpj, telefone, email, nivel_assinatura, id_empresa]
    );

    const [rows] = await db.query(
      'SELECT * FROM empresa WHERE id_empresa = ?',
      [id_empresa]
    );

    if (rows.length === 0) {
      return res.status(404).json({ message: 'empresa não encontrada' });
    }

    return res.status(200).json(rows[0]);
  } catch (e) {
    console.error(e);
    if (e.code === 'ER_DUP_ENTRY') {
      return res.status(409).json({ message: 'cnpj já cadastrado' });
    }
    return res.status(500).json({ message: 'erro interno' });
  }
});

// POST - CADASTRAR COLABORADOR
routes.post('/colaboradores', async (req, res) => {
  const { id_loja, nome_completo, cpf, email, telefone, senha, cargo } = req.body;

  if (!id_loja || !nome_completo || !senha)
    return res.status(400).json({ message: 'campos obrigatórios ausentes' });

  try {
    const [result] = await db.query(
      `INSERT INTO colaborador 
       (id_loja, nome_completo, cpf, email, telefone, senha, cargo, status) 
       VALUES (?, ?, ?, ?, ?, ?, ?, 1)`,
      [id_loja, nome_completo, cpf, email, telefone, senha, cargo]
    );

    const [rows] = await db.query('SELECT * FROM colaborador WHERE id_colaborador = ?', [result.insertId]);
    return res.status(201).json(rows[0]);
  } catch (e) {
    console.error(e);
    if (e.code === 'ER_DUP_ENTRY')
      return res.status(409).json({ message: 'cpf ou email já cadastrado' });
    return res.status(500).json({ message: 'erro interno' });
  }
});

// GET - LISTAR COLABORADORES DE UMA EMPRESA (através das lojas)
routes.get('/empresas/:id_empresa/colaboradores', async (req, res) => {
  const id_empresa = parseInt(req.params.id_empresa);

  try {
    const [rows] = await db.query(`
      SELECT c.* 
      FROM colaborador c
      JOIN loja l ON c.id_loja = l.id_loja
      WHERE l.id_empresa = ?
      ORDER BY c.nome_completo ASC
    `, [id_empresa]);

    return res.status(200).json(rows);
  } catch (e) {
    console.error(e);
    return res.status(500).json({ message: 'erro interno' });
  }
});

module.exports = routes;