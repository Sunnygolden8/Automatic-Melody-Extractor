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
string doneSaving = "";

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

void draw()
{
 //if button is clicked
  //if(recordButton.clicked)
  //{
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
 /* else
  {
     recordButton.render();
  }*/
  
  
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
  if (mouseX > 50 && mouseX < 150 && mouseY > 50 && mouseY < 125) {
    recordButton.clicked = !recordButton.clicked;
  }  
}
