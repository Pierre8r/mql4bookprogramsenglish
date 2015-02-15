//-------------------------------------------------------------------------------
// openbuy.mq4 
// The code should be used for educational purpose only.
//-------------------------------------------------------------------------- 1 --
int start()                                     // Special function start
  {
   int Dist_SL =10;                             // Preset SL (pt)
   int Dist_TP =3;                              // Preset TP (pt)
   double Prots=0.35;                           // Percentage of free margin
   string Symb=Symbol();                        // Symbol
//-------------------------------------------------------------------------- 2 --
   while(true)                                  // Cycle that opens an order
     {
      int Min_Dist=MarketInfo(Symb,MODE_STOPLEVEL);// Min. distance
      double Min_Lot=MarketInfo(Symb,MODE_MINLOT);// Min. volume
      double Step   =MarketInfo(Symb,MODE_LOTSTEP);//Step to change lots
      double Free   =AccountFreeMargin();       // Free Margin
      double One_Lot=MarketInfo(Symb,MODE_MARGINREQUIRED);//Cost per 1 lot
      //-------------------------------------------------------------------- 3 --
      double Lot=MathFloor(Free*ProtsOne_LotStep)*Step;// Lots
      if (Lot < Min_Lot)                        // If it is less than allowed
        {
         Alert(" Not enough money for ", Min_Lot," lots");
         break;                                 // Exit cycle
        }
      //-------------------------------------------------------------------- 4 --
      if (Dist_SL < Min_Dist)                   // If it is less than allowed
        {
         Dist_SL=Min_Dist;                      // Set the allowed
         Alert(" Increased the distance of SL = ",Dist_SL," pt");
        }
      double SL=Bid - Dist_SL*Point;            // Requested price of SL
      //-------------------------------------------------------------------- 5 --
      if (Dist_TP < Min_Dist)                   // If it is less than allowed
        {
         Dist_TP=Min_Dist;                      // Set the allowed
         Alert(" Increased the distance of TP = ",Dist_TP," pt");
        }
      double TP=Bid + Dist_TP*Point;            // Requested price of TP
      //-------------------------------------------------------------------- 6 --
      Alert("The request was sent to the server. Waiting for reply..");
      int ticket=OrderSend(Symb, OP_BUY, Lot, Ask, 2, SL, TP);
      //-------------------------------------------------------------------- 7 --
      if (ticket>0)                             // Got it!:)
        {
         Alert ("Opened order Buy ",ticket);
         break;                                 // Exit cycle
        }
      //-------------------------------------------------------------------- 8 --
      int Error=GetLastError();                 // Failed :(
      switch(Error)                             // Overcomable errors
        {
         case 135:Alert("The price has changed. Retrying..");
            RefreshRates();                     // Update data
            continue;                           // At the next iteration
         case 136:Alert("No prices. Waiting for a new tick..");
            while(RefreshRates()==false)        // Up to a new tick
               Sleep(1);                        // Cycle delay
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
         case 133:Alert("Trading forbidden");
            break;                              // Exit 'switch'
         default: Alert("Occurred error ",Error);// Other alternatives   
        }
      break;                                    // Exit cycle
     }
//-------------------------------------------------------------------------- 9 --
   Alert ("The script has completed its operations ---------------------------");
   return;                                      // Exit start()
  }
//-------------------------------------------------------------------------- 10 --