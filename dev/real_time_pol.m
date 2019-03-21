%pre window data (for B to fill)
 data_cen = [23,120,0,62,45,0.63,91,38.2,136;
         40,126,323,60,8,0.43,48,63,103;
         50,115,307,52.4,352,0.14,35,53,80;
         60,100,289,44.8,334,0.03,17,47,62;
         70,120,266,65,311,0.3,358,48,43;
         80,110,249,50,294,0.51,340,64,25;
         80,114,76,44,121,1,158,60,203;
         90,120,232,55,277,0.87,320,68,5;
         100,121,208,61,253,0.5,298,50.7,343;
         10,100,22,60,67,0.58,118,48,163;
         0,91,49,61,97,0.8,140,50.5,185;
         350,120,60,72,105,0.75,158,59,203;
         340,112,84,69,129,0.8,178,64,223;
         330,90,111,43,156,0.65,200,63,245;
         320,117,128,61,173,0.6,218,60,263;
         310,120,146,60,191,0,238,45,283;
         300,91,169,53,214,0.2,260,62,305;
         290,120,183,55,228,0.1,279,51,324;
         280,91,208,46,253,0.2,299,65,344;
         270,113,222,74,267,0.3,319,50,4;
         260,89,247,49,292,0.1,338,44.2,23;
         250,95,271,38,316,0.2,356,50,41;
         305,100,160,42,205,0.2,249,65,294;
         295,90,180,46,225,0.13,270,61,315;
         315,116,139,56,184,0.4,228,26.7,273;
         315,120,134,68,179,0.43,228,60,273;
         325,120,122,58,167,0.78,210,51,255;
         355,88,102,42,147,0.75,188,45.8,233;
         345,122,84,40.4,129,0.77,169,54,214;
         355,92,48,61.5,93,0.65,149,47.2,194;
         5,91,39,50.1,84,0.68,128,63,173;
         120,90,167,46.2,212,0.12,259,51,304;
         140,85,131,53,176,0.26,219,57,264;
         160,108,85,60,130,0.63,179,61,224;
         190,112,26,56,71,0.25,118,58,136;
         220,110,328,54,13,1.4,58,55,103];
     
 data_left = [220,25,144,10,201,0.175,239,13.3,284;
              300,25,168,12.3,213,0.04,259,11.5,304;
              310,20.6,149,10.7,194,0.12,241,10,286;
              320,23,130,9.2,175,0.17,218,10.3,263;
              330,26,108,14,153,0.26,200,13,245;
              340,26,90,12.2,135,0.08,178,12.7,223;
              350,24,71,9.7,116,0.04,160,10.7,205;
              360,21.2,55,7.0,102,0.06,140,9.6,185;
              10,26,19,18.4,64,0.23,121,13.5,166;
              20,25,0,17,45,0.24,101,13.7,146;
              20,18.7,358,13,43,0.2,100,9.8,145;
              30,23,351,11.5,36,0.09,78,9.2,123;
              40,25,321,8.9,16,0.045,59,9.6,104;
              50,24,304,11.1,349,0.025,40,9.4,85;
              60,26,291,11.9,336,0.142,21,14.4,66;
              305,23.4,159,11.9,204,0.050,249,11.7,294;
              315,24.2,138,11.6,183,0.19,228,12.4,273;
              325,22.6,115,12.7,160,0.2,210,12.7,255;
              335,22.7,95,13.2,140,0.14,188,11.3,233;
              345,18.1,78,11.7,123,0.035,169,11.7,214;
              355,24.4,61,11.2,106,0.037,150,12.5,195;
              5,23.7,37,11.5,82,0.105,131,9.1,176;
              15,25.3,14,14.6,59,0.14,109,8.9,154;
              25,18.3,0,9.4,45,0.157,91,8.9,136];
     
data_right=[300,16.3,171,7.9,216,0.017,258,7.4,303;
            310,13.8,147,6.9,192,0.14,239,7.0,284;
            320,13.0,126,7.2,171,0.22,215,6.2,260;
            330,13.1,102,8.6,147,0.26,196,6.9,241;
            340,14.5,82,7.5,127,0.1,175,6.7,220;
            350,13.1,66,7.4,111,0.04,157,7.0,202;
            0,14.3,48,7.9,93,0.028,135,9.5,180;
            10,16.6,26,9.1,71,0.024,117,7.9,162;
            20,17.7,9,7.5,54,0.055,96,6.8,141;
            30,17.2,355,4.9,40,0.204,75,7.2,120;
            295,13.3,179,6.1,224,0.015,267,7.0,312;
            305,13.2,155,7.1,200,0.06,247,6.9,292;
            315,15.7,140,7.7,185,0.24,225,6.6,270;
            325,13.0,116,6.6,161,0.224,207,7.5,252;
            335,13.4,94,7.7,139,0.145,185,9.1,230;
            345,17,79,7.9,124,0.072,167,9.5,212;
            355,12.8,56,6.7,101,0.018,146,7.2,191;
            5,16.8,26,11.8,71,0.026,124,8.4,169;
            15,16.8,18,7.8,63,0.037,106,9.0,151;
            25,17.1,358,8.0,43,0.131,88,9.5,133;
            35,17.2,334,9.7,19,0.317,78,12.3,123];
hwp_ang = data_cen(:,1);     
d_p_cen = (data_cen(:,2)-data_cen(:,6))./(data_cen(:,2)+data_cen(:,6));%contrast 
V_cen = sqrt(1-d_p_cen.^2).*(1-2.*(22.5<abs(mod(hwp_ang,90)-42.5)));

hwp_ang = data_left(:,1);  
d_p_left = (data_left(:,2)-data_left(:,6))./(data_left(:,2)+data_left(:,6));%contrast 
V_left = sqrt(1-d_p_left.^2).*(1-2.*(22.5<abs(mod(hwp_ang,90)-42.5)));

hwp_ang = data_right(:,1);
d_p_right = (data_right(:,2)-data_right(:,6))./(data_right(:,2)+data_right(:,6));%contrast 
V_right = sqrt(1-d_p_right.^2).*(1-2.*(22.5<abs(mod(hwp_ang,90)-42.5)));

sfigure(1);
clf
scatter(mod(data_cen(:,1),90),V_cen)
hold on
scatter(mod(data_left(:,1),90),V_left)
scatter(mod(data_right(:,1),90),V_right,'g')
hold off
ylabel('A')
xlabel('HWP ang')

    pol_data_val = [
                       NaN    6.0000   75.0000  146.0000    0.9600   50.5000   -1.0000
                       NaN  354.0000   89.0000  120.0000    0.9400   29.0000   -1.0000
                       NaN  314.0000  120.0000   40.0000    0.3700  130.5000    1.0000
                       NaN  335.0000  113.0000   84.0000    0.1300  170.0000   -1.0000
                       NaN  344.0000  133.0000  104.0000    0.6800  190.0000   -1.0000
                       NaN  353.0000   57.0000  298.0000    0.6500  208.0000   -1.0000
                       NaN  347.0000   78.0000  282.0000    0.6600  194.0000   -1.0000
                       NaN  342.0000   92.0000  278.0000    0.5200  187.0000   -1.0000
                       NaN  340.0000   71.0000  271.0000    0.3300  181.0000   -1.0000
                       NaN  338.5000   65.0000  266.0000    0.2300  176.5000   -1.0000
                       NaN  338.5000   65.0000  266.0000    0.2300  176.5000   -1.0000
                       NaN  335.0000   79.0000  264.0000    0.1600  171.0000   -1.0000
                       NaN  332.0000   80.0000  255.0000    0.2000  165.0000    1.0000
                       NaN  319.0000  120.0000   70.5000    0.1200  160.0000    1.0000
                       NaN  327.0000   60.4000  248.0000    0.1100  155.0000    1.0000
                       NaN  324.0000   87.6000  238.0000    0.2300  147.0000    1.0000
                       NaN  320.0000  112.0000   50.0000    0.3300  140.5000    1.0000
                       NaN  309.0000   78.0000  221.0000    0.3700  120.0000    1.0000
                       NaN  299.0000   72.0000  188.0000    0.2500   99.5000    1.0000
                       NaN  290.0000  107.5000  165.0000    0.0700   80.0000   -1.0000
                       NaN  310.0000   86.0000   32.0000    0.3600  121.0000    1.0000
                       NaN  352.0000   72.0000  112.0000    0.5400   24.5000   -1.0000
                       NaN    3.0000   74.0000  137.0000    0.8600   46.0000   -1.0000
                       NaN   10.0000   84.0000  154.0000    0.5200   61.0000   -1.0000
                       NaN   26.0000   77.0000  181.0000    0.0600   92.0000    1.0000
                       NaN    4.0000   70.1000  135.0000    0.7000  231.0000   -1.0000
                       NaN  358.0000   78.0000  308.0000    0.9000  217.0000   -1.0000
                       NaN  350.0000   82.0000  290.0000    0.7200  199.0000   -1.0000
                       NaN  300.0000   72.0000  191.0000    0.1700  100.0000    1.0000
                       NaN  320.0000   62.0000  230.0000    0.2400  140.0000    1.0000
                       NaN  329.0000   76.0000  249.0000    0.1400  160.0000    1.0000
                       NaN  339.0000   93.0000   89.0000    0.1900  180.0000   -1.0000
                       NaN   15.0000  120.0000  165.0000    0.5900   70.0000   -1.0000
                       NaN    9.5000   53.0000  150.0000    0.6400  239.5000   -1.0000
                       NaN   14.5000   75.1000  160.0000    0.5800  249.0000   -1.0000
                       NaN  304.0000   79.0000   20.0000    0.3400  111.0000    1.0000
                       NaN  325.0000   98.0000   63.0000    0.1400  151.0000    1.0000
                  280.0000  333.0000  168.0000  257.0000    0.1300  171.0000    1.0000
                  283.0000  333.0000  195.0000   83.0000    0.6000  352.0000    1.0000
                  283.0000  333.0000  195.0000   83.0000    0.6000  352.0000    1.0000
                  246.0000  333.0000  127.0000   29.0000   45.0000  136.0000   -1.0000
                  270.0000  333.0000  167.3000  248.0000    5.3700  159.0000   -1.0000
                  286.5000  333.0000  165.0000   88.5000    2.1800  179.0000    1.0000
                  310.0000  333.0000  140.7000  117.0000   40.8000  205.0000    1.0000
                  286.0000  333.0000  165.0000   88.5000    2.1800  179.0000    1.0000
                  254.0000  333.0000  115.0000  240.0000   22.1000  143.0000   -1.0000
                  246.0000  333.0000  101.0000   50.0000   42.0000  316.0000   -1.0000
                  234.0000  333.0000   95.0000  226.0000   82.0000  319.0000   -1.0000
                  226.0000  333.0000   87.0000  290.0000   73.0000  199.0000   -1.0000
                  220.0000  333.0000  110.0000  273.0000   44.1000  192.0000   -1.0000
                  202.0000  333.0000  178.0000  262.0000   11.5000  355.0000   -1.0000
                  187.0000  333.0000  165.0000  253.0000    0.4600  343.0000    1.0000
                  177.0000  333.0000  150.0000  248.0000    8.7000  338.0000    1.0000
                  162.0000  333.0000  132.0000  242.0000   35.0000  329.0000    1.0000
                  154.0000  333.0000  113.0000  236.0000   58.0000  328.0000    1.0000
                  130.0000  333.0000  119.0000  284.0000   31.0000   12.0000    1.0000
                  134.0000  333.0000  156.0000  292.0000   59.0000   18.0000    1.0000
                  138.0000  333.0000  134.0000  284.0000   58.0000    3.0000    1.0000
                  142.0000  333.0000   77.5000  278.0000   53.0000    9.0000    1.0000
                  146.0000  333.0000  118.0000  260.0000   74.0000  344.0000    1.0000
                  150.0000  333.0000   90.6000  245.0000   63.9000  152.0000    1.0000
                  260.0000  333.0000  124.0000   51.0000   18.1000  329.0000   -1.0000
                  270.0000  340.0000  206.5000   66.0000   34.4000  156.0000   -1.0000
                  274.0000  350.0000  205.0000  222.0000   143.200  314.0000   -1.0000
                  268.0000  354.0000  176.0000  165.0000    87.000  252.0000   -1.0000
                  280.0000  10.0000   148.0000  352.0000    11.200   83.0000   -1.0000
                  290.0000   6.0000   123.5000   12.0000    49.100   281.000   -1.0000
                  ];
                  V_cen = pol_data_val(:,7).*2.*sqrt(pol_data_val(:,3).*pol_data_val(:,5))...
        ./(pol_data_val(:,3)+pol_data_val(:,5));%the V parameter for each run
              hold on
        hwp_ang = pol_data_val(1:37,2);
        scatter(mod(hwp_ang,90),(V_cen(1:37)),'kx')
        legend('Bryce Pre Cen','Bryce Pre Left','Bryce Pre Right','Post orgigina')