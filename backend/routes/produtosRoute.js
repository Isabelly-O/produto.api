const express = require('express');
const { Pool } = require('pg');
const router = express.Router();

// Configuração do pool de conexões com o banco de dados
const pool = new Pool({
    user: process.env.DB_USER,
    host: process.env.DB_HOST,
    database: process.env.DB_NAME,
    password: process.env.DB_PASSWORD,
    port: process.env.DB_PORT,
});

// Criação de um novo produto
router.post('/produto', async (req, res) => {
    const { descricao, preco, estoque } = req.body;
    try {
        const { rows } = await pool.query(
            'INSERT INTO produto (descricao, preco, estoque) VALUES ($1, $2, $3) RETURNING *',
            [descricao, preco, estoque]
        );
        res.status(201).json(rows[0]);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// Listagem de todos os produtos
router.get('/produtos', async (req, res) => {
    try {
        console.log("Tentando conectar ao banco e buscar produtos...");
        const { rows } = await pool.query('SELECT * FROM produto');
        res.json(rows);
    } catch (error) {
        console.error("Erro ao conectar ao banco:", error.message);
        res.status(500).json({ error: error.message });
    }
});

// Obtém um produto por ID
router.get('/produto/:id', async (req, res) => {
    const { id } = req.params;
    try {
        const { rows } = await pool.query('SELECT * FROM produto WHERE id = $1', [id]);
        if (rows.length) {
            res.json(rows[0]);
        } else {
            res.status(404).json({ message: 'Produto não encontrado' });
        }
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// Atualiza um produto por ID
router.put('/produto/:id', async (req, res) => {
    const { id } = req.params;
    const { descricao, preco, estoque } = req.body;
    try {
        const { rows } = await pool.query(
            'UPDATE produto SET descricao = $1, preco = $2, estoque = $3 WHERE id = $4 RETURNING *',
            [descricao, preco, estoque, id]
        );
        if (rows.length) {
            res.json(rows[0]);
        } else {
            res.status(404).json({ message: 'Produto não encontrado' });
        }
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// Remove um produto por ID
router.delete('/produto/:id', async (req, res) => {
    const { id } = req.params;
    try {
        const { rowCount } = await pool.query('DELETE FROM produto WHERE id = $1', [id]);
        if (rowCount) {
            res.status(204).send();
        } else {
            res.status(404).json({ message: 'Produto não encontrado' });
        }
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

module.exports = router;
