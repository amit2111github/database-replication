const express = require("express");
const {Pool} = require("pg");
const app = express();
const port = 9000;
const masterPool = new Pool({
    host : "localhost",
    port : 5641,
    database : "postgres",
    user : "postgres",
    password : "password"
})
const slavePool = new Pool({
    host : "localhost",
    port : 5662,
    database : "postgres",
    user : "postgres",
    password : "password"
})
const createTable = async () => {
    await masterPool.query(`create table if not exists t (id serial primary key, name text)`);
};
createTable();
app.get("/" , async (req , res) => {
    const {rows} = await slavePool.query(`select * from t`);
    return res.json(rows);
});

app.get("/add/:name" , async (req , res) => {
    const {name} = req.params;
    const {rows} = await masterPool.query(`insert into t (name) values ($1) returning *`,[name]);
    res.json(rows);
})
app.listen(port , () => {
    console.log(`Running on port ${port}`);
});