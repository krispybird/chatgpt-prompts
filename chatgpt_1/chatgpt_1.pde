/*This is part of a series of ChatGPT generated codes showing the 
limitations of Chatgpt in generating many snippets of code
A series of prompts were used in the following order, which 
are shown in the corresponding pde files

Add the prompts in order into ChatGPT and test the generated code one at a time
** represents the code generated from the prompt

**Prompt 1: "Create an escape room in Processing"
Prompt 2: "Make the walls coloured"
Prompt 3: "Add first person viewpoint like in Doom"
Prompt 4: "Add all the code together"
Prompt 5: "Where's the escape room"

See the tutorial slides on AI-assisted coding for more details

*/
// Escape Room Setup in Processing

int doorX = 300;  // Door X position
int doorY = 200;  // Door Y position
int doorWidth = 100;
int doorHeight = 200;
boolean doorLocked = true;
String password = "1234";  // The password to unlock the door
String input = "";  // User's input
boolean showMessage = false;
boolean unlocked = false;

void setup() {
  size(800, 600);
  textAlign(CENTER, CENTER);
  fill(0);
  textSize(20);
}

void draw() {
  background(255);
  
  // Draw the door
  if (unlocked) {
    fill(0, 255, 0);  // Green if unlocked
  } else {
    fill(255, 0, 0);  // Red if locked
  }
  rect(doorX, doorY, doorWidth, doorHeight);
  
  // Draw instructions and the input area
  fill(0);
  text("Enter password to unlock the door:", width / 2, 50);
  text(input, width / 2, 100);
  
  if (showMessage) {
    if (unlocked) {
      text("The door is unlocked! Congratulations!", width / 2, height - 50);
    } else {
      text("Incorrect password. Try again.", width / 2, height - 50);
    }
  }
}

void keyPressed() {
  if (key == BACKSPACE && input.length() > 0) {
    input = input.substring(0, input.length() - 1); // Remove last character
  } else if (key == ENTER) {
    checkPassword();  // Check password when Enter is pressed
  } else {
    input += key;  // Add typed character to input string
  }
}

void checkPassword() {
  if (input.equals(password)) {
    doorLocked = false;  // Unlock the door
    unlocked = true;
  } else {
    doorLocked = true;
    unlocked = false;
  }
  showMessage = true;
  delay(2000);  // Wait for 2 seconds to display the message
  showMessage = false;
  input = "";  // Reset the input field
}
