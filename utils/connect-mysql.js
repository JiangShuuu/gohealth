import mysql from "mysql2/promise";

import "dotenv/config.js";

const { DB_HOST, DB_USER, DB_PASS, DB_NAME, DB_PORT } = process.env;

const db = await mysql.createPool({
  host: DB_HOST,
  user: DB_USER,
  password: DB_PASS,
  database: DB_NAME,
  port: DB_PORT,
  waitForConnections: true,
  connectionLimit: 5,
  queueLimit: 0,
});

export default db;
