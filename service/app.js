// const userApi = require('./api/userApi');
const userApi_new = require('./api/userApi_new');

const fs = require('fs');
const path = require('path');
const bodyParser = require('body-parser');
const express = require('express');
const app = express();

app.use(bodyParser.json());
app.use(bodyParser.urlencoded())

app.use('/api/user', userApi_new);

app.listen(3000);
console.log('success listen at port: 3000')
