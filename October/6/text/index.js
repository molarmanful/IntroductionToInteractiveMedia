const fs = require('fs')
const Chain = require('./chain.js')

let data = ' ' + fs.readFileSync(process.argv[2] || 'data.txt')
data = data.replace(/\n/g, ' ')
           .replace(/ +/g, ' ')
           .replace(/[^a-z.!?,\-’' ]/ig, '')

console.log('SAMPLE OUTPUTS\n---')

;[1, 2, 3, 4, 5, 10].map(s=>{
  console.log('\nSTATE ' + s)
  console.log(new Chain(data, s).gen(10))
})
