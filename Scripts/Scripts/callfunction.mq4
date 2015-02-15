///-----------------------------------------------------------------------------------
// callfunction.mq4
// The code should be used for educational purpose only.
//------------------------------------------------------------------------------------
int start()                               // Description of function start()
  {                                       // Start of the function start() body
   int n;                                 // Variable declaration
   int T=15;                              // Predefined time
   for(int i=Func_yes_ret(T);i<=10;i++)   // The use of the function in..
                                          //.the cycle operator header
     {                                    // Start of the cycle 'for' body
      n=n+1;                              // Iterations counter
      Alert ("Iteration n=",n," i=",i);   // Function call operator
     }                                    // End of the cycle 'for' body
   return;                                // Exit function start()
  }                                       // End of the function start() body
//-------------------------------------------------------------------------------------
int Func_yes_ret (int Times_in)           // Description of the user-defined function
  {                                       // Start of the user-defined function body
   datetime T_cur=TimeCurrent();          // The use of the function in.. 
                                          // ..the assignment operator
   if(TimeHour(T_cur) > Times_in)         // The use of the function in.. 
                                          //..the header of the operator 'if-else'
      return(1);                          // Return value 1
   return(5);                             // Return value 5
  }                                       // End of the user-defined function body
//-------------------------------------------------------------------------------------