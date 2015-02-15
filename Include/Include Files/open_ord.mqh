//---------------------------------------------------------------------------------
// Open_Ord.mqh
// The code should be used for educational purpose only.
//---------------------------------------------------------------------------- 1 --
// Function opening one market order of the given type
// Global variables:
// int Mas_Tip                Order type array
// int StopLoss               The value of StopLoss (amount of points)
// int TakeProfit             The value of TakeProfit (amount of points)
//---------------------------------------------------------------------------- 2 --
int Open_Ord(int Tip)
  {
   int    Ticket,                        // Order ticket
          MN;                            // MagicNumber
   double SL,                            // StopLoss (as related to the price)
          TP;                            // TakeProf (as related to the price)
//---------------------------------------------------------------------------- 3 --
   while(Mas_Tip[Tip]==0)                // Until they ..
     {                                   //.. succeed
      if (StopLoss<Level_new)            // If it is less than allowed..
         StopLoss=Level_new;             // .. then the allowed one
      if (TakeProfit<Level_new)          // If it is less than allowed..
         TakeProfit=Level_new;           // ..then the allowed one
      MN=TimeCurrent();                  // Simple MagicNumber
      Inform(13,Tip);                    // Message about an attempt to open
      if (Tip==0)                        // Let's open a Buy
        {
         SL=Bid - StopLoss*  Point;      // StopLoss   (price)
         TP=Bid + TakeProfit*Point;      // TakeProfit (price)
         Ticket=OrderSend(Symbol(),0,Lots_New,Ask,2,SL,TP,"",MN);
        }
      if (Tip==1)                        // Let's open a Sell
        {
         SL=Ask + StopLoss*  Point;      // StopLoss   (price)
         TP=Ask - TakeProfit*Point;      // TakeProfit (price)
         Ticket=OrderSend(Symbol(),1,Lots_New,Bid,2,SL,TP,"",MN);
        }
      //---------------------------------------------------------------------- 4 --
      if (Ticket<0)                       // Failed :( 
        {                                 // Check for errors:
         if(Errors(GetLastError())==false)// If the error is critical,
            return;                       // .. then leave.
        }
      Terminal();                         // Order accounting function 
      Events();                           // Event tracking
     }
//---------------------------------------------------------------------------- 5 --
   return;                                // Exit the user-defined function
  }
//---------------------------------------------------------------------------- 6 --