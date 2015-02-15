//--------------------------------------------------------------------
// Errors.mqh
// The code should be used for educational purpose only.
//--------------------------------------------------------------- 1 --
// Error processing function.
// Returned values:
// true  - if the error is overcomable (i.e. work can be continued)
// false - if the error is critical (i.e. trading is impossible)
//--------------------------------------------------------------- 2 --
bool Errors(int Error)                    // Custom function
  {
   // Error             // Error number   
   if(Error==0)
      return(false);                      // No error
   Inform(15,Error);                      // Message
//--------------------------------------------------------------- 3 --
   switch(Error)
     {   // Overcomable errors:
      case 129:         // Wrong price
      case 135:         // Price changed
         RefreshRates();                  // Renew data
         return(true);                    // Error is overcomable
      case 136:         // No quotes. Waiting for the tick to come
         while(RefreshRates()==false)     // Before new tick
            Sleep(1);                     // Delay in the cycle
         return(true);                    // Error is overcomable
      case 146:         // The trade subsystem is busy
         Sleep(500);                      // Simple solution
         RefreshRates();                  // Renew data
         return(true);                    // Error is overcomable
         // Critical errors:
      case 2 :          // Common error
      case 5 :          // Old version of the client terminal
      case 64:          // Account blocked
      case 133:         // Trading is prohibited
      default:          // Other variants
         return(false);                   // Critical error
     }
//--------------------------------------------------------------- 4 --
  }
//--------------------------------------------------------------------