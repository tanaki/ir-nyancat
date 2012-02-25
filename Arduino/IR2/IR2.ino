int IRpin = 0;

void setup() {
  Serial.begin(9600);
}

void loop() {
  float volts = analogRead(IRpin)*0.0048828125;
  float distance = 20*pow(volts, -1.10);
 // Serial.println(distance);
  Serial.println(analogRead(IRpin));
  delay(100);
}

// value from sensor * (5/1024) - if running 3.3.volts then change 5 to 3.3
// worked out from graph 65 = theretical distance / (1/Volts)S - luckylarry.co.uk
