# GameOfLife
An Implementation of Conway's Game of Life in Processing

---

Brief description of the animation achieved:
A cellular automaton consists a collection of "cells" in grid where each cell has
finite number of states. The evolution of the cells is governed by a set of 
rules which determines which cells live, die or are reborn. Conways's Game of 
life is a well known example of cellular automaton. 

This program executes Conway's game of life. 
A grid is drawn onscreen, the "alive" and "dead" cells are indicated on the grid
and evolution of cells according to the Game of Life rules is shown.

###Known bugs/problems:
- When the evolution of the game is stopped, the reset key does not work.
- When the reset key is repeatedly pressed the animation halts/slow down 
  sometimes.
- While resetting the game the generation counter shows an inaccurate number
  for a brief period.

###Sources  
- Examples in processing.org
  - Arrays
  - Array 2D
  - Iteration
  - Embedded Iteration
  - Logical Operators
- Processing style guidelines from 
  https://github.com/processing/processing/wiki/Style-Guidelines
- YouTube video by a channel called "The Coding Train" on the game of life
  https://www.youtube.com/watch?v=FWSR_7kZuYg 
