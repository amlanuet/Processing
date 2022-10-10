class PWindow extends PApplet {
  int x,y,w,h;
  boolean setLocation,setTitle,makeResizable;
  String title;
  
  PWindow() {
    super();
    PApplet.runSketch(new String[] {this.getClass().getSimpleName()}, this);
  };
  
  PWindow(int x_,int y_) {
    super();
    x = x_;
    y = y_;
    setLocation = true;
    PApplet.runSketch(new String[] {this.getClass().getSimpleName()}, this);
  };
  
  PWindow(int x_,int y_,int ww, int hh) {
    super();
    x = x_;
    y = y_;
    w = ww;
    hh = hh;
    
    setLocation = true;
    PApplet.runSketch(new String[] {this.getClass().getSimpleName()}, this);
  };
  
  PWindow(int x_,int y_,int ww,int hh,String s) {
    super();
    x = x_;
    y = y_;
    w = ww;
    h = hh;
    setLocation = true;
    title = s;
    setTitle = true;
    PApplet.runSketch(new String[] {this.getClass().getSimpleName()}, this);
  };
  
  PWindow(int x_,int y_, String s, boolean k) {
    super();
    x = x_;
    y = y_;
    setLocation = true;
    title = s;
    setTitle = true;
    makeResizable = true;
    PApplet.runSketch(new String[] {this.getClass().getSimpleName()}, this);
  };
  

  void settings() {
    if(w>0&&h>0)size(w, h);
    else size(500, 200);
  };

  void setup() {
    background(150);
    if(setLocation)surface.setLocation(x, y);
    if(setTitle)surface.setTitle(title);
    if(makeResizable)surface.setResizable(true);
  };

  void draw() {
    ellipse(random(width), random(height), random(50), random(50));
  };

  void mousePressed() {
    println("mousePressed in secondary window");
    closeWindow();
  };
  
  void closeWindow(){
    Frame frame = ( (SmoothCanvas) ((PSurfaceAWT)surface).getNative()).getFrame();
    frame.dispose();
  };
};
