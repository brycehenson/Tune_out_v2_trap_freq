
background = 0.1; % all power in microwatts
%Angle readings on dial when fast axis vertical
hwp_offset = 20; 
qwp_offset = 24;
%hwp 337 qwp 198 min transmition of 1.8 to reflection of 490
%with test hwp 155 min 0.99 to 490
       %QWP HWP QWP_anal HWP_Anal: 155 Phi_min Phi_max (Reflect,Transmit) ...
data = {130,333,nan,155,[140.,343],[332,131] ,112,[108,347],196;
        134,333,nan,155,[300.,162],[325,160] ,242,[130,352],286;
        138,333,nan,155,[273.,185],[275,180] ,068,[150,314],109;
        142,333,nan,155,[252.,202],[256,202] ,169,[178,285],209;
        146,333,nan,155,[245.,216],[270,185] ,270,[156,307],124;
        150,333,nan,155,[242.,222],[297,165] ,297,[138,335],130;
        154,333,nan,155,[235.,256],[325,138] ,079,[116,380],117;
        162,333,nan,155,[195.,278],[380,66.7],039,[084,409],084;
        177,333,nan,155,[087.,282],[527,10.2],122,[12.3,421],165;
        187,333,nan,155,[022.,406],[500,03.6],204,[.8,437],250;
        202,333,nan,155,[21.7,412],[420,38.8],287,[27.8,418],242
        220,333,nan,155,[150,306], [350,129], 275,[125,367],232
        226,333,nan,155,[199,262], [309,157], 179,[159,352],126
        234,333,nan,155,[240.,210],[260,208], 172,[220,282],208
        246,333,nan,155,[242.,211],[353,158], 226,[147,346],272
        254,333,nan,155,[267.,222],[411,111], 037,[100,395],351
        270,333,nan,155,[080.,415],[454,24.3], 299,[15.2,489],
        280,333,nan,155,[021.,477],[535,03.7], 204,[1.3,508],249
        283,333,nan,155,[13.7,464],[540,05.2], 204,[4.6,463],158
        270,340,nan,155,[126.,360],[412,105], 121,[76,368],77
        274,350,nan,155,[203.,280],[317,207], 024,[184,291],86
        268,354,nan,155,[299.,153],[297,155], 066,[160,312],21
        280,010,nan,155,[472,045], [465,41.7],066,[34,437],22
        290,006,nan,155,[326,158], [372,148], 059,[140,366],14
        198,337,nan,155,[1.8,490]
        
        