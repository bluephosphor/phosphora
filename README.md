### Technologies used: <span style="color:green">GML</span> | <span style="color:gray">GLSL</span> 

<a class="source-link" target="_blank" href="https://github.com/bluephosphor/phosphora-2-3">[Source]</a>

![Phosphora](https://bluephosphor.github.io/portfolio/asset/img/projects/phos_header.gif)

My main Game Maker project! I've been working on this on and off for a few years now when I have the time. Some key technical features I've built for this include.

#### Procedural level generation

- Several level generation algorithms were written for use in various areas, including Drunken Walk, Cellular Automata, and even a custom Maze generator using a Recursive Backtracking algorithm.

![Some generated-maps](https://bluephosphor.github.io/portfolio/asset/img/projects/phos_maps.png)
<div class="img-footer">Ordered: Cellular Automata, Drunken Walk, Recursive Backtracking Maze</div>

#### State Machines and Enemy AI

- Both the player and all mobile entities operate on a custom state machine. 

- Utilizing state concepts, the player is able to have complex behaviors with no interferance between states. The player can run, spin attack, be in hitstun, and also swim.

- Enemies can have passive, aggro and other states. Often times, sub states will be used to create even more complex behaviors (different attack patterns, blocking, ect.).

<div class="img-collection">
    <img class="img-collection-piece" src="https://bluephosphor.github.io/portfolio/asset/img/projects/88.gif">
    <img class="img-collection-piece" src="https://bluephosphor.github.io/portfolio/asset/img/projects/96b.gif">
</div>

#### UI Elements

![menus, inventories!](https://bluephosphor.github.io/portfolio/asset/img/projects/107.gif)