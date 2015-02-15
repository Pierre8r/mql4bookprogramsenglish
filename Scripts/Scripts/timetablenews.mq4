//--------------------------------------------------------------------
// timetablenews.mq4
// The code should be used for educational purpose only.
//--------------------------------------------------------------- 1 --
int start()                            // Spec. function start()
  {
//--------------------------------------------------------------- 2 --
   int Handle,                         // File descriptor
       Stl;                            // Style of vertical line
   string File_Name="News.csv",        // Name of the file
          Obj_Name,                    // Name of the object
          Instr,                       // Name of the currency
          One,Two,                     // 1st and 2nd name of the instr.
          Text,                        // Text of event description
          Str_DtTm;                    // Date and time of the event (line)
   datetime Dat_DtTm;                  // Date and time of the event (date)
   color Col;                          // Color of the vertical line
//--------------------------------------------------------------- 3 --
   Handle=FileOpen(File_Name,FILE_CSV|FILE_READ,";");// File opening
   if(Handle<0)                        // File opening fails
     {
      if(GetLastError()==4103)         // If the file does not exist,..
         Alert("No file named ",File_Name);//.. inform trader
      else                             // If any other error occurs..
         Alert("Error while opening file ",File_Name);//..this message
      PlaySound("Bzrrr.wav");          // Sound accompaniment
      return;                          // Exit start()      
     }
//--------------------------------------------------------------- 4 --
   while(FileIsEnding(Handle)==false)  // While the file pointer..
     {                                 // ..is not at the end of the file
      //--------------------------------------------------------- 5 --
      Str_DtTm =FileReadString(Handle);// Date and time of the event (date)
      Text     =FileReadString(Handle);// Text of event description
      if(FileIsEnding(Handle)==true)   // File pointer is at the end
         break;                        // Exit reading and drawing
      //--------------------------------------------------------- 6 --
      Dat_DtTm =StrToTime(Str_DtTm);   // Transformation of data type
      Instr    =StringSubstr(Text,0,3);// Extract first three symbols
      One=StringSubstr(Symbol(),0,3);// Extract first three symbols
      Two=StringSubstr(Symbol(),3,3);// Extract second three symbols
      Stl=STYLE_DOT;                   // For all - dotted line style
      Col=DarkOrange;                  // For all - this color
      if(Instr==One || Instr==Two)     // And for the events of our..
        {                              // .. symbol..
         Stl=STYLE_SOLID;              // .. this style..
         Col=Red;                      // .. and this color of the vert. line
        }
      //--------------------------------------------------------- 7 --
      Obj_Name="News_Line  "+Str_DtTm;              // Name of the object
      ObjectCreate(Obj_Name,OBJ_VLINE,0,Dat_DtTm,0);// Create object..
      ObjectSet(Obj_Name,OBJPROP_COLOR, Col);       // ..and its color,..
      ObjectSet(Obj_Name,OBJPROP_STYLE, Stl);       // ..and style..
      ObjectSetText(Obj_Name,Text,10);              // ..and description
     }
//--------------------------------------------------------------- 8 --
   FileClose( Handle );                // Close file
   PlaySound("bulk.wav");              // Sound accompaniment
   WindowRedraw();                     // Redraw object
   return;                             // Exit start()
  }
//--------------------------------------------------------------- 9 --