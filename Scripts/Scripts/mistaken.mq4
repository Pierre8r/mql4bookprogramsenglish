//-------------------------------------------------------------------------
// mistaken.mq4 
// The code should be used for educational purpose only.
//-------------------------------------------------------------------------
int start()                                     // Special function start
  {                                             // Opening BUY
   OrderSend(Symbol(),OP_BUY,0.1,Bid,3,Bid-15*Point,Bid+15*Point);
   Alert (GetLastError());                      // Error message
   return;                                      // Exit start()
  }
//-------------------------------------------------------------------------