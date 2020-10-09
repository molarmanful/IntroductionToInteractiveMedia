// MARKOV CHAIN IMPLEMENTATION CODE

// helpers
let rand = x=> x[0 | Math.random() * x.length]
let count = (x, r)=> (x.match(r) || []).length


module.exports = class Chain {

  // CONSTRUCTOR ARGUMENTS
  // text   : String                     : reference text to construct chain from
  // states : Number (default: 5)        : number of letters to use for consideration at a time
  // start  : RegExp (default: /^[A-Z]/) : character set to denote sentence beginnings
  // sep    : String (default: ' ')      : word separator (e.g. space)
  // end    : RegExp (default: /[.!?]/g) : punctuation to denote sentence endings
  // endc   : indexable (default: '.!?') : string version of `end` for internal usage

  constructor(text, states = 5, start = /^[A-Z]/, sep = ' ', end = /[.!?]/g, endc = '.!?'){
    this.text = text
    this.states = states
    this.start = start
    this.sep = sep
    this.end = end
    this.endc = endc
    this.chain = {}

    this.build()
  }

  // constructs a Markov chain from given text
  // automatically performed during constructor
  // NOTE: internally, the chain is stored as an object
  // - keys -> sequences of characters (length determined by state number)
  // - values -> potential next character
  // - trivializes determination of subsequent events
  // - removes the need to do any math

  build(){
    // iterate through every character in the text...
    [...this.text].map((c, i)=>{
      // build key-value pairs based on state number
      let key = this.text.slice(i, i + this.states)
      this.chain[key] = this.chain[key] || ''
      this.chain[key] += this.text[i + this.states] || this.sep
    })
  }

  // generate new text using the constructed Markov chain
  // ARGUMENTS
  // n : Number (default: 1) : number of sentences to generate

  gen(n = 1){
    // set initial output/starting event to existing sentence starters
    // if none are found, then simply start with a random key
    let keys = Object.keys(this.chain)
    let output = rand(keys.filter(a=> a[0].match(this.start))) || rand(keys)

    // while not all sentences are done generating...
    while(count(output, this.end) < n){
      // get potential next events from last [state number] letters in output
      // if the key somehow doesn't exist, then find a close match and continue
      let cur = output.slice(-this.states)
      let cands = this.chain[cur] || keys.find(a=> cur.contains(a))

      output += rand(cands)
    }

    return output
  }
}
