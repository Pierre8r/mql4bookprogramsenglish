//----------------------------------------------------------------------------------------
// fibonacci.mq4
// The code should be used for educational purpose only.
//----------------------------------------------------------------------------------------
int start()                               // Special function start()
  {
//----------------------------------------------------------------------------------------
   int i;                                 // Formal parameter, counter
   double
   A,B,C,                                 // Numbers in the sequence
   Delta,                                 // Real difference between coefficients
   D;                                     // Preset accuracy
//----------------------------------------------------------------------------------------
   A=1;                                   // Initial value
   B=1;                                   // Initial value 
   C=2;                                   // Initial value
   D=0.0000000001;                        // Set accuracy
   Delta=1000.0;                          // Initial value
//----------------------------------------------------------------------------------------
   while(Delta > D)                       // Cycle operator header
     {                                    // Opening brace of the cycle body
      i++;                                // Counter
      A=B;                                // Next value
      B=C;                                // Next value
      C=A + B;                            // Next value
      Delta=MathAbs(C/B - B/A);           // Search difference between coefficients
     }                                    // Closing brace of the cycle body
//----------------------------------------------------------------------------------------
   Alert("C=",C," Fibonacci number=",C/B," i=",i);//Display on the screen
   return;                                // Exit start()
  }
//----------------------------------------------------------------------------------------