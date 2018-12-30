let UserModel=require('../models/user');
let bcrypt = require('bcryptjs');
var mongoose = require('mongoose');
var jwt = require("jsonwebtoken");
var config =require('../config/userSecret')
var crypto = require('crypto')
var Schema = mongoose.Schema;
let ObjectId=Schema.Types.ObjectId
let userController={}


//add user with email,password,name
userController.addUser=(req,res)=>{
	if(!req.body.name){
    	return res.json(400,"required name field")
    }
    if(!req.body.email){
    	return res.json(400,"required email field")
    }
    if(!req.body.password){
    	return res.json(400,"password is required")
    }
    userController.createPasswordHash(req.body.password,(err,password)=>{
	if(err){
		res.json(500,"internal error")
	} else {
    		let user =new UserModel(req.body)
			user.password=password
			user.save((err,data)=>{
				if(err){
			 		res.json(500,"internal server error")
				} else {
					res.json(201,{
						status:"ok",
						userId:data._id
					})
				}
			})
		}
	})
}


//login user with username and password
userController.login=async (req,res)=>{
	if(req.body.email && req.body.password){
		UserModel.findOne({email:req.body.email},(err,userData)=>{
			if(userData){
				userController.passwordMatch(userData.password,req.body.password,(err,passResp)=>{
					if(passResp){
						let userObj=userData.toObject()
						delete userObj.password
						let token=jwt.sign({userObj},config.jwtSecret)
						res.status(200).json({
							userToken:token
						})
					}else{
						res.status(400).json({
							err:"wrong password enter"
						})
					}
				})
			}else{
				console.log(err,userData)
				res.status(400).json({
					err:"username/password not found2"
				})
			}
		})
	}else{
		res.status(400).json({
			err:"username/password not found"
		})
	}
}

//bcrypt js libraray for secure password
userController.createPasswordHash=(password,cb)=>{
bcrypt.genSalt(10, function(err, salt) {
    bcrypt.hash(password, salt, function(err, hash) {
    	cb(err,hash)
    });
});
}

userController.passwordMatch=(hash,pass,cb)=>{
bcrypt.compare(pass,hash, function(err, res) {
    // res === true
   cb(err,res);
});
}


userController.getUser=(req,res)=>{
let condition={}
    if(req.query.userId){
 	    condition._id=req.query.userId
    }
	UserModel.find(condition,(err,user)=>{
		if(err){
			res.json(400,"internal server error")
		}else{
            let userString=JSON.stringify(user)
			userController.crypto(userString,(err,encryptUser)=>{
			 if(err){
				res.json(400,"internal server error1")
			 }else{
				 res.json(200,{
				 status:"ok",
					user:user,
					encryptData:encryptUser
				})
			 }
		 })	
		}
	})
}

userController.crypto=(text,cb)=>{
	var cipher = crypto.createCipher(config.algorithm,config.AesSecret)
	var crypted = cipher.update(text,'utf8','hex')
	crypted += cipher.final('hex');
	cb(null,crypted)
}

userController.decrypt=(req,res)=>{
	var decipher = crypto.createDecipher(config.algorithm,config.AesSecret)
	var dec = decipher.update(req.body.text,'hex','utf8')
	dec += decipher.final('utf8');
    res.status(200).json({
		"msg":JSON.parse(dec)
	})
}

module.exports=userController;