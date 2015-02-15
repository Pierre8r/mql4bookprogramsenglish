//------------------------------------------------------------------------
// Trade.mqh
// The code should be used for educational purpose only.
//------------------------------------------------------------------------
// Trade function.
//------------------------------------------------------------------- 1 --
int Trade(int Trad_Oper)              // User-defined function
  {
   // Trad_Oper - trade operation type:
   // 10 - opening Buy  
   // 20 - opening Sell 
   // 11 - closing Buy
   // 21 - closing Sell
   //  0 - no important criteria available
   // -1 - another symbol is used
   switch(Trad_Oper)
     {
      //------------------------------------------------------------- 2 --
      case 10:                         // Trading criterion = Buy
         Close_All(1);                 // Close all Sell
         if (Lot()==false)             // Not enough money for min.
            return;                    // Exit the user-defined function
         Open_Ord(0);                  // Open Buy
         return;                       // Having traded, leave
         //---------------------------------------------------------- 3 --
      case 11:                         // Trading criterion = closing Buy
         Close_All(0);                 // Close all Buy
         return;                       // Having traded, leave
         //---------------------------------------------------------- 4 --
      case 20:                         // Trading criterion = Sell
         Close_All(0);                 // Close all Buy
         if (Lot()==false)
            return;                    // Exit the user-defined function
         Open_Ord(1);                  // Open Sell            
         return;                       // Having traded, leave
         //---------------------------------------------------------- 5 --
      case 21:                         // Trading criterion = closing Sell
         Close_All(1);                 // Close all Sell
         return;                       // Having traded, leave
         //---------------------------------------------------------- 6 --
      case 0:                          // Retaining opened positions
         Tral_Stop(0);                 // Trailing stop Buy
         Tral_Stop(1);                 // Trailing stop Sell
         return;                       // Having traded, leave
         //---------------------------------------------------------- 7 --
     }
  }
//------------------------------------------------------------------- 8 --