//-------------------------------------------------------------------------------------
// deleteorder.mq4 
// The code should be used for educational purpose only.
//-------------------------------------------------------------------------------- 1 --
int start()                                     // Special function 'start'
  {
   string Symb=Symbol();                        // Symbol
   double Dist=1000000.0;                       // Presetting
   int Limit_Stop=-1;                           // No pending orders yet
   double Win_Price=WindowPriceOnDropped();     // The script is dropped here
//-------------------------------------------------------------------------------- 2 --
   for(int i=1; i<=OrdersTotal(); i++)          // Order searching cycle
     {
      if (OrderSelect(i-1,SELECT_BY_POS)==true) // If the next is available
        {                                       // Order analysis:
         //----------------------------------------------------------------------- 3 --
         if (OrderSymbol()!= Symb) continue;    // Symbol is not ours
         int Tip=OrderType();                   // Order type
         if (Tip>2) continue;                   // Market order  
         //----------------------------------------------------------------------- 4 --
         double Price=OrderOpenPrice();         // Order price
         if (NormalizeDouble(MathAbs(Price-Win_Price),Digits)> //Selection
            NormalizeDouble(Dist,Digits))       // of the closest order       
           {
            Dist=MathAbs(Price-Win_Price);      // New value
            Limit_Stop=Tip;                     // Pending order available
            int Ticket=OrderTicket();           // Order ticket
           }                                    // End of 'if'
        }                                       //End of order analysis
     }                                          // End of order searching
//-------------------------------------------------------------------------------- 5 --
   switch(Limit_Stop)                           // By order type
     {
      case 2: string Text= "BuyLimit ";         // Text for BuyLimit
         break;                                 // Exit 'switch'
      case 3: Text= "SellLimit ";               // Text for SellLimit
         break;                                 // Exit 'switch'
      case 4: Text= "BuyStopt ";                // Text for BuyStopt
         break;                                 // Exit 'switch'
      case 5: Text= "SellStop ";                // Text for SellStop
         break;                                 // Exit 'switch'
     }
//-------------------------------------------------------------------------------- 6 --
   while(true)                                  // Order closing cycle
     {
      if (Limit_Stop==-1)                       // If no pending orders available
        {
         Alert("For ",Symb," no pending orders available");
         break;                                 // Exit closing cycle        
        }
      //-------------------------------------------------------------------------- 7 --
      Alert("Attempt to delete ",Text," ",Ticket,". Awaiting response..");
      bool Ans=OrderDelete(Ticket);             // Deletion of the order
      //-------------------------------------------------------------------------- 8 --
      if (Ans==true)                            // Got it! :)
        {
         Alert ("Deleted order ",Text," ",Ticket);
         break;                                 // Exit closing cycle
        }
      //-------------------------------------------------------------------------- 9 --
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
         case 139:Alert("The order is blocked and is being processed");
            break;                              // Exit 'switch'
         case 145:Alert("Modification is prohibited. ",
                              "The order is too close to the market");
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