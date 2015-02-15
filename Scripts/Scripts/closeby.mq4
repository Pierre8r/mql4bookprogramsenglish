//--------------------------------------------------------------------
// closeby.mq4 
// The code should be used for educational purpose only.
//--------------------------------------------------------------- 1 --
int start()                                     // Special function 'start'
  {
   string Symb=Symbol();                        // Symbol
   double Dist=1000000.0;                       // Presetting
//--------------------------------------------------------------- 2 --
   while(true)                                  // Processing cycle.. 
     {                                          // ..of opposite orders
      double Hedg_Buy = -1.0;                   // Max. cost of Buy
      double Hedg_Sell= -1.0;                   // Max. cost of Sell
      for(int i=1; i<=OrdersTotal(); i++)       // Order searching cycle
        {
         if(OrderSelect(i-1,SELECT_BY_POS)==true)// If the next is available
           {                                    // Order analysis:
            //--------------------------------------------------- 3 --
            if (OrderSymbol()!= Symb) continue; // Symbol is not ours
            int Tip=OrderType();                // Order type
            if (Tip>1) continue;                // Pending order  
            //--------------------------------------------------- 4 --
            switch(Tip)                         // By order type
              {
               case 0:                          // Order Buy
                  if (OrderLots()>Hedg_Buy)
                    {
                     Hedg_Buy=OrderLots();      // Choose the max. cost
                     int Ticket_Buy=OrderTicket();//Order ticket
                    }
                  break;                        // From switch
               case 1:                          // Order Sell
                  if (OrderLots()>Hedg_Sell)
                    {
                     Hedg_Sell=OrderLots();     // Choose the max. cost
                     int Ticket_Sell=OrderTicket();//Order ticket
                    }
              }                                 //End of 'switch'
           }                                    //End of order analysis
        }                                       //End of order searching
      //--------------------------------------------------------- 5 --
      if (Hedg_Buy<0 || Hedg_Sell<0)            // If no order available..
        {                                       // ..of some type
         Alert("All opposite orders are closed :)");// Message  
         return;                                // Exit start()
        }
      //--------------------------------------------------------- 6 --
      while(true)                               // Closing cycle 
        {
         //------------------------------------------------------ 7 --
         Alert("Attempt to close by. Awaiting response..");
         bool Ans=OrderCloseBy(Ticket_Buy,Ticket_Sell);// ???????? 
         //------------------------------------------------------ 8 --
         if (Ans==true)                         // Got it! :)
           {
            Alert ("Performed closing by.");
            break;                              // Exit closing cycle
           }
         //------------------------------------------------------ 9 --
         int Error=GetLastError();              // Failed :(
         switch(Error)                          // Overcomable errors
           {
            case  4: Alert("Trade server is busy. Retrying..");
               Sleep(3000);                     // Simple solution
               continue;                        // At the next iteration
            case 137:Alert("Broker is busy. Retrying..");
               Sleep(3000);                     // Simple solution
               continue;                        // At the next iteration
            case 146:Alert("Trading subsystem is busy. Retrying..");
               Sleep(500);                      // Simple solution
               continue;                        // At the next iteration
           }
         switch(Error)                          // Critical errors
           {
            case 2 : Alert("Common error.");
               break;                           // Exit 'switch'
            case 64: Alert("Account is blocked.");
               break;                           // Exit 'switch'
            case 133:Alert("Trading is prohibited");
               break;                           // Exit 'switch'
            case 139:Alert("The order is blocked and is being processed");
               break;                           // Exit 'switch'
            case 145:Alert("Modification is prohibited. ",
                                 "The order is too close to market");
               break;                           // Exit 'switch'
            default: Alert("Occurred error ",Error);//Other alternatives   
           }
         Alert ("The script has finished operations --------------------------");
         return;                                // Exit start()
        }
     }                                          // End of the processing cycle
//-------------------------------------------------------------- 10 --
  }                                             // End of start()
//--------------------------------------------------------------------