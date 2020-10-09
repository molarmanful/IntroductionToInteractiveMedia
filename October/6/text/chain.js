let rand = x=> x[0 | Math.random() * x.length]
let count = (x, r)=> (x.match(r) || []).length

module.exports = class Chain {
  constructor(text, states = 4, sep = ' ', end = /[.!?]/g, endc = '.!?'){
    this.text = text
    this.states = states
    this.sep = sep
    this.end = end
    this.endc = endc
    this.chain = {}

    this.build()
  }

  build(){
    [...this.text].map((c, i)=>{
      let key = this.text.slice(i, i + this.states)
      this.chain[key] = this.chain[key] || ''
      this.chain[key] += this.text[i + this.states] || this.sep
    })
  }

  gen(n = 1){
    let output = rand(Object.keys(this.chain).filter(a=> a[0].match(/[A-Z]/)))

    while(count(output, this.end) < n){
      let cands = this.chain[output.slice(-this.states)] || this.endc
      output += rand(cands)
    }

    return output
  }
}
