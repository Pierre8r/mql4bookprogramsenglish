//--------------------------------------------------------------------
// countiter.mq4
// The code should be used for educational purpose only.
//--------------------------------------------------------------------
int start()                                  // Special funct. start()
  {
   int i, Count;                             // Declaring variables
   for (i=1; i<=5; i++)                      // Show for 5 ticks
     {
      Count=0;                               // Clearing counter
      while(RefreshRates()==false)           // Until...
        {                                   //..a new tick comes
         Count = Count+1;                    // Iteration counter 
        }
      Alert("Tick ",i,", loops ",Count);     // After each tick
     }
   return;                                   // Exit start()
  }
//--------------------------------------------------------------------