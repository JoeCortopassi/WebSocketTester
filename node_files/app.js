
var io = require('socket.io').listen(8000);




var buffer = [];
io.on('connection', function(client){
    
    client.send({ buffer: buffer });
    //client.broadcast({ announcement: client.sessionId + ' connected' });

    client.on('message', function(message){
      console.log("Message: " + message);
//        var msg = { message: [client.sessionId, message] };
//        buffer.push(msg);
//        if (buffer.length > 15) buffer.shift();
//        client.broadcast(msg);
    });

    client.on('disconnect', function(){
     //   client.broadcast({ announcement: client.sessionId + ' disconnected' });
    });
});