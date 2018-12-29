var multer  = require('multer')


var storage = multer.diskStorage({
    destination: function (req, file, callback) {
        file.originalFileName = file.originalname;
        callback(null, './uploads');
    },
    filename: function (req, file, callback) {
        var im = file.originalname.split('.')
        var ran = Math.floor((Math.random() * 100) + 1);
        callback(null, ran + Date.now() + '.' + im[im.length - 1]);
    },
});
var upload = multer({
    storage: storage
}).single('file');

exports.uploadImage = (req, res, callback) => {
    upload(req, res, function (err) {
        if (err) {
            console.log("errrr is", err)
            return res.end("Error uploading file.", err);
        }
        callback(null, req.file)
    });
};