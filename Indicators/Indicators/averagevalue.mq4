//--------------------------------------------------------------------
// averagevalue.mq4 
// The code should be used for educational purpose only.
//--------------------------------------------------------------------
#property indicator_chart_window    // Indicator is drawn in the main window
#property indicator_buffers 2       // Number of buffers
#property indicator_color1 Blue     // Color of the 1st line
#property indicator_color2 Red      // Color of the 2nd line
 
extern int Aver_Bars=5;             // number of bars for calculation
 
double Buf_0[],Buf_1[];             // Declaring indicator arrays
//--------------------------------------------------------------------
int init()                          // Special function init()
  {
//--------------------------------------------------------------------
   SetIndexBuffer(0,Buf_0);         // Assigning an array to a buffer
   SetIndexStyle (0,DRAW_LINE,STYLE_SOLID,2);// Line style
//--------------------------------------------------------------------
   SetIndexBuffer(1,Buf_1);         // Assigning an array to a buffer
   SetIndexStyle (1,DRAW_LINE,STYLE_DOT,1);// Line style
//--------------------------------------------------------------------
   return;                          // Exit the special funct.init()
  }
//--------------------------------------------------------------------
int start()                         // Special function start()
  {
   int i,                           // Bar index
       n,                           // Formal parameter
       Counted_bars;                // Number of counted bars
       double
       Sum_H,                       // Sum of High values for period
       Sum_L;                       // Sum of Low values for period
//--------------------------------------------------------------------
   Counted_bars=IndicatorCounted(); // Number of counted bars
   i=Bars-Counted_bars-1;           // Index of the first uncounted
   while(i>=0)                      // Loop for uncounted bars
     {
      Sum_H=0;                      // Nulling at loop beginning
      Sum_L=0;                      // Nulling at loop beginning
      for(n=i;n<=i+Aver_Bars-1;n++) // Loop of summing values
        {
         Sum_H=Sum_H + High[n];     // Accumulating maximal values sum
         Sum_L=Sum_L + Low[n];      // Accumulating minimal values sum
        }
      Buf_0[i]=Sum_H/Aver_Bars;     // Value of 0 buffer on i bar
      Buf_1[i]=Sum_L/Aver_Bars;     // Value of 1st buffer on i bar
 
      i--;                          // Calculating index of the next bar
     }
//--------------------------------------------------------------------
   return;                          // Exit the special funct. start()
  }
//--------------------------------------------------------------------