//--------------------------------------------------------------------
// incorrect.mq4
// To be used as an example in MQL4 book.
//--------------------------------------------------------------------
int start()                                     // Special funct. start()
   {
   double Price = Bid;                          // Local variable
   Count++;
   Alert ("New tick ",Count,"   Price = ",Price);// Alert
   return;                                      // Exit start()
   }
//--------------------------------------------------------------------
int Count=0;                                    // Global variable
//--------------------------------------------------------------------
int init()                                      // Special funct. init()
   {
   Alert ("Function init() triggered at start");// Alert
   return;                                      // Exit init()
   }   
//--------------------------------------------------------------------
int deinit()                                    // Special funct. deinit()
   {
   Alert ("Function deinit() triggered at exit");// Alert
   return;                                      // Exit deinit()
   }
//--------------------------------------------------------------------