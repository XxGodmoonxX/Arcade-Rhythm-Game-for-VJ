#include <MIDI.h>
MIDI_CREATE_DEFAULT_INSTANCE();

const int BUTTON = 7;
const int LED = 13;

const int GREEN_BUTTON = 6;

int button = 0;
int g_button = 0;

void setup() {
  pinMode(LED, OUTPUT);
  pinMode(BUTTON, INPUT);
  MIDI.begin();
}
 
void loop() {
  //play notes from F#-0 (0x1E) to F#-5 (0x5A):
    
//  //Note No 36をオンベロシティ100,1chで送信
//  MIDI.sendNoteOn(36,100,1);
//  delay(1000); //1秒待つ
//    
//  //Note No 40をオンベロシティ100,1chで送信
//  MIDI.sendNoteOn(40,100,1);
//  delay(1000); //1秒待つ
    
  button = digitalRead(BUTTON); // 入力を読み取りvalに新鮮な値を保存
  if (button == HIGH) {
    digitalWrite(LED, LOW);
    //Note No 36をオンベロシティ0,1chで送信
    MIDI.sendNoteOff(36, 0, 1);
  } else {
    digitalWrite(LED, HIGH);
    //Note No 36をオンベロシティ127,1chで送信
    MIDI.sendNoteOn(36, 127, 1);
  }
  
  g_button = digitalRead(GREEN_BUTTON);
  if (g_button == HIGH) {
    digitalWrite(LED, LOW);
    //Note No 37をオンベロシティ0,1chで送信
    MIDI.sendNoteOff(37, 0, 1);
  } else {
    digitalWrite(LED, HIGH);
    //Note No 37をオンベロシティ127,1chで送信
    MIDI.sendNoteOn(37, 127, 1);
  }
}
