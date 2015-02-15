//----------------------------------------------------------------------------------
// Lot.mqh
// The code should be used for educational purpose only.
//----------------------------------------------------------------------------- 1 --
// Function calculating the amount of lots.
// Global variables:
// double Lots_New - the amount of lots for new orders (calculated)
// double Lots     - the desired amount of lots defined by the user.
// int Percent     - free margin percentage defined by the user
// Returned values:
// true  - if there is enough money for the minimum volume
// false - if there is no enough money for the minimum volume
//----------------------------------------------------------------------------- 2 --
bool Lot()                                     // User-defined function
  {
   string Symb   =Symbol();                    // Symbol
   double One_Lot=MarketInfo(Symb,MODE_MARGINREQUIRED);//!-lot cost
   double Min_Lot=MarketInfo(Symb,MODE_MINLOT);// Min. amount of lots
   double Step   =MarketInfo(Symb,MODE_LOTSTEP);//Step in volume changing
   double Free   =AccountFreeMargin();         // Free margin
//----------------------------------------------------------------------------- 3 --
   if (Lots>0)                                 // Volume is explicitly set..
     {                                         // ..check it
      double Money=Lots*One_Lot;               // Order cost
      if(Money<=AccountFreeMargin())           // Free margin covers it..
         Lots_New=Lots;                        // ..accept the set one
      else                                     // If free margin is not enough..
         Lots_New=MathFloor(Free/One_Lot/Step)*Step;// Calculate lots
     }
//----------------------------------------------------------------------------- 4 --
   else                                        // If volume is not preset
     {                                         // ..take percentage
      if (Percent > 100)                       // Preset, but incorrectly ..
         Percent=100;                          // .. then no more than 100
      if (Percent==0)                          // If 0 is preset ..
         Lots_New=Min_Lot;                     // ..then the min. lot
      else                                     // Desired amount of lots:
         Lots_New=MathFloor(Free*Percent/100/One_Lot/Step)*Step;//Calc
     }
//----------------------------------------------------------------------------- 5 --
   if (Lots_New < Min_Lot)                     // If it is less than allowed..
      Lots_New=Min_Lot;                        // .. then minimum
   if (Lots_New*One_Lot > AccountFreeMargin()) // It isn't enough even..
     {                                         // ..for the min. lot:(
      Inform(11,0,Min_Lot);                    // Message..
      return(false);                           // ..and exit 
     }
   return(true);                               // Exit user-defined function
  }
//----------------------------------------------------------------------------- 6 --