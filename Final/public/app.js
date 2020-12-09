let ws

Vue.createApp({
  data(){
    return {
      power: 0,
      clients: 0,
      cd: false,
      clicked: false
    }
  },

  mounted(){
    this.initSocket()
  },

  methods: {
    initSocket(){
      if(ws){
        ws.onerror = ws.onopen = ws.onclose = null
        ws.close()
      }

      ws = new WebSocket('ws://backscratcher.ngrok.io')

      ws.onopen = _=>{
        console.log('opened')
        app.classList.remove('unloaded')
      }
      ws.onmessage = ({data})=>{
        console.log('data received')
        let d = JSON.parse(data)
        this.power = d.power
        this.clients = d.clients

        document.body.className =
          this.power >= 70 ? 'hard'
          : this.power >= 50 ? 'med'
          : this.power >= 20 ? 'light'
          : ''
      }
      ws.onclose = _=>{
        console.log('closed')
        ws = null
      }
    },

    scratch(){
      if(!this.clicked){
        this.clicked = true
      }

      if(!ws){
        console.error('socket disconnected')
        return
      }

      ws.send('scratch')
    }
  }

}).mount('#app')
