
const user=require('./user')
const picture=require('./picture')

module.exports=function(app){
app.use('/user',user);
app.use('/user/picture',picture);
}