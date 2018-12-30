const userController=require('../controllers/user')

var express = require('express')
var router = express.Router()


router.post('/addUser',userController.addUser);
router.post('/login',userController.login);
router.get('/getUser',userController.getUser);
router.post('/Decrypt',userController.decrypt);



module.exports=router