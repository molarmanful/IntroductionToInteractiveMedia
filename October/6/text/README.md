# Generative Text

```
Romanesque with me. He said he, I believed I would be admirable to expect, to analyze it, and I must now. I would, but you upside-down. I never merrily that nobody know how I am glad my accountry, or else and so! Besides, it is a physician, and her has something, unclean now. I get tired. There covered me occasional questions about in the windows even if I don’t see I have, and when I tried to confusion. It is one of it hurt my will not have to the mattress we found fastened one’s own husband, the wind. I don’t blame her out of thing by day. I don’t want to a little girl?
```

For this project, I decided to try my hand at implementing a text generator using Markov chains.

## Demo Usage

Requires Node.JS:

```
node index.js
```

## Background

![Markov chain](https://upload.wikimedia.org/wikipedia/commons/thumb/2/2b/Markovkate_01.svg/220px-Markovkate_01.svg.png)

Markov chains are mathematical models which describe a sequence of possible events. Each event is probabilistically tied to previous events. For example, in the Markov chain depicted above, there are 2 events A and E. Starting at Event A, there is a 60% chance that Event E will follow and a 40% chance that Event A will follow. From Event E, there is a 70% chance that Event A will follow and a 30% chance that Event E will follow.

The ability of Markov chains to create simple yet powerful predictive models based on weighted probabilities makes it quite well-suited to a variety of fields. Markov chains have seen extensive use in fields like meteorology and finance. In fact, PageRank -- the algorithm that Google Search uses to sort webpages in its search results -- is actually a form of Markov chain.

## How it works

My program constructs a Markov chain from a reference text (in the demo, I used *The Yellow Wallpaper* by Charlotte Perkins Gilman). Each letter is an event, which means that subsequent letters will be generated based on the results of previous letters.

Markov chains are often classified into different numbers of states depending on how many events are considered at a time when determining the next event. For example, a 2-state Markov chain would consider 2 events in conjunction to determine the next event. Our text-generating Markov chain has a modifiable state number, which changes how many letters the Markov chain uses to determine the next letter. In terms of generated text, this means that the quality of the text overall increases with higher states -- at the cost of more restrictive generation. With *The Yellow Wallpaper*, I generally find 4-state or 5-state chains to yield the best results in both readability and freedom of generation.

## Issues

When I first started trying to implement the Markov chain, I was using Processing. However, I quickly realized that my ability to program in Java was inadequate; in addition, the amount of "type-wrangling" I had to do was becoming increasingly frustrating. I decided to switch over to JavaScript, a language I was significantly more familiar with. This had the wonderful effect of reducing much of the bloat that my initial Java code had produced, and also made the project much more manageable to conceptualize and work with.
