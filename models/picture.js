var mongoose = require('mongoose');
  var Schema = mongoose.Schema;

  var pictureSchema = new Schema({
  
 userId:{type:Schema.Types.ObjectId, ref: 'user'},
 typeOfPicture:{type:String},
 	name:{type:String},
 	url:{type:String},
 	fileName:{type:String}
  },
  { timestamps: { createdAt: 'created_at',updatedAt:'updated_at' } })


  module.exports = mongoose.model('picture',pictureSchema)