# 3-Light Passcode

![Circuit](pass.png)

A relatively simple circuit which generates a 4-length sequence from 3 lights that the user must guess correctly.

## Problems

Most of my issues were relating to the flashing of lights to indicate correct or incorrect answers. Part of the issue was that it was somewhat difficult to find suitable patterns to distinguish the two outcomes. However, I eventually found that flashing lights would work well for incorrect, and "successions" of lights would work well for correct.

I had some issues with storing the password itself; initially, I used a boolean array, but felt that this was too complicated a solution. Instead, I opted to use a single number to store the light sequence, which greatly simplified the computation needed to store, retrieve, and verify the password.
