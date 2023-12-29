#include "BluetoothSerial.h"
#include <ESP32Servo.h>

//#define USE_PIN // Uncomment this to use PIN during pairing. The pin is specified on the line below
const char *pin = "1234"; // Change this to more secure PIN.

String device_name = "ESP32-BT-Slave";

#if !defined(CONFIG_BT_ENABLED) || !defined(CONFIG_BLUEDROID_ENABLED)
#error Bluetooth is not enabled! Please run `make menuconfig` to and enable it
#endif

#if !defined(CONFIG_BT_SPP_ENABLED)
#error Serial Bluetooth not available or not enabled. It is only available for the ESP32 chip.
#endif

BluetoothSerial SerialBT;

Servo myservo;

// Recommended PWM GPIO pins on the ESP32 include 2,4,12-19,21-23,25-27,32-33
// Possible PWM GPIO pins on the ESP32-S2: 0(used by on-board button),1-17,18(used by on-board LED),19-21,26,33-42
#if defined(ARDUINO_ESP32S2_DEV)
int servoPin = 17;
#else
int servoPin = 18;
#endif

#define PotPin A6

#define ECGPin 12//A1
#define ECGLP 13//A3
#define ECGLN 14///A2

#define Servo_Pin B8

#define ECGTrigLevel 500

#define OrtaDelay 200

int StepCounter = 0;

bool ExecuteMove = 0;
bool ExecuteHelp = 0;
int Way;

int WantedAngle = 0;
int CurrentAngle = 0;
byte ServoAngle = 90;
int ServoStep = 2;

byte Mode = 0;
byte trial = 0;
//////////////////////////USB
byte Index1, Index2, Index3, Index4, Index5, Index6;

char StartMarker = '<';
char EndMarker = '>';
char FirstByte;

bool islem = 0;

String SerialBTReceived;

//////////////////////////USB

void setup() {
  // initialize the SerialBT communication:
  Serial.begin(9600);
  //SerialBT.begin("ESP32test", true);
  SerialBT.begin(device_name); //Bluetooth device name
  Serial.printf("The device with name \"%s\" is started.\nNow you can pair it with Bluetooth!\n", device_name.c_str());
  //Serial.printf("The device with name \"%s\" and MAC address %s is started.\nNow you can pair it with Bluetooth!\n", device_name.c_str(), SerialBT.getMacString()); // Use this after the MAC method is implemented
#ifdef USE_PIN
  SerialBT.setPin(pin);
  Serial.println("Using PIN");
#endif

  /*
    #ifdef USE_PIN
    SerialBT.setPin(pin);
    Serial.println("Using PIN");
    #endif
  */


  ESP32PWM::allocateTimer(0);
  ESP32PWM::allocateTimer(1);
  ESP32PWM::allocateTimer(2);
  ESP32PWM::allocateTimer(3);
  myservo.setPeriodHertz(50);    // standard 50 hz servo

  myservo.attach(servoPin, 1000, 2000); // attaches the servo on pin 18 to the servo object

  // using default min/max of 1000us and 2000us
  // different servos may require different min/max settings
  // for an accurate 0 to 180 sweep

  myservo.write(ServoAngle);//90 dereceye git0

  pinMode(ECGPin, INPUT); // Setup for ECG
  pinMode(ECGLP, INPUT); // Setup for leads off detection LO +
  pinMode(ECGLN, INPUT); // Setup for leads off detection LO -

  pinMode(PotPin, INPUT); // Setup for Pot Position sens

}
//SerialBT ekle OTGden gelen bilgiye göre help veya move ve istenilen açıyı bul.
void loop() {

  delay(200);
  //////////////////////////USB
  if (SerialBT.available() > 6) {
    //effect integers

    delay(10);

    SerialBTReceived = SerialBT.readStringUntil('\n');//sona kadar oku
    FirstByte = SerialBTReceived.charAt(0); // ">" işareti oku
    if (FirstByte == StartMarker) { //startmark

      Index1 = SerialBTReceived.indexOf(StartMarker);//'<'
      Index2 = SerialBTReceived.indexOf(',', Index1 + 1);
      Index3 = SerialBTReceived.indexOf(',', Index2 + 1);
      Index4 = SerialBTReceived.indexOf(',', Index3 + 1);
      Index5 = SerialBTReceived.indexOf(',', Index4 + 1);
      Index6 = SerialBTReceived.indexOf(EndMarker, Index5 + 1);//'>' <1,100,,>


      Mode = SerialBTReceived.substring(Index1 + 1, Index2).toInt(); //toint cost 100uS
      WantedAngle = SerialBTReceived.substring(Index2 + 1, Index3).toInt();
      /* RGBs[0][2] = SerialBTReceived.substring(Index3 + 1, Index4).toInt();
        RGBs[0][3] = SerialBTReceived.substring(Index4 + 1, Index5).toInt();*/

      delay(10);
    }
    else SerialBT_flush_buffer();
  }
  //////////////////////////USB END


  CurrentAngle = (analogRead(PotPin) / 3) - 210;

  if ((digitalRead(ECGLP) == 1) || (digitalRead(ECGLN) == 1)) {
    SerialBT.println("! ECG SENSOR ERROR !");
    Serial.println("! ECG SENSOR ERROR !");
  }
  else {
    // send the value of analog input 0:
    SerialBT.print("ECG Status : ");
    SerialBT.println(analogRead(ECGPin));
    Serial.print("ECG Status : ");
    Serial.println(analogRead(ECGPin));
  }
  //Wait for a bit to keep SerialBT data from saturating
  delay(1);




  if (ExecuteMove || Mode == 1) {
    SerialBT.println("ExecuteMove");
    //myservo.write(80);
    if (WantedAngle < CurrentAngle) {
      ServoStep = abs(ServoStep);
    }
    else {
      ServoStep = abs(ServoStep) * (-1);
    }
    SerialBT.print("ServoStep : ");
    SerialBT.println(ServoStep);
    StepCounter = 0;
    while ((abs(WantedAngle - CurrentAngle)) > 3) {
      StepCounter++;
      CurrentAngle = (analogRead(PotPin) / 3) - 210;
      ServoAngle = ServoAngle + ServoStep;

      if (ServoAngle < 5 )ServoAngle = 5;
      if (ServoAngle > 150 )ServoAngle = 150;

      myservo.write(ServoAngle);

      SerialBT.print("StepCounter : ");
      SerialBT.println(StepCounter);
      delay(100);
      if (StepCounter >= 50)break;
    }
    Mode = 0;
    StepCounter = 0;
  }
  /*
    if (ExecuteHelp) {
      digitalWrite(PowerPin, LOW);
      if (WantedAngle > CurrentAngle) {
        digitalWrite(DirPin, HIGH);
        ServoStep = abs(ServoStep);
      }
      else {
        digitalWrite(DirPin, LOW);
        ServoStep = (abs(ServoStep) * (-1));
      }
      StepCounter = 0;
      while ((abs(WantedAngle - CurrentAngle)) < 5) {
        StepCounter++;
        //Stepit();

        if (StepCounter >= 50)break;
      }
    }*/

  SerialBT.print("Wanted Angle : ");
  SerialBT.println(WantedAngle);
  SerialBT.print("Current Angle : ");
  SerialBT.println(CurrentAngle);
  SerialBT.print("ServoAngle : ");
  SerialBT.println(ServoAngle);
}//main

void ServoSafety() {
  if (ServoAngle < 5 )ServoAngle = 5;
  if (ServoAngle < 175 )ServoAngle = 175;
}

void SerialBT_flush_buffer()
{
  while (SerialBT.read() >= 0)
    ; // do nothing
}
/*
  void program1() {
  for (int i = 0; i < 10; i++) {
    servokonumOrtaHiz(120);//120 dereceye git
    delay(2000);
    servokonumOrtaHiz(50);//50 dereceye git
    delay(2000);
  }

  }

  void servokonumOrtaHiz(byte whereToGo) {
  CurrentAngle = analogRead(PotPin);
  if ((whereToGo - CurrentAngle) > 0)Way = 1;
  myservo.write(CurrentAngle);
  delay(OrtaDelay);
  while (abs(whereToGo - CurrentAngle) > 3) {
    CurrentAngle = analogRead(PotPin);
    myservo.write(CurrentAngle + Way);
    delay(OrtaDelay);
    trial++;
    if (trial > 90) {
      trial = 0;
      break;
    }
  }
  }
*/
