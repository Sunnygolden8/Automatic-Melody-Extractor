class Button {
  
  //Location and size
  boolean clicked = false;
  int x, y, w, h;
  
  Button()
  {
    int x = 50;
    int y = 50;
    int w = 100;
    int h = 75;
  }
  void render()
  {
    fill(color(50, 55, 100));
    rect(x,y,w,h);
  }  
}
