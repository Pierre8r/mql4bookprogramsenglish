//----------------------------------------------------------------------------
// Inform.mqh
// The code should be used for educational purpose only.
//----------------------------------------------------------------------- 1 --
// Function that displays graphical messages on the screen.
//----------------------------------------------------------------------- 2 --
int Inform(int Mess_Number, int Number=0, double Value=0.0)
  {
   // int    Mess_Number               // Message number  
   // int    Number                    // Integer to be passed
   // double Value                     // Real number to be passed
   int    Win_ind;                     // Indicator window number
   string Graf_Text;                   // Message line
   color  Color_GT;                    // Color of the message line
   static int    Time_Mess;            // Last publication time of the message
   static int    Nom_Mess_Graf;        // Graphical messages counter
   static string Name_Grf_Txt[30];     // Array of graphical message names
//----------------------------------------------------------------------- 3 --
   Win_ind= WindowFind("inform");      // Searching for indicator window number
   if (Win_ind<0)return;               // If there is no such a window, leave
//----------------------------------------------------------------------- 4 --
   if (Mess_Number==0)                 // This happens at every tick
     {
      if (Time_Mess==0) return;        // If it is gray already
      if (GetTickCount()-Time_Mess>15000)// The color has become updated within 15 sec
        {
         for(int i=0;i<=29; i++)       // Color lines with gray
            ObjectSet( Name_Grf_Txt[i], OBJPROP_COLOR, Gray);
         Time_Mess=0;                  // Flag: All lines are gray
         WindowRedraw();               // Redrawing objects
        }
      return;                          // Exit the function
     }
//----------------------------------------------------------------------- 5 --
   if (Mess_Number==-1)                // This happens at deinit()
     {
      for(i=0; i<=29; i++)             // By object indexes
         ObjectDelete(Name_Grf_Txt[i]);// Deletion of object
      return;                          // Exit the function
     }
//----------------------------------------------------------------------- 6 --
   Nom_Mess_Graf++;                    // Graphical messages counter
   Time_Mess=GetTickCount();           // Last publication time 
   Color_GT=Lime;
//----------------------------------------------------------------------- 7 --
   switch(Mess_Number)                 // Going to message
     {
      case 1:
         Graf_Text="Closed order Buy "+ Number;
         PlaySound("Close_order.wav");                         break;
      case 2:
         Graf_Text="Closed order Sell "+ Number;
         PlaySound("Close_order.wav");                         break;
      case 3:
         Graf_Text="Deleted pending order "+ Number;
         PlaySound("Close_order.wav");                         break;
      case 4:
         Graf_Text="Opened order Buy "+ Number;
         PlaySound("Ok.wav");                                  break;
      case 5:
         Graf_Text="Opened order Sell "+ Number;
         PlaySound("Ok.wav");                                  break;
      case 6:
         Graf_Text="Placed pending order "+ Number;
         PlaySound("Ok.wav");                                  break;
      case 7:
         Graf_Text="Order "+Number+" modified into the market one";
         PlaySound("Transform.wav");                           break;
      case 8:
         Graf_Text="Reopened order "+ Number;                  break;
         PlaySound("Bulk.wav");
      case 9:
         Graf_Text="Partly closed order "+ Number;
         PlaySound("Close_order.wav");                         break;
      case 10:
         Graf_Text="New minimum distance: "+ Number;
         PlaySound("Inform.wav");                              break;
      case 11:
         Graf_Text=" Not enough money for "+
         DoubleToStr(Value,2) + " lots";
         Color_GT=Red;
         PlaySound("Oops.wav");                                break;
      case 12:
         Graf_Text="Trying to close order "+ Number;
         PlaySound("expert.wav");                              break;
      case 13:
         if (Number>0)
            Graf_Text="Trying to open order Sell..";
         else
            Graf_Text="Trying to open order Buy..";
         PlaySound("expert.wav");                              break;
      case 14:
         Graf_Text="Invalid password. EA doesn't function.";
         Color_GT=Red;
         PlaySound("Oops.wav");                                break;
      case 15:
         switch(Number)                 // Going to the error number
           {
            case 2:   Graf_Text="Common error.";                    break;
            case 129: Graf_Text="Wrong price. ";                    break;
            case 135: Graf_Text="Price changed. ";                  break;
            case 136: Graf_Text="No prices. Awaiting a new tick.."; break;
            case 146: Graf_Text="Trading subsystem is busy";        break;
            case 5 :  Graf_Text="Old version of the terminal.";     break;
            case 64:  Graf_Text="Account is blocked.";              break;
            case 133: Graf_Text="Trading is prohibited";            break;
            default:  Graf_Text="Occurred error " + Number;//Other errors
           }
         Color_GT=Red;
         PlaySound("Error.wav");                                    break;
      case 16:
         Graf_Text="Expert Advisor works only for EURUSD";
         Color_GT=Red;
         PlaySound("Oops.wav");                                     break;
      default:
         Graf_Text="default "+ Mess_Number;
         Color_GT=Red;
         PlaySound("Bzrrr.wav");
     }
//----------------------------------------------------------------------- 8 --
   ObjectDelete(Name_Grf_Txt[29]);      // Deleting 29th (upper) object
   for(i=29; i>=1; i--)                 // Cycle for array indexes ..
     {                                 // .. of graphical objects
      Name_Grf_Txt[i]=Name_Grf_Txt[i-1];// Raising objects:
      ObjectSet( Name_Grf_Txt[i], OBJPROP_YDISTANCE, 2+15*i);
     }
   Name_Grf_Txt[0]="Inform_"+Nom_Mess_Graf+"_"+Symbol(); // Object name
   ObjectCreate (Name_Grf_Txt[0],OBJ_LABEL, Win_ind,0,0);// Creating
   ObjectSet    (Name_Grf_Txt[0],OBJPROP_CORNER, 3   );  // Corner
   ObjectSet    (Name_Grf_Txt[0],OBJPROP_XDISTANCE, 450);// Axis ?
   ObjectSet    (Name_Grf_Txt[0],OBJPROP_YDISTANCE, 2);  // Axis Y
   // ????????? ???????? ???????
   ObjectSetText(Name_Grf_Txt[0],Graf_Text,10,"Courier New",Color_GT);
   WindowRedraw();                      // Redrawing all objects
   return;
  }
//----------------------------------------------------------------------- 9 --