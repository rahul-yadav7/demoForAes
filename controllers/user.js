let UserModel=require('../models/user');
let bcrypt = require('bcryptjs');
var mongoose = require('mongoose');
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
	}else{

	let user =new UserModel(req.body)
	user.password=password
    user.save((err,data)=>{
    	if(err){
    		res.json(500,"internal server error")
    	}else{
    		res.json(201,{
    			status:"ok",
    			userId:data._id
    		})
    		
	}
})
    }
    })
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


userController.updateUser=(req,res)=>{
	if(!req.body.name){
		return res.json(400,"name is required")
	}
	let update={}
	if(req.body.name)
		update.name=req.body.name

	UserModel.update({_id:req.params.id},{$set:update},(err,update)=>{
		if(err){
			res.json(500,err)
		}else{
			res.json(200,"update successfully")
		}
	})
}

userController.deleteUser=(req,res)=>{

	UserModel.remove({_id:req.params.id},(err,remov)=>{
		if(err){
			res.json(500,"internal server eror")
		}else{
			res.json(200,"remove successfully")
		}
	})
}

userController.getUser=(req,res)=>{
let condition={}
 if(req.query.userId){
 	condition._id=req.query.userId
 }

	UserModel.find(condition,(err,user)=>{
		if(err){
			res.json(500,"internal server error")
		}else{
			res.json(200,{
				status:"ok",
				user:user
			})
		}
	})
}



userController.getUserWithAllImages=(req,res)=>{
	let condition={}
	if(req.query.userId){
		condition._id=ObjectId(req.query.userId)
	}
	UserModel.aggregate([{
		$match:condition
	},{
		$lookup:{
			 from: "pictures",
         localField: "_id",
         foreignField: "userId",
         as: "pictures"
		}
	}]).exec((err,data)=>{
if(err){
	console.log("err",err)
	res.json(500,"sorry internal error")
}else{
	res.json(200,{
		status:"ok",
		user:data
	})
}

})
}

module.exports=userController;