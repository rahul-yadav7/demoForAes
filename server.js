var express=require('express');
var path=require('path')
var app=express();
const mongoose = require('mongoose');
var bodyParser = require('body-parser')
mongoose.connect('mongodb://localhost/test');


app.use(bodyParser.urlencoded({ extended: true }))
 
// parse application/json
app.use(bodyParser.json())
 
app.use("/uploads", express.static(path.join(__dirname, 'uploads')));

app.listen(8080);
console.log("port is running",8080)
require('./routes/index.js')(app)

app.get('/',(req,res)=>{
	res.json("hello test")
})
