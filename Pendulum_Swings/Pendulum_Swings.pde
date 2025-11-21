import static javax.swing.JOptionPane.*;

float g = 9.81f; // Acceleration due to gravity in m/s^2
float Kk; 

String Length = showInputDialog ("Enter Pendulum's length");
String Initangle = showInputDialog ("Enter the initial angle");

float L = float (Length);
float InitAngle = float (Initangle);

float rad = radians (InitAngle/2);
float k = sin(rad);

//(PI/2)*((1+pow((1/2), 2)* pow(k, 2) + (1*3)/pow((2*4), 2)*pow(k, 4) + (1*3*5)/pow((2*4*6), 2)*pow(k, 6)));

float ellipticK(float k) {
  // This method calculates the complete elliptic integral of the first kind K(k)
  // using a numerical approximation (Gauss-Legendre quadrature).

  if (k < 0 || k >= 1) {
    throw new IllegalArgumentException("k must be in the range [0, 1)");
  }

  int n = 100; // Number of intervals for the approximation
  float sum = 0;
  float factor = 1;

  for (int i = 0; i <= n; i++) {
    float t = (float) i / n;
    float sinTheta = (float) sin(PI * t / 2);
    float term = (1 - k * sinTheta * sinTheta);
    sum += factor * (1 / sqrt(term));
    factor = (i == 0) ? 1 : (i % 2 == 0) ? 2 : 4; // Alternating coefficients
  }

  return (PI / 2) * (1.0 / n) * sum; // Final result
}

void setup () {
  float k = sin(rad / 2); // Calculate k

  // Calculate the period T
   Kk = ellipticK(k); // Complete elliptic integral K(k)
  float T = 4 * L * sqrt(1 / g) * Kk;

  println("The period T of the pendulum is: " + T + " seconds");
}
