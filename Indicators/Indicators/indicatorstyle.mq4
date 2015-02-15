//--------------------------------------------------------------------
// indicatorstyle.mq4 
// The code should be used for educational purpose only.
//--------------------------------------------------------------- 1 --
#property indicator_chart_window    // Indic. is drawn in the main window
#property indicator_buffers 1       // Amount of buffers
#property indicator_color1 Blue     // Color of the first line
 
double Buf_0[];                     // Indicator array opening
//--------------------------------------------------------------- 2 --
int init()                          // Special function init()
  {
   SetIndexBuffer(0,Buf_0);         // Assigning the array to the buffer
   SetIndexStyle (0,DRAW_LINE,STYLE_SOLID,2);// Line style
   SetIndexLabel (0,"High Line");
   return;                          // Exit spec. function init()
  }
//--------------------------------------------------------------- 3 --
int start()                         // Special function start()
  {
   int i,                           // Bar index
   Counted_bars;                    // Amount of calculated bars
   Counted_bars=IndicatorCounted(); // Amount of calculated bars 
   i=Bars-Counted_bars-1;           // Index of the first uncounted
   while(i>=0)                      // Cycle for the uncounted bars
     {
      Buf_0[i]=High[i];             // value 0 of the buffer on ith bar
      i--;                          // Index calculation for the next bar
     }
   return;                          // Exit spec. function start()
  }
//--------------------------------------------------------------- 4 --