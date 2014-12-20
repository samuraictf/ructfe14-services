Jetpack9 is a brand new technology for jet-travelers to make their trip as incredible as it can get.
Imagine you taking your new shiny jetpack out for a try.
Where would you be heading? Nowhere near, I guess.
And what to do all along your way? Nothing particularly interesting, I guess.
But. With Jetpack9 you can see all the interesting places somewhere near.
New bar? Beautiful park? Strip club? Everything that may catch your eye in a matter of seconds!
Give it a try!

Each jetpack hosts it's own shard of Jetpack9 for load distribution and ubiquitousness.
With Jetpack9 shard you can either find interesting places along your path or discover some company.

Protocol is simple as that:
byte 0: Request type. It's 0 or 1 for path finding and companions discovery respectively.
Then go coordinates on the map that comes with each distribution of Jetpack9
We're sorry, but this function is only available in your local region.
bytes 1-2: Source x coordinate
bytes 3-4: Source y coordinate
bytes 5-6: Destination x coordinate
bytes 7-8: Destination y coordinate
If you want to find a path, you should also provide your jetpack unique ID (you can find it between turbines)
bytes 9-40: Your jetpack ID

Enjoy!