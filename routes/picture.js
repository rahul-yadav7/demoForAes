
const pictureController=require('../controllers/picture');
let upload=require('../utils/upload')

var express = require('express')
var router = express.Router()


router.post('/addPicture',upload.uploadImage,pictureController.addPicture);
router.delete('/deleteImage',pictureController.deleteImage)

router.put('/updateImage',upload.uploadImage,pictureController.updateImage)

module.exports=router