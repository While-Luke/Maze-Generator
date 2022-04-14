//grid area, builder blocks take up one space, every turn, builders check to see if they can move in one direction, if they can move in multiple directions //<>//
//they have a chance to create a new builder in one of the those directions

//each turn, check to tsee if they can move, check to see if there is more than one places around them they can move, if there is create new builder, then move

int horiz = 20;
int vert = 20;
int block_size = 40;

int[][] taken;
IntDict[][] sides;

ArrayList<PVector> builders;
int count;
IntList open = new IntList();
boolean stop;

void setup() {
  size(800, 800);
  frameRate(30); //change framerate to change speed of maze building

  taken = new int[horiz][vert];

  sides = new IntDict[horiz][vert];
  for (int i = 0; i < vert; i++) {
    for (int j = 0; j < horiz; j++) {
      sides[i][j] = new IntDict();

      sides[i][j].set("North", 1);
      sides[i][j].set("East", 1);
      sides[i][j].set("South", 1);
      sides[i][j].set("West", 1);
    }
  }

  builders = new ArrayList<PVector>();
  builders.add(new PVector(0, 0));
  taken[0][0] = 1;
}

void draw() {
  background(255);

  if (builders.size() > 0) {
    for (int i = 0; i < builders.size(); i++) {

      count = 0;
      open.clear();
      if (builders.get(i).x != 0 && taken[int(builders.get(i).x) - 1][int(builders.get(i).y)] == 0) {
        count+= 1;
        open.append(4);
      }
      if (builders.get(i).x != horiz-1 && taken[int(builders.get(i).x) + 1][int(builders.get(i).y)] == 0) {
        count+= 1;
        open.append(2);
      }
      if (builders.get(i).y != 0 && taken[int(builders.get(i).x)][int(builders.get(i).y) - 1] == 0) {
        count+= 1;
        open.append(1);
      }
      if (builders.get(i).y != vert-1 && taken[int(builders.get(i).x)][int(builders.get(i).y) + 1] == 0) {
        count+= 1;
        open.append(3);
      }

      if (count == 0) {
        builders.remove(i);
        if (builders.size() == 0) {
          stop = false;
          for (int k = 0; k < vert; k++) {
            for (int l = 0; l < horiz; l++) {
              if (taken[k][l] == 0 && stop == false) {
                if (k == 0) {
                  builders.add(new PVector(k, l));
                  taken[k][l] = 1;
                  sides[k][l].set("North", 0);
                  sides[k][l-1].set("South", 0);
                } else {
                  builders.add(new PVector(k, l));
                  taken[k][l] = 1;
                  sides[k][l].set("West", 0);
                  sides[k-1][l].set("East", 0);
                }
                stop = true;
              }
            }
          }
          break;
        } else {
          i--;
          continue;
        }
      }

      if (count > 1) {
        if (int(random(4)) == 0) {
          switch(open.get(int(random(open.size())))) {
            case(1):
            builders.add(new PVector(builders.get(i).x, builders.get(i).y-1));
            taken[int(builders.get(i).x)][int(builders.get(i).y-1)] = 1;
            sides[int(builders.get(i).x)][int(builders.get(i).y)].set("North", 0);
            sides[int(builders.get(i).x)][int(builders.get(i).y-1)].set("South", 0);
            for (int j = 0; j < open.size(); j++) {
              if (open.get(j) == 1) {
                open.remove(j);
                break;
              }
            }
            break;

            case(2):
            builders.add(new PVector(builders.get(i).x+1, builders.get(i).y));
            taken[int(builders.get(i).x+1)][int(builders.get(i).y)] = 1;
            sides[int(builders.get(i).x)][int(builders.get(i).y)].set("East", 0);
            sides[int(builders.get(i).x+1)][int(builders.get(i).y)].set("West", 0);
            for (int j = 0; j < open.size(); j++) {
              if (open.get(j) == 2) {
                open.remove(j);
                break;
              }
            }
            break;

            case(3):
            builders.add(new PVector(builders.get(i).x, builders.get(i).y+1));
            taken[int(builders.get(i).x)][int(builders.get(i).y+1)] = 1;
            sides[int(builders.get(i).x)][int(builders.get(i).y)].set("South", 0);
            sides[int(builders.get(i).x)][int(builders.get(i).y+1)].set("North", 0);
            for (int j = 0; j < open.size(); j++) {
              if (open.get(j) == 3) {
                open.remove(j);
                break;
              }
            }
            break;

            case(4):
            builders.add(new PVector(builders.get(i).x-1, builders.get(i).y));
            taken[int(builders.get(i).x-1)][int(builders.get(i).y)] = 1;
            sides[int(builders.get(i).x)][int(builders.get(i).y)].set("West", 0);
            sides[int(builders.get(i).x-1)][int(builders.get(i).y)].set("East", 0);
            for (int j = 0; j < open.size(); j++) {
              if (open.get(j) == 4) {
                open.remove(j);
                break;
              }
            }
            break;
          }
        }
      }

      switch(open.get(int(random(open.size())))) {
        case(1):
        taken[int(builders.get(i).x)][int(builders.get(i).y-1)] = 1;
        sides[int(builders.get(i).x)][int(builders.get(i).y)].set("North", 0);
        sides[int(builders.get(i).x)][int(builders.get(i).y-1)].set("South", 0);
        builders.get(i).y--;
        break;

        case(2):
        taken[int(builders.get(i).x+1)][int(builders.get(i).y)] = 1;
        sides[int(builders.get(i).x)][int(builders.get(i).y)].set("East", 0);
        sides[int(builders.get(i).x+1)][int(builders.get(i).y)].set("West", 0);
        builders.get(i).x++;
        break;

        case(3):
        taken[int(builders.get(i).x)][int(builders.get(i).y+1)] = 1;
        sides[int(builders.get(i).x)][int(builders.get(i).y)].set("South", 0);
        sides[int(builders.get(i).x)][int(builders.get(i).y+1)].set("North", 0);
        builders.get(i).y++;
        break;

        case(4):
        taken[int(builders.get(i).x-1)][int(builders.get(i).y)] = 1;
        sides[int(builders.get(i).x)][int(builders.get(i).y)].set("West", 0);
        sides[int(builders.get(i).x-1)][int(builders.get(i).y)].set("East", 0);
        builders.get(i).x--;
        break;
      }
    }
  }

  for (int i = 0; i < vert; i++) {
    for (int j = 0; j < horiz; j++) {
      if (sides[i][j].get("North") == 1) {
        line(i*block_size, j*block_size, (i+1)*block_size, j*block_size);
      }
      if (sides[i][j].get("East") == 1) {
        line((i+1)*block_size, j*block_size, (i+1)*block_size, (j+1)*block_size);
      }
      if (sides[i][j].get("South") == 1) {
        line(i*block_size, (j+1)*block_size, (i+1)*block_size, (j+1)*block_size);
      }
      if (sides[i][j].get("West") == 1) {
        line(i*block_size, j*block_size, i*block_size, (j+1)*block_size);
      }

      if (taken[i][j] == 0) {
        fill(50);
        square(i*block_size, j*block_size, block_size);
      }
    }
  }

  for (int i = 0; i < builders.size(); i++) {
    fill(255, 0, 0);
    square(builders.get(i).x*block_size, builders.get(i).y*block_size, block_size);
  }
}
