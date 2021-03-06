


////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT START (by dugland, v1.063, #Wokemo)
////////////////////////////////////////////////////////


////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT END
////////////////////////////////////////////////////////
#define GUI_GRID_X	(0)
#define GUI_GRID_Y	(0)
#define GUI_GRID_W	(0.025)
#define GUI_GRID_H	(0.04)
#define GUI_GRID_WAbs	(1)
#define GUI_GRID_HAbs	(1)


class PARAMETERS_DIALOG
{
    idd = 5001;
    movingenable = false;
    duration = 10e10;

    class Controls
    {


         class RscFrame_1800: RscFrame
        {
          idc = 1800;
          text = "";
          x = -15 * GUI_GRID_W + GUI_GRID_X;
          y = 0;
          w = 22 * GUI_GRID_W;
          h = 25 * GUI_GRID_H;
        };
          class RscBox_1801: IGUIBack
         {
          idc = 1801;
          text = "";
          x = -15 * GUI_GRID_W + GUI_GRID_X;
          y = 0;
          w = 22 * GUI_GRID_W;
          h = 25 * GUI_GRID_H;
         };
       

         class RscText_1002: RscText
        {
            idc = 1002;
            text = "Time of the day";
            x = -10 * GUI_GRID_W + GUI_GRID_X;
            y = 4 * GUI_GRID_H + GUI_GRID_Y;
            w = 12 * GUI_GRID_W;
            h = 1 * GUI_GRID_H;
        };
        class RscCombo_2100: RscCombo
        {
          idc = 2100;
          text = "Time of the day";
          x = -10 * GUI_GRID_W + GUI_GRID_X;
          y = 5 * GUI_GRID_H + GUI_GRID_Y;
          w = 12 * GUI_GRID_W;
          h = 1 * GUI_GRID_H;
          tooltip = "Time day";
        };
         class RscText_1003: RscText
        {
            idc = 1003;
            text = "Weather";
            x = -10 * GUI_GRID_W + GUI_GRID_X;
            y = 7 * GUI_GRID_H + GUI_GRID_Y;
            w = 12 * GUI_GRID_W;
            h = 1 * GUI_GRID_H;
        };
         class RscCombo_2101: RscCombo
        {
          idc = 2101;
          text = "Weather";
          x = -10 * GUI_GRID_W + GUI_GRID_X;
          y = 8 * GUI_GRID_H + GUI_GRID_Y;
          w = 12 * GUI_GRID_W;
          h = 1 * GUI_GRID_H;
          tooltip = "Time weather";
        };

        
     class RscText_1004: RscText
        {
            idc = 1004;
            text = "People density";
            x = -10 * GUI_GRID_W + GUI_GRID_X;
            y = 10 * GUI_GRID_H + GUI_GRID_Y;
            w = 12 * GUI_GRID_W;
            h = 1 * GUI_GRID_H;
        };
       class RscCombo_2102: RscCombo
        {
          idc = 2102;
          text = "People density";
          x = -10 * GUI_GRID_W + GUI_GRID_X;
          y = 11 * GUI_GRID_H + GUI_GRID_Y;
          w = 12 * GUI_GRID_W;
          h = 1 * GUI_GRID_H;
          tooltip = "People density";
        };

        class RscText_1005: RscText
        {
            idc = 1005;
            text = "Faction (WIP)";
            x = -10 * GUI_GRID_W + GUI_GRID_X;
            y = 13 * GUI_GRID_H + GUI_GRID_Y;
            w = 12 * GUI_GRID_W;
            h = 1 * GUI_GRID_H;
        };
       class RscCombo_2103: RscCombo
        {
          idc = 2103;
          text = "Faction (WIP)";
          x = -10 * GUI_GRID_W + GUI_GRID_X;
          y = 14 * GUI_GRID_H + GUI_GRID_Y;
          w = 12 * GUI_GRID_W;
          h = 1 * GUI_GRID_H;
          tooltip = "Faction";
        };
        class RscText_1006: RscText
        {
            idc = 1006;
            text = "Medevac AI system enabled";
            x = -8 * GUI_GRID_W + GUI_GRID_X;
            y = 16 * GUI_GRID_H + GUI_GRID_Y;
            w = 12 * GUI_GRID_W;
            h = 1 * GUI_GRID_H;
        };
       class RscCombo_2104: RscCheckbox
        {
          idc = 2104;
          x = -10 * GUI_GRID_W + GUI_GRID_X;
          y = 16 * GUI_GRID_H + GUI_GRID_Y;
          w = 1 * GUI_GRID_W;
          h = 1 * GUI_GRID_H;
          tooltip = "Enable AI medevac system";
        };
        class RscText_1007: RscText
        {
            idc = 1007;
            text = "Respawn available";
            x = -8 * GUI_GRID_W + GUI_GRID_X;
            y = 17 * GUI_GRID_H + GUI_GRID_Y;
            w = 12 * GUI_GRID_W;
            h = 1 * GUI_GRID_H;
        };
       class RscCombo_2105: RscCheckbox
        {
          idc = 2105;
          x = -10 * GUI_GRID_W + GUI_GRID_X;
          y = 17 * GUI_GRID_H + GUI_GRID_Y;
          w = 1 * GUI_GRID_W;
          h = 1 * GUI_GRID_H;
          tooltip = "Enable respawn";
        };

        class RscText_1008: RscText
        {
            idc = 1008;
            text = "Restricted arsenal";
            x = -8 * GUI_GRID_W + GUI_GRID_X;
            y = 18 * GUI_GRID_H + GUI_GRID_Y;
            w = 12 * GUI_GRID_W;
            h = 1 * GUI_GRID_H;
        };
       class RscCombo_2106: RscCheckbox
        {
          idc = 2106;
          x = -10 * GUI_GRID_W + GUI_GRID_X;
          y = 18 * GUI_GRID_H + GUI_GRID_Y;
          w = 1 * GUI_GRID_W;
          h = 1 * GUI_GRID_H;
          tooltip = "Enable restricted arsenal";
        };

        
      /*  class RscPicture_2200: RscPicture
        {
          idc = 2200;
          text = "#(argb,8,8,3)color(0,0,0,0.2)";
          x = 35 * GUI_GRID_W + GUI_GRID_X;
          y = -5 * GUI_GRID_H + GUI_GRID_Y;
          w = 12 * GUI_GRID_W;
          h = 5 * GUI_GRID_H;
        };
    
        class RscPicture_2201: RscPicture
        {
          idc = 2201;
          text = "#(argb,8,8,3)color(0,0,0,0.2)";
          x = 35 * GUI_GRID_W + GUI_GRID_X;
          y = 1 * GUI_GRID_H + GUI_GRID_Y;
          w = 12 * GUI_GRID_W;
          h = 5 * GUI_GRID_H;
        };

        class RscPicture_2202: RscPicture
        {
          idc = 2202;
          text = "#(argb,8,8,3)color(0,0,0,0.2)";
          x = 35 * GUI_GRID_W + GUI_GRID_X;
          y = 7 * GUI_GRID_H + GUI_GRID_Y;
          w = 12 * GUI_GRID_W;
          h = 5 * GUI_GRID_H;
        }; */

        class ICE_BUTTON_1000: RscButton
        {
          idc = -1;
          text = "OK";
          x = -10 * GUI_GRID_W + GUI_GRID_X;
          y = 20 * GUI_GRID_H + GUI_GRID_Y;
          w = 12 * GUI_GRID_W;
          h = 1 * GUI_GRID_H;
          action = "[] call fnc_SaveAndCloseConfigDialog";
        };
    };
};

