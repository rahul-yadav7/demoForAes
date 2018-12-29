const PictureModel=require('../models/picture')
let upload=require('../utils/upload')

let pictureController={}

pictureController.addPicture=(req,res)=>{
    let uri="http://localhost:8080/uploads/"
    if(!req.file){
                return res.json(400,"image file required")
    }
    let picture=new PictureModel({
    	userId:req.body.userId,
        typeOfPicture:req.body.typeOfPicture,
        name:req.file.originalFileName,
        url:uri+req.file.filename,
        fileName:req.file.filename
    })
    picture.save((err,data)=>{
    	if(err){
    		res.json(500,"internal server error")
    	}else{
            res.json(200,"image succeessfully upload")
        }
    })

}

pictureController.updateImage=(req,res)=>{
    let update={}
let uri="http://localhost:8080/uploads/"
    if(!req.file){
        return res.json(400,"image file required")
    }
    update.name=req.file.originalFileName,
    update.url=uri+req.file.filename

    PictureModel.update({_id:req.params.id},{$set:update},(err,data)=>{
        if(err){
            res.json(500,err)
        }else{
            res.json(200,"okkk")
        }
    })
}

pictureController.deleteImage=(req,res)=>{
    PictureModel.findOne({_id:req.params.id},(err,data)=>{
        if(err){
            res.json(500,err)
        }else if(data){
require('fs').unlink(`/uploads/${data.fileName}`);
PictureModel.remove({_id:req.params.id},(err,data)=>{
    if(err){
        res.json(500,err)
    }else{
        res.json(200,"okk")
    }
})

        }else{
            res.json(400,"sorry image not found")
        }
    })
}






module.exports=pictureController;