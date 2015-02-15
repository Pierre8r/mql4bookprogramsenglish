//--------------------------------------------------------------------
// arrayalert.mq4
// The code should be used for educational purpose only.
//--------------------------------------------------------------------
int start()                                     // Special funct. start()
  {
   string Mas_s[4] = {"a","b", ,"d"};           // String array
   int Mas_i[6] = { 0,1,2, ,4,5 };              // Integer type array
   Alert(Mas_s[0],Mas_s[1],Mas_s[2],Mas_s[3]);  // Displaying
   Alert(Mas_i[0],Mas_i[1],Mas_i[2],Mas_i[3],Mas_i[4],Mas_i[5]);
   return;                                      // Exit start()
  }
//--------------------------------------------------------------------