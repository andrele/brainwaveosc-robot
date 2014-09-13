// Import the libraries and dependencies
import oscP5.*;
import java.awt.*;

OscP5 oscP5;
Robot bob;
float currentAttention;
float threshold = 75.0;

// The setup function runs once when you start your application
void setup(){
  oscP5 = new OscP5(this, 7771); // Start listening for incoming messages at port 7771 
  
  try { // Try and create a new robot named bob
    bob = new Robot();
  } 
  catch (AWTException e) { // If there is an error, print it out to the console
    e.printStackTrace();
  }
}

// The draw function runs over and over again until you close the application
void draw(){
  
  if (currentAttention > threshold) {
    bob.keyPress(java.awt.event.KeyEvent.VK_S);
  } else {
    bob.keyRelease(java.awt.event.KeyEvent.VK_S);
  }
  
}

void oscEvent(OscMessage theMessage) {
  // Print the address and typetag of the message to the console
  // println("OSC Message received! The address pattern is " + theMessage.addrPattern() + ". The typetag is: " + theMessage.typetag());

  // Check for Attention messages only
  if (theMessage.checkAddrPattern("/attention") == true) {
    currentAttention = theMessage.get(0).floatValue();
    println("Your attention is at: " + currentAttention);
  }  
}
