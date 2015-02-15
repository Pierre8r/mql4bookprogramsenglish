//--------------------------------------------------------------------
// Terminal.mqh
// The code should be used for educational purpose only.
//------------------------------------------------------------------------------ 1 --
// Order accounting function
// Global variables:
// Mas_Ord_New[31][9]   // The latest known orders array
// Mas_Ord_Old[31][9]   // The preceding (old) orders array
                        // 1st index = order number 
                        // [][0] not defined
                        // [][1] order open price (abs. price value)
                        // [][2] StopLoss of the order (abs. price value)
                        // [][3] TakeProfit of the order (abs. price value)
                        // [][4] order number        
                        // [][5] order volume in lots (abs. price value)
                        // [][6] order type 0=B,1=S,2=BL,3=SL,4=BS,5=SS
                        // [][7] order magic number
                        // [][8] 0/1 comment availability
// Mas_Tip[6]           // Array of the amount of orders of all types
                        // [] order type: 0=B,1=S,2=BL,3=SL,4=BS,5=SS
//------------------------------------------------------------------------------ 2 --
int Terminal()
  {
   int Qnt=0;                          // Orders counter
 
//------------------------------------------------------------------------------ 3 --
   ArrayCopy(Mas_Ord_Old, Mas_Ord_New);// Saves the preceding history
   Qnt=0;                              // Zeroize orders counter
   ArrayInitialize(Mas_Ord_New,0);     // Zeroize the array
   ArrayInitialize(Mas_Tip,    0);     // Zeroize the array
//------------------------------------------------------------------------------ 4 --
   for(int i=0; i<OrdersTotal(); i++) // For market and pending orders
     {
      if((OrderSelect(i,SELECT_BY_POS)==true)     //If there is the next one
      && (OrderSymbol()==Symbol()))               //.. and our currency pair
        {
         //--------------------------------------------------------------------- 5 --
         Qnt++;                                   // Amount of orders
         Mas_Ord_New[Qnt][1]=OrderOpenPrice();    // Order open price
         Mas_Ord_New[Qnt][2]=OrderStopLoss();     // SL price
         Mas_Ord_New[Qnt][3]=OrderTakeProfit();   // TP price 
         Mas_Ord_New[Qnt][4]=OrderTicket();       // Order number
         Mas_Ord_New[Qnt][5]=OrderLots();         // Amount of lots
         Mas_Tip[OrderType()]++;                  // Amount of orders of the type
         Mas_Ord_New[Qnt][6]=OrderType();         // Order type
         Mas_Ord_New[Qnt][7]=OrderMagicNumber();  // Magic number 
         if (OrderComment()=="")
            Mas_Ord_New[Qnt][8]=0;                // If there is no comment
         else
            Mas_Ord_New[Qnt][8]=1;                // If there is a comment
         //--------------------------------------------------------------------- 6 --
        }
     }
   Mas_Ord_New[0][0]=Qnt;                         // Amount of orders
//------------------------------------------------------------------------------ 7 --
   return;
  }
//------------------------------------------------------------------------------ 8 --