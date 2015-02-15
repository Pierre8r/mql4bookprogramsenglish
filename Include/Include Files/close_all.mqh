//---------------------------------------------------------------------------------
// Close_All.mqh
// The code should be used for educational purpose only.
//---------------------------------------------------------------------------- 1 --
// Function closing all market orders of the given type
// Global variables:
// Mas_Ord_New   Last known order array
// Mas_Tip       Order type array
//---------------------------------------------------------------------------- 2 --
int Close_All(int Tip)                    // User-defined function
  {
   // int Tip                             // Order type
   int Ticket=0;                          // Order ticket
   double Lot=0;                          // Amount of closed lots
   double Price_Cls;                      // Order close price
//---------------------------------------------------------------------------- 3 --
   while(Mas_Tip[Tip]>0)                 // As long as the orders of the ..
     {                                   //.. given type are available 
      for(int i=1; i<=Mas_Ord_New[0][0]; i++)// Cycle for live orders
        {
         if(Mas_Ord_New[i][6]==Tip &&     // Among the orders of our type
            Mas_Ord_New[i][5]>Lot)        // .. select the most expensive one
           {                              // This one was found at earliest.
            Lot=Mas_Ord_New[i][5];        // The largest amount of lots found
            Ticket=Mas_Ord_New[i][4];     // Its order ticket is that
           }
        }
      if (Tip==0) Price_Cls=Bid;          // For orders Buy
      if (Tip==1) Price_Cls=Ask;          // For orders Sell
      Inform(12,Ticket);                  // Message about an attempt to close
      bool Ans=OrderClose(Ticket,Lot,Price_Cls,2);// Close order !:)
      //---------------------------------------------------------------------- 4 --
      if (Ans==false)                     // Failed :( 
        {                                // Check for errors:
         if(Errors(GetLastError())==false)// If the error is critical,
            return;                       // .. then leave.
        }
      //---------------------------------------------------------------------- 5 --
      Terminal();                         // Order accounting function 
      Events();                           // Event tracking
     }
   return;                                // Exit the user-defined function
  }
//---------------------------------------------------------------------------- 6 --