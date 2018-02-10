#include <MIDI.h>
MIDI_CREATE_DEFAULT_INSTANCE();

const int LED = 13;

const int PINK_BUTTON = 6;
const int BLUE_BUTTON = 5;
const int YELLOW_BUTTON = 4;
const int GREEN_BUTTON = 3;

int pink_button = 0;
int blue_button = 0;
int yellow_button = 0;
int green_button = 0;

void setup() {
  pinMode(LED, OUTPUT);
  pinMode(PINK_BUTTON, INPUT);
  pinMode(BLUE_BUTTON, INPUT);
  pinMode(YELLOW_BUTTON, INPUT);
  pinMode(GREEN_BUTTON, INPUT);
  MIDI.begin();
}
 
void loop() {
  
  pink_button = digitalRead(PINK_BUTTON);  
  blue_button = digitalRead(BLUE_BUTTON);
  yellow_button = digitalRead(YELLOW_BUTTON);
  green_button = digitalRead(GREEN_BUTTON);
  
  if ((pink_button == HIGH) && (blue_button == LOW) &&
      (yellow_button == LOW) && (green_button == LOW))
  {
    digitalWrite(LED, HIGH);
    //Note No 37をオンベロシティ0,1chで送信
    MIDI.sendNoteOff(37, 0, 1);
    delay(100);
    digitalWrite(LED, LOW);
    //Note No 37をオンベロシティ127,1chで送信
    MIDI.sendNoteOn(37, 127, 1);
  } else if ((pink_button == LOW) && (blue_button == HIGH) &&
             (yellow_button == LOW) && (green_button == LOW)) 
  {
    digitalWrite(LED, LOW);
    //Note No 38をオンベロシティ0,2chで送信
    MIDI.sendNoteOff(38, 0, 2);
    delay(100);
    digitalWrite(LED, HIGH);
    //Note No 38をオンベロシティ127,2chで送信
    MIDI.sendNoteOn(38, 127, 2);
  } else if ((pink_button == LOW) && (blue_button == LOW) &&
             (yellow_button == HIGH) && (green_button == LOW)) 
  {
    digitalWrite(LED, LOW);
    //Note No 39をオンベロシティ0,3chで送信
    MIDI.sendNoteOff(39, 0, 3);
    delay(100);
    digitalWrite(LED, HIGH);
    //Note No 39をオンベロシティ127,3chで送信
    MIDI.sendNoteOn(39, 127, 3);
  } else if ((pink_button == LOW) && (blue_button == LOW) &&
             (yellow_button == LOW) && (green_button == HIGH)) 
  {
    digitalWrite(LED, LOW);
    //Note No 40をオンベロシティ0,4chで送信
    MIDI.sendNoteOff(40, 0, 4);
    delay(100);
    digitalWrite(LED, HIGH);
    //Note No 40をオンベロシティ127,4chで送信
    MIDI.sendNoteOn(40, 127, 4);
  }
}
