//--------------------------------------------------------------------
// simpleopen.mq4 
// The code should be used for educational purpose only.
//--------------------------------------------------------------------
int start()                                  // Special function start()
  {                                          // Opening BUY
   OrderSend(Symbol(),OP_BUY,0.1,Ask,3,Bid-15*Point,Bid+15*Point);
   return;                                   // Exit start()
  }
//--------------------------------------------------------------------