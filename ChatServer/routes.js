const express = require("express");
const router = express.Router();
const multer = require("multer");

const storage = multer.diskStorage({
    destination: function(req,file,cb){
        cb(null , "./uploads");
    },
    filename: function(req,file,cb){
        cb(null,Date.now()+".jpg");
    }
})


const upload = multer({
     storage:storage
})

router.route("/addimage").post(upload.single("img") , function(req,res){
    try {
        res.json({path: req.file.filename});
    } catch (error) {
        return res.json({error:e});
    }
})

module.exports = router;