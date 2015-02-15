//--------------------------------------------------------------------
// displacement.mq4 
// The code should be used for educational purpose only.
//--------------------------------------------------------------------
#property indicator_chart_window       //Indicator is drawn in the main window
#property indicator_buffers 3          // Number of buffers
#property indicator_color1 Red         // Color of the 1st line
#property indicator_color2 Blue        // Color of the 2nd line
#property indicator_color3 Green       // Color of the 3rd line
 
extern int History  =500;              // Amount of bars in calculation history
extern int Aver_Bars=5;                // Amount of bars for calculation
extern int Left_Right= 5;              // Horizontal shift (bars)
extern int Up_Down  =25;               // Vertical shift (points)
 
double Line_0[],Line_1[],Line_2[];     // Declaring data arrays
//--------------------------------------------------------------------
int init()                             // Special funct. init()
  {
//--------------------------------------------------------------------
   SetIndexBuffer(0,Line_0);           // Assigning an array to buffer 0
   SetIndexStyle (0,DRAW_LINE,STYLE_SOLID,2);// Line style
//--------------------------------------------------------------------
   SetIndexBuffer(1,Line_1);           // Assigning an array to buffer 1
   SetIndexStyle (1,DRAW_LINE,STYLE_DOT,1);// Line style
//--------------------------------------------------------------------
   SetIndexBuffer(2,Line_2);           // Assigning an array to buffer 2
   SetIndexStyle (2,DRAW_LINE,STYLE_DOT,1);// Line style
//--------------------------------------------------------------------
   return;                             // Exit the special funct. init()
  }
//--------------------------------------------------------------------
int start()                            // Special function start()
  {
   int i,                              // Bar index
       n,                              // Formal parameter (index)
       k,                              // Index of indicator array element
       Counted_bars;                   // Number of counted bars
       double
       Sum;                            // High and Low sum for the period
//--------------------------------------------------------------------
   Counted_bars=IndicatorCounted();    // Number of counted bars
   i=Bars-Counted_bars-1;              // Index of the 1st uncounted
   if (i>History-1)                    // If too many bars ..
      i=History-1;                     // ..calculate for specified amount.
 
   while(i>=0)                         // Loop for uncounted bars
     {
      Sum=0;                           // Nulling at loop beginning
      for(n=i;n<=i+Aver_Bars-1;n++)    // Loop of summing values 
         Sum=Sum + High[n]+Low[n];     // Accumulating maximal values sum
      k=i+Left_Right;                  // Obtaining calculation index
      Line_0[k]= Sum/2/Aver_Bars;      // Value of 0 buffer on k bar
      Line_1[k]= Line_0[k]+Up_Down*Point;// Value of the 1st buffer
      Line_2[k]= Line_0[k]-Up_Down*Point;// Value of the 2nd buffer
 
      i--;                             // Calculating index of the next bar
     }
//--------------------------------------------------------------------
   return;                             // Exit the special funct. start()
  }
//--------------------------------------------------------------------