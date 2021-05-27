#include <Wire.h>
#include <LiquidCrystal_I2C.h>

int data_pin=2;
int data_pin1=3;
int data_pin2=4;
int data_pin3=5;
LiquidCrystal_I2C lcd(0x27, 16, 2);
void setup() {
  // put your setup code here, to run once:
   lcd.begin();
  lcd.backlight();
   lcd.clear();
 Serial.begin(9600);
 pinMode(0,INPUT);
 pinMode(2,INPUT);
 pinMode(3,INPUT);
 pinMode(4,INPUT);
}

void loop() {
  // put your main code here, to run repeatedly:
  int data = digitalRead(data_pin);
  int data1 = digitalRead(data_pin1);
  int data2 = digitalRead(data_pin2);
  int data3 = digitalRead(data_pin3);
  if(data3==0 && data2==0 && data1==0 && data==1) {
     lcd.clear();
     lcd.setCursor(5,0);
     lcd.print("EE271");
     lcd.setCursor(3,1);
     lcd.print("state0");
  }
  if(data3==0 && data2==0 && data1==1 && data==0) {
     lcd.clear();
     lcd.setCursor(5,0);
     lcd.print("EE271");
     lcd.setCursor(3,1);
     lcd.print("state1");
  }
  if(data3==0 && data2==1 && data1==0 && data==0) {
     lcd.clear();
     lcd.setCursor(5,0);
     lcd.print("EE271");
     lcd.setCursor(3,1);
     lcd.print("state2");
  }
  if(data3==1 && data2==0 && data1==0 && data==0) {
     lcd.clear();
     lcd.setCursor(5,0);
     lcd.print("EE271");
     lcd.setCursor(3,1);
     lcd.print("state3");
  }
  else {
     lcd.clear();
     lcd.setCursor(5,0);
     lcd.print("EE271");
  }
 

 //Serial.println(data,data1);
 //delay(1000);
 
}
