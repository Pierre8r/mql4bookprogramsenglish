//------------------------------------------------------------------------------------
// openbuystop.mq4 
// The code should be used for educational purpose only.
//------------------------------------------------------------------------------- 1 --
int start()                                     // Special function start
  {
   int Dist_SL =10;                             // Preset SL (pt)
   int Dist_TP =3;                              // Preset TP (pt)
   double Prots=0.35;                           // Percentage of free margin
   string Symb=Symbol();                        // Symbol
   double Win_Price=WindowPriceOnDropped();     // The script is dropped here
   Alert("The price is set by the mouse as Price = ",Win_Price);// Set by the mouse
//------------------------------------------------------------------------------- 2 --
   while(true)                                  // Cycle that opens an order
     {
      int Min_Dist=MarketInfo(Symb,MODE_STOPLEVEL);// Min. distance
      double Min_Lot=MarketInfo(Symb,MODE_MINLOT);// Min. volume
      double Free   =AccountFreeMargin();       // Free Margin
      double One_Lot=MarketInfo(Symb,MODE_MARGINREQUIRED);//Cost per 1 lot
      double Lot=MathFloor(Free*ProtsOne_LotMin_Lot)*Min_Lot;// Lots
      //------------------------------------------------------------------------- 3 --
      double Price=Win_Price;                   // The price is set by the mouse
      if (NormalizeDouble(Price,Digits)<        // If it is less than allowed
         NormalizeDouble(Ask+Min_Dist*Point,Digits))
        {                                       // For BuyStop only!
         Price=Ask+Min_Dist*Point;              // No closer
         Alert("Changed the requested price: Price = ",Price);
        }
      //------------------------------------------------------------------------- 4 --
      double SL=Price - Dist_SL*Point;          // Requested price of SL
      if (Dist_SL < Min_Dist)                   // If it is less than allowed
        {
         SL=Price - Min_Dist*Point;             // Requested price of SL
         Alert(" Increased the distance of SL = ",Min_Dist," pt");
        }
      //------------------------------------------------------------------------- 5 --
      double TP=Price + Dist_TP*Point;          // Requested price of TP
      if (Dist_TP < Min_Dist)                   // If it is less than allowed
        {
         TP=Price + Min_Dist*Point;             // Requested price of TP
         Alert(" Increased the distance of TP = ",Min_Dist," pt");
        }
      //------------------------------------------------------------------------- 6 --
      Alert("The request was sent to the server. Waiting for reply..");
      int ticket=OrderSend(Symb, OP_BUYSTOP, Lot, Price, 0, SL, TP);
      //------------------------------------------------------------------------- 7 --
      if (ticket>0)                             // Got it!:)
        {
         Alert ("Placed order BuyStop ",ticket);
         break;                                 // Exit cycle
        }
      //------------------------------------------------------------------------- 8 --
      int Error=GetLastError();                 // Failed :(
      switch(Error)                             // Overcomable errors
        {
         case 129:Alert("Invalid price. Retrying..");
            RefreshRates();                     // Update data
            continue;                           // At the next iteration
         case 135:Alert("The price has changed. Retrying..");
            RefreshRates();                     // Update data
            continue;                           // At the next iteration
         case 146:Alert("Trading subsystem is busy. Retrying..");
            Sleep(500);                         // Simple solution
            RefreshRates();                     // Update data
            continue;                           // At the next iteration
        }
      switch(Error)                             // Critical errors
        {
         case 2 : Alert("Common error.");
            break;                              // Exit 'switch'
         case 5 : Alert("Outdated version of the client terminal.");
            break;                              // Exit 'switch'
         case 64: Alert("The account is blocked.");
            break;                              // Exit 'switch'
         case 133:Alert("Trading fobidden");
            break;                              // Exit 'switch'
         default: Alert("Occurred error ",Error);// Other alternatives   
        }
      break;                                    // Exit cycle
     }
//------------------------------------------------------------------------------- 9 --
   Alert ("The script has completed its operations -----------------------------");
   return;                                      // Exit start()
  }
//------------------------------------------------------------------------------- 10 --