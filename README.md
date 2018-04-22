#  Frog Game

Written by John Kennedy

![SwiftGame/screenshot.png]

* Xcode 9.3
* Swift 4.1
* iOS 11
* iPhone

A simple 2D SpriteKit based retro arcade game, currently in progress.


## To use

Download the repo and load the project into Xcode 9.3 or 9.4. It should compile without complaint and run on the emulator. At the moment, it's only been tested on iPhone X and iPhone 8 Plus screen sizes.

Unlike the more traditional Frog game, you can only move up and down the screen, not left and right. Tap the lower part of the screen to jump forward, and the upper part to jump backwards.

Also unlike the more traditional game, you don't lose a life if you scroll off the side of the water while sitting on a log or row of turtles.


## To do

* Move to new level when all lillypads are occupied.
* Actual levels rather than randomly generated positions for logs etc. which can sometimes be impossible.
* Sound effects, and high score table.
* Animations when killed, jumping and so on.
* More game play elements including flies, crocodiles etc.



## Things I learned..

Every. Single. Time I try to write a game using SpriteKit (which I love) I make the mistake of letting the physics engine and collision detection do too much. It just leads to unreliable game play and lots and lots of checking for corner cases. It's must better to keep track of co-ordinates etc yourself, and let the SpriteKit code move them between these positions. Never assume that because you tell a Sprite to move 96 pixels using some MoveBy action that it's going to move exactly 96 pixels. You should move the co-ordinate yourself and get SpriteKit to update the position. i.e. rely on your internal map rather than counting on SpriteKit to keep track of it for you. You can however, depend on the collision detection.

## Credits

* I bodged the sprite images together myself.
* The cool typeface I got from 1001Fonts and is called Press Start

## License

This project is released under the MIT license.

Copyright (c) 2018 John T. Kennedy

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
