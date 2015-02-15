//--------------------------------------------------------------------
// linelevel.mq4 
// The code should be used for educational purpose only.
//--------------------------------------------------------------- 1 --
#property indicator_separate_window // Indic. is drawn in a sep. window
#property indicator_buffers 1       // Amount of buffers
#property indicator_color1 Red      // Line color
 
double Buf_0[];                     // Indicator array opening
//--------------------------------------------------------------- 2 --
int init()                          // Special init() function
  {
   SetIndexBuffer(0,Buf_0);         // Assigning the array to the buffer
   SetIndexStyle (0,DRAW_LINE,STYLE_SOLID,2);// Line style
   SetIndexLabel (0,"High/Low Difference");
   SetLevelValue (0, 0.0010);       // The horizontal line level is set
   SetLevelValue (1,-0.0010);       // Another level is set
   return;                          // Exit from spec.init() function
  }
//--------------------------------------------------------------- 3 --
int start()                         // Special start() function
  {
   int i,                           // Bar index
       Counted_bars;                // Amount of calculated bars 
 
   Counted_bars=IndicatorCounted(); // Amount of calculated bars 
   i=Bars-Counted_bars-1;           // Index of the first uncounted
 
   while(i>=0)                      // Cycle for the uncounted bars
     {
      Buf_0[i]=High[i]-Low[i];      // 0 value of the buffer on bar i
      if(Open[i]>Close[i])          // if the candle is black..
         Buf_0[i]=-Buf_0[i];        // .. then reverse the value
      i--;                          // Index calculation for the next bar
     }
   return;                          // Exit from spec.start() function
  }
//--------------------------------------------------------------- 4 --