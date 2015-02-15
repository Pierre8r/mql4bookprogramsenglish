//--------------------------------------------------------------------
// deleteall.mq4
// The program is intended to be used as an example in MQL4 Tutorial.
//--------------------------------------------------------------------
int start()                             // Special start() function
  {
   GlobalVariablesDeleteAll();          // Deleting of all GVs
   PlaySound("W2.wav");                 // Sound
   return;                              // Exit
  }
//--------------------------------------------------------------------