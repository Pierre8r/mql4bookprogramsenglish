//------------------------------------------------------------------------------------
// modifyorderprice.mq4 
// The code should be used for educational purpose only.
//------------------------------------------------------------------------------- 1 --
int start()                                     // Special function 'start'
  {
   int Tral=10;                                 // Approaching distance
   string Symb=Symbol();                        // Symbol
   double Dist=1000000.0;                       // Presetting
   double Win_Price=WindowPriceOnDropped();     // The script is dropped here
//------------------------------------------------------------------------------- 2 --
   for(int i=1; i<=OrdersTotal(); i++)          // Cycle searching in orders
     {
      if (OrderSelect(i-1,SELECT_BY_POS)==true) // If the next is available
        {                                       // Analysis of orders:
         //---------------------------------------------------------------------- 3 --
         if (OrderSymbol()!= Symb) continue;    // The symbol is not "ours"
         if (OrderType()<2) continue;           // Market order  
         //---------------------------------------------------------------------- 4 --
         if(NormalizeDouble(MathAbs(OrderOpenPrice()-Win_Price),Digits)
            < NormalizeDouble(Dist,Digits))     // Select the nearest one
           {
            Dist=MathAbs(OrderOpenPrice()-Win_Price);// New value 
            int    Tip   =OrderType();          // Type of the selected order.
            int    Ticket=OrderTicket();        // Ticket of the selected order
            double Price =OrderOpenPrice();     // ???? ???????. ???.
            double SL    =OrderStopLoss();      // SL of the selected order
            double TP    =OrderTakeProfit();    // TP of the selected order
           }                                    // End of 'if'
        }                                       // End of order analysis
     }                                          // End of order search
//------------------------------------------------------------------------------- 5 --
   if (Tip==0)                                  // If there are no pending orders
     {
      Alert("For ",Symb," no pending orders available");
      return;                                   // Exit the program
     }
//------------------------------------------------------------------------------- 6 --
   while(true)                                  // Order closing cycle
     {
      RefreshRates();                           // Update data
      //------------------------------------------------------------------------- 7 --
      double TS=Tral;                           // Initial value
      int Min_Dist=MarketInfo(Symb,MODE_STOPLEVEL);//Min distance
      if (TS < Min_Dist)                        // If less than allowed
         TS=Min_Dist;                           // New value of TS
      //------------------------------------------------------------------------- 8 --
      string Text="";                           // Not to be modified
      double New_SL=0;
      double New_TP=0;
      switch(Tip)                               // By order type
        {
         case 2:                                // BuyLimit
            if (NormalizeDouble(Price,Digits) < // If it is further than by
                NormalizeDouble(Ask-TS*Point,Digits))//..the preset value
              {
               double New_Price=Ask-TS*Point;   // Its new price
               if (NormalizeDouble(SL,Digits)>0)
                  New_SL=New_Price-(Price-SL);  // New StopLoss
               if (NormalizeDouble(TP,Digits)>0)
                  New_TP=New_Price+(TP-Price);  // New TakeProfit
               Text= "BuyLimit ";               // Modify it.
              }
            break;                              // Exit 'switch'
         case 3:                                // SellLimit 
            if (NormalizeDouble(Price,Digits) > // If it is further than by
                NormalizeDouble(Bid+TS*Point,Digits))//..the preset value
              {
               New_Price=Bid+TS*Point;          // Its new price
               if (NormalizeDouble(SL,Digits)>0)
                  New_SL=New_Price+(SL-Price);  // New StopLoss
               if (NormalizeDouble(TP,Digits)>0)
                  New_TP=New_Price-(Price-TP);  // New TakeProfit
               Text= "SellLimit ";              // Modify it.
              }
            break;                              // Exit 'switch'
         case 4:                                // BuyStopt
            if (NormalizeDouble(Price,Digits) > // If it is further than by
                NormalizeDouble(Ask+TS*Point,Digits))//..the preset value
              {
               New_Price=Ask+TS*Point;          // Its new price
               if (NormalizeDouble(SL,Digits)>0)
                  New_SL=New_Price-(Price-SL);  // New StopLoss
               if (NormalizeDouble(TP,Digits)>0)
                  New_TP=New_Price+(TP-Price);  // New TakeProfit
               Text= "BuyStopt ";               // Modify it.
              }
            break;                              // Exit 'switch'
         case 5:                                // SellStop
            if (NormalizeDouble(Price,Digits) < // If it is further than by
                NormalizeDouble(Bid-TS*Point,Digits))//..the preset value
              {
               New_Price=Bid-TS*Point;          // Its new price
               if (NormalizeDouble(SL,Digits)>0)
                  New_SL=New_Price+(SL-Price);  // New StopLoss
               if (NormalizeDouble(TP,Digits)>0)
                  New_TP=New_Price-(Price-TP);  // New TakeProfit
               Text= "SellStop ";               // Modify it.
              }
        }
      if (NormalizeDouble(New_SL,Digits)<0)     // Checking SL
         New_SL=0;
      if (NormalizeDouble(New_TP,Digits)<0)     // Checking TP
         New_TP=0;
      //------------------------------------------------------------------------- 9 --
      if (Text=="")                             // If it is not modified
        {
         Alert("No conditions for modification.");
         break;                                 // Exit 'while'
        }
      //------------------------------------------------------------------------ 10 --
      Alert ("Modification ",Text,Ticket,". Awaiting response..");
      bool Ans=OrderModify(Ticket,New_Price,New_SL,New_TP,0);//Modify it!
      //------------------------------------------------------------------------ 11 --
      if (Ans==true)                            // Got it! :)
        {
         Alert ("Modified order ",Text," ",Ticket," :)");
         break;                                 // Exit the closing cycle
        }
      //------------------------------------------------------------------------ 12 --
      int Error=GetLastError();                 // Failed :(
      switch(Error)                             // Overcomable errors
        {
         case  4: Alert("Trade server is busy. Retrying..");
            Sleep(3000);                        // Simple solution
            continue;                           // At the next iteration
         case 137:Alert("Broker is busy. Retrying..");
            Sleep(3000);                        // Simple solution
            continue;                           // At the next iteration
         case 146:Alert("Trading subsystem is busy. Retrying..");
            Sleep(500);                         // Simple solution
            continue;                           // At the next iteration
        }
      switch(Error)                             // Critical errors
        {
         case 2 : Alert("Common error.");
            break;                              // Exit 'switch'
         case 64: Alert("Account is blocked.");
            break;                              // Exit 'switch'
         case 133:Alert("Trading is prohibited");
            break;                              // Exit 'switch'
         case 139:Alert("Order is blocked and is being processed");
            break;                              // Exit 'switch'
         case 145:Alert("Modification prohibited. ",
                              "Order is too close to the market");
            break;                              // Exit 'switch'
         default: Alert("Occurred error ",Error);//Other alternatives   
        }
      break;                                    // Exit the closing cycle
     }                                          // End of closing cycle   
//------------------------------------------------------------------------------ 13 --
   Alert ("The script has completed its operations -----------------------");
   return;                                      // Exit start()
  }
//------------------------------------------------------------------------------ 14 --