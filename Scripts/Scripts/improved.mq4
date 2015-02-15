//------------------------------------------------------------------------------
// improved.mq4 
// The code should be used for educational purpose only.
//------------------------------------------------------------------------------
int start()                                     // Special function start
  {
   double bid   =MarketInfo("GBPUSD",MODE_BID); // Request for the value of Bid
   double ask   =MarketInfo("GBPUSD",MODE_ASK); // Request for the value of Ask
   double point =MarketInfo("GBPUSD",MODE_POINT);//Request for Point
   // Opening BUY
   OrderSend("GBPUSD",OP_BUY,0.1,ask,3,bid-15*Point,bid+15*Point);
   Alert (GetLastError());                      // Error message
   return;                                      // Exit start()
  }
//------------------------------------------------------------------------------