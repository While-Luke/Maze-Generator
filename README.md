# Maze-Generator

This was a random idea I came up with to randomly generate 2D mazes. It works by having a 'builder' object randomly move around a 2D grid, removing the walls between every cell that it visits and never visiting a cell that has already been visited. If the builder can travel in multiple directions, it has a small chance to create another builder to also start moving randomly, thus creating the different paths.
