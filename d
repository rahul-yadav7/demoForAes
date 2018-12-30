warning: LF will be replaced by CRLF in package-lock.json.
The file will have its original line endings in your working directory
warning: LF will be replaced by CRLF in package.json.
The file will have its original line endings in your working directory
[1mdiff --git a/controllers/picture.js b/controllers/picture.js[m
[1mdeleted file mode 100644[m
[1mindex 06b7294..0000000[m
[1m--- a/controllers/picture.js[m
[1m+++ /dev/null[m
[36m@@ -1,71 +0,0 @@[m
[31m-const PictureModel=require('../models/picture')[m
[31m-let upload=require('../utils/upload')[m
[31m-[m
[31m-let pictureController={}[m
[31m-[m
[31m-pictureController.addPicture=(req,res)=>{[m
[31m-    let uri="http://localhost:8080/uploads/"[m
[31m-    if(!req.file){[m
[31m-                return res.json(400,"image file required")[m
[31m-    }[m
[31m-    let picture=new PictureModel({[m
[31m-    	userId:req.body.userId,[m
[31m-        typeOfPicture:req.body.typeOfPicture,[m
[31m-        name:req.file.originalFileName,[m
[31m-        url:uri+req.file.filename,[m
[31m-        fileName:req.file.filename[m
[31m-    })[m
[31m-    picture.save((err,data)=>{[m
[31m-    	if(err){[m
[31m-    		res.json(500,"internal server error")[m
[31m-    	}else{[m
[31m-            res.json(200,"image succeessfully upload")[m
[31m-        }[m
[31m-    })[m
[31m-[m
[31m-}[m
[31m-[m
[31m-pictureController.updateImage=(req,res)=>{[m
[31m-    let update={}[m
[31m-let uri="http://localhost:8080/uploads/"[m
[31m-    if(!req.file){[m
[31m-        return res.json(400,"image file required")[m
[31m-    }[m
[31m-    update.name=req.file.originalFileName,[m
[31m-    update.url=uri+req.file.filename[m
[31m-[m
[31m-    PictureModel.update({_id:req.params.id},{$set:update},(err,data)=>{[m
[31m-        if(err){[m
[31m-            res.json(500,err)[m
[31m-        }else{[m
[31m-            res.json(200,"okkk")[m
[31m-        }[m
[31m-    })[m
[31m-}[m
[31m-[m
[31m-pictureController.deleteImage=(req,res)=>{[m
[31m-    PictureModel.findOne({_id:req.params.id},(err,data)=>{[m
[31m-        if(err){[m
[31m-            res.json(500,err)[m
[31m-        }else if(data){[m
[31m-require('fs').unlink(`/uploads/${data.fileName}`);[m
[31m-PictureModel.remove({_id:req.params.id},(err,data)=>{[m
[31m-    if(err){[m
[31m-        res.json(500,err)[m
[31m-    }else{[m
[31m-        res.json(200,"okk")[m
[31m-    }[m
[31m-})[m
[31m-[m
[31m-        }else{[m
[31m-            res.json(400,"sorry image not found")[m
[31m-        }[m
[31m-    })[m
[31m-}[m
[31m-[m
[31m-[m
[31m-[m
[31m-[m
[31m-[m
[31m-[m
[31m-module.exports=pictureController;[m
\ No newline at end of file[m
[1mdiff --git a/controllers/user.js b/controllers/user.js[m
[1mindex 244627f..aa0095c 100644[m
[1m--- a/controllers/user.js[m
[1m+++ b/controllers/user.js[m
[36m@@ -1,14 +1,17 @@[m
 let UserModel=require('../models/user');[m
 let bcrypt = require('bcryptjs');[m
 var mongoose = require('mongoose');[m
[31m-  var Schema = mongoose.Schema;[m
[32m+[m[32mvar jwt = require("jsonwebtoken");[m
[32m+[m[32mvar config =require('../config/userSecret')[m
[32m+[m[32mvar crypto = require('crypto')[m
[32m+[m[32mvar Schema = mongoose.Schema;[m
 let ObjectId=Schema.Types.ObjectId[m
 let userController={}[m
 [m
 [m
 //add user with email,password,name[m
 userController.addUser=(req,res)=>{[m
[31m-    if(!req.body.name){[m
[32m+[m	[32mif(!req.body.name){[m
     	return res.json(400,"required name field")[m
     }[m
     if(!req.body.email){[m
[36m@@ -17,31 +20,61 @@[m [muserController.addUser=(req,res)=>{[m
     if(!req.body.password){[m
     	return res.json(400,"password is required")[m
     }[m
[31m-[m
[31m-userController.createPasswordHash(req.body.password,(err,password)=>{[m
[32m+[m[32m    userController.createPasswordHash(req.body.password,(err,password)=>{[m
 	if(err){[m
 		res.json(500,"internal error")[m
[31m-	}else{[m
[32m+[m	[32m} else {[m
[32m+[m[41m    [m		[32mlet user =new UserModel(req.body)[m
[32m+[m			[32muser.password=password[m
[32m+[m			[32muser.save((err,data)=>{[m
[32m+[m				[32mif(err){[m
[32m+[m			[41m [m		[32mres.json(500,"internal server error")[m
[32m+[m				[32m} else {[m
[32m+[m					[32mres.json(201,{[m
[32m+[m						[32mstatus:"ok",[m
[32m+[m						[32muserId:data._id[m
[32m+[m					[32m})[m
[32m+[m				[32m}[m
[32m+[m			[32m})[m
[32m+[m		[32m}[m
[32m+[m	[32m})[m
[32m+[m[32m}[m
 [m
[31m-	let user =new UserModel(req.body)[m
[31m-	user.password=password[m
[31m-    user.save((err,data)=>{[m
[31m-    	if(err){[m
[31m-    		res.json(500,"internal server error")[m
[31m-    	}else{[m
[31m-    		res.json(201,{[m
[31m-    			status:"ok",[m
[31m-    			userId:data._id[m
[31m-    		})[m
[31m-    		[m
[32m+[m
[32m+[m[32m//login user with username and password[m
[32m+[m[32muserController.login=async (req,res)=>{[m
[32m+[m	[32mif(req.body.email && req.body.password){[m
[32m+[m		[32mUserModel.findOne({email:req.body.email},(err,userData)=>{[m
[32m+[m			[32mif(userData){[m
[32m+[m				[32muserController.passwordMatch(userData.password,req.body.password,(err,passResp)=>{[m
[32m+[m					[32mif(passResp){[m
[32m+[m						[32mlet userObj=userData.toObject()[m
[32m+[m						[32mdelete userObj.password[m
[32m+[m						[32mlet token=jwt.sign({userObj},config.jwtSecret)[m
[32m+[m						[32mres.status(200).json({[m
[32m+[m							[32muserToken:token[m
[32m+[m						[32m})[m
[32m+[m					[32m}else{[m
[32m+[m						[32mres.status(400).json({[m
[32m+[m							[32merr:"wrong password enter"[m
[32m+[m						[32m})[m
[32m+[m					[32m}[m
[32m+[m				[32m})[m
[32m+[m			[32m}else{[m
[32m+[m				[32mconsole.log(err,userData)[m
[32m+[m				[32mres.status(400).json({[m
[32m+[m					[32merr:"username/password not found2"[m
[32m+[m				[32m})[m
[32m+[m			[32m}[m
[32m+[m		[32m})[m
[32m+[m	[32m}else{[m
[32m+[m		[32mres.status(400).json({[m
[32m+[m			[32merr:"username/password not found"[m
[32m+[m		[32m})[m
 	}[m
[31m-})[m
[31m-    }[m
[31m-    })[m
 }[m
 [m
 //bcrypt js libraray for secure password[m
[31m-[m
 userController.createPasswordHash=(password,cb)=>{[m
 bcrypt.genSalt(10, function(err, salt) {[m
     bcrypt.hash(password, salt, function(err, hash) {[m
[36m@@ -58,80 +91,45 @@[m [mbcrypt.compare(pass,hash, function(err, res) {[m
 }[m
 [m
 [m
[31m-userController.updateUser=(req,res)=>{[m
[31m-	if(!req.body.name){[m
[31m-		return res.json(400,"name is required")[m
[31m-	}[m
[31m-	let update={}[m
[31m-	if(req.body.name)[m
[31m-		update.name=req.body.name[m
[31m-[m
[31m-	UserModel.update({_id:req.params.id},{$set:update},(err,update)=>{[m
[31m-		if(err){[m
[31m-			res.json(500,err)[m
[31m-		}else{[m
[31m-			res.json(200,"update successfully")[m
[31m-		}[m
[31m-	})[m
[31m-}[m
[31m-[m
[31m-userController.deleteUser=(req,res)=>{[m
[31m-[m
[31m-	UserModel.remove({_id:req.params.id},(err,remov)=>{[m
[31m-		if(err){[m
[31m-			res.json(500,"internal server eror")[m
[31m-		}else{[m
[31m-			res.json(200,"remove successfully")[m
[31m-		}[m
[31m-	})[m
[31m-}[m
[31m-[m
 userController.getUser=(req,res)=>{[m
 let condition={}[m
[31m- if(req.query.userId){[m
[31m- 	condition._id=req.query.userId[m
[31m- }[m
[31m-[m
[32m+[m[32m    if(req.query.userId){[m
[32m+[m[41m [m	[32m    condition._id=req.query.userId[m
[32m+[m[32m    }[m
 	UserModel.find(condition,(err,user)=>{[m
 		if(err){[m
[31m-			res.json(500,"internal server error")[m
[32m+[m			[32mres.json(400,"internal server error")[m
 		}else{[m
[31m-			res.json(200,{[m
[31m-				status:"ok",[m
[31m-				user:user[m
[31m-			})[m
[32m+[m[32m            let userString=JSON.stringify(user)[m
[32m+[m			[32muserController.crypto(userString,(err,encryptUser)=>{[m
[32m+[m			[32m if(err){[m
[32m+[m				[32mres.json(400,"internal server error1")[m
[32m+[m			[32m }else{[m
[32m+[m				[32m res.json(200,{[m
[32m+[m				[32m status:"ok",[m
[32m+[m					[32muser:user,[m
[32m+[m					[32mencryptData:encryptUser[m
[32m+[m				[32m})[m
[32m+[m			[32m }[m
[32m+[m		[32m })[m[41m	[m
 		}[m
 	})[m
 }[m
 [m
[31m-[m
[31m-[m
[31m-userController.getUserWithAllImages=(req,res)=>{[m
[31m-	let condition={}[m
[31m-	if(req.query.userId){[m
[31m-		condition._id=ObjectId(req.query.userId)[m
[31m-	}[m
[31m-	UserModel.aggregate([{[m
[31m-		$match:condition[m
[31m-	},{[m
[31m-		$lookup:{[m
[31m-			 from: "pictures",[m
[31m-         localField: "_id",[m
[31m-         foreignField: "userId",[m
[31m-         as: "pictures"[m
[31m-		}[m
[31m-	}]).exec((err,data)=>{[m
[31m-if(err){[m
[31m-	console.log("err",err)[m
[31m-	res.json(500,"sorry internal error")[m
[31m-}else{[m
[31m-	res.json(200,{[m
[31m-		status:"ok",[m
[31m-		user:data[m
[31m-	})[m
[32m+[m[32muserController.crypto=(text,cb)=>{[m
[32m+[m	[32mvar cipher = crypto.createCipher(config.algorithm,config.AesSecret)[m
[32m+[m	[32mvar crypted = cipher.update(text,'utf8','hex')[m
[32m+[m	[32mcrypted += cipher.final('hex');[m
[32m+[m	[32mcb(null,crypted)[m
 }[m
 [m
[31m-})[m
[32m+[m[32muserController.decrypt=(req,res)=>{[m
[32m+[m	[32mvar decipher = crypto.createDecipher(config.algorithm,config.AesSecret)[m
[32m+[m	[32mvar dec = decipher.update(req.body.text,'hex','utf8')[m
[32m+[m	[32mdec += decipher.final('utf8');[m
[32m+[m[32m    res.status(200).json({[m
[32m+[m		[32m"msg":JSON.parse(dec)[m
[32m+[m	[32m})[m
 }[m
 [m
 module.exports=userController;[m
\ No newline at end of file[m
[1mdiff --git a/package-lock.json b/package-lock.json[m
[1mindex 1a20b66..08c7283 100644[m
[1m--- a/package-lock.json[m
[1m+++ b/package-lock.json[m
[36m@@ -63,6 +63,11 @@[m
       "resolved": "https://registry.npmjs.org/bson/-/bson-1.1.0.tgz",[m
       "integrity": "sha512-9Aeai9TacfNtWXOYarkFJRW2CWo+dRon+fuLZYJmvLV3+MiUp0bEI6IAZfXEIg7/Pl/7IWlLaDnhzTsD81etQA=="[m
     },[m
[32m+[m[32m    "buffer-equal-constant-time": {[m
[32m+[m[32m      "version": "1.0.1",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/buffer-equal-constant-time/-/buffer-equal-constant-time-1.0.1.tgz",[m
[32m+[m[32m      "integrity": "sha1-+OcRMvf/5uAaXJaXpMbz5I1cyBk="[m
[32m+[m[32m    },[m
     "buffer-from": {[m
       "version": "1.1.1",[m
       "resolved": "https://registry.npmjs.org/buffer-from/-/buffer-from-1.1.1.tgz",[m
[36m@@ -147,6 +152,11 @@[m
       "resolved": "https://registry.npmjs.org/core-util-is/-/core-util-is-1.0.2.tgz",[m
       "integrity": "sha1-tf1UIgqivFq1eqtxQMlAdUUDwac="[m
     },[m
[32m+[m[32m    "crypto": {[m
[32m+[m[32m      "version": "1.0.1",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/crypto/-/crypto-1.0.1.tgz",[m
[32m+[m[32m      "integrity": "sha512-VxBKmeNcqQdiUQUW2Tzq0t377b54N2bMtXO/qiLa+6eRRmmC4qT3D4OnTGoT/U6O9aklQ/jTwbOtRMTTY8G0Ig=="[m
[32m+[m[32m    },[m
     "debug": {[m
       "version": "2.6.9",[m
       "resolved": "https://registry.npmjs.org/debug/-/debug-2.6.9.tgz",[m
[36m@@ -174,6 +184,14 @@[m
         "streamsearch": "0.1.2"[m
       }[m
     },[m
[32m+[m[32m    "ecdsa-sig-formatter": {[m
[32m+[m[32m      "version": "1.0.10",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/ecdsa-sig-formatter/-/ecdsa-sig-formatter-1.0.10.tgz",[m
[32m+[m[32m      "integrity": "sha1-HFlQAPBKiJffuFAAiSoPTDOvhsM=",[m
[32m+[m[32m      "requires": {[m
[32m+[m[32m        "safe-buffer": "^5.0.1"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
     "ee-first": {[m
       "version": "1.1.1",[m
       "resolved": "https://registry.npmjs.org/ee-first/-/ee-first-1.1.1.tgz",[m
[36m@@ -289,6 +307,48 @@[m
       "resolved": "https://registry.npmjs.org/isarray/-/isarray-0.0.1.tgz",[m
       "integrity": "sha1-ihis/Kmo9Bd+Cav8YDiTmwXR7t8="[m
     },[m
[32m+[m[32m    "jsonwebtoken": {[m
[32m+[m[32m      "version": "8.4.0",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/jsonwebtoken/-/jsonwebtoken-8.4.0.tgz",[m
[32m+[m[32m      "integrity": "sha512-coyXjRTCy0pw5WYBpMvWOMN+Kjaik2MwTUIq9cna/W7NpO9E+iYbumZONAz3hcr+tXFJECoQVrtmIoC3Oz0gvg=="