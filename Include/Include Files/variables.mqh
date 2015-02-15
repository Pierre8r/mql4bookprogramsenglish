//----------------------------------------------------------------------------
// Variables.mqh
// The code should be used for educational purpose only.
//----------------------------------------------------------------------- 1 --
// Description of global variables
extern double Lots    = 0.0;// Amount of lots
extern int Percent    = 0;  // Allocated funds percentage
extern int StopLoss   =100; // StopLoss for new orders (in points) 
extern int TakeProfit =40;  // TakeProfit for new orders (in points)
extern int TralingStop=100; // TralingStop for market orders (in points)
//----------------------------------------------------------------------- 2 --
int 
   Level_new,           // New value of the minimum distance
   Level_old,           // Previous value of the minimum distance
   Mas_Tip[6];          // Order type array
                        // [] order type: 0=B,1=S,2=BL,3=SL,4=BS,5=SS
//----------------------------------------------------------------------- 3 --
double
   Lots_New,            // Amount of lots for new orders
   Mas_Ord_New[31][9],  // Current order array ..
   Mas_Ord_Old[31][9];  // .. old order array
                        // 1st index = order number in the list 
                        // [][0] cannot be detected
                        // [][1] order open price (abs. price value)
                        // [][2] StopLoss of the order (abs. price value)
                        // [][3] TakeProfit of the order (abs. price value)
                        // [][4] order number        
                        // [][5] order volume (abs. price value)
                        // [][6] order type 0=B,1=S,2=BL,3=SL,4=BS,5=SS
                        // [][7] Order magic number
                        // [][8] 0/1 the fact of availability of comments
//----------------------------------------------------------------------- 4 --