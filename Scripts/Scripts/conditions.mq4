//--------------------------------------------------------------------------
// conditions.mq4 
// The code should be used for educational purpose only.
//--------------------------------------------------------------------------
int start()                                      // Special function start
  {
   Alert(Symbol(),"  Sell = ",AccountFreeMargin()// At selling
         -AccountFreeMarginCheck(Symbol(),OP_SELL,1));
   Alert(Symbol(),"  Buy = ",AccountFreeMargin() // At buying
         -AccountFreeMarginCheck(Symbol(),OP_BUY,1));
   return;                                       // Exit start()
  }
//--------------------------------------------------------------------------