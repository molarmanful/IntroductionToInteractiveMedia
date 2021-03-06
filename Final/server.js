const express = require('express')
const http = require('http')
const bodyParser = require('body-parser')
const WebSocket = require('ws')
const path = require('path')

const app = express()
app.use(bodyParser.urlencoded({extended: false}))
app.use(bodyParser.json())
app.use(express.static('public'))

const server = http.createServer(app)
const wss = new WebSocket.Server({server})

let power = 0
// let cool
// let down

app.get('/power', (req, res)=>{
  res.send(power)
})

let updateClients = _=>{
  wss.clients.forEach(client=>{
    if(client.readyState == WebSocket.OPEN){
      client.send(JSON.stringify({
        power: power,
        clients: wss.clients.size
      }))
    }
  })
}

wss.on('connection', ws=>{
  console.log('connected')
  updateClients()

  ws.on('message', data=>{
    if(data == 'scratch'){
      console.log('scratch received')

      if(power < 100){
        console.log('power increasing')

        power++
        // clearTimeout(cool)
        // clearInterval(down)

        let time = 3000 - (wss.clients.size - 1) * 200
        if(time < 500) time = 500

        setTimeout(_=>{
          console.log('power decreasing ' + time)

          power--
          updateClients()

          // down = setInterval(_=>{
          //   if(power > 0){
          //     power--
          //   }
          //   else {
          //     clearInterval(down)
          //     console.log('power at 0')
          //   }
          //   updateClients()
          // }, 100)

        }, time)

      }
    }

    updateClients()
  })

  ws.on('close', _=>{
    console.log('disconnected')
    updateClients()
  })
})

server.listen(3000, _=>{
  console.log('Listening @ 3000')
})
