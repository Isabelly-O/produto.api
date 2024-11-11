require('dotenv').config({ path: './var.env' });

var express = require('express'),
    path = require('path'),
    bodyParser = require('body-parser'),
    cons = require ('consolidate'),
    pg = require('pg'),
    app = express();

var connect = `postgres://${process.env.DB_USER}:${process.env.DB_PASSWORD}@${process.env.DB_HOST}/${process.env.DB_NAME}`;
const port = 3000;
const host = '192.168.1.14';
const produtosRoutes = require('./routes/produtosRoute.js')

app.use(express.json());

app.use(express.static(path.join(__dirname, 'public')));

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({extended: false}));

/////////////////////////
app.get('/',function(req, res){
    console.log(`aa`);
})
//////////////////////////

app.use('/', produtosRoutes);

app.listen(port, host, () => {
});
