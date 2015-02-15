//--------------------------------------------------------------------------------
// Events.mqh
// The code should be used for educational purpose only.
//--------------------------------------------------------------------------- 1 --
// Event tracking function.
// Global variables:
// Level_new            The new value of the minimum distance
// Level_old            The preceding value of the minimum distance
// Mas_Ord_New[31][9]   The last known array of orders
// Mas_Ord_Old[31][9]   The old array of orders
//--------------------------------------------------------------------------- 2 --
int Events()                              // User-defined function
  {
   bool Conc_Nom_Ord;                     // Matching orders in ..
   //.. the old and the new arrays
//--------------------------------------------------------------------------- 3 --
   Level_new=MarketInfo(Symbol(),MODE_STOPLEVEL );// Last known
   if (Level_old!=Level_new)              // New is not the same as old..
     {                                    // it means the condition have been changed
      Level_old=Level_new;                // New "old value"
      Inform(10,Level_new);               // Message: new distance
     }
//--------------------------------------------------------------------------- 4 --
   // Searching for lost, type-changed, partly closed and reopened orders
   for(int old=1;old<=Mas_Ord_Old[0][0];old++)// In the array of old orders
     {                                    // Assuming the..
      Conc_Nom_Ord=false;                 // ..orders don't match
      //--------------------------------------------------------------------- 5 --
      for(int new=1;new<=Mas_Ord_New[0][0];new++)//Cycle for the array ..
        {                                 //..of new orders
         //------------------------------------------------------------------ 6 --
         if (Mas_Ord_Old[old][4]==Mas_Ord_New[new][4])// Matched number 
           {                              // Order type becomes ..
            if (Mas_Ord_New[new][6]!=Mas_Ord_Old[old][6])//.. different
               Inform(7,Mas_Ord_New[new][4]);// Message: modified:)
            Conc_Nom_Ord=true;            // The order is found, ..
            break;                        // ..so exiting ..
           }                              // .. the internal cycle
         //------------------------------------------------------------------ 7 --
                                          // Order number does not match
         if (Mas_Ord_Old[old][7]>0 &&     // MagicNumber matches
            Mas_Ord_Old[old][7]==Mas_Ord_New[new][7])//.. with the old one
           {               //it means it is reopened or partly closed
                                             // If volumes match,.. 
            if (Mas_Ord_Old[old][5]==Mas_Ord_New[new][5])
               Inform(8,Mas_Ord_Old[old][4]);// ..it is reopening
            else                             // Otherwise, it was.. 
               Inform(9,Mas_Ord_Old[old][4]);// ..partly closing
            Conc_Nom_Ord=true;               // The order is found, ..
            break;                           // ..so exiting ..
           }                                 // .. the internal cycle
        }
      //--------------------------------------------------------------------- 8 --
      if (Conc_Nom_Ord==false)               // If we are here,..
        {                                    // ..it means no order found:(
         if (Mas_Ord_Old[old][6]==0)
            Inform(1, Mas_Ord_Old[old][4]);  // Order Buy closed
         if (Mas_Ord_Old[old][6]==1)
            Inform(2, Mas_Ord_Old[old][4]);  // Order Sell closed
         if (Mas_Ord_Old[old][6]> 1)
            Inform(3, Mas_Ord_Old[old][4]);  // Pending order deleted
        }
     }
//--------------------------------------------------------------------------- 9 --
   // Search for new orders
   for(new=1; new<=Mas_Ord_New[0][0]; new++)// In the array of new orders
     {
      if (Mas_Ord_New[new][8]>0)            //This one is not new, but reopened
         continue;                          //..or partly closed
      Conc_Nom_Ord=false;                   // As long as no matches found
      for(old=1; old<=Mas_Ord_Old[0][0]; old++)// Searching for this order 
        {                                   // ..in the array of old orders
         if (Mas_Ord_New[new][4]==Mas_Ord_Old[old][4])//Matched number..
           {                                          //.. of the order
            Conc_Nom_Ord=true;              // The order is found, ..
            break;                          // ..so exiting ..
           }                                // .. the internal cycle
        }
      if (Conc_Nom_Ord==false)              // If no matches found,..
        {                                   // ..the order is new :)
         if (Mas_Ord_New[new][6]==0)
            Inform(4, Mas_Ord_New[new][4]); // Order Buy opened
         if (Mas_Ord_New[new][6]==1)
            Inform(5, Mas_Ord_New[new][4]); // Order Sell opened
         if (Mas_Ord_New[new][6]> 1)
            Inform(6, Mas_Ord_New[new][4]); // Pending order placed
        }
     }
//-------------------------------------------------------------------------- 10 --
   return;
  }
//-------------------------------------------------------------------------- 11 --