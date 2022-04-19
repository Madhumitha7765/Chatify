// https://warm-atoll-34063.herokuapp.com/

const express = require("express");
var http = require("http");
const ms = require("ms");

const app = express();
const port = process.env.PORT || 7000;

var server = http.createServer(app);
var io = require("socket.io")(server);

// middleware
app.use(express.json());
var clients = {};

const routes = require("./routes");
app.use("/routes",routes)
app.use("/uploads",express.static("uploads"));

io.on("connection", function(socket){
    console.log("Connected");
    console.log(socket.id,"has joined!");
    socket.on("signin",function(id){
        console.log(id);
        clients[id] = socket;
        console.log(clients);
    })

    socket.on("message",function(msg){
        console.log(msg);
        let targetId = msg.targetId;
        if (clients[targetId]) {
            clients[targetId].emit("message",msg);
        }
        
    })
});

app.route("/check").get(function(req,res){
    return res.json("Your app is working fine!");
});

server.listen(port , "0.0.0.0", function(){
    console.log("Server started on port "+port);
});