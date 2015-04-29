//Automatic Melody Recorder
//Christine Lam and Erica S. Low
//EEE 394

import ddf.minim.*;
import ddf.minim.analysis.*; //to analyze frequencies
FFT fastfourier;

Minim minim;
AudioPlayer player; //play sounds
AudioInput input; //get sound input
AudioRecorder recorder; //records

Button recordButton;
String doneSaving = "";

boolean button = false;

int x = 50;
int y = 50;
int w = 100;
int h = 75;

void setup()
{
  size(500, 500, P2D);
 
  minim = new Minim(this);
  
  //player = minim.loadFile("song.mp3");
  input = minim.getLineIn();
  
   //recorded audio will be saved in the sketch's root folder
  recorder = minim.createRecorder(input, "melody.wav");
  
  textFont(createFont("Arial", 12));
  
  recordButton = new Button();
}

void draw() {
  
  /*SCENE for recording audio*/
  if (button) {
    background(0);
    stroke(255);
    
    //this draws dynamic waveforms
      //the wave values returned by left.get() and right.get() will be between -1 and 1,
      //so we need to scale them up to see the waveform
      for(int i = 0; i < input.bufferSize() - 1; i++)
      {
        line(i, 50 + input.left.get(i)*50, i+1, 50 + input.left.get(i+1)*50);
        line(i, 150 + input.right.get(i)*50, i+1, 150 + input.right.get(i+1)*50);
      }
     
      if ( recorder.isRecording() )
      {
        text("Recording Now", 5, 15);
      }
      else
      {
        text("Press R to Start Recording & S to Save Music.", 5, 15);
      }
  } 
  else if()
  {
  }
  /*DEFAULT SCENE for recording audio*/
  else {
    fill(175);
    rect(x,y,w,h);
  }
  
  
}
void keyReleased()
{
  //if button is clicked
  //if(recordButton.clicked)
  //{
    if ( key == 'r' ) 
    {
      if ( recorder.isRecording() ) 
      {
        recorder.endRecord();
      }
      else 
      {
        recorder.beginRecord();
      }
    }
    if ( key == 's' )
    {
      recorder.save();
      text("Done saving.", 5, 15);
    }
 // }
}

//when button is clicked, go to recording state   
void mousePressed() {
  
  //if record button is pressed, then make it true
  if (mouseX > x && mouseX < x+w && mouseY > y && mouseY < y+h) {
    button = !button;
  }  
  //the keyboard guis appear!
  else
  {
    /
  }
}

void fftArray() {
  
  player = minim.loadFile("melody.wav", 1024);
  
  player.loop();
  
  FFT fft = new FFT( player.bufferSize(), player.sampleRate());
  
  fftArray();
  
  fft.forward(player.mix);
  int specSize = fft.specSize(); //this is 512 since the fft size is 1024 
  //already halves it for me.
  
  float[] fftArray = new float[specSize];
  
  for (int i = 0; i<specSize; i++) {
     fftArray[i] = fft.getBand(i);
     println(fftArray[i]);
  };
 
  float max = max(fftArray);
  println("The maximum intensity is "+max); 
  
  int position = -1;
  
  //now get the index # of the max.
  for (int i=0; i<fftArray.length; i++) {
    if (fftArray[i]==max){
      position = i;
      
    };
  };
  
  println(position);
  
  //take that index and find the Hz of it
  float hertz = -1;
  hertz = position * (player.sampleRate() / 1024);
  println(hertz);
  
  
  
};
