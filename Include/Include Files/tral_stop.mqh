//---------------------------------------------------------------------------------
// Tral_Stop.mqh
// The code should be used for educational purpose only.
//---------------------------------------------------------------------------- 1 --
// Function modifying StopLosses of all orders of the given type
// Global variables:
// Mas_Ord_New             Last known order array
// int TralingStop         Value of TralingStop (amount of points)
//---------------------------------------------------------------------------- 2 --
int Tral_Stop(int Tip)
  {
   int Ticket;                      // Order ticket
   double
   Price,                           // Market order open price
   TS,                              // TralingStop (as related to the price)
   SL,                              // Value of order StopLoss
   TP;                              // Value of order TakeProfit
   bool Modify;                     // A criterion to modify.
//---------------------------------------------------------------------------- 3 --
   for(int i=1;i<=Mas_Ord_New[0][0];i++)  // Cycle for all orders
     {                                    // Searching for orders of the given type
      if (Mas_Ord_New[i][6]!=Tip)         // If this is not our type..
         continue;                        //.. skip the order
      Modify=false;                       // It is not assigned to be modified
      Price =Mas_Ord_New[i][1];           // Order open price
      SL    =Mas_Ord_New[i][2];           // Value of order StopLoss
      TP    =Mas_Ord_New[i][3];           // Value of order TakeProft
      Ticket=Mas_Ord_New[i][4];           // Order ticket
      if (TralingStop<Level_new)          // If it is less than allowed..
         TralingStop=Level_new;           // .. then the allowed one
      TS=TralingStop*Point;               // The same in the relat, price value
      //---------------------------------------------------------------------- 4 --
      switch(Tip)                         // Go to Order type
        {
         case 0 :                         // Order Buy
            if (NormalizeDouble(SL,Digits)<// If it is lower than we want..
               NormalizeDouble(Bid-TS,Digits))
              {                           // ..then modify it:
               SL=Bid-TS;                 // Its new StopLoss
               Modify=true;               // Assigned to be modified.
              }
            break;                        // Exit 'switch'
         case 1 :                         // Order Sell
            if (NormalizeDouble(SL,Digits)>// If it is higher than we want..
               NormalizeDouble(Ask+TS,Digits)||
               NormalizeDouble(SL,Digits)==0)//.. or zero(!)
              {                           // ..then modify it
               SL=Ask+TS;                 // Its new StopLoss
               Modify=true;               // Assigned to be modified.
              }
        }                                 // End of 'switch'
      if (Modify==false)                  // If there is no need to modify it..
         continue;                        // ..then continue the cycle
      bool Ans=OrderModify(Ticket,Price,SL,TP,0);//Modify it!
      //---------------------------------------------------------------------- 5 --
      if (Ans==false)                     // Failed :( 
        {                                 // Check for errors:
         if(Errors(GetLastError())==false)// If the error is critical,
            return;                       // .. then leave.
         i--;                             // Decreasing counter
        }
      Terminal();                         // Order accounting function 
      Events();                           // Event tracking
     }
   return;                                // Exit the user-defined function
  }
//---------------------------------------------------------------------------- 6 --