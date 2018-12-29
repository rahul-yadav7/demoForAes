var mongoose = require('mongoose');
  var Schema = mongoose.Schema;

  var userSchema = new Schema({
  
  name:{type:String,trim:true,required:true},
  email:{type:String,required:true,trim:true},
  password:{type:String,required:true},

  },
    { timestamps: { createdAt: 'created_at',updatedAt:'updated_at' } })



  module.exports = mongoose.model('user',userSchema)