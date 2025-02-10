/*This is part of a series of ChatGPT generated codes showing the 
limitations of Chatgpt in generating many snippets of code
A series of prompts were used in the following order, which 
are shown in the corresponding pde files

Add the prompts in order into ChatGPT and test the generated code one at a time
** represents the code generated from the prompt

Prompt 1: "Create an escape room in Processing"
Prompt 2: "Make the walls coloured"
Prompt 3: "Add first person viewpoint like in Doom"
Prompt 4: "Add all the code together"
**Prompt 5: "Where's the escape room"

See the tutorial slides on AI-assisted coding for more details

*/
// Escape Room with Raycasting (First-Person View)

int screenWidth = 800;
int screenHeight = 600;
float playerX = 400;  // Player's X position
float playerY = 300;  // Player's Y position
float playerAngle = 0;  // Player's initial view angle
boolean hasKey = false;  // Inventory item: key

int mapWidth = 8;
int mapHeight = 8;
int[][] map = new int[mapWidth][mapHeight];

// Camera and raycasting settings
float fov = PI / 3.0;  // Field of view (60 degrees)
float maxDepth = 16;  // Maximum ray distance

// Room walls colors
color wallColor1 = color(255, 200, 200);  // Light pink wall
color wallColor2 = color(200, 255, 200);  // Light green wall
color wallColor3 = color(200, 200, 255);  // Light blue wall
color wallColor4 = color(255, 255, 200);  // Light yellow wall

void setup() {
  size(800, 600);
  textSize(20);
  
  // Simple map (1 = wall, 0 = empty space, 2 = door, 3 = key)
  int tempMap[][] = {
    {1, 1, 1, 1, 1, 1, 1, 1},
    {1, 0, 0, 0, 0, 0, 0, 1},
    {1, 0, 1, 1, 1, 1, 0, 1},
    {1, 0, 1, 0, 0, 1, 0, 1},
    {1, 0, 1, 3, 1, 1, 0, 1},  // The key is at (3, 3)
    {1, 0, 0, 0, 2, 1, 0, 1},  // The door is at (4, 4)
    {1, 1, 1, 1, 1, 1, 1, 1},
    {1, 1, 1, 1, 1, 1, 1, 1}
  };
  
  // Load the map into the grid
  for (int i = 0; i < mapWidth; i++) {
    for (int j = 0; j < mapHeight; j++) {
      map[i][j] = tempMap[i][j];
    }
  }
}

void draw() {
  background(0);
  
  // Draw the colored walls
  fill(wallColor1);  // Top wall
  rect(0, 0, width, 50);

  fill(wallColor2);  // Left wall
  rect(0, 50, 50, height - 50);

  fill(wallColor3);  // Right wall
  rect(width - 50, 50, 50, height - 50);

  fill(wallColor4);  // Bottom wall
  rect(0, height - 50, width, 50);
  
  // Cast rays to create the walls in the first-person perspective
  for (int x = 0; x < screenWidth; x++) {
    // Calculate the ray's angle
    float rayAngle = (playerAngle - fov / 2.0) + ((float)x / screenWidth) * fov;
    
    // Cast the ray
    float distance = castRay(rayAngle);
    
    // Calculate the height of the wall to draw
    int wallHeight = (int)(screenHeight / (distance + 0.0001));
    
    // Draw the wall strip (vertical line)
    int colorValue = (int)map(distance, 0, maxDepth, 255, 0);  // Darker when farther
    stroke(colorValue);
    line(x, screenHeight / 2 - wallHeight / 2, x, screenHeight / 2 + wallHeight / 2);
  }
  
  // Display the door (locked/unlocked) and the key
  displayObjects();

  // Draw player (for reference)
  fill(255, 0, 0);
  ellipse(playerX, playerY, 10, 10);
}

// Cast a ray from the player's position
float castRay(float angle) {
  float x = playerX;
  float y = playerY;
  float sinA = sin(angle);
  float cosA = cos(angle);
  
  // Step size for ray
  float stepSize = 0.1;
  
  for (float depth = 0; depth < maxDepth; depth += stepSize) {
    x += cosA * stepSize;
    y += sinA * stepSize;
    
    int mapX = (int)(x / 50);
    int mapY = (int)(y / 50);
    
    if (mapX >= 0 && mapX < mapWidth && mapY >= 0 && mapY < mapHeight && map[mapX][mapY] == 1) {
      return depth;
    }
    // Check if the ray hits the key
    if (mapX >= 0 && mapX < mapWidth && mapY >= 0 && mapY < mapHeight && map[mapX][mapY] == 3) {
      return depth; // Key found
    }
  }
  
  return maxDepth;  // No wall hit, return max depth
}

// Display the door and key
void displayObjects() {
  // Draw the key (only visible if not picked up)
  if (!hasKey) {
    fill(255, 255, 0);
    ellipse(300, 250, 20, 20);  // Key location at (3,3)
  }
  
  // Draw the door (locked or unlocked)
  if (hasKey) {
    fill(0, 255, 0);  // Door unlocked
  } else {
    fill(255, 0, 0);  // Door locked
  }
  rect(400, 250, 50, 100);  // Door location at (4,4)
}

// Handle player movement and interaction
void keyPressed() {
  // Player movement and rotation control
  if (key == 'w' || key == 'W') {
    playerX += cos(playerAngle) * 5;
    playerY += sin(playerAngle) * 5;
  } else if (key == 's' || key == 'S') {
    playerX -= cos(playerAngle) * 5;
    playerY -= sin(playerAngle) * 5;
  } else if (key == 'a' || key == 'A') {
    playerAngle -= 0.1;
  } else if (key == 'd' || key == 'D') {
    playerAngle += 0.1;
  }
  
  // Check if player is close to the key and pick it up
  if (dist(playerX, playerY, 300, 250) < 20 && !hasKey) {
    hasKey = true;
    println("You picked up the key!");
  }
  
  // Check if player is close to the door and unlock it
  if (dist(playerX, playerY, 400, 250) < 50 && hasKey) {
    println("The door is unlocked. You escaped!");
  }
}
