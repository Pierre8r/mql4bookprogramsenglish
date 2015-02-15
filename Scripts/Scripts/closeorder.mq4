//--------------------------------------------------------------------------------------
// closeorder.mq4
// The code should be used for educational purpose only.
//--------------------------------------------------------------------------------- 1 --
int start()                                     // Special function 'start'
  {
   string Symb=Symbol();                        // Symbol
   double Dist=1000000.0;                       // Presetting
   int Real_Order=-1;                           // No market orders yet
   double Win_Price=WindowPriceOnDropped();     // The script is dropped here
//-------------------------------------------------------------------------------- 2 --
   for(int i=1; i<=OrdersTotal(); i++)          // Order searching cycle
     {
      if (OrderSelect(i-1,SELECT_BY_POS)==true) // If the next is available
        {                                       // Order analysis:
         //----------------------------------------------------------------------- 3 --
         if (OrderSymbol()!= Symb) continue;    // Symbol is not ours
         int Tip=OrderType();                   // Order type
         if (Tip>1) continue;                   // Pending order  
         //----------------------------------------------------------------------- 4 --
         double Price=OrderOpenPrice();         // Order price
         if (NormalizeDouble(MathAbs(Price-Win_Price),Digits)< //Selection
            NormalizeDouble(Dist,Digits))       // of the closest order       
           {
            Dist=MathAbs(Price-Win_Price);      // New value
            Real_Order=Tip;                     // Market order available
            int Ticket=OrderTicket();           // Order ticket
            double Lot=OrderLots();             // Amount of lots
           }
         //----------------------------------------------------------------------- 5 --
        }                                       //End of order analysis
     }                                          //End of order searching
//-------------------------------------------------------------------------------- 6 --
   while(true)                                  // Order closing cycle
     {
      if (Real_Order==-1)                       // If no market orders available
        {
         Alert("For ",Symb," no market orders available");
         break;                                 // Exit closing cycle        
        }
      //-------------------------------------------------------------------------- 7 --
      switch(Real_Order)                        // By order type
        {
         case 0: double Price_Cls=Bid;          // Order Buy
            string Text="Buy ";                 // Text for Buy
            break;                              // ?? switch
         case 1: Price_Cls=Ask;                 // Order Sell
            Text="Sell ";                       // Text for Sell
        }
      Alert("Attempt to close ",Text," ",Ticket,". Awaiting response..");
      bool Ans=OrderClose(Ticket,Lot,Price_Cls,2);// Order closing
      //-------------------------------------------------------------------------- 8 --
      if (Ans==true)                            // Got it! :)
        {
         Alert ("Closed order ",Text," ",Ticket);
         break;                                 // Exit closing cycle
        }
      //-------------------------------------------------------------------------- 9 --
      int Error=GetLastError();                 // Failed :(
      switch(Error)                             // Overcomable errors
        {
         case 135:Alert("The price has changed. Retrying..");
            RefreshRates();                     // Update data
            continue;                           // At the next iteration
         case 136:Alert("No prices. Waiting for a new tick..");
            while(RefreshRates()==false)        // To the new tick
               Sleep(1);                        // Cycle sleep
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
         case 5 : Alert("Old version of the client terminal.");
            break;                              // Exit 'switch'
         case 64: Alert("Account is blocked.");
            break;                              // Exit 'switch'
         case 133:Alert("Trading is prohibited");
            break;                              // Exit 'switch'
         default: Alert("Occurred error ",Error);//Other alternatives   
        }
      break;                                    // Exit closing cycle
     }
//------------------------------------------------------------------------------- 10 --
   Alert ("The script has finished operations -----------------------------");
   return;                                      // Exit start()
  }
//------------------------------------------------------------------------------- 11 --