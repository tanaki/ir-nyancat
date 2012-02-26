int IRpin = 0;

void setup() {
  Serial.begin(9600);
}

void loop() {
  Serial.println(analogRead(IRpin));
  delay(100);
}
