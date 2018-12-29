const userController=require('../controllers/user')

var express = require('express')
var router = express.Router()


router.post('/addUser',userController.addUser);
router.put('/updateUser/:id',userController.updateUser)
router.delete('/deleteUser:id',userController.deleteUser)

router.get('/getUser',userController.getUser);

router.get('/getUserWithAllImages',userController.getUserWithAllImages)


module.exports=router