# subtotal_section outputs are consistent

    Code
      subtotal_section(df_simple, mtcars, vars = "mpg")
    Output
      # A tibble: 4 x 2
      # Groups:   cyl [4]
        cyl     mpg
        <fct> <dbl>
      1 All   643. 
      2 4      26.7
      3 6      19.7
      4 8      15.1

---

    Code
      subtotal_section(df_multi, mtcars, vars = "hp")
    Output
      # A tibble: 38 x 4
      # Groups:   cyl, gear, vs [38]
         cyl   gear  vs       hp
         <fct> <fct> <fct> <dbl>
       1 All   All   All    4694
       2 All   All   0      3415
       3 All   All   1      1279
       4 All   3     All    2642
       5 All   3     0      2330
       6 All   3     1       312
       7 All   4     All    1074
       8 All   4     0       220
       9 All   4     1       854
      10 All   5     All     978
      # i 28 more rows

---

    Code
      subtotal_section(df_bad, mtcars, vars = "mpg")
    Condition
      Error:
      ! 
      Your data report has only one column!

# subtotal_section advanced scenarios

    Code
      subtotal_section(df_iris, iris, vars = c("Sepal.Length", "Sepal.Width"))
    Output
      # A tibble: 4 x 3
      # Groups:   Species [4]
        Species    Sepal.Length Sepal.Width
        <fct>             <dbl>       <dbl>
      1 All                876.        459.
      2 setosa             250.        171.
      3 versicolor         297.        138.
      4 virginica          329.        149.

---

    Code
      subtotal_section(df_dia, ggplot2::diamonds, vars = "price", aggregator = "mean",
      exclude = 1)
    Output
      # A tibble: 365 x 4
      # Groups:   cut, color, clarity [365]
         cut   color clarity price
         <fct> <fct> <fct>   <dbl>
       1 All   All   All     3933.
       2 All   All   I1      3924.
       3 All   All   SI2     5063.
       4 All   All   SI1     3996.
       5 All   All   VS2     3925.
       6 All   All   VS1     3839.
       7 All   All   VVS2    3284.
       8 All   All   VVS1    2523.
       9 All   All   IF      2865.
      10 Fair  All   All     4359.
      # i 355 more rows

---

    Code
      subtotal_section(df_cars, mtcars, vars = "mpg", aggregator = "max",
        subtotal_label = "Grand Total", agg_parameter = "na.rm")
    Output
      # A tibble: 15 x 3
      # Groups:   cyl, gear [15]
         cyl         gear          mpg
         <fct>       <fct>       <dbl>
       1 Grand Total Grand Total  33.9
       2 Grand Total 3            21.5
       3 Grand Total 4            33.9
       4 Grand Total 5            30.4
       5 4           Grand Total  33.9
       6 4           3            21.5
       7 4           4            33.9
       8 4           5            30.4
       9 6           Grand Total  21.4
      10 6           3            21.4
      11 6           4            21  
      12 6           5            19.7
      13 8           Grand Total  19.2
      14 8           3            19.2
      15 8           5            15.8

---

    Code
      subtotal_section(df_na, airquality, vars = "Ozone")
    Condition
      Warning in `subtotal_section()`:
      NA values detected in output. Setting agg_parameter to "na.rm" may resolve this.
    Output
      # A tibble: 6 x 2
      # Groups:   Month [6]
        Month Ozone
        <fct> <dbl>
      1 All    NA  
      2 5      23.6
      3 6      29.4
      4 7      59.1
      5 8      60.0
      6 9      31.4

---

    Code
      subtotal_section(df_complex, mtcars, vars = c("mpg", "disp"), aggregator = "median",
      exclude = c(2, 3))
    Output
      # A tibble: 23 x 5
      # Groups:   cyl, gear, carb [23]
         cyl   gear  carb    mpg  disp
         <fct> <fct> <fct> <dbl> <dbl>
       1 All   3     1      21.4 225  
       2 All   3     2      17.1 339  
       3 All   3     3      16.4 276. 
       4 All   3     4      13.3 440  
       5 All   4     1      29.8  78.8
       6 All   4     2      23.6 131. 
       7 All   4     4      20.1 164. 
       8 All   5     2      28.2 108. 
       9 All   5     4      15.8 351  
      10 All   5     6      19.7 145  
      # i 13 more rows

---

    Code
      subtotal_section(df_breaks, warpbreaks, vars = "breaks", aggregator = "sd")
    Output
      # A tibble: 12 x 3
      # Groups:   wool, tension [12]
         wool  tension breaks
         <fct> <fct>    <dbl>
       1 All   All      13.2 
       2 All   L        16.4 
       3 All   M         9.12
       4 All   H         8.35
       5 A     All      15.9 
       6 A     L        18.1 
       7 A     M         8.66
       8 A     H        10.3 
       9 B     All       9.30
      10 B     L         9.86
      11 B     M         9.43
      12 B     H         4.89

---

    Code
      subtotal_section(df_dates, data.frame(report_date = as.Date(c("2026-07-01",
        "2026-07-01", "2026-08-01", "2026-08-01")), is_active = c(TRUE, TRUE, FALSE,
        TRUE), revenue = c(100, 200, 150, 300)), vars = "revenue")
    Output
      # A tibble: 8 x 3
      # Groups:   report_date, is_active [8]
        report_date is_active revenue
        <fct>       <fct>       <dbl>
      1 All         All           750
      2 All         FALSE         150
      3 All         TRUE          600
      4 2026-07-01  All           300
      5 2026-07-01  TRUE          300
      6 2026-08-01  All           450
      7 2026-08-01  FALSE         150
      8 2026-08-01  TRUE          300

---

    Code
      subtotal_section(df_weird_groups, data.frame(category = c("A", "A", NA, "B"),
      value = c(10, 15, 20, 25)), vars = "value")
    Output
      # A tibble: 4 x 2
      # Groups:   category [4]
        category value
        <fct>    <dbl>
      1 All         70
      2 A           25
      3 B           25
      4 <NA>        20

# Snapshot: High cardinality, multiple variables, default aggregator

    Code
      as.data.frame(out)
    Output
             region store_id category      sales    profit
      1         All      All      All 5020833.09 502176.26
      2         All      All        A  500800.13  50999.43
      3         All      All        B  483136.99  49980.84
      4         All      All        C  519025.64  50555.85
      5         All      All        D  510138.14  50191.45
      6         All      All        E  517187.99  51466.73
      7         All      All        F  510789.79  50834.66
      8         All      All        G  524073.40  51172.65
      9         All      All        H  496284.21  51367.44
      10        All      All        I  491477.36  49039.95
      11        All      All        J  467919.44  46567.26
      12        All  Store_1      All   99343.99  10128.98
      13        All  Store_1        A    9386.04   1084.89
      14        All  Store_1        B    6986.99    769.66
      15        All  Store_1        C   13361.07   1138.06
      16        All  Store_1        D   11930.73   1046.59
      17        All  Store_1        E   10034.24    929.71
      18        All  Store_1        F    8035.57    752.08
      19        All  Store_1        G    6044.55    710.86
      20        All  Store_1        H   11716.34   1349.90
      21        All  Store_1        I   12482.54   1312.52
      22        All  Store_1        J    9365.92   1034.71
      23        All Store_10      All   99064.37  10126.84
      24        All Store_10        A    9932.63   1357.71
      25        All Store_10        B   11795.25   1194.80
      26        All Store_10        C   12148.80    997.89
      27        All Store_10        D    8675.45    952.50
      28        All Store_10        E   13602.09   1132.42
      29        All Store_10        F   10588.96   1075.39
      30        All Store_10        G    8823.99    958.68
      31        All Store_10        H    8778.47    895.75
      32        All Store_10        I    6090.59    749.85
      33        All Store_10        J    8628.14    811.85
      34        All Store_11      All   95056.45   9667.64
      35        All Store_11        A    7641.63    883.28
      36        All Store_11        B    9434.92    712.21
      37        All Store_11        C   11523.02   1213.32
      38        All Store_11        D    4732.02    554.70
      39        All Store_11        E    7806.38    883.37
      40        All Store_11        F   10608.94   1049.20
      41        All Store_11        G   13281.97   1313.28
      42        All Store_11        H    9872.59    969.04
      43        All Store_11        I   10460.05   1059.35
      44        All Store_11        J    9694.93   1029.89
      45        All Store_12      All  102292.11  10107.89
      46        All Store_12        A   12854.80   1339.46
      47        All Store_12        B   10030.63    980.99
      48        All Store_12        C    9509.05    787.45
      49        All Store_12        D    8631.86    848.41
      50        All Store_12        E   15034.66   1436.78
      51        All Store_12        F    7497.89    799.73
      52        All Store_12        G    8815.82    773.57
      53        All Store_12        H    9962.14   1043.89
      54        All Store_12        I   10161.94   1060.29
      55        All Store_12        J    9793.32   1037.32
      56        All Store_13      All  113890.24  11927.99
      57        All Store_13        A   11692.98   1293.24
      58        All Store_13        B   10720.07    997.99
      59        All Store_13        C    7899.04   1012.46
      60        All Store_13        D   10234.83   1107.29
      61        All Store_13        E   12504.02   1420.14
      62        All Store_13        F   11147.04   1009.73
      63        All Store_13        G   16427.21   1622.70
      64        All Store_13        H   12294.92   1358.17
      65        All Store_13        I   14689.19   1384.99
      66        All Store_13        J    6280.94    721.28
      67        All Store_14      All  111346.51  11112.92
      68        All Store_14        A    7251.05   1175.91
      69        All Store_14        B   15159.13   1260.88
      70        All Store_14        C    6428.67    694.48
      71        All Store_14        D   13709.81   1177.32
      72        All Store_14        E   10045.53   1039.73
      73        All Store_14        F   13123.82   1072.11
      74        All Store_14        G   11703.41   1350.18
      75        All Store_14        H   11018.99    993.67
      76        All Store_14        I   10657.26   1207.41
      77        All Store_14        J   12248.84   1141.23
      78        All Store_15      All  107976.03   9891.96
      79        All Store_15        A    8356.63    632.18
      80        All Store_15        B    8712.67    774.13
      81        All Store_15        C   12917.12   1107.23
      82        All Store_15        D   10036.19   1016.08
      83        All Store_15        E    8424.07    670.35
      84        All Store_15        F   12861.38    913.14
      85        All Store_15        G   10373.44   1191.66
      86        All Store_15        H   12859.44   1376.54
      87        All Store_15        I    8754.08    833.79
      88        All Store_15        J   14681.01   1376.86
      89        All Store_16      All   93083.34   9609.70
      90        All Store_16        A    9988.07    961.67
      91        All Store_16        B    8791.48    915.88
      92        All Store_16        C    6859.14    983.13
      93        All Store_16        D    7223.05    860.84
      94        All Store_16        E    9440.72    889.30
      95        All Store_16        F   16425.78   1415.98
      96        All Store_16        G    7823.40    801.62
      97        All Store_16        H    8088.15    863.00
      98        All Store_16        I    9858.30   1030.77
      99        All Store_16        J    8585.25    887.51
      100       All Store_17      All  110641.21  10731.70
      101       All Store_17        A   10995.77   1046.70
      102       All Store_17        B   12206.51   1388.53
      103       All Store_17        C   10191.13   1013.70
      104       All Store_17        D   13996.76   1130.22
      105       All Store_17        E    9828.03    974.98
      106       All Store_17        F   10286.92    952.82
      107       All Store_17        G   11505.98    994.15
      108       All Store_17        H    8349.43    880.03
      109       All Store_17        I   10620.91   1178.18
      110       All Store_17        J   12659.77   1172.39
      111       All Store_18      All   94193.30   8959.74
      112       All Store_18        A    9137.49    862.13
      113       All Store_18        B    8762.47    959.73
      114       All Store_18        C   10904.39    956.05
      115       All Store_18        D    9501.00    876.06
      116       All Store_18        E   11096.88    894.29
      117       All Store_18        F    9887.07    867.13
      118       All Store_18        G    7441.43    823.53
      119       All Store_18        H   11451.85   1033.87
      120       All Store_18        I    5085.22    439.88
      121       All Store_18        J   10925.50   1247.07
      122       All Store_19      All   88699.81   9476.10
      123       All Store_19        A   10274.41    873.75
      124       All Store_19        B    9272.91    815.97
      125       All Store_19        C    6262.78    760.08
      126       All Store_19        D   11150.32    926.24
      127       All Store_19        E   10879.74   1185.62
      128       All Store_19        F    9070.22    898.89
      129       All Store_19        G    7264.88    989.54
      130       All Store_19        H    7391.87    941.02
      131       All Store_19        I   11968.92   1120.34
      132       All Store_19        J    5163.76    964.65
      133       All  Store_2      All   97963.58   9723.50
      134       All  Store_2        A    8543.27   1263.95
      135       All  Store_2        B   16350.53   1651.23
      136       All  Store_2        C   15823.66   1273.61
      137       All  Store_2        D   12002.26    948.72
      138       All  Store_2        E   12546.49   1006.76
      139       All  Store_2        F    8470.75   1167.49
      140       All  Store_2        G    5187.36    531.81
      141       All  Store_2        H    6610.77    707.52
      142       All  Store_2        I    6110.36    753.27
      143       All  Store_2        J    6318.13    419.14
      144       All Store_20      All   90130.09   9048.35
      145       All Store_20        A   10984.73   1216.64
      146       All Store_20        B    8386.11    661.97
      147       All Store_20        C    9432.55    863.77
      148       All Store_20        D    8220.57    993.92
      149       All Store_20        E    5993.22    642.95
      150       All Store_20        F    6519.25    852.48
      151       All Store_20        G   10891.05    846.86
      152       All Store_20        H    6037.17    674.03
      153       All Store_20        I   12269.68   1194.00
      154       All Store_20        J   11395.76   1101.73
      155       All Store_21      All  106398.04  10350.85
      156       All Store_21        A   12369.92   1052.67
      157       All Store_21        B   11116.29   1173.47
      158       All Store_21        C   14356.82   1241.57
      159       All Store_21        D   10035.20   1106.03
      160       All Store_21        E    9550.24    880.41
      161       All Store_21        F   15285.23   1504.79
      162       All Store_21        G   12252.40   1081.52
      163       All Store_21        H    5239.23    826.12
      164       All Store_21        I    9781.07    943.45
      165       All Store_21        J    6411.64    540.82
      166       All Store_22      All   92928.44   9169.67
      167       All Store_22        A    9788.84   1037.59
      168       All Store_22        B    5282.70    512.47
      169       All Store_22        C    7276.10    834.03
      170       All Store_22        D   10713.35   1077.76
      171       All Store_22        E   13854.09   1077.97
      172       All Store_22        F    9300.80    867.06
      173       All Store_22        G    8381.73   1011.75
      174       All Store_22        H    7142.51    841.96
      175       All Store_22        I   12202.74    992.37
      176       All Store_22        J    8985.58    916.71
      177       All Store_23      All   88888.80  10085.65
      178       All Store_23        A    8025.20    919.31
      179       All Store_23        B    6896.73    900.58
      180       All Store_23        C   13290.05   1565.21
      181       All Store_23        D    7338.68    952.35
      182       All Store_23        E    8640.01    868.10
      183       All Store_23        F   12007.58   1262.26
      184       All Store_23        G    6807.43    749.88
      185       All Store_23        H   10417.94    933.51
      186       All Store_23        I    7530.75    980.71
      187       All Store_23        J    7934.43    953.74
      188       All Store_24      All  110408.16  10340.83
      189       All Store_24        A   11227.17   1197.47
      190       All Store_24        B   12417.43   1146.79
      191       All Store_24        C    9377.56    978.14
      192       All Store_24        D   15922.32   1377.34
      193       All Store_24        E   11604.12   1235.87
      194       All Store_24        F    5498.43    444.57
      195       All Store_24        G   14130.44   1184.33
      196       All Store_24        H   14849.99   1526.80
      197       All Store_24        I   13660.27   1011.15
      198       All Store_24        J    1720.43    238.37
      199       All Store_25      All   92609.44  10320.10
      200       All Store_25        A   10239.24   1302.84
      201       All Store_25        B    7302.43    752.47
      202       All Store_25        C    6723.96    679.06
      203       All Store_25        D    8496.49   1015.34
      204       All Store_25        E    9943.33   1013.88
      205       All Store_25        F   13241.12   1346.55
      206       All Store_25        G    9886.99   1301.56
      207       All Store_25        H    9695.50   1318.88
      208       All Store_25        I    8347.84    840.88
      209       All Store_25        J    8732.54    748.64
      210       All Store_26      All  106448.36   9801.82
      211       All Store_26        A   14481.56   1238.17
      212       All Store_26        B   11950.61   1106.06
      213       All Store_26        C    9208.71    844.40
      214       All Store_26        D   14038.58   1408.77
      215       All Store_26        E    9609.59   1206.60
      216       All Store_26        F    9236.27    785.06
      217       All Store_26        G    7813.54    665.87
      218       All Store_26        H   11211.80   1022.31
      219       All Store_26        I   12454.58    974.60
      220       All Store_26        J    6443.12    549.98
      221       All Store_27      All   88583.91   9511.78
      222       All Store_27        A    8449.48    884.61
      223       All Store_27        B    6809.10    624.16
      224       All Store_27        C   10748.26   1053.08
      225       All Store_27        D    4825.79    538.78
      226       All Store_27        E   11784.00   1318.21
      227       All Store_27        F   10205.60   1052.15
      228       All Store_27        G   11556.25   1092.37
      229       All Store_27        H    7498.38    871.58
      230       All Store_27        I    9044.80   1170.64
      231       All Store_27        J    7662.25    906.20
      232       All Store_28      All   98791.11  10183.62
      233       All Store_28        A   12117.17   1065.46
      234       All Store_28        B    5504.79    818.08
      235       All Store_28        C   10544.08    894.44
      236       All Store_28        D   12353.12   1078.88
      237       All Store_28        E   12594.46   1408.16
      238       All Store_28        F    8439.29    859.65
      239       All Store_28        G   10716.37   1104.03
      240       All Store_28        H    8238.22   1123.07
      241       All Store_28        I    5380.76    677.40
      242       All Store_28        J   12902.85   1154.45
      243       All Store_29      All  102894.71  10234.08
      244       All Store_29        A    6862.12    714.27
      245       All Store_29        B    7236.42    638.94
      246       All Store_29        C   15378.34   1626.00
      247       All Store_29        D   11252.41    960.52
      248       All Store_29        E   13055.59   1242.98
      249       All Store_29        F   10772.82   1022.36
      250       All Store_29        G   11873.64    973.33
      251       All Store_29        H    7517.61   1135.72
      252       All Store_29        I    8816.92   1032.30
      253       All Store_29        J   10128.84    887.66
      254       All  Store_3      All  102188.67  10494.81
      255       All  Store_3        A   15350.74   1277.87
      256       All  Store_3        B    8688.06    903.87
      257       All  Store_3        C    9735.61   1036.72
      258       All  Store_3        D    4872.06    616.04
      259       All  Store_3        E   12277.07   1172.32
      260       All  Store_3        F   12695.18   1614.90
      261       All  Store_3        G    9288.03    908.51
      262       All  Store_3        H   11438.89   1060.13
      263       All  Store_3        I   10381.28   1248.17
      264       All  Store_3        J    7461.75    656.28
      265       All Store_30      All  112563.72  10634.66
      266       All Store_30        A    8068.10    844.49
      267       All Store_30        B   15365.51   1195.81
      268       All Store_30        C   15459.28   1529.09
      269       All Store_30        D    5573.19    616.25
      270       All Store_30        E    7764.47    886.11
      271       All Store_30        F   10328.78   1075.03
      272       All Store_30        G   10972.61   1021.82
      273       All Store_30        H   14594.21   1135.78
      274       All Store_30        I   11735.83   1059.04
      275       All Store_30        J   12701.74   1271.24
      276       All Store_31      All  101949.00  10464.58
      277       All Store_31        A   10196.05    946.01
      278       All Store_31        B   11191.22   1265.94
      279       All Store_31        C   11125.52   1262.85
      280       All Store_31        D   10514.13   1105.45
      281       All Store_31        E    7270.48    838.22
      282       All Store_31        F   11911.16   1127.54
      283       All Store_31        G    8142.99    808.45
      284       All Store_31        H   11608.77   1244.00
      285       All Store_31        I   11449.47   1167.66
      286       All Store_31        J    8539.21    698.46
      287       All Store_32      All   96257.32  10180.60
      288       All Store_32        A    9877.39   1016.90
      289       All Store_32        B    7341.82    817.92
      290       All Store_32        C    9674.13    991.08
      291       All Store_32        D   12874.72   1275.00
      292       All Store_32        E   10695.80    898.87
      293       All Store_32        F    8283.63   1102.95
      294       All Store_32        G   10573.45    909.20
      295       All Store_32        H   11241.03   1247.45
      296       All Store_32        I    9809.45   1019.61
      297       All Store_32        J    5885.90    901.62
      298       All Store_33      All  105056.59  10124.03
      299       All Store_33        A    7849.54    707.79
      300       All Store_33        B    8063.09    874.13
      301       All Store_33        C   13709.32    997.43
      302       All Store_33        D   15288.30   1353.60
      303       All Store_33        E    9789.67    915.97
      304       All Store_33        F   11428.83   1005.69
      305       All Store_33        G    8200.19    821.90
      306       All Store_33        H    7475.82    881.49
      307       All Store_33        I    7907.05   1162.11
      308       All Store_33        J   15344.78   1403.92
      309       All Store_34      All   98126.96   9468.93
      310       All Store_34        A    8308.52   1068.39
      311       All Store_34        B   10481.34    999.81
      312       All Store_34        C   14010.73   1236.43
      313       All Store_34        D   10725.19   1097.89
      314       All Store_34        E    9183.33    921.47
      315       All Store_34        F   10631.64   1163.75
      316       All Store_34        G   12153.79   1366.66
      317       All Store_34        H    7565.44    515.39
      318       All Store_34        I    9603.32    730.10
      319       All Store_34        J    5463.66    369.04
      320       All Store_35      All  100848.12  10039.03
      321       All Store_35        A   12556.62   1037.17
      322       All Store_35        B    8168.81   1088.66
      323       All Store_35        C    9031.50   1025.66
      324       All Store_35        D   13742.90   1506.09
      325       All Store_35        E   10083.55    926.22
      326       All Store_35        F    7139.03    757.80
      327       All Store_35        G    8263.97    701.13
      328       All Store_35        H   10931.80   1087.94
      329       All Store_35        I   10571.05   1091.86
      330       All Store_35        J   10358.89    816.50
      331       All Store_36      All   89802.03   8956.78
      332       All Store_36        A    4797.34    691.92
      333       All Store_36        B    5088.92    563.57
      334       All Store_36        C    9319.94    858.35
      335       All Store_36        D   12461.20   1249.74
      336       All Store_36        E    5446.63    511.12
      337       All Store_36        F   12036.12   1194.39
      338       All Store_36        G    6810.46    449.10
      339       All Store_36        H   12535.97   1442.58
      340       All Store_36        I   11671.48   1149.23
      341       All Store_36        J    9633.97    846.78
      342       All Store_37      All   93035.91   9143.63
      343       All Store_37        A    9302.81    957.63
      344       All Store_37        B   10518.62   1027.91
      345       All Store_37        C   12712.82    921.21
      346       All Store_37        D    5399.17    850.52
      347       All Store_37        E    9411.10    943.01
      348       All Store_37        F   12287.27   1250.39
      349       All Store_37        G    8885.36    820.88
      350       All Store_37        H    9012.41    997.01
      351       All Store_37        I    5874.03    577.59
      352       All Store_37        J    9632.32    797.48
      353       All Store_38      All   92596.63   9255.09
      354       All Store_38        A    9177.07    881.84
      355       All Store_38        B    6771.93    664.39
      356       All Store_38        C    9410.55    833.02
      357       All Store_38        D   10836.31   1173.38
      358       All Store_38        E   10894.86   1230.31
      359       All Store_38        F    8543.89    793.65
      360       All Store_38        G    7541.30   1111.74
      361       All Store_38        H    6690.42    809.86
      362       All Store_38        I   15033.12   1050.13
      363       All Store_38        J    7697.18    706.77
      364       All Store_39      All  110790.80  10618.33
      365       All Store_39        A   11206.52   1153.85
      366       All Store_39        B   10823.16   1431.10
      367       All Store_39        C   10915.95    864.43
      368       All Store_39        D    9472.25    700.92
      369       All Store_39        E   14085.26   1153.11
      370       All Store_39        F    8073.26    825.40
      371       All Store_39        G   15074.51   1519.41
      372       All Store_39        H   10501.09   1107.00
      373       All Store_39        I    9811.45    925.32
      374       All Store_39        J   10827.35    937.79
      375       All  Store_4      All   87041.17   8770.97
      376       All  Store_4        A    6417.91    626.95
      377       All  Store_4        B    8665.95    999.28
      378       All  Store_4        C    6975.56    900.47
      379       All  Store_4        D    6082.47    678.62
      380       All  Store_4        E    9696.48    970.63
      381       All  Store_4        F   11167.63   1074.76
      382       All  Store_4        G   10048.54   1086.55
      383       All  Store_4        H   11096.68    962.62
      384       All  Store_4        I    7990.91    601.07
      385       All  Store_4        J    8899.04    870.02
      386       All Store_40      All  109530.66  10877.67
      387       All Store_40        A   16240.07   1239.23
      388       All Store_40        B   14514.86   1521.35
      389       All Store_40        C    7582.38    747.43
      390       All Store_40        D   13245.43   1152.55
      391       All Store_40        E    6032.13   1034.97
      392       All Store_40        F    5602.45    605.09
      393       All Store_40        G   10596.69    916.93
      394       All Store_40        H   14240.23   1511.54
      395       All Store_40        I   10834.60    931.31
      396       All Store_40        J   10641.82   1217.27
      397       All Store_41      All   95770.64   9988.75
      398       All Store_41        A    8832.73   1058.28
      399       All Store_41        B    9328.75   1139.07
      400       All Store_41        C    9490.84    875.01
      401       All Store_41        D    9671.16   1011.31
      402       All Store_41        E   10193.42    929.60
      403       All Store_41        F   11730.43   1049.97
      404       All Store_41        G   11252.56   1186.60
      405       All Store_41        H    8112.11    773.91
      406       All Store_41        I    8268.50    848.97
      407       All Store_41        J    8890.14   1116.03
      408       All Store_42      All  112468.57  11455.24
      409       All Store_42        A    7080.67    933.54
      410       All Store_42        B   11019.76    867.23
      411       All Store_42        C   12573.04   1440.95
      412       All Store_42        D    8698.07    852.73
      413       All Store_42        E   12313.33   1198.63
      414       All Store_42        F    9234.32   1148.46
      415       All Store_42        G   14007.65   1142.45
      416       All Store_42        H   14816.09   1460.58
      417       All Store_42        I   12518.66   1282.16
      418       All Store_42        J   10206.98   1128.51
      419       All Store_43      All  127560.20  11523.38
      420       All Store_43        A   13184.52    975.36
      421       All Store_43        B   11523.10   1288.92
      422       All Store_43        C   15516.47   1445.96
      423       All Store_43        D    9765.16   1088.91
      424       All Store_43        E   10032.18    951.51
      425       All Store_43        F   12272.95    944.82
      426       All Store_43        G   10202.99    783.46
      427       All Store_43        H   14268.95   1444.83
      428       All Store_43        I   14264.16   1241.23
      429       All Store_43        J   16529.72   1358.38
      430       All Store_44      All  114807.30  11035.10
      431       All Store_44        A   13822.11   1207.52
      432       All Store_44        B    8342.84    740.63
      433       All Store_44        C   10571.67   1048.14
      434       All Store_44        D    9336.56    925.81
      435       All Store_44        E    9794.00    811.45
      436       All Store_44        F   11491.95   1020.01
      437       All Store_44        G   14977.91   1440.00
      438       All Store_44        H   11890.43   1171.30
      439       All Store_44        I   12245.75   1309.18
      440       All Store_44        J   12334.08   1361.06
      441       All Store_45      All   94484.01   9142.04
      442       All Store_45        A    5290.28    585.28
      443       All Store_45        B    7621.90    670.66
      444       All Store_45        C   10966.27   1145.33
      445       All Store_45        D    9933.85   1085.57
      446       All Store_45        E   13160.22   1212.89
      447       All Store_45        F   16060.00   1722.51
      448       All Store_45        G    6589.23    561.15
      449       All Store_45        H    8024.71    818.89
      450       All Store_45        I    7668.20    581.46
      451       All Store_45        J    9169.35    758.30
      452       All Store_46      All   99144.99  10078.35
      453       All Store_46        A   10765.39   1034.70
      454       All Store_46        B   10945.97   1195.10
      455       All Store_46        C    9294.12    905.03
      456       All Store_46        D    9913.14    830.71
      457       All Store_46        E   11333.78   1098.85
      458       All Store_46        F   13872.86   1446.11
      459       All Store_46        G    8806.85   1091.98
      460       All Store_46        H    8023.55    732.19
      461       All Store_46        I    8028.63    864.22
      462       All Store_46        J    8160.70    879.46
      463       All Store_47      All   90961.76  10405.24
      464       All Store_47        A   10431.13   1245.65
      465       All Store_47        B    9563.37   1305.56
      466       All Store_47        C    9095.82    849.58
      467       All Store_47        D    9409.56    825.70
      468       All Store_47        E    6283.82    954.00
      469       All Store_47        F    8719.95    942.87
      470       All Store_47        G   12815.27   1303.82
      471       All Store_47        H    8212.42   1042.60
      472       All Store_47        I    9895.56   1088.10
      473       All Store_47        J    6534.86    847.36
      474       All Store_48      All   93404.35   8929.47
      475       All Store_48        A    9767.58    965.32
      476       All Store_48        B   11185.71   1061.27
      477       All Store_48        C    8665.31    870.39
      478       All Store_48        D    7742.21    602.39
      479       All Store_48        E    9526.45    893.65
      480       All Store_48        F    7749.43    871.23
      481       All Store_48        G   10820.96   1175.32
      482       All Store_48        H    9043.20    871.53
      483       All Store_48        I    7442.05    506.67
      484       All Store_48        J   11461.45   1111.70
      485       All Store_49      All  102321.89  10681.56
      486       All Store_49        A   13119.37   1475.86
      487       All Store_49        B   11188.73   1656.29
      488       All Store_49        C   10360.37   1129.45
      489       All Store_49        D    8477.04    789.00
      490       All Store_49        E    7961.11    927.03
      491       All Store_49        F    6937.05    674.94
      492       All Store_49        G   15012.44   1180.63
      493       All Store_49        H   10317.64    815.55
      494       All Store_49        I    9004.68    934.56
      495       All Store_49        J    9943.46   1098.25
      496       All  Store_5      All  109795.81  10129.71
      497       All  Store_5        A    9981.54    890.80
      498       All  Store_5        B    8620.73   1218.11
      499       All  Store_5        C    8834.82    755.45
      500       All  Store_5        D   16694.05   1284.82
      501       All  Store_5        E   12155.06   1341.08
      502       All  Store_5        F    6398.62    612.02
      503       All  Store_5        G   13841.99   1001.64
      504       All  Store_5        H   14234.30   1199.29
      505       All  Store_5        I    9636.20   1063.84
      506       All  Store_5        J    9398.50    762.66
      507       All Store_50      All   91157.81   8939.94
      508       All Store_50        A   12508.07   1237.61
      509       All Store_50        B    6183.96    775.26
      510       All Store_50        C   10882.90   1197.87
      511       All Store_50        D    8866.16    850.29
      512       All Store_50        E    8361.11    903.23
      513       All Store_50        F    8615.43    837.77
      514       All Store_50        G   13714.76   1068.25
      515       All Store_50        H    8115.30    803.93
      516       All Store_50        I    3378.21    306.32
      517       All Store_50        J   10531.91    959.41
      518       All  Store_6      All  106665.68   9980.95
      519       All  Store_6        A    8556.15    656.52
      520       All  Store_6        B   12585.68    964.51
      521       All  Store_6        C    7517.10    811.88
      522       All  Store_6        D   13497.78   1113.67
      523       All  Store_6        E   12314.87   1159.80
      524       All  Store_6        F    8334.84    900.62
      525       All  Store_6        G   13892.55   1507.92
      526       All  Store_6        H    9287.54    729.47
      527       All  Store_6        I    9002.94   1060.09
      528       All  Store_6        J   11676.23   1076.47
      529       All  Store_7      All   94574.42   9924.00
      530       All  Store_7        A    8420.80    924.68
      531       All  Store_7        B   10820.49   1066.13
      532       All  Store_7        C    9662.70   1027.79
      533       All  Store_7        D    8804.31   1050.41
      534       All  Store_7        E   10932.98   1093.62
      535       All  Store_7        F   10606.86    998.21
      536       All  Store_7        G   10162.11   1092.60
      537       All  Store_7        H    9499.07    865.58
      538       All  Store_7        I    7182.81    730.17
      539       All  Store_7        J    8482.29   1074.81
      540       All  Store_8      All  100386.23  10717.95
      541       All  Store_8        A    7515.90    698.16
      542       All  Store_8        B    7529.61    941.05
      543       All  Store_8        C    9593.30    783.00
      544       All  Store_8        D   11998.20   1434.04
      545       All  Store_8        E   11994.78   1031.04
      546       All  Store_8        F   11080.93   1219.59
      547       All  Store_8        G   11011.28   1040.27
      548       All  Store_8        H    9912.06   1112.31
      549       All  Store_8        I   13567.75   1692.93
      550       All  Store_8        J    6182.42    765.56
      551       All  Store_9      All   95909.85   9703.76
      552       All  Store_9        A   11575.01   1256.21
      553       All  Store_9        B    9866.93    980.32
      554       All  Store_9        C    6173.32    548.69
      555       All  Store_9        D   11222.78   1115.38
      556       All  Store_9        E   10328.55   1199.44
      557       All  Store_9        F    9044.57    883.57
      558       All  Store_9        G   11409.68   1081.20
      559       All  Store_9        H    7350.77    836.31
      560       All  Store_9        I   10271.45    868.71
      561       All  Store_9        J    8666.79    933.93
      562  Region_1      All      All  994863.18 100430.84
      563  Region_1      All        A  101208.71  10362.06
      564  Region_1      All        B   91087.69   9529.64
      565  Region_1      All        C  109134.10  11297.33
      566  Region_1      All        D   93909.11   9652.34
      567  Region_1      All        E  111504.06  10831.80
      568  Region_1      All        F   99778.70   9330.30
      569  Region_1      All        G  103239.94  10190.03
      570  Region_1      All        H   97507.44  10670.47
      571  Region_1      All        I  100620.46   9337.42
      572  Region_1      All        J   86872.97   9229.45
      573  Region_1  Store_1      All   16471.71   1788.90
      574  Region_1  Store_1        A    4436.84    312.89
      575  Region_1  Store_1        B     738.26     80.67
      576  Region_1  Store_1        C     621.44    181.42
      577  Region_1  Store_1        D    1106.61     77.55
      578  Region_1  Store_1        E    1811.71    249.61
      579  Region_1  Store_1        F     840.92     31.98
      580  Region_1  Store_1        G    2558.41    260.23
      581  Region_1  Store_1        H     948.59    290.47
      582  Region_1  Store_1        I    1299.94     97.52
      583  Region_1  Store_1        J    2108.99    206.56
      584  Region_1 Store_10      All   24460.17   2602.37
      585  Region_1 Store_10        A    2588.44    401.84
      586  Region_1 Store_10        B    2250.00    324.87
      587  Region_1 Store_10        C    5131.09    404.29
      588  Region_1 Store_10        D     182.62    116.11
      589  Region_1 Store_10        E    2551.14    237.12
      590  Region_1 Store_10        F    2104.68    204.86
      591  Region_1 Store_10        G    2808.11    241.59
      592  Region_1 Store_10        H    2793.10    210.11
      593  Region_1 Store_10        I    2104.89    188.42
      594  Region_1 Store_10        J    1946.10    273.16
      595  Region_1 Store_11      All   17145.76   1783.43
      596  Region_1 Store_11        A    1373.57    258.41
      597  Region_1 Store_11        B      43.76     35.82
      598  Region_1 Store_11        C     936.02    137.67
      599  Region_1 Store_11        D    2103.96    220.61
      600  Region_1 Store_11        E    1700.39    196.41
      601  Region_1 Store_11        F    2096.39    234.31
      602  Region_1 Store_11        G    3877.20    295.40
      603  Region_1 Store_11        H    1628.00     93.40
      604  Region_1 Store_11        I    2412.16    199.12
      605  Region_1 Store_11        J     974.31    112.28
      606  Region_1 Store_12      All   14373.55   1441.41
      607  Region_1 Store_12        A     848.38     74.89
      608  Region_1 Store_12        B    1590.61     28.80
      609  Region_1 Store_12        C    1065.18     86.24
      610  Region_1 Store_12        E    2609.55    307.86
      611  Region_1 Store_12        F     820.79    107.57
      612  Region_1 Store_12        G    2297.95    227.20
      613  Region_1 Store_12        H    1460.53     75.60
      614  Region_1 Store_12        I    1701.99    249.88
      615  Region_1 Store_12        J    1978.57    283.37
      616  Region_1 Store_13      All   22708.94   2328.06
      617  Region_1 Store_13        A    3648.88    380.22
      618  Region_1 Store_13        B    2779.47    247.03
      619  Region_1 Store_13        C    2587.52    280.14
      620  Region_1 Store_13        D    1507.03    101.38
      621  Region_1 Store_13        E    1752.58    243.96
      622  Region_1 Store_13        F    1432.52    150.65
      623  Region_1 Store_13        G    5840.18    578.30
      624  Region_1 Store_13        H    2196.65    228.83
      625  Region_1 Store_13        J     964.11    117.55
      626  Region_1 Store_14      All   16695.21   1589.06
      627  Region_1 Store_14        A     650.93     97.03
      628  Region_1 Store_14        B    4054.89    312.91
      629  Region_1 Store_14        C    1049.82    171.74
      630  Region_1 Store_14        D    2179.96    106.78
      631  Region_1 Store_14        E     277.28     30.91
      632  Region_1 Store_14        F    1999.54    156.16
      633  Region_1 Store_14        G    1505.84    131.85
      634  Region_1 Store_14        H     836.81    114.41
      635  Region_1 Store_14        I    1367.81    216.03
      636  Region_1 Store_14        J    2772.33    251.24
      637  Region_1 Store_15      All   25571.90   2049.30
      638  Region_1 Store_15        A    2803.09    210.48
      639  Region_1 Store_15        B     120.67     39.52
      640  Region_1 Store_15        C    3498.90    176.78
      641  Region_1 Store_15        D    1763.58    254.66
      642  Region_1 Store_15        E    1989.07    108.40
      643  Region_1 Store_15        F    2975.93    201.72
      644  Region_1 Store_15        G    2367.72     92.91
      645  Region_1 Store_15        H    4310.02    474.26
      646  Region_1 Store_15        I    3186.23    254.68
      647  Region_1 Store_15        J    2556.69    235.89
      648  Region_1 Store_16      All   22049.18   2334.04
      649  Region_1 Store_16        A    1118.80     97.98
      650  Region_1 Store_16        B    2718.33    257.93
      651  Region_1 Store_16        C    3056.71    340.85
      652  Region_1 Store_16        D    2146.88    266.52
      653  Region_1 Store_16        E    3278.44    343.00
      654  Region_1 Store_16        F    3399.12    384.34
      655  Region_1 Store_16        G    1774.81    125.67
      656  Region_1 Store_16        H    1612.77    176.74
      657  Region_1 Store_16        I    2192.90    225.27
      658  Region_1 Store_16        J     750.42    115.74
      659  Region_1 Store_17      All   19439.02   2084.60
      660  Region_1 Store_17        A     856.14    163.97
      661  Region_1 Store_17        B    2487.46    327.90
      662  Region_1 Store_17        C    1420.02    253.57
      663  Region_1 Store_17        D    3024.62    311.70
      664  Region_1 Store_17        E    2098.12    205.03
      665  Region_1 Store_17        F    1758.51    198.62
      666  Region_1 Store_17        G     801.16     21.49
      667  Region_1 Store_17        H    1655.88    201.78
      668  Region_1 Store_17        I    3128.73    212.47
      669  Region_1 Store_17        J    2208.38    188.07
      670  Region_1 Store_18      All   21998.46   2262.64
      671  Region_1 Store_18        A    2423.85    324.31
      672  Region_1 Store_18        B    2298.90    326.16
      673  Region_1 Store_18        C    4208.74    377.65
      674  Region_1 Store_18        D    1551.75    166.10
      675  Region_1 Store_18        E    2540.81    212.47
      676  Region_1 Store_18        F    2479.26    124.13
      677  Region_1 Store_18        G     649.88    189.88
      678  Region_1 Store_18        H    1896.41    191.46
      679  Region_1 Store_18        I     739.25     57.86
      680  Region_1 Store_18        J    3209.61    292.62
      681  Region_1 Store_19      All   19369.46   2069.86
      682  Region_1 Store_19        A    3022.42     81.28
      683  Region_1 Store_19        B    2804.99    156.01
      684  Region_1 Store_19        C     655.29    120.23
      685  Region_1 Store_19        D    2082.68    181.26
      686  Region_1 Store_19        E    1791.99    220.51
      687  Region_1 Store_19        F    1650.50    126.84
      688  Region_1 Store_19        G    1395.58    283.75
      689  Region_1 Store_19        H    2229.61    381.51
      690  Region_1 Store_19        I    1307.78    128.03
      691  Region_1 Store_19        J    2428.62    390.44
      692  Region_1  Store_2      All   16375.35   1663.60
      693  Region_1  Store_2        A     426.59     67.39
      694  Region_1  Store_2        B    2652.46    161.28
      695  Region_1  Store_2        C    1805.02    214.79
      696  Region_1  Store_2        D    3198.07    214.80
      697  Region_1  Store_2        E    2799.48    197.10
      698  Region_1  Store_2        F    3077.03    347.81
      699  Region_1  Store_2        G     663.44    134.69
      700  Region_1  Store_2        H     208.47    124.25
      701  Region_1  Store_2        I    1254.63    130.92
      702  Region_1  Store_2        J     290.16     70.57
      703  Region_1 Store_20      All   20213.15   1838.45
      704  Region_1 Store_20        A    2682.60    249.59
      705  Region_1 Store_20        B    2440.99    141.38
      706  Region_1 Store_20        C    1800.21    155.62
      707  Region_1 Store_20        D    2399.14    260.55
      708  Region_1 Store_20        E    1306.69    216.37
      709  Region_1 Store_20        F    1259.06    150.83
      710  Region_1 Store_20        G    2470.00    197.30
      711  Region_1 Store_20        H     504.13     54.57
      712  Region_1 Store_20        I    2349.09    178.24
      713  Region_1 Store_20        J    3001.24    234.00
      714  Region_1 Store_21      All   19101.95   2189.04
      715  Region_1 Store_21        A     797.62    105.86
      716  Region_1 Store_21        B    1119.50     87.59
      717  Region_1 Store_21        C    2242.25    330.27
      718  Region_1 Store_21        D    2709.16    391.88
      719  Region_1 Store_21        E    3762.47    360.34
      720  Region_1 Store_21        F    2158.87    259.88
      721  Region_1 Store_21        G     647.47    131.79
      722  Region_1 Store_21        H    1032.60    170.17
      723  Region_1 Store_21        I    3577.34    267.11
      724  Region_1 Store_21        J    1054.67     84.15
      725  Region_1 Store_22      All   11811.25   1216.59
      726  Region_1 Store_22        A    2227.38    109.04
      727  Region_1 Store_22        B     388.20     35.11
      728  Region_1 Store_22        C     759.04    227.67
      729  Region_1 Store_22        D    1280.38    109.02
      730  Region_1 Store_22        E    1492.24    200.88
      731  Region_1 Store_22        F    1609.20    116.12
      732  Region_1 Store_22        H     467.31     57.94
      733  Region_1 Store_22        I    3002.92    232.38
      734  Region_1 Store_22        J     584.58    128.43
      735  Region_1 Store_23      All   16086.21   1846.32
      736  Region_1 Store_23        A    1971.32    235.24
      737  Region_1 Store_23        B     851.28    145.51
      738  Region_1 Store_23        C    1504.61    167.35
      739  Region_1 Store_23        D    1505.57    119.48
      740  Region_1 Store_23        E     169.90     87.25
      741  Region_1 Store_23        F    5060.49    357.93
      742  Region_1 Store_23        G     855.67    102.63
      743  Region_1 Store_23        H    2663.07    451.98
      744  Region_1 Store_23        J    1504.30    178.95
      745  Region_1 Store_24      All   22948.03   2273.19
      746  Region_1 Store_24        A    2089.75    288.44
      747  Region_1 Store_24        B    5505.98    513.83
      748  Region_1 Store_24        C    1722.15    131.07
      749  Region_1 Store_24        D     658.10    101.12
      750  Region_1 Store_24        E    2961.80    267.19
      751  Region_1 Store_24        F    1623.12    122.02
      752  Region_1 Store_24        G    2807.64    225.53
      753  Region_1 Store_24        H    2741.85    405.50
      754  Region_1 Store_24        I    2664.03    175.50
      755  Region_1 Store_24        J     173.61     42.99
      756  Region_1 Store_25      All   17593.06   2165.49
      757  Region_1 Store_25        A    3129.83    389.66
      758  Region_1 Store_25        B      96.46     56.54
      759  Region_1 Store_25        C    1299.96    166.53
      760  Region_1 Store_25        D    1119.02    159.81
      761  Region_1 Store_25        E    3912.25    340.34
      762  Region_1 Store_25        F    2005.93    168.60
      763  Region_1 Store_25        G    2027.92    273.72
      764  Region_1 Store_25        H     781.26    144.42
      765  Region_1 Store_25        I    2905.42    394.58
      766  Region_1 Store_25        J     315.01     71.29
      767  Region_1 Store_26      All   22775.88   1960.61
      768  Region_1 Store_26        A    3157.95    201.08
      769  Region_1 Store_26        B    3070.71    268.64
      770  Region_1 Store_26        C    1113.12    108.76
      771  Region_1 Store_26        D     969.90     89.50
      772  Region_1 Store_26        E    3667.87    477.11
      773  Region_1 Store_26        F    2589.99    171.32
      774  Region_1 Store_26        G    1542.68    133.13
      775  Region_1 Store_26        H    2016.57    187.81
      776  Region_1 Store_26        I    2373.86    206.15
      777  Region_1 Store_26        J    2273.23    117.11
      778  Region_1 Store_27      All   16783.46   1788.57
      779  Region_1 Store_27        A    2872.81    288.45
      780  Region_1 Store_27        B     942.39     25.14
      781  Region_1 Store_27        C    4371.54    458.31
      782  Region_1 Store_27        D      70.37     21.62
      783  Region_1 Store_27        E     994.16    120.25
      784  Region_1 Store_27        F    3445.92    338.71
      785  Region_1 Store_27        G    2415.61    272.15
      786  Region_1 Store_27        H     171.19     49.41
      787  Region_1 Store_27        I      29.47     43.08
      788  Region_1 Store_27        J    1470.00    171.45
      789  Region_1 Store_28      All   23542.49   2129.54
      790  Region_1 Store_28        A    1618.48    197.83
      791  Region_1 Store_28        B      66.85     54.91
      792  Region_1 Store_28        C    3160.12    212.55
      793  Region_1 Store_28        D    1789.69     72.16
      794  Region_1 Store_28        E    4592.39    447.49
      795  Region_1 Store_28        F     686.04     58.89
      796  Region_1 Store_28        G    2726.95    221.58
      797  Region_1 Store_28        H    1368.99    254.17
      798  Region_1 Store_28        I    3417.24    287.07
      799  Region_1 Store_28        J    4115.74    322.89
      800  Region_1 Store_29      All   17831.62   1870.71
      801  Region_1 Store_29        A    2669.50    169.94
      802  Region_1 Store_29        B     394.66     34.39
      803  Region_1 Store_29        C     737.79    168.47
      804  Region_1 Store_29        D    2985.79    261.65
      805  Region_1 Store_29        E    3175.27    339.61
      806  Region_1 Store_29        F    1585.17    196.20
      807  Region_1 Store_29        G    1422.65    169.30
      808  Region_1 Store_29        H    1919.46    235.29
      809  Region_1 Store_29        J    2941.33    295.86
      810  Region_1  Store_3      All   19252.98   2131.14
      811  Region_1  Store_3        A    1632.94    197.50
      812  Region_1  Store_3        B     835.65     73.99
      813  Region_1  Store_3        C    1973.76    179.41
      814  Region_1  Store_3        D     419.54     47.81
      815  Region_1  Store_3        E    2387.54    270.41
      816  Region_1  Store_3        F    1867.02    260.95
      817  Region_1  Store_3        G    2309.65    344.50
      818  Region_1  Store_3        H    4231.23    324.18
      819  Region_1  Store_3        I    1779.48    237.97
      820  Region_1  Store_3        J    1816.17    194.42
      821  Region_1 Store_30      All   19778.03   2005.46
      822  Region_1 Store_30        A    1975.25    157.03
      823  Region_1 Store_30        B    1860.73    250.97
      824  Region_1 Store_30        C    3777.78    290.56
      825  Region_1 Store_30        D    1200.15     67.30
      826  Region_1 Store_30        E    1830.30    145.77
      827  Region_1 Store_30        F    1960.18    220.29
      828  Region_1 Store_30        G     657.68    127.49
      829  Region_1 Store_30        H    2548.78    185.69
      830  Region_1 Store_30        I    1472.01    197.82
      831  Region_1 Store_30        J    2495.17    362.54
      832  Region_1 Store_31      All   21632.84   1998.07
      833  Region_1 Store_31        A    3059.29    262.02
      834  Region_1 Store_31        B    3043.66    280.19
      835  Region_1 Store_31        C     759.81    178.54
      836  Region_1 Store_31        D    1663.51    268.53
      837  Region_1 Store_31        E    3462.70    245.15
      838  Region_1 Store_31        F      95.05     62.44
      839  Region_1 Store_31        G    1249.22     93.13
      840  Region_1 Store_31        H    2656.37    183.90
      841  Region_1 Store_31        I    4906.58    378.91
      842  Region_1 Store_31        J     736.65     45.26
      843  Region_1 Store_32      All   20140.45   2365.58
      844  Region_1 Store_32        A    3308.40    381.76
      845  Region_1 Store_32        B     681.27     96.16
      846  Region_1 Store_32        C    1146.18    181.93
      847  Region_1 Store_32        D    4209.09    349.92
      848  Region_1 Store_32        E    1710.47     86.66
      849  Region_1 Store_32        F    1181.43    116.68
      850  Region_1 Store_32        G    1512.43    133.88
      851  Region_1 Store_32        H    3828.74    544.79
      852  Region_1 Store_32        I    1871.94    197.99
      853  Region_1 Store_32        J     690.50    275.81
      854  Region_1 Store_33      All   22959.03   2227.77
      855  Region_1 Store_33        A    2973.53    268.50
      856  Region_1 Store_33        B    2329.05    206.02
      857  Region_1 Store_33        C    4098.02    276.67
      858  Region_1 Store_33        D    1032.79    131.73
      859  Region_1 Store_33        E    1926.61    129.36
      860  Region_1 Store_33        F    1894.16     92.99
      861  Region_1 Store_33        G    3893.00    353.35
      862  Region_1 Store_33        H     918.46    129.92
      863  Region_1 Store_33        I    1444.33    343.56
      864  Region_1 Store_33        J    2449.08    295.67
      865  Region_1 Store_34      All   21443.80   2154.08
      866  Region_1 Store_34        A    3556.97    409.15
      867  Region_1 Store_34        B    1931.56    203.17
      868  Region_1 Store_34        C     612.14     66.19
      869  Region_1 Store_34        D    2956.15    284.42
      870  Region_1 Store_34        E    1465.69    186.98
      871  Region_1 Store_34        F    3114.00    386.31
      872  Region_1 Store_34        G    2725.56    271.56
      873  Region_1 Store_34        H     816.05     57.64
      874  Region_1 Store_34        I    2514.73    202.92
      875  Region_1 Store_34        J    1750.95     85.74
      876  Region_1 Store_35      All   17779.60   1922.91
      877  Region_1 Store_35        A    2192.50    248.62
      878  Region_1 Store_35        B    1422.29    252.77
      879  Region_1 Store_35        C    1624.55    251.84
      880  Region_1 Store_35        D    2378.02    348.42
      881  Region_1 Store_35        E    2444.75    139.11
      882  Region_1 Store_35        F    2048.42    139.49
      883  Region_1 Store_35        G    2025.33    147.96
      884  Region_1 Store_35        H    1395.00    178.97
      885  Region_1 Store_35        I    1447.63    104.45
      886  Region_1 Store_35        J     801.11    111.28
      887  Region_1 Store_36      All   21079.27   1916.71
      888  Region_1 Store_36        A    2138.10    323.56
      889  Region_1 Store_36        B    1661.28    152.40
      890  Region_1 Store_36        C    1724.72    129.63
      891  Region_1 Store_36        D    2219.57    149.67
      892  Region_1 Store_36        E    2166.27    241.05
      893  Region_1 Store_36        F    1008.34    128.08
      894  Region_1 Store_36        G    1078.54     75.92
      895  Region_1 Store_36        H    2971.71    280.15
      896  Region_1 Store_36        I    4594.70    303.15
      897  Region_1 Store_36        J    1516.04    133.10
      898  Region_1 Store_37      All   17838.35   2097.81
      899  Region_1 Store_37        A    4161.47    442.85
      900  Region_1 Store_37        B     598.97    184.70
      901  Region_1 Store_37        C    2321.30     68.03
      902  Region_1 Store_37        D     379.46    190.58
      903  Region_1 Store_37        E    3208.72    340.85
      904  Region_1 Store_37        F    3053.90    302.62
      905  Region_1 Store_37        G    2539.91    278.74
      906  Region_1 Store_37        H     172.09     62.75
      907  Region_1 Store_37        I     685.15     62.44
      908  Region_1 Store_37        J     717.38    164.25
      909  Region_1 Store_38      All   14678.55   1458.44
      910  Region_1 Store_38        A    1852.37    156.05
      911  Region_1 Store_38        B    1284.87     61.78
      912  Region_1 Store_38        C    2316.93    181.31
      913  Region_1 Store_38        D    2182.09    220.74
      914  Region_1 Store_38        E     727.59     88.63
      915  Region_1 Store_38        F     654.17     74.91
      916  Region_1 Store_38        G     884.57    136.65
      917  Region_1 Store_38        H     935.25    196.94
      918  Region_1 Store_38        I    1499.33    101.61
      919  Region_1 Store_38        J    2341.38    239.82
      920  Region_1 Store_39      All   19277.09   1916.09
      921  Region_1 Store_39        A    3699.07    347.85
      922  Region_1 Store_39        B    2189.84    225.20
      923  Region_1 Store_39        C     384.40     37.67
      924  Region_1 Store_39        D    1322.21     98.61
      925  Region_1 Store_39        E    2590.07    313.78
      926  Region_1 Store_39        F    1399.99    131.65
      927  Region_1 Store_39        G    3074.97    358.94
      928  Region_1 Store_39        H    2024.68    249.02
      929  Region_1 Store_39        I     257.86     33.95
      930  Region_1 Store_39        J    2334.00    119.42
      931  Region_1  Store_4      All   15228.48   1426.57
      932  Region_1  Store_4        A     845.09     43.81
      933  Region_1  Store_4        B     664.21    107.90
      934  Region_1  Store_4        C    1490.06    181.33
      935  Region_1  Store_4        D    1198.98     84.62
      936  Region_1  Store_4        E    3262.71    303.26
      937  Region_1  Store_4        F    3236.00    253.03
      938  Region_1  Store_4        G    1042.85    123.35
      939  Region_1  Store_4        H    1051.31     79.84
      940  Region_1  Store_4        I    1373.55    124.56
      941  Region_1  Store_4        J    1063.72    124.87
      942  Region_1 Store_40      All   24758.09   2302.20
      943  Region_1 Store_40        A    1184.11    205.19
      944  Region_1 Store_40        B    3657.48    319.32
      945  Region_1 Store_40        C    2714.36    224.80
      946  Region_1 Store_40        D    2891.53    266.95
      947  Region_1 Store_40        E    1175.73    171.31
      948  Region_1 Store_40        F    1431.22     72.57
      949  Region_1 Store_40        G    2744.90    195.63
      950  Region_1 Store_40        H    4653.45    436.18
      951  Region_1 Store_40        I    2222.24    198.84
      952  Region_1 Store_40        J    2083.07    211.41
      953  Region_1 Store_41      All   21447.51   2147.05
      954  Region_1 Store_41        A    1403.21    183.75
      955  Region_1 Store_41        B    1854.49    102.62
      956  Region_1 Store_41        C    1836.44    112.06
      957  Region_1 Store_41        D    3853.42    373.95
      958  Region_1 Store_41        E    1154.89    185.11
      959  Region_1 Store_41        F    5256.49    491.03
      960  Region_1 Store_41        G     950.60    105.47
      961  Region_1 Store_41        H    1928.50    230.44
      962  Region_1 Store_41        I     580.28    148.86
      963  Region_1 Store_41        J    2629.19    213.76
      964  Region_1 Store_42      All   23954.95   2516.12
      965  Region_1 Store_42        A    1307.34    238.81
      966  Region_1 Store_42        B    2864.08    230.63
      967  Region_1 Store_42        C    3869.02    494.45
      968  Region_1 Store_42        D    2491.61    275.04
      969  Region_1 Store_42        E    1298.68     83.71
      970  Region_1 Store_42        F     836.52    162.60
      971  Region_1 Store_42        G    4342.45    409.36
      972  Region_1 Store_42        H    3523.78    333.72
      973  Region_1 Store_42        I     942.48     56.45
      974  Region_1 Store_42        J    2478.99    231.35
      975  Region_1 Store_43      All   26798.00   2872.72
      976  Region_1 Store_43        A    1938.19    132.95
      977  Region_1 Store_43        B    2015.16    217.92
      978  Region_1 Store_43        C    5796.77    688.33
      979  Region_1 Store_43        D     943.70    137.97
      980  Region_1 Store_43        E    3496.00    248.48
      981  Region_1 Store_43        F    2746.74    265.87
      982  Region_1 Store_43        G     307.54     70.10
      983  Region_1 Store_43        H    2793.22    338.14
      984  Region_1 Store_43        I    3198.05    354.73
      985  Region_1 Store_43        J    3562.63    418.23
      986  Region_1 Store_44      All   24887.50   2242.19
      987  Region_1 Store_44        A    3795.46    347.19
      988  Region_1 Store_44        B    4667.35    289.80
      989  Region_1 Store_44        C    3153.34    301.45
      990  Region_1 Store_44        D    1547.92    159.38
      991  Region_1 Store_44        E     474.21     54.53
      992  Region_1 Store_44        F    2427.12    132.21
      993  Region_1 Store_44        G    2573.97    219.46
      994  Region_1 Store_44        H    3121.26    289.46
      995  Region_1 Store_44        I    2036.38    237.91
      996  Region_1 Store_44        J    1090.49    210.80
      997  Region_1 Store_45      All   22725.40   1974.21
      998  Region_1 Store_45        A     119.27     53.64
      999  Region_1 Store_45        B    2253.93    194.93
      1000 Region_1 Store_45        C    3439.32    404.65
      1001 Region_1 Store_45        D    1257.48    166.61
      1002 Region_1 Store_45        E    2342.85    161.27
      1003 Region_1 Store_45        F    4249.21    323.80
      1004 Region_1 Store_45        G    2251.99    176.14
      1005 Region_1 Store_45        H    2088.03    160.70
      1006 Region_1 Store_45        I    3259.40    138.18
      1007 Region_1 Store_45        J    1463.92    194.29
      1008 Region_1 Store_46      All   17529.19   1623.50
      1009 Region_1 Store_46        A    1252.01    105.99
      1010 Region_1 Store_46        B    1360.33    126.94
      1011 Region_1 Store_46        C    2613.19    274.97
      1012 Region_1 Store_46        D     225.39     46.87
      1013 Region_1 Store_46        E    5468.62    485.01
      1014 Region_1 Store_46        F     857.99     94.39
      1015 Region_1 Store_46        G    1169.74    120.60
      1016 Region_1 Store_46        H    1518.86    150.72
      1017 Region_1 Store_46        I    1706.08    130.69
      1018 Region_1 Store_46        J    1356.98     87.32
      1019 Region_1 Store_47      All   15700.86   1850.39
      1020 Region_1 Store_47        A     773.21    165.31
      1021 Region_1 Store_47        B    1020.54    293.09
      1022 Region_1 Store_47        C    2756.39    231.85
      1023 Region_1 Store_47        D     820.87     48.39
      1024 Region_1 Store_47        E    2119.75    198.31
      1025 Region_1 Store_47        F     272.73     65.42
      1026 Region_1 Store_47        G    2013.41    247.91
      1027 Region_1 Store_47        H    1685.99    141.62
      1028 Region_1 Store_47        I    2763.18    274.38
      1029 Region_1 Store_47        J    1474.79    184.11
      1030 Region_1 Store_48      All   15758.87   1752.94
      1031 Region_1 Store_48        B    2918.83    403.21
      1032 Region_1 Store_48        C    2433.59    324.09
      1033 Region_1 Store_48        D    1080.84    108.73
      1034 Region_1 Store_48        E    2090.51    266.11
      1035 Region_1 Store_48        F    1782.57    220.60
      1036 Region_1 Store_48        G    1661.50    141.34
      1037 Region_1 Store_48        H     123.40     38.99
      1038 Region_1 Store_48        I    1754.91     70.40
      1039 Region_1 Store_48        J    1912.72    179.47
      1040 Region_1 Store_49      All   19879.34   2030.56
      1041 Region_1 Store_49        A    2345.80    263.13
      1042 Region_1 Store_49        B    1331.82    201.88
      1043 Region_1 Store_49        C    1804.86    226.67
      1044 Region_1 Store_49        D    2879.70    315.49
      1045 Region_1 Store_49        E    1619.57     28.99
      1046 Region_1 Store_49        F     745.36     34.11
      1047 Region_1 Store_49        G    4291.93    417.25
      1048 Region_1 Store_49        H    2998.84    222.70
      1049 Region_1 Store_49        I    1813.68    221.10
      1050 Region_1 Store_49        J      47.78     99.24
      1051 Region_1  Store_5      All   24420.48   2353.31
      1052 Region_1  Store_5        A     612.55     72.02
      1053 Region_1  Store_5        B    3504.32    515.05
      1054 Region_1  Store_5        C    1429.81    139.33
      1055 Region_1  Store_5        D    5648.20    458.51
      1056 Region_1  Store_5        E    1375.57    109.94
      1057 Region_1  Store_5        F     644.46     93.89
      1058 Region_1  Store_5        G    1949.69    177.73
      1059 Region_1  Store_5        H    4862.80    338.71
      1060 Region_1  Store_5        I    2225.56    320.37
      1061 Region_1  Store_5        J    2167.52    127.76
      1062 Region_1 Store_50      All   21524.56   2098.06
      1063 Region_1 Store_50        A    1614.47    212.45
      1064 Region_1 Store_50        B    1661.08    162.44
      1065 Region_1 Store_50        C    2857.86    319.60
      1066 Region_1 Store_50        D    1681.12    193.04
      1067 Region_1 Store_50        E    2257.26    204.75
      1068 Region_1 Store_50        F    3288.10    334.09
      1069 Region_1 Store_50        G    2266.35    210.30
      1070 Region_1 Store_50        H    1409.54    200.28
      1071 Region_1 Store_50        I    1487.00     98.13
      1072 Region_1 Store_50        J    3001.78    162.98
      1073 Region_1  Store_6      All   17610.40   1744.50
      1074 Region_1  Store_6        A     175.87     -6.44
      1075 Region_1  Store_6        B     969.08    219.24
      1076 Region_1  Store_6        C    2103.70    264.39
      1077 Region_1  Store_6        D    2726.30    265.13
      1078 Region_1  Store_6        E    1684.58    119.71
      1079 Region_1  Store_6        F    2192.96    161.23
      1080 Region_1  Store_6        G    1640.32    196.51
      1081 Region_1  Store_6        H    2515.12    192.38
      1082 Region_1  Store_6        I    1131.85    218.74
      1083 Region_1  Store_6        J    2470.62    113.61
      1084 Region_1  Store_7      All   17994.48   1967.46
      1085 Region_1  Store_7        A    1764.27     84.46
      1086 Region_1  Store_7        B    1770.49    286.53
      1087 Region_1  Store_7        C    2118.69    198.66
      1088 Region_1  Store_7        D    1272.22    204.47
      1089 Region_1  Store_7        E    2030.76    222.65
      1090 Region_1  Store_7        F     965.97    156.20
      1091 Region_1  Store_7        G    1986.07    264.47
      1092 Region_1  Store_7        H    1688.07     76.82
      1093 Region_1  Store_7        I    2592.25    165.67
      1094 Region_1  Store_7        J    1805.69    307.53
      1095 Region_1  Store_8      All   21508.74   2017.19
      1096 Region_1  Store_8        A    2493.61    167.71
      1097 Region_1  Store_8        C    1739.72     95.04
      1098 Region_1  Store_8        D    3228.03    379.71
      1099 Region_1  Store_8        E    3134.01    247.91
      1100 Region_1  Store_8        F    2507.08    218.45
      1101 Region_1  Store_8        G    3104.81    216.64
      1102 Region_1  Store_8        H    1222.19    243.94
      1103 Region_1  Store_8        I    3301.50    342.45
      1104 Region_1  Store_8        J     777.79    105.34
      1105 Region_1  Store_9      All   21930.53   2042.03
      1106 Region_1  Store_9        A    1619.19    191.38
      1107 Region_1  Store_9        B    1318.51    208.85
      1108 Region_1  Store_9        C    1490.85    101.91
      1109 Region_1  Store_9        D    3864.34    405.49
      1110 Region_1  Store_9        E    1362.05    143.79
      1111 Region_1  Store_9        F    1402.54    124.91
      1112 Region_1  Store_9        G    3534.09    265.56
      1113 Region_1  Store_9        H    2381.45    227.80
      1114 Region_1  Store_9        I    4742.65    326.88
      1115 Region_1  Store_9        J     214.86     45.46
      1116 Region_2      All      All 1012103.39 102412.14
      1117 Region_2      All        A  101272.41  10289.96
      1118 Region_2      All        B   99036.50  10085.74
      1119 Region_2      All        C   94043.60   9120.01
      1120 Region_2      All        D  110634.02  10749.86
      1121 Region_2      All        E   90429.16   9178.16
      1122 Region_2      All        F   98045.88  10500.32
      1123 Region_2      All        G  118567.37  11329.62
      1124 Region_2      All        H  102169.13  10798.99
      1125 Region_2      All        I  105312.13  10437.36
      1126 Region_2      All        J   92593.19   9922.12
      1127 Region_2  Store_1      All   19929.55   2118.97
      1128 Region_2  Store_1        A    1609.70    247.43
      1129 Region_2  Store_1        B    2999.45    407.69
      1130 Region_2  Store_1        C    2940.68    198.30
      1131 Region_2  Store_1        D    1498.64    175.89
      1132 Region_2  Store_1        E    2666.10    126.91
      1133 Region_2  Store_1        F    1002.84     85.12
      1134 Region_2  Store_1        G    2002.67    244.24
      1135 Region_2  Store_1        H    2820.51    227.67
      1136 Region_2  Store_1        I    1355.76    244.21
      1137 Region_2  Store_1        J    1033.20    161.51
      1138 Region_2 Store_10      All   15909.05   1614.55
      1139 Region_2 Store_10        A     867.47    148.68
      1140 Region_2 Store_10        B    2039.46    202.00
      1141 Region_2 Store_10        C    1786.99    208.81
      1142 Region_2 Store_10        D    1274.40     65.87
      1143 Region_2 Store_10        E    1880.71    133.84
      1144 Region_2 Store_10        F    1724.93    214.69
      1145 Region_2 Store_10        G    1692.02    123.44
      1146 Region_2 Store_10        H    1648.91    223.79
      1147 Region_2 Store_10        I    1551.14    148.95
      1148 Region_2 Store_10        J    1443.02    144.48
      1149 Region_2 Store_11      All   20382.79   2083.00
      1150 Region_2 Store_11        A    1012.76    169.79
      1151 Region_2 Store_11        B    1161.48    129.47
      1152 Region_2 Store_11        C    4810.12    426.23
      1153 Region_2 Store_11        D    1145.76    106.37
      1154 Region_2 Store_11        E     638.98    132.69
      1155 Region_2 Store_11        F    5560.33    537.14
      1156 Region_2 Store_11        G    2897.89    260.49
      1157 Region_2 Store_11        H    1076.52    104.25
      1158 Region_2 Store_11        I     225.67     33.57
      1159 Region_2 Store_11        J    1853.28    183.00
      1160 Region_2 Store_12      All   21715.10   2296.40
      1161 Region_2 Store_12        A    1915.03    322.24
      1162 Region_2 Store_12        B    4203.12    410.46
      1163 Region_2 Store_12        C    3382.98    256.47
      1164 Region_2 Store_12        D    2435.69    242.70
      1165 Region_2 Store_12        E    2323.08    217.37
      1166 Region_2 Store_12        F    1657.53    167.49
      1167 Region_2 Store_12        G     509.12     58.10
      1168 Region_2 Store_12        H    2392.01    308.75
      1169 Region_2 Store_12        I    1097.91     74.97
      1170 Region_2 Store_12        J    1798.63    237.85
      1171 Region_2 Store_13      All   25926.67   2493.92
      1172 Region_2 Store_13        A    2126.17    211.71
      1173 Region_2 Store_13        B    2232.60    104.28
      1174 Region_2 Store_13        C    2376.80    262.77
      1175 Region_2 Store_13        D    4004.23    335.16
      1176 Region_2 Store_13        E    1413.84    179.07
      1177 Region_2 Store_13        F    1673.78    179.19
      1178 Region_2 Store_13        G    2716.52    261.96
      1179 Region_2 Store_13        H    3069.51    387.49
      1180 Region_2 Store_13        I    4822.85    399.84
      1181 Region_2 Store_13        J    1490.37    172.45
      1182 Region_2 Store_14      All   24779.73   2559.72
      1183 Region_2 Store_14        A    1235.98    245.56
      1184 Region_2 Store_14        B    2314.36    226.84
      1185 Region_2 Store_14        D    5607.76    521.02
      1186 Region_2 Store_14        E    3023.12    226.84
      1187 Region_2 Store_14        F    2174.21    123.02
      1188 Region_2 Store_14        G    3888.56    538.41
      1189 Region_2 Store_14        H    2380.50    237.60
      1190 Region_2 Store_14        I    2436.57    248.61
      1191 Region_2 Store_14        J    1718.67    191.82
      1192 Region_2 Store_15      All   23995.89   2204.15
      1193 Region_2 Store_15        A    1121.01     97.80
      1194 Region_2 Store_15        B    2152.58    114.17
      1195 Region_2 Store_15        C    3187.79    261.24
      1196 Region_2 Store_15        D    3340.03    382.28
      1197 Region_2 Store_15        E    2458.81    132.67
      1198 Region_2 Store_15        F    2482.40    113.49
      1199 Region_2 Store_15        G    1347.98    219.58
      1200 Region_2 Store_15        H    2890.46    243.73
      1201 Region_2 Store_15        I    1900.40    194.98
      1202 Region_2 Store_15        J    3114.43    444.21
      1203 Region_2 Store_16      All   16054.11   1862.15
      1204 Region_2 Store_16        A    2982.19    377.02
      1205 Region_2 Store_16        B    1973.06    171.11
      1206 Region_2 Store_16        C     525.46    119.05
      1207 Region_2 Store_16        D     938.18    115.26
      1208 Region_2 Store_16        E    1720.57    268.19
      1209 Region_2 Store_16        F    3017.39    202.11
      1210 Region_2 Store_16        G     345.82     78.23
      1211 Region_2 Store_16        H    1625.91    263.43
      1212 Region_2 Store_16        I    1832.34    119.67
      1213 Region_2 Store_16        J    1093.19    148.08
      1214 Region_2 Store_17      All   18287.28   1735.53
      1215 Region_2 Store_17        A    2898.33    213.51
      1216 Region_2 Store_17        B    2236.91    308.23
      1217 Region_2 Store_17        C     788.63     54.24
      1218 Region_2 Store_17        D    4241.67    306.23
      1219 Region_2 Store_17        E    1936.51    152.76
      1220 Region_2 Store_17        F     144.96     14.64
      1221 Region_2 Store_17        G     766.87    133.53
      1222 Region_2 Store_17        H    1715.37    141.85
      1223 Region_2 Store_17        I    1348.15    199.54
      1224 Region_2 Store_17        J    2209.88    211.00
      1225 Region_2 Store_18      All   19386.40   2038.59
      1226 Region_2 Store_18        A    1817.42    157.16
      1227 Region_2 Store_18        B    1967.67    133.61
      1228 Region_2 Store_18        C     485.27     52.47
      1229 Region_2 Store_18        D     862.91    160.46
      1230 Region_2 Store_18        E    1722.34    144.03
      1231 Region_2 Store_18        F    2030.85    187.54
      1232 Region_2 Store_18        G    2420.15    254.14
      1233 Region_2 Store_18        H    3302.29    412.65
      1234 Region_2 Store_18        I    3069.76    275.41
      1235 Region_2 Store_18        J    1707.74    261.12
      1236 Region_2 Store_19      All   13375.53   1411.75
      1237 Region_2 Store_19        A     871.90     61.78
      1238 Region_2 Store_19        B     655.72    145.53
      1239 Region_2 Store_19        C    2020.93    306.58
      1240 Region_2 Store_19        E    3986.54    264.02
      1241 Region_2 Store_19        F    2019.51    150.28
      1242 Region_2 Store_19        G     559.02     41.78
      1243 Region_2 Store_19        H    2692.01    292.45
      1244 Region_2 Store_19        I     440.00     75.71
      1245 Region_2 Store_19        J     129.90     73.62
      1246 Region_2  Store_2      All   18227.22   1851.36
      1247 Region_2  Store_2        A     933.22    163.55
      1248 Region_2  Store_2        B    2400.13    407.51
      1249 Region_2  Store_2        C    2054.83    149.25
      1250 Region_2  Store_2        D    3727.45    251.32
      1251 Region_2  Store_2        E    1794.71    227.76
      1252 Region_2  Store_2        F     712.54     95.21
      1253 Region_2  Store_2        G    1028.35     71.80
      1254 Region_2  Store_2        H    1486.83    188.59
      1255 Region_2  Store_2        I    2076.49    191.67
      1256 Region_2  Store_2        J    2012.67    104.70
      1257 Region_2 Store_20      All   24940.42   2289.91
      1258 Region_2 Store_20        A    4785.76    410.13
      1259 Region_2 Store_20        B    1877.60    114.66
      1260 Region_2 Store_20        C    2857.89    168.82
      1261 Region_2 Store_20        D     986.91    110.49
      1262 Region_2 Store_20        E     704.17    140.72
      1263 Region_2 Store_20        F     777.79    151.25
      1264 Region_2 Store_20        G    4239.49    252.52
      1265 Region_2 Store_20        H     677.69    121.61
      1266 Region_2 Store_20        I    4901.93    432.41
      1267 Region_2 Store_20        J    3131.19    387.30
      1268 Region_2 Store_21      All   23207.23   2309.17
      1269 Region_2 Store_21        A    4546.19    488.30
      1270 Region_2 Store_21        B    2720.44    193.04
      1271 Region_2 Store_21        C    2273.17    192.00
      1272 Region_2 Store_21        D     365.47     41.96
      1273 Region_2 Store_21        E    1619.07    123.49
      1274 Region_2 Store_21        F    3787.49    444.71
      1275 Region_2 Store_21        G    2559.32    189.29
      1276 Region_2 Store_21        H    1352.84    319.07
      1277 Region_2 Store_21        I    3067.05    305.64
      1278 Region_2 Store_21        J     916.19     11.67
      1279 Region_2 Store_22      All   16022.42   1741.13
      1280 Region_2 Store_22        A    1431.43    178.06
      1281 Region_2 Store_22        B     598.53     51.74
      1282 Region_2 Store_22        C    1437.78     99.47
      1283 Region_2 Store_22        D    1337.61    189.00
      1284 Region_2 Store_22        E    1501.85    255.62
      1285 Region_2 Store_22        F    1221.09    185.89
      1286 Region_2 Store_22        G    2854.32    320.06
      1287 Region_2 Store_22        H     856.60    102.45
      1288 Region_2 Store_22        I    3378.71    290.66
      1289 Region_2 Store_22        J    1404.50     68.18
      1290 Region_2 Store_23      All   11662.95   1941.90
      1291 Region_2 Store_23        A    1367.96    228.67
      1292 Region_2 Store_23        B     351.27    176.11
      1293 Region_2 Store_23        C     959.31    207.21
      1294 Region_2 Store_23        D    1969.04    366.10
      1295 Region_2 Store_23        E    1015.02    148.71
      1296 Region_2 Store_23        F    2067.29    248.12
      1297 Region_2 Store_23        G     597.96     36.89
      1298 Region_2 Store_23        H    1733.44     77.54
      1299 Region_2 Store_23        I     300.00    149.00
      1300 Region_2 Store_23        J    1301.66    303.55
      1301 Region_2 Store_24      All   23733.43   1963.04
      1302 Region_2 Store_24        A    2847.06    214.88
      1303 Region_2 Store_24        B    4460.66    403.60
      1304 Region_2 Store_24        D    2060.38    129.54
      1305 Region_2 Store_24        E    3543.24    340.72
      1306 Region_2 Store_24        F    1177.04    123.89
      1307 Region_2 Store_24        G    2596.85    164.68
      1308 Region_2 Store_24        H    2427.73    255.46
      1309 Region_2 Store_24        I    4111.35    272.75
      1310 Region_2 Store_24        J     509.12     57.52
      1311 Region_2 Store_25      All   17501.46   2058.27
      1312 Region_2 Store_25        A      96.87     86.49
      1313 Region_2 Store_25        B    2200.73    244.22
      1314 Region_2 Store_25        C     971.55     82.39
      1315 Region_2 Store_25        D    1339.23    167.49
      1316 Region_2 Store_25        E    2685.00    223.90
      1317 Region_2 Store_25        F    3234.67    390.93
      1318 Region_2 Store_25        G    2235.29    288.81
      1319 Region_2 Store_25        H    3418.40    378.83
      1320 Region_2 Store_25        I     727.53     84.59
      1321 Region_2 Store_25        J     592.19    110.62
      1322 Region_2 Store_26      All   23712.90   2101.26
      1323 Region_2 Store_26        A    1941.53    153.37
      1324 Region_2 Store_26        B    3440.56    317.61
      1325 Region_2 Store_26        C    1650.74    170.84
      1326 Region_2 Store_26        D    3434.87    348.19
      1327 Region_2 Store_26        E     742.07    113.60
      1328 Region_2 Store_26        F    2367.98    304.36
      1329 Region_2 Store_26        G    3127.28    224.97
      1330 Region_2 Store_26        H    2420.99    128.23
      1331 Region_2 Store_26        I    4277.24    280.71
      1332 Region_2 Store_26        J     309.64     59.38
      1333 Region_2 Store_27      All   21472.86   2186.78
      1334 Region_2 Store_27        A     988.19     95.82
      1335 Region_2 Store_27        B     811.10     51.19
      1336 Region_2 Store_27        C     901.91    152.89
      1337 Region_2 Store_27        D     679.02    132.23
      1338 Region_2 Store_27        E    2713.52    308.33
      1339 Region_2 Store_27        F    2963.23    264.55
      1340 Region_2 Store_27        G    3840.65    316.55
      1341 Region_2 Store_27        H    1764.67    131.73
      1342 Region_2 Store_27        I    3244.49    443.60
      1343 Region_2 Store_27        J    3566.08    289.89
      1344 Region_2 Store_28      All   17614.86   1760.81
      1345 Region_2 Store_28        A    2871.30    231.24
      1346 Region_2 Store_28        B    1883.64    189.75
      1347 Region_2 Store_28        C    1370.12    133.63
      1348 Region_2 Store_28        D     308.05     86.74
      1349 Region_2 Store_28        E    3100.72    305.36
      1350 Region_2 Store_28        F    1694.10    165.45
      1351 Region_2 Store_28        G    2801.40    215.91
      1352 Region_2 Store_28        H     708.64     55.95
      1353 Region_2 Store_28        I     550.81    142.76
      1354 Region_2 Store_28        J    2326.08    234.02
      1355 Region_2 Store_29      All   17484.83   1855.84
      1356 Region_2 Store_29        A    1234.80    204.07
      1357 Region_2 Store_29        B     763.36     25.99
      1358 Region_2 Store_29        C    2999.79    384.17
      1359 Region_2 Store_29        D    2529.89    274.11
      1360 Region_2 Store_29        E    2170.88    161.37
      1361 Region_2 Store_29        F    1145.04    146.53
      1362 Region_2 Store_29        G    3057.97    254.77
      1363 Region_2 Store_29        H     687.23    118.10
      1364 Region_2 Store_29        I    1567.97    189.76
      1365 Region_2 Store_29        J    1327.90     96.97
      1366 Region_2  Store_3      All   19085.44   1579.21
      1367 Region_2  Store_3        A    4399.07    274.82
      1368 Region_2  Store_3        B    2416.41    178.11
      1369 Region_2  Store_3        C    1315.04    212.67
      1370 Region_2  Store_3        D    2527.32    228.39
      1371 Region_2  Store_3        E    2310.78    184.44
      1372 Region_2  Store_3        F     604.96     62.72
      1373 Region_2  Store_3        G    1988.67    136.00
      1374 Region_2  Store_3        H     434.66     37.34
      1375 Region_2  Store_3        I    3088.53    264.72
      1376 Region_2 Store_30      All   21085.00   2177.38
      1377 Region_2 Store_30        A    2600.41    404.10
      1378 Region_2 Store_30        B    1808.69    197.21
      1379 Region_2 Store_30        C    2608.80    221.51
      1380 Region_2 Store_30        D     747.13    140.26
      1381 Region_2 Store_30        E     310.44     34.94
      1382 Region_2 Store_30        F    1148.72    133.40
      1383 Region_2 Store_30        G    4319.57    344.40
      1384 Region_2 Store_30        H    4148.66    310.78
      1385 Region_2 Store_30        I    2504.96    207.52
      1386 Region_2 Store_30        J     887.62    183.26
      1387 Region_2 Store_31      All   24542.44   2324.30
      1388 Region_2 Store_31        A     572.66     71.45
      1389 Region_2 Store_31        B    2631.06    217.30
      1390 Region_2 Store_31        C    3803.33    348.72
      1391 Region_2 Store_31        D    5193.02    398.31
      1392 Region_2 Store_31        E     786.67    125.33
      1393 Region_2 Store_31        F    3672.48    346.65
      1394 Region_2 Store_31        G    1334.27    138.67
      1395 Region_2 Store_31        H    2451.35    291.49
      1396 Region_2 Store_31        I     871.79    128.84
      1397 Region_2 Store_31        J    3225.81    257.54
      1398 Region_2 Store_32      All   22671.58   2387.79
      1399 Region_2 Store_32        A    1245.92    106.73
      1400 Region_2 Store_32        B    1019.68    114.98
      1401 Region_2 Store_32        C    3117.32    300.17
      1402 Region_2 Store_32        D    2219.97    171.70
      1403 Region_2 Store_32        E    2627.64    161.30
      1404 Region_2 Store_32        F    2899.82    583.87
      1405 Region_2 Store_32        G    2819.54    295.21
      1406 Region_2 Store_32        H    1791.49    267.89
      1407 Region_2 Store_32        I    2273.77    134.37
      1408 Region_2 Store_32        J    2656.43    251.57
      1409 Region_2 Store_33      All   21337.16   1958.41
      1410 Region_2 Store_33        A     664.54    170.40
      1411 Region_2 Store_33        B     349.91     79.45
      1412 Region_2 Store_33        C    2480.66    146.50
      1413 Region_2 Store_33        D    3778.57    316.48
      1414 Region_2 Store_33        E    2885.57    239.05
      1415 Region_2 Store_33        F    2891.88    238.47
      1416 Region_2 Store_33        G    1503.42    175.12
      1417 Region_2 Store_33        H    2504.71    260.36
      1418 Region_2 Store_33        I    1721.37    205.59
      1419 Region_2 Store_33        J    2556.53    126.99
      1420 Region_2 Store_34      All   15494.88   1693.53
      1421 Region_2 Store_34        A     888.78    199.16
      1422 Region_2 Store_34        B    1743.73    223.91
      1423 Region_2 Store_34        C    2269.59    149.33
      1424 Region_2 Store_34        D    2733.58    285.48
      1425 Region_2 Store_34        E     892.95    149.26
      1426 Region_2 Store_34        F    1743.19    266.24
      1427 Region_2 Store_34        G     443.05     81.33
      1428 Region_2 Store_34        H    1673.59    143.52
      1429 Region_2 Store_34        I    1448.84     83.69
      1430 Region_2 Store_34        J    1657.58    111.61
      1431 Region_2 Store_35      All   21686.34   2066.68
      1432 Region_2 Store_35        A    4472.83    295.19
      1433 Region_2 Store_35        B     386.56    167.88
      1434 Region_2 Store_35        C    1183.93    103.31
      1435 Region_2 Store_35        D    5532.00    433.91
      1436 Region_2 Store_35        E     296.73     91.34
      1437 Region_2 Store_35        F    1536.63    214.68
      1438 Region_2 Store_35        G    3596.71    264.65
      1439 Region_2 Store_35        H    2207.46    306.20
      1440 Region_2 Store_35        I    1891.73    136.53
      1441 Region_2 Store_35        J     581.76     52.99
      1442 Region_2 Store_36      All   19780.57   2033.61
      1443 Region_2 Store_36        A     809.28    103.33
      1444 Region_2 Store_36        B     623.37     86.98
      1445 Region_2 Store_36        C    2370.71    215.10
      1446 Region_2 Store_36        D    1905.00    301.71
      1447 Region_2 Store_36        E    1295.04     80.52
      1448 Region_2 Store_36        F    2313.52    209.81
      1449 Region_2 Store_36        G    2221.97    210.51
      1450 Region_2 Store_36        H    3845.27    330.26
      1451 Region_2 Store_36        I    1114.10    241.36
      1452 Region_2 Store_36        J    3282.31    254.03
      1453 Region_2 Store_37      All   24298.75   2007.98
      1454 Region_2 Store_37        A    1386.56     61.21
      1455 Region_2 Store_37        B    4949.12    379.15
      1456 Region_2 Store_37        C    3620.35    166.14
      1457 Region_2 Store_37        D     763.19    191.24
      1458 Region_2 Store_37        E    1736.13    172.89
      1459 Region_2 Store_37        F    1887.71    323.12
      1460 Region_2 Store_37        G    2240.57    124.97
      1461 Region_2 Store_37        H     709.38     77.88
      1462 Region_2 Store_37        I    3714.26    288.35
      1463 Region_2 Store_37        J    3291.48    223.03
      1464 Region_2 Store_38      All   23005.56   2683.20
      1465 Region_2 Store_38        A    1649.94    146.62
      1466 Region_2 Store_38        B    2131.22    215.39
      1467 Region_2 Store_38        C    3754.83    402.38
      1468 Region_2 Store_38        D    2219.29    124.56
      1469 Region_2 Store_38        E    3110.21    517.96
      1470 Region_2 Store_38        F    1946.43    235.71
      1471 Region_2 Store_38        G    2734.82    429.28
      1472 Region_2 Store_38        H    3496.77    371.55
      1473 Region_2 Store_38        I    1759.35    165.58
      1474 Region_2 Store_38        J     202.70     74.17
      1475 Region_2 Store_39      All   23509.19   2372.05
      1476 Region_2 Store_39        A    3469.31    321.35
      1477 Region_2 Store_39        B    2245.83    198.25
      1478 Region_2 Store_39        C    2610.93    228.55
      1479 Region_2 Store_39        D    1588.36    126.45
      1480 Region_2 Store_39        E     428.36     50.64
      1481 Region_2 Store_39        F    1959.80    199.08
      1482 Region_2 Store_39        G    4199.91    520.22
      1483 Region_2 Store_39        H    1175.11    119.96
      1484 Region_2 Store_39        I    3953.27    423.01
      1485 Region_2 Store_39        J    1878.31    184.54
      1486 Region_2  Store_4      All   13314.58   1709.55
      1487 Region_2  Store_4        A    1466.78    153.64
      1488 Region_2  Store_4        B     938.68    164.19
      1489 Region_2  Store_4        C     836.52    258.32
      1490 Region_2  Store_4        D     947.99     91.67
      1491 Region_2  Store_4        E    1993.79    231.04
      1492 Region_2  Store_4        F    2166.07    252.60
      1493 Region_2  Store_4        G    1230.91    198.97
      1494 Region_2  Store_4        H     919.67    103.04
      1495 Region_2  Store_4        I     175.77     31.11
      1496 Region_2  Store_4        J    2638.40    224.97
      1497 Region_2 Store_40      All   21039.55   1877.40
      1498 Region_2 Store_40        A    2375.26    139.42
      1499 Region_2 Store_40        B    2460.29    239.70
      1500 Region_2 Store_40        C     449.65     74.58
      1501 Region_2 Store_40        D    2566.04    258.35
      1502 Region_2 Store_40        E    1081.29    115.03
      1503 Region_2 Store_40        F      85.15     48.35
      1504 Region_2 Store_40        G    2771.15    220.76
      1505 Region_2 Store_40        H    3785.88    339.19
      1506 Region_2 Store_40        I    2106.09    179.94
      1507 Region_2 Store_40        J    3358.75    262.08
      1508 Region_2 Store_41      All   22052.44   2433.62
      1509 Region_2 Store_41        A     856.71    150.92
      1510 Region_2 Store_41        B    1977.84    359.33
      1511 Region_2 Store_41        C    2153.47    161.34
      1512 Region_2 Store_41        D    1906.38    175.52
      1513 Region_2 Store_41        E    1256.61     53.95
      1514 Region_2 Store_41        F    3117.72    219.79
      1515 Region_2 Store_41        G    4104.98    400.84
      1516 Region_2 Store_41        H    2228.26    232.62
      1517 Region_2 Store_41        I    2075.66    265.35
      1518 Region_2 Store_41        J    2374.81    413.96
      1519 Region_2 Store_42      All   23696.60   2137.57
      1520 Region_2 Store_42        A    1358.70    111.23
      1521 Region_2 Store_42        B    2012.51     97.83
      1522 Region_2 Store_42        C    3707.65    342.89
      1523 Region_2 Store_42        D     450.67     34.24
      1524 Region_2 Store_42        E    2351.69    222.96
      1525 Region_2 Store_42        F    2076.03    235.59
      1526 Region_2 Store_42        G    4008.26    331.76
      1527 Region_2 Store_42        H    2342.67    247.12
      1528 Region_2 Store_42        I    4284.96    363.98
      1529 Region_2 Store_42        J    1103.46    149.97
      1530 Region_2 Store_43      All   23057.44   1957.19
      1531 Region_2 Store_43        A    3767.62    298.18
      1532 Region_2 Store_43        B    1828.76    190.71
      1533 Region_2 Store_43        C    1241.57    130.10
      1534 Region_2 Store_43        D    2166.49    291.57
      1535 Region_2 Store_43        E     882.74    102.88
      1536 Region_2 Store_43        F    1123.56     72.80
      1537 Region_2 Store_43        G    1722.33    102.26
      1538 Region_2 Store_43        H    3339.34    273.32
      1539 Region_2 Store_43        I    2748.31    218.04
      1540 Region_2 Store_43        J    4236.72    277.33
      1541 Region_2 Store_44      All   20683.31   1946.66
      1542 Region_2 Store_44        A    2383.83     89.11
      1543 Region_2 Store_44        B     982.06     96.57
      1544 Region_2 Store_44        C    2652.41    295.71
      1545 Region_2 Store_44        D    3903.23    267.13
      1546 Region_2 Store_44        E     172.48     42.80
      1547 Region_2 Store_44        F    2222.75    227.18
      1548 Region_2 Store_44        G    4075.20    429.37
      1549 Region_2 Store_44        H     949.08     78.38
      1550 Region_2 Store_44        I     808.75     98.01
      1551 Region_2 Store_44        J    2533.52    322.40
      1552 Region_2 Store_45      All   13468.45   1634.47
      1553 Region_2 Store_45        A     467.99     30.74
      1554 Region_2 Store_45        B    2277.74    273.42
      1555 Region_2 Store_45        C     538.36     82.85
      1556 Region_2 Store_45        D    1947.60    221.53
      1557 Region_2 Store_45        E     703.50    219.54
      1558 Region_2 Store_45        F    2364.97    348.24
      1559 Region_2 Store_45        G     139.53     63.63
      1560 Region_2 Store_45        H    2071.19    180.91
      1561 Region_2 Store_45        J    2957.57    213.61
      1562 Region_2 Store_46      All   19763.86   2349.71
      1563 Region_2 Store_46        A    1780.61    203.12
      1564 Region_2 Store_46        B    2607.58    207.92
      1565 Region_2 Store_46        C    1722.67    168.21
      1566 Region_2 Store_46        D    4916.89    489.16
      1567 Region_2 Store_46        E    1426.77    144.78
      1568 Region_2 Store_46        F    1196.91    254.27
      1569 Region_2 Store_46        G    1000.21    147.73
      1570 Region_2 Store_46        H    1445.44    136.90
      1571 Region_2 Store_46        I    1690.30    261.99
      1572 Region_2 Store_46        J    1976.48    335.63
      1573 Region_2 Store_47      All   20017.18   2208.78
      1574 Region_2 Store_47        A    2105.77    375.45
      1575 Region_2 Store_47        B    1217.68    131.67
      1576 Region_2 Store_47        C    2507.91    149.34
      1577 Region_2 Store_47        D    2592.18    196.30
      1578 Region_2 Store_47        E    2164.29    267.70
      1579 Region_2 Store_47        F    3251.70    290.74
      1580 Region_2 Store_47        G    2089.88    239.66
      1581 Region_2 Store_47        H    1291.94    201.57
      1582 Region_2 Store_47        I    2151.99    261.70
      1583 Region_2 Store_47        J     643.84     94.65
      1584 Region_2 Store_48      All   20734.89   1707.21
      1585 Region_2 Store_48        A    2599.61     80.19
      1586 Region_2 Store_48        B    2847.72    194.97
      1587 Region_2 Store_48        C     213.11     38.66
      1588 Region_2 Store_48        D    3295.38    245.58
      1589 Region_2 Store_48        E    1569.88    149.91
      1590 Region_2 Store_48        F     741.77    114.69
      1591 Region_2 Store_48        G    4335.31    380.46
      1592 Region_2 Store_48        H    1286.77    151.79
      1593 Region_2 Store_48        I    1398.70    121.21
      1594 Region_2 Store_48        J    2446.64    229.75
      1595 Region_2 Store_49      All   20326.76   2046.31
      1596 Region_2 Store_49        A    2836.66    316.95
      1597 Region_2 Store_49        B    2691.81    248.97
      1598 Region_2 Store_49        C    2375.65    174.84
      1599 Region_2 Store_49        D     967.54     42.06
      1600 Region_2 Store_49        E    1431.47    225.11
      1601 Region_2 Store_49        F    1761.39    175.33
      1602 Region_2 Store_49        G    1181.75    151.86
      1603 Region_2 Store_49        H    1797.17    138.74
      1604 Region_2 Store_49        I    1926.07    175.62
      1605 Region_2 Store_49        J    3357.25    396.83
      1606 Region_2  Store_5      All   19933.70   2116.91
      1607 Region_2  Store_5        A    4245.08    266.92
      1608 Region_2  Store_5        B    1433.44    209.76
      1609 Region_2  Store_5        C     628.55     70.49
      1610 Region_2  Store_5        D    1665.57    199.57
      1611 Region_2  Store_5        E    1307.08    215.75
      1612 Region_2  Store_5        F    1933.01    215.19
      1613 Region_2  Store_5        G    2711.13    151.68
      1614 Region_2  Store_5        H    2109.65    299.11
      1615 Region_2  Store_5        I    1795.99    239.41
      1616 Region_2  Store_5        J    2104.20    249.03
      1617 Region_2 Store_50      All   19210.48   1729.15
      1618 Region_2 Store_50        A    2583.79    208.73
      1619 Region_2 Store_50        B     655.57     95.20
      1620 Region_2 Store_50        C    2185.32    331.81
      1621 Region_2 Store_50        D    1381.40    114.30
      1622 Region_2 Store_50        E    2291.98    207.66
      1623 Region_2 Store_50        F    1356.95     88.54
      1624 Region_2 Store_50        G    3840.48    171.90
      1625 Region_2 Store_50        H    3529.47    292.98
      1626 Region_2 Store_50        I     991.50     95.45
      1627 Region_2 Store_50        J     394.02    122.58
      1628 Region_2  Store_6      All   23203.18   2198.74
      1629 Region_2  Store_6        A    2772.52    334.39
      1630 Region_2  Store_6        B    3920.51    272.57
      1631 Region_2  Store_6        C    1727.34    182.27
      1632 Region_2  Store_6        D    1608.29    127.51
      1633 Region_2  Store_6        E    2548.65    169.28
      1634 Region_2  Store_6        F    1467.92    146.37
      1635 Region_2  Store_6        G    2699.54    318.06
      1636 Region_2  Store_6        H    2148.85    189.34
      1637 Region_2  Store_6        I    2657.75    231.11
      1638 Region_2  Store_6        J    1651.81    227.84
      1639 Region_2  Store_7      All   17928.64   2308.62
      1640 Region_2  Store_7        A    2373.44    333.62
      1641 Region_2  Store_7        B    1453.55    188.04
      1642 Region_2  Store_7        C     198.62     46.82
      1643 Region_2  Store_7        D    1995.08    268.11
      1644 Region_2  Store_7        E    1303.88    137.14
      1645 Region_2  Store_7        F    1528.64    114.35
      1646 Region_2  Store_7        G    2341.27    234.40
      1647 Region_2  Store_7        H    1004.82    250.23
      1648 Region_2  Store_7        I    2415.12    299.48
      1649 Region_2  Store_7        J    3314.22    436.43
      1650 Region_2  Store_8      All   22673.67   2345.06
      1651 Region_2  Store_8        A    1565.21    134.75
      1652 Region_2  Store_8        B    3088.09    409.10
      1653 Region_2  Store_8        C     678.55    134.69
      1654 Region_2  Store_8        D    2544.52    245.06
      1655 Region_2  Store_8        E    3364.25    234.09
      1656 Region_2  Store_8        F    2572.99    208.18
      1657 Region_2  Store_8        G    3161.02    358.90
      1658 Region_2  Store_8        H    2229.49    208.25
      1659 Region_2  Store_8        I    2533.98    295.73
      1660 Region_2  Store_8        J     935.57    116.31
      1661 Region_2  Store_9      All   19179.07   1942.85
      1662 Region_2  Store_9        A    2071.26    200.98
      1663 Region_2  Store_9        B     892.66    118.37
      1664 Region_2  Store_9        C    1308.02     95.88
      1665 Region_2  Store_9        D    2484.15    255.30
      1666 Region_2  Store_9        E    2537.44    302.90
      1667 Region_2  Store_9        F    1836.22    178.76
      1668 Region_2  Store_9        G    1666.42    156.87
      1669 Region_2  Store_9        H    2101.93    237.05
      1670 Region_2  Store_9        I    2925.10    220.66
      1671 Region_2  Store_9        J    1355.87    176.08
      1672 Region_3      All      All  956805.36  95256.27
      1673 Region_3      All        A   98977.41   9588.53
      1674 Region_3      All        B   93480.36  10087.27
      1675 Region_3      All        C   91403.20   8893.60
      1676 Region_3      All        D   93221.34   8850.16
      1677 Region_3      All        E  102567.81   9997.11
      1678 Region_3      All        F   97942.90   9984.15
      1679 Region_3      All        G   93989.76   9179.75
      1680 Region_3      All        H   98416.97   9416.81
      1681 Region_3      All        I   85245.72   9563.76
      1682 Region_3      All        J  101559.89   9695.13
      1683 Region_3  Store_1      All   19499.06   1788.21
      1684 Region_3  Store_1        A    1522.15    116.63
      1685 Region_3  Store_1        B     941.71     38.60
      1686 Region_3  Store_1        C    3901.46    254.00
      1687 Region_3  Store_1        D    3817.03    207.21
      1688 Region_3  Store_1        E     415.68     62.63
      1689 Region_3  Store_1        F    2247.18    326.41
      1690 Region_3  Store_1        G    1402.40    177.35
      1691 Region_3  Store_1        H    1150.93     61.63
      1692 Region_3  Store_1        I    1660.98    181.92
      1693 Region_3  Store_1        J    2439.54    361.83
      1694 Region_3 Store_10      All   20984.96   2027.90
      1695 Region_3 Store_10        A    2324.74    175.67
      1696 Region_3 Store_10        B    1789.21    153.23
      1697 Region_3 Store_10        C    2073.95    142.02
      1698 Region_3 Store_10        D    4031.96    402.35
      1699 Region_3 Store_10        E    2884.25    262.62
      1700 Region_3 Store_10        F    2142.31    162.38
      1701 Region_3 Store_10        G    1544.52    196.45
      1702 Region_3 Store_10        H    1848.06    194.74
      1703 Region_3 Store_10        I    1358.56    243.97
      1704 Region_3 Store_10        J     987.40     94.47
      1705 Region_3 Store_11      All   19731.80   2226.53
      1706 Region_3 Store_11        A    2436.40    233.73
      1707 Region_3 Store_11        B    1729.70    156.80
      1708 Region_3 Store_11        C    1746.14    240.06
      1709 Region_3 Store_11        D     926.57    131.89
      1710 Region_3 Store_11        E    2660.56    258.36
      1711 Region_3 Store_11        F      64.90     69.69
      1712 Region_3 Store_11        G    2626.37    309.46
      1713 Region_3 Store_11        H    4654.40    473.27
      1714 Region_3 Store_11        I    1200.20    121.96
      1715 Region_3 Store_11        J    1686.56    231.31
      1716 Region_3 Store_12      All   18702.90   1674.62
      1717 Region_3 Store_12        A    3747.68    349.49
      1718 Region_3 Store_12        C    1749.98    130.19
      1719 Region_3 Store_12        D     573.25    114.46
      1720 Region_3 Store_12        E    2229.68    170.86
      1721 Region_3 Store_12        F    2215.56    179.90
      1722 Region_3 Store_12        G     898.91     65.37
      1723 Region_3 Store_12        H    2183.36    244.04
      1724 Region_3 Store_12        I    2362.43    185.41
      1725 Region_3 Store_12        J    2742.05    234.90
      1726 Region_3 Store_13      All   22757.84   2718.54
      1727 Region_3 Store_13        A    1775.07     77.40
      1728 Region_3 Store_13        B    2700.46    337.61
      1729 Region_3 Store_13        C    1445.31    239.22
      1730 Region_3 Store_13        D    1252.72    178.60
      1731 Region_3 Store_13        E    3967.24    510.14
      1732 Region_3 Store_13        F    2343.45    280.56
      1733 Region_3 Store_13        G    2487.91    279.08
      1734 Region_3 Store_13        H    2745.12    240.94
      1735 Region_3 Store_13        I    3495.79    484.59
      1736 Region_3 Store_13        J     544.77     90.40
      1737 Region_3 Store_14      All   21850.50   2004.43
      1738 Region_3 Store_14        A    1598.32    248.30
      1739 Region_3 Store_14        B    2542.06    186.51
      1740 Region_3 Store_14        C    2476.92    216.11
      1741 Region_3 Store_14        D     359.66     19.07
      1742 Region_3 Store_14        E    2479.62    189.18
      1743 Region_3 Store_14        F    1615.29    164.10
      1744 Region_3 Store_14        G    2565.79    238.58
      1745 Region_3 Store_14        H    3591.66    196.00
      1746 Region_3 Store_14        I    1870.14    306.68
      1747 Region_3 Store_14        J    2751.04    239.90
      1748 Region_3 Store_15      All   13889.40   1503.67
      1749 Region_3 Store_15        A      50.57     31.69
      1750 Region_3 Store_15        B     462.55     59.42
      1751 Region_3 Store_15        C    1512.73    148.20
      1752 Region_3 Store_15        D     417.85    104.29
      1753 Region_3 Store_15        E    1027.13    142.01
      1754 Region_3 Store_15        F    1441.71    127.69
      1755 Region_3 Store_15        G    2777.51    299.58
      1756 Region_3 Store_15        H    1941.47    225.06
      1757 Region_3 Store_15        I    1400.62    194.05
      1758 Region_3 Store_15        J    2857.26    171.68
      1759 Region_3 Store_16      All   15805.88   1588.58
      1760 Region_3 Store_16        A    1599.32    117.96
      1761 Region_3 Store_16        B     739.00    123.77
      1762 Region_3 Store_16        C    1246.10    188.63
      1763 Region_3 Store_16        D     387.87     67.01
      1764 Region_3 Store_16        E     817.21     44.76
      1765 Region_3 Store_16        F    3764.62    387.92
      1766 Region_3 Store_16        G    3024.86    292.74
      1767 Region_3 Store_16        H    1064.89     88.51
      1768 Region_3 Store_16        I    1030.86    111.93
      1769 Region_3 Store_16        J    2131.15    165.35
      1770 Region_3 Store_17      All   21450.63   2245.19
      1771 Region_3 Store_17        A    1308.46    176.49
      1772 Region_3 Store_17        B    1351.93    180.67
      1773 Region_3 Store_17        C    2178.49    187.16
      1774 Region_3 Store_17        D    3267.09    246.05
      1775 Region_3 Store_17        E    2154.29    237.65
      1776 Region_3 Store_17        F    1943.43    210.15
      1777 Region_3 Store_17        G    4573.85    386.31
      1778 Region_3 Store_17        H    1131.32    119.32
      1779 Region_3 Store_17        I    2177.24    331.56
      1780 Region_3 Store_17        J    1364.53    169.83
      1781 Region_3 Store_18      All   13950.90   1091.49
      1782 Region_3 Store_18        A    1262.85     69.02
      1783 Region_3 Store_18        B     474.55     49.67
      1784 Region_3 Store_18        C    1896.31    203.85
      1785 Region_3 Store_18        D    3684.92    223.01
      1786 Region_3 Store_18        E    1086.51    117.01
      1787 Region_3 Store_18        F    1126.39    111.89
      1788 Region_3 Store_18        H     609.36     49.14
      1789 Region_3 Store_18        I     822.39     50.22
      1790 Region_3 Store_18        J    2987.62    217.68
      1791 Region_3 Store_19      All   18715.86   1906.84
      1792 Region_3 Store_19        A    2669.47    228.17
      1793 Region_3 Store_19        B     911.52     64.37
      1794 Region_3 Store_19        C    1946.71    186.37
      1795 Region_3 Store_19        D    2754.23    221.51
      1796 Region_3 Store_19        E    2712.81    378.09
      1797 Region_3 Store_19        F    1389.25    177.62
      1798 Region_3 Store_19        G    1275.22    160.67
      1799 Region_3 Store_19        H     227.15     48.98
      1800 Region_3 Store_19        I    3860.47    300.33
      1801 Region_3 Store_19        J     969.03    140.73
      1802 Region_3  Store_2      All   12593.75   1587.00
      1803 Region_3  Store_2        A    1688.46    283.38
      1804 Region_3  Store_2        B    3401.29    527.04
      1805 Region_3  Store_2        C    2047.20    231.95
      1806 Region_3  Store_2        E    1073.69     76.16
      1807 Region_3  Store_2        F    1304.43    191.58
      1808 Region_3  Store_2        G     852.21     80.97
      1809 Region_3  Store_2        H     838.66    113.88
      1810 Region_3  Store_2        J    1387.81     82.04
      1811 Region_3 Store_20      All   17180.06   2054.33
      1812 Region_3 Store_20        A    1632.00    223.77
      1813 Region_3 Store_20        B    1250.58     90.17
      1814 Region_3 Store_20        C     514.13    114.51
      1815 Region_3 Store_20        D    1774.79    252.79
      1816 Region_3 Store_20        E    3363.72    192.06
      1817 Region_3 Store_20        F    2929.50    355.74
      1818 Region_3 Store_20        G     924.04    157.19
      1819 Region_3 Store_20        H    1059.40    187.25
      1820 Region_3 Store_20        I    1257.16    241.03
      1821 Region_3 Store_20        J    2474.74    239.82
      1822 Region_3 Store_21      All   19687.80   1731.12
      1823 Region_3 Store_21        A    3052.72    216.37
      1824 Region_3 Store_21        B    2470.27    371.83
      1825 Region_3 Store_21        C    2707.62    154.95
      1826 Region_3 Store_21        D     962.09    129.86
      1827 Region_3 Store_21        E    1998.21     93.87
      1828 Region_3 Store_21        F    2316.56    255.79
      1829 Region_3 Store_21        G    1975.08    157.73
      1830 Region_3 Store_21        H    1745.47     83.12
      1831 Region_3 Store_21        I    1563.39    126.19
      1832 Region_3 Store_21        J     896.39    141.41
      1833 Region_3 Store_22      All   20118.27   1788.34
      1834 Region_3 Store_22        A    1294.08    267.71
      1835 Region_3 Store_22        B    1751.10    159.09
      1836 Region_3 Store_22        C    1913.92    132.75
      1837 Region_3 Store_22        D    1319.53    159.06
      1838 Region_3 Store_22        E    2630.30    185.03
      1839 Region_3 Store_22        F    3158.09    248.38
      1840 Region_3 Store_22        G    1687.68    187.56
      1841 Region_3 Store_22        H     882.60     98.38
      1842 Region_3 Store_22        I    3274.87    191.05
      1843 Region_3 Store_22        J    2206.10    159.33
      1844 Region_3 Store_23      All   20351.31   2285.13
      1845 Region_3 Store_23        A    1398.17    185.21
      1846 Region_3 Store_23        B    2296.43    246.87
      1847 Region_3 Store_23        C    1382.13    224.71
      1848 Region_3 Store_23        D    1699.24    167.15
      1849 Region_3 Store_23        E    2631.81    226.77
      1850 Region_3 Store_23        F    2094.66    367.45
      1851 Region_3 Store_23        G     536.47    101.95
      1852 Region_3 Store_23        H    2257.43    152.01
      1853 Region_3 Store_23        I    3073.92    401.38
      1854 Region_3 Store_23        J    2981.05    211.63
      1855 Region_3 Store_24      All   20074.20   2046.90
      1856 Region_3 Store_24        A    3217.83    354.11
      1857 Region_3 Store_24        B     550.46     62.09
      1858 Region_3 Store_24        C    2623.10    322.44
      1859 Region_3 Store_24        D    3791.83    302.68
      1860 Region_3 Store_24        E     889.40    140.59
      1861 Region_3 Store_24        F    2300.62    152.61
      1862 Region_3 Store_24        G    2389.96    256.18
      1863 Region_3 Store_24        H     826.08    108.60
      1864 Region_3 Store_24        I    3067.24    285.78
      1865 Region_3 Store_24        J     417.68     61.82
      1866 Region_3 Store_25      All   20500.60   2101.12
      1867 Region_3 Store_25        A    1264.65    201.09
      1868 Region_3 Store_25        B    3660.64    330.44
      1869 Region_3 Store_25        C    2787.24    219.12
      1870 Region_3 Store_25        D    1006.26    129.59
      1871 Region_3 Store_25        E     285.19    126.78
      1872 Region_3 Store_25        F    3177.13    313.04
      1873 Region_3 Store_25        G     518.11    129.77
      1874 Region_3 Store_25        H    1901.48    245.78
      1875 Region_3 Store_25        I    1416.47     82.76
      1876 Region_3 Store_25        J    4483.43    322.75
      1877 Region_3 Store_26      All   13394.93   1550.84
      1878 Region_3 Store_26        A      48.05     36.12
      1879 Region_3 Store_26        B    2573.82    238.55
      1880 Region_3 Store_26        C    1839.26    179.80
      1881 Region_3 Store_26        D    2269.71    209.77
      1882 Region_3 Store_26        E    1702.60    190.07
      1883 Region_3 Store_26        G     799.39    181.25
      1884 Region_3 Store_26        H    2288.10    250.10
      1885 Region_3 Store_26        I    1215.14    127.64
      1886 Region_3 Store_26        J     658.86    137.54
      1887 Region_3 Store_27      All   17727.66   1750.54
      1888 Region_3 Store_27        A    2064.35    133.97
      1889 Region_3 Store_27        B    1988.60    212.59
      1890 Region_3 Store_27        C    1497.92    134.68
      1891 Region_3 Store_27        D    3000.08    276.27
      1892 Region_3 Store_27        E    2851.59    391.49
      1893 Region_3 Store_27        F    1453.07    111.11
      1894 Region_3 Store_27        G    1696.25    156.71
      1895 Region_3 Store_27        H    1726.61     77.86
      1896 Region_3 Store_27        I    1021.39    155.09
      1897 Region_3 Store_27        J     427.80    100.77
      1898 Region_3 Store_28      All   11984.16   1437.85
      1899 Region_3 Store_28        B     946.88    103.70
      1900 Region_3 Store_28        C     598.44     28.37
      1901 Region_3 Store_28        D    2426.29    270.80
      1902 Region_3 Store_28        E    1028.60    185.19
      1903 Region_3 Store_28        F     729.46    129.43
      1904 Region_3 Store_28        G     505.65     44.38
      1905 Region_3 Store_28        H    2172.85    314.48
      1906 Region_3 Store_28        I     362.66    104.94
      1907 Region_3 Store_28        J    3213.33    256.56
      1908 Region_3 Store_29      All   23868.25   2200.30
      1909 Region_3 Store_29        A     685.06    100.27
      1910 Region_3 Store_29        B    1928.16    217.81
      1911 Region_3 Store_29        C    3076.29    262.63
      1912 Region_3 Store_29        D    4033.61    156.48
      1913 Region_3 Store_29        E    2796.50    203.06
      1914 Region_3 Store_29        F    4399.34    391.47
      1915 Region_3 Store_29        G    1199.41     87.98
      1916 Region_3 Store_29        H    2340.51    291.32
      1917 Region_3 Store_29        I    1981.23    287.92
      1918 Region_3 Store_29        J    1428.14    201.36
      1919 Region_3  Store_3      All   20854.22   2236.06
      1920 Region_3  Store_3        A    3909.78    384.79
      1921 Region_3  Store_3        B    2941.71    337.72
      1922 Region_3  Store_3        C    2024.46    260.44
      1923 Region_3  Store_3        D     687.61     63.69
      1924 Region_3  Store_3        E    1158.17    153.90
      1925 Region_3  Store_3        F    2014.45    302.35
      1926 Region_3  Store_3        G    2121.42    227.30
      1927 Region_3  Store_3        H    3880.87    291.08
      1928 Region_3  Store_3        I    1605.73    183.06
      1929 Region_3  Store_3        J     510.02     31.73
      1930 Region_3 Store_30      All   23695.93   1873.76
      1931 Region_3 Store_30        A    2668.99    162.77
      1932 Region_3 Store_30        B    3736.22    181.83
      1933 Region_3 Store_30        C    3089.28    283.68
      1934 Region_3 Store_30        D    1608.37    180.64
      1935 Region_3 Store_30        E    1770.61    112.11
      1936 Region_3 Store_30        F     877.20    106.49
      1937 Region_3 Store_30        G    1819.33    121.92
      1938 Region_3 Store_30        H    3299.67    220.86
      1939 Region_3 Store_30        I    1616.34    202.13
      1940 Region_3 Store_30        J    3209.92    301.33
      1941 Region_3 Store_31      All   15877.76   1868.81
      1942 Region_3 Store_31        A    2553.69    297.14
      1943 Region_3 Store_31        B    2815.55    321.41
      1944 Region_3 Store_31        C    1600.11    214.96
      1945 Region_3 Store_31        D    1904.67    160.98
      1946 Region_3 Store_31        E     870.73     67.17
      1947 Region_3 Store_31        F    1294.22    187.89
      1948 Region_3 Store_31        G     284.25     68.51
      1949 Region_3 Store_31        H    2239.16    238.41
      1950 Region_3 Store_31        I    1050.75    222.60
      1951 Region_3 Store_31        J    1264.63     89.74
      1952 Region_3 Store_32      All   20724.14   2151.44
      1953 Region_3 Store_32        A     912.71     37.45
      1954 Region_3 Store_32        B    2153.94    327.46
      1955 Region_3 Store_32        C    2210.00    277.12
      1956 Region_3 Store_32        D    2689.49    281.55
      1957 Region_3 Store_32        E    3007.52    258.13
      1958 Region_3 Store_32        F    1912.18    278.15
      1959 Region_3 Store_32        G    3828.40    251.12
      1960 Region_3 Store_32        H    1254.79    108.31
      1961 Region_3 Store_32        I    2755.11    332.15
      1962 Region_3 Store_33      All   22739.86   2295.14
      1963 Region_3 Store_33        A    1810.94     85.57
      1964 Region_3 Store_33        B    3091.45    350.07
      1965 Region_3 Store_33        C    1046.79     68.58
      1966 Region_3 Store_33        D    3792.46    268.14
      1967 Region_3 Store_33        E    1296.00    184.36
      1968 Region_3 Store_33        F    2712.19    267.78
      1969 Region_3 Store_33        G     334.48     56.09
      1970 Region_3 Store_33        H    1767.58    260.15
      1971 Region_3 Store_33        I     860.63    123.81
      1972 Region_3 Store_33        J    6027.34    630.59
      1973 Region_3 Store_34      All   19932.00   1733.03
      1974 Region_3 Store_34        A    1509.31    180.95
      1975 Region_3 Store_34        B    1436.79    102.98
      1976 Region_3 Store_34        C    3337.51    287.13
      1977 Region_3 Store_34        D    2045.58    242.71
      1978 Region_3 Store_34        E    3460.84    192.46
      1979 Region_3 Store_34        F    2518.75    237.94
      1980 Region_3 Store_34        G    1994.24    276.11
      1981 Region_3 Store_34        H    3128.51    185.33
      1982 Region_3 Store_34        I     500.47     27.42
      1983 Region_3 Store_35      All   18246.05   1887.09
      1984 Region_3 Store_35        A    2894.72    203.95
      1985 Region_3 Store_35        B    2049.90    269.69
      1986 Region_3 Store_35        C     270.25     14.63
      1987 Region_3 Store_35        D    1591.87    350.25
      1988 Region_3 Store_35        E    2865.08    227.13
      1989 Region_3 Store_35        F     976.01     44.43
      1990 Region_3 Store_35        G     310.80     38.96
      1991 Region_3 Store_35        H    2714.31    150.74
      1992 Region_3 Store_35        I    1485.82    276.24
      1993 Region_3 Store_35        J    3087.29    311.07
      1994 Region_3 Store_36      All   15254.76   1617.80
      1995 Region_3 Store_36        A     278.87     89.74
      1996 Region_3 Store_36        B     816.73     39.59
      1997 Region_3 Store_36        C     674.97    125.78
      1998 Region_3 Store_36        D    3306.54    316.27
      1999 Region_3 Store_36        E    1201.72     81.95
      2000 Region_3 Store_36        F    2536.53    241.72
      2001 Region_3 Store_36        G    1538.96     51.35
      2002 Region_3 Store_36        H    1685.14    285.02
      2003 Region_3 Store_36        I    1550.08    213.81
      2004 Region_3 Store_36        J    1665.22    172.57
      2005 Region_3 Store_37      All   21441.29   1929.15
      2006 Region_3 Store_37        A    1649.45    138.93
      2007 Region_3 Store_37        B    4384.27    367.41
      2008 Region_3 Store_37        C    2429.56    176.75
      2009 Region_3 Store_37        D    1021.56    142.39
      2010 Region_3 Store_37        E    3042.33    308.96
      2011 Region_3 Store_37        F    2148.17    172.31
      2012 Region_3 Store_37        G    1210.22    157.78
      2013 Region_3 Store_37        H    1674.65    226.22
      2014 Region_3 Store_37        J    3881.08    238.40
      2015 Region_3 Store_38      All   14560.54   1312.31
      2016 Region_3 Store_38        A    2769.57    211.14
      2017 Region_3 Store_38        B     456.22     28.83
      2018 Region_3 Store_38        C    1072.26    113.15
      2019 Region_3 Store_38        D    1174.90    202.61
      2020 Region_3 Store_38        E     884.54    129.66
      2021 Region_3 Store_38        F     840.52     74.80
      2022 Region_3 Store_38        G    1868.79    167.51
      2023 Region_3 Store_38        H     632.77     54.33
      2024 Region_3 Store_38        I    2726.07    208.96
      2025 Region_3 Store_38        J    2134.90    121.32
      2026 Region_3 Store_39      All   22350.60   2019.54
      2027 Region_3 Store_39        A     504.43     85.44
      2028 Region_3 Store_39        B    2732.83    409.32
      2029 Region_3 Store_39        C    1877.28    215.05
      2030 Region_3 Store_39        D    1695.91    130.28
      2031 Region_3 Store_39        E    5408.39    362.77
      2032 Region_3 Store_39        F    1429.51     81.75
      2033 Region_3 Store_39        G    1424.50    123.22
      2034 Region_3 Store_39        H    1476.96    108.19
      2035 Region_3 Store_39        I    2537.76    152.82
      2036 Region_3 Store_39        J    3263.03    350.70
      2037 Region_3  Store_4      All   25182.53   2207.09
      2038 Region_3  Store_4        A     121.77     61.11
      2039 Region_3  Store_4        B    4153.10    420.95
      2040 Region_3  Store_4        C    3264.61    316.52
      2041 Region_3  Store_4        D     773.79     79.27
      2042 Region_3  Store_4        E    2575.89    124.89
      2043 Region_3  Store_4        F    2103.37    235.10
      2044 Region_3  Store_4        G    4295.23    252.78
      2045 Region_3  Store_4        H    4232.61    394.77
      2046 Region_3  Store_4        I    2723.06    213.82
      2047 Region_3  Store_4        J     939.10    107.88
      2048 Region_3 Store_40      All   20050.76   1983.01
      2049 Region_3 Store_40        A    2812.75    212.47
      2050 Region_3 Store_40        B    2612.86    287.30
      2051 Region_3 Store_40        C    1401.42    139.39
      2052 Region_3 Store_40        D    3244.51    146.88
      2053 Region_3 Store_40        E     516.81    180.48
      2054 Region_3 Store_40        F    2262.04    240.91
      2055 Region_3 Store_40        G    1121.70    143.52
      2056 Region_3 Store_40        H    2065.60    173.35
      2057 Region_3 Store_40        I    1473.97     74.96
      2058 Region_3 Store_40        J    2539.10    383.75
      2059 Region_3 Store_41      All   20142.81   2099.26
      2060 Region_3 Store_41        A    1918.59    215.60
      2061 Region_3 Store_41        B    1691.28    305.81
      2062 Region_3 Store_41        C    2154.33    261.56
      2063 Region_3 Store_41        D    1059.50    180.35
      2064 Region_3 Store_41        E    2483.38    288.55
      2065 Region_3 Store_41        F    1415.51    143.45
      2066 Region_3 Store_41        G    1928.23    192.04
      2067 Region_3 Store_41        H    2573.87    194.88
      2068 Region_3 Store_41        I    3413.65    190.84
      2069 Region_3 Store_41        J    1504.47    126.18
      2070 Region_3 Store_42      All   22347.33   2456.70
      2071 Region_3 Store_42        A    1021.26    233.85
      2072 Region_3 Store_42        B    1529.50    212.65
      2073 Region_3 Store_42        C     770.32     82.38
      2074 Region_3 Store_42        D    1842.66    175.24
      2075 Region_3 Store_42        E    2107.37    272.55
      2076 Region_3 Store_42        F    3629.99    319.54
      2077 Region_3 Store_42        G    2508.52    187.31
      2078 Region_3 Store_42        H    3117.87    330.53
      2079 Region_3 Store_42        I    2795.88    271.94
      2080 Region_3 Store_42        J    3023.96    370.71
      2081 Region_3 Store_43      All   25185.39   2224.01
      2082 Region_3 Store_43        A    3193.65    253.85
      2083 Region_3 Store_43        B    2837.53    290.59
      2084 Region_3 Store_43        C    1855.68    139.48
      2085 Region_3 Store_43        D    2519.99    216.54
      2086 Region_3 Store_43        E    1525.29    228.53
      2087 Region_3 Store_43        F    2692.44    223.59
      2088 Region_3 Store_43        G    3200.21    209.00
      2089 Region_3 Store_43        H    2052.13    262.23
      2090 Region_3 Store_43        I    2620.94    262.01
      2091 Region_3 Store_43        J    2687.53    138.19
      2092 Region_3 Store_44      All   19839.15   1927.34
      2093 Region_3 Store_44        A    2450.42    170.10
      2094 Region_3 Store_44        B     695.09     70.79
      2095 Region_3 Store_44        C     793.22    125.18
      2096 Region_3 Store_44        D    1497.94    270.50
      2097 Region_3 Store_44        E    1504.60     73.75
      2098 Region_3 Store_44        F    1383.15    109.27
      2099 Region_3 Store_44        G    3280.74    220.43
      2100 Region_3 Store_44        H    2490.33    266.21
      2101 Region_3 Store_44        I    1884.58    237.22
      2102 Region_3 Store_44        J    3859.08    383.89
      2103 Region_3 Store_45      All   16410.67   1401.60
      2104 Region_3 Store_45        A    1198.94    129.84
      2105 Region_3 Store_45        B    1706.27     51.91
      2106 Region_3 Store_45        C     600.73     97.97
      2107 Region_3 Store_45        D     290.59    109.14
      2108 Region_3 Store_45        E    3577.66    178.84
      2109 Region_3 Store_45        F    5253.72    407.10
      2110 Region_3 Store_45        G    1806.70    151.19
      2111 Region_3 Store_45        H     377.73     67.03
      2112 Region_3 Store_45        I     391.71     92.74
      2113 Region_3 Store_45        J    1206.62    115.84
      2114 Region_3 Store_46      All   22560.55   1957.18
      2115 Region_3 Store_46        A    6357.79    433.14
      2116 Region_3 Store_46        B     958.86    136.31
      2117 Region_3 Store_46        C    1129.87    170.89
      2118 Region_3 Store_46        D    1361.21    115.90
      2119 Region_3 Store_46        E    1721.19    106.57
      2120 Region_3 Store_46        F    4871.08    369.66
      2121 Region_3 Store_46        G    2661.72    286.84
      2122 Region_3 Store_46        H     787.97     35.62
      2123 Region_3 Store_46        I    1352.22    171.56
      2124 Region_3 Store_46        J    1358.64    130.69
      2125 Region_3 Store_47      All   15196.64   1880.66
      2126 Region_3 Store_47        A    2463.61    293.75
      2127 Region_3 Store_47        B    1574.08    143.08
      2128 Region_3 Store_47        C    1170.50    169.52
      2129 Region_3 Store_47        D    1929.58    227.41
      2130 Region_3 Store_47        E    1141.26    248.48
      2131 Region_3 Store_47        F    2075.73    194.78
      2132 Region_3 Store_47        G    1880.32    260.92
      2133 Region_3 Store_47        H    1416.51    175.57
      2134 Region_3 Store_47        I     277.34     92.39
      2135 Region_3 Store_47        J    1267.71     74.76
      2136 Region_3 Store_48      All   17034.78   1716.47
      2137 Region_3 Store_48        A    2032.74    289.66
      2138 Region_3 Store_48        B    1325.82    165.84
      2139 Region_3 Store_48        C    2394.69    175.71
      2140 Region_3 Store_48        E    1613.91     83.91
      2141 Region_3 Store_48        F     112.11     72.26
      2142 Region_3 Store_48        G    1760.85    294.79
      2143 Region_3 Store_48        H    2828.59    187.32
      2144 Region_3 Store_48        I    1865.04    150.05
      2145 Region_3 Store_48        J    3101.03    296.93
      2146 Region_3 Store_49      All   24192.17   2824.99
      2147 Region_3 Store_49        A    4069.06    446.80
      2148 Region_3 Store_49        B    1817.69    355.56
      2149 Region_3 Store_49        C    4235.63    399.82
      2150 Region_3 Store_49        D    2242.93    238.78
      2151 Region_3 Store_49        E    1385.35    231.24
      2152 Region_3 Store_49        F    1192.33    194.57
      2153 Region_3 Store_49        G    2088.95    225.89
      2154 Region_3 Store_49        H    2769.15    227.09
      2155 Region_3 Store_49        I    2558.86    318.65
      2156 Region_3 Store_49        J    1832.22    186.59
      2157 Region_3  Store_5      All   22069.38   1939.55
      2158 Region_3  Store_5        A    1784.94    166.03
      2159 Region_3  Store_5        B     435.22     80.97
      2160 Region_3  Store_5        C    2491.65    132.63
      2161 Region_3  Store_5        D    2136.79    181.38
      2162 Region_3  Store_5        E    2280.78    208.56
      2163 Region_3  Store_5        F     987.27    108.42
      2164 Region_3  Store_5        G    3190.86    258.51
      2165 Region_3  Store_5        H    3315.52    302.82
      2166 Region_3  Store_5        I    2878.23    321.87
      2167 Region_3  Store_5        J    2568.12    178.36
      2168 Region_3 Store_50      All   16695.18   1671.83
      2169 Region_3 Store_50        A    3031.65    266.09
      2170 Region_3 Store_50        B    1485.92    201.38
      2171 Region_3 Store_50        C    2547.41    154.07
      2172 Region_3 Store_50        D    2307.21    153.79
      2173 Region_3 Store_50        E     992.89    128.12
      2174 Region_3 Store_50        F    1304.47    206.22
      2175 Region_3 Store_50        G    3373.11    333.44
      2176 Region_3 Store_50        H     702.32     53.85
      2177 Region_3 Store_50        I     191.55     75.64
      2178 Region_3 Store_50        J     758.65     99.23
      2179 Region_3  Store_6      All   19593.97   1728.10
      2180 Region_3  Store_6        A    3180.10    210.18
      2181 Region_3  Store_6        B    1632.23    107.75
      2182 Region_3  Store_6        C     197.92     42.79
      2183 Region_3  Store_6        D    1717.93     55.90
      2184 Region_3  Store_6        E    3482.23    363.93
      2185 Region_3  Store_6        F     312.23     92.39
      2186 Region_3  Store_6        G    2603.87    225.64
      2187 Region_3  Store_6        H    1255.72    118.24
      2188 Region_3  Store_6        I    1559.20    173.17
      2189 Region_3  Store_6        J    3652.54    338.11
      2190 Region_3  Store_7      All   15237.82   1392.77
      2191 Region_3  Store_7        A    1651.87    194.94
      2192 Region_3  Store_7        B     898.96    129.96
      2193 Region_3  Store_7        C    2111.01    158.57
      2194 Region_3  Store_7        D    1046.33     49.46
      2195 Region_3  Store_7        E    2671.11    280.27
      2196 Region_3  Store_7        F    2828.98    137.67
      2197 Region_3  Store_7        G     198.23     33.95
      2198 Region_3  Store_7        H    1657.16    219.92
      2199 Region_3  Store_7        I    1217.22     96.97
      2200 Region_3  Store_7        J     956.95     91.06
      2201 Region_3  Store_8      All   17686.98   1931.74
      2202 Region_3  Store_8        B    2632.81    299.23
      2203 Region_3  Store_8        C    1490.39    148.13
      2204 Region_3  Store_8        D    2542.76    253.05
      2205 Region_3  Store_8        E    2381.78    292.33
      2206 Region_3  Store_8        F    1489.54    159.45
      2207 Region_3  Store_8        G    1853.34    123.58
      2208 Region_3  Store_8        H    2359.03    243.95
      2209 Region_3  Store_8        I    1740.06    310.84
      2210 Region_3  Store_8        J    1197.27    101.18
      2211 Region_3  Store_9      All   16881.38   1680.37
      2212 Region_3  Store_9        A    3585.41    306.70
      2213 Region_3  Store_9        B    2416.61    180.05
      2214 Region_3  Store_9        D    1432.08     87.16
      2215 Region_3  Store_9        E    1953.79    243.13
      2216 Region_3  Store_9        F     612.26     59.25
      2217 Region_3  Store_9        G    3240.20    292.79
      2218 Region_3  Store_9        H    1473.54    170.38
      2219 Region_3  Store_9        I     140.30     49.69
      2220 Region_3  Store_9        J    2027.19    291.22
      2221 Region_4      All      All 1027429.98 100036.73
      2222 Region_4      All        A  103215.09  10631.18
      2223 Region_4      All        B   95845.80   9398.96
      2224 Region_4      All        C  111024.82  10232.55
      2225 Region_4      All        D  106955.68  10740.62
      2226 Region_4      All        E  104765.09  10338.72
      2227 Region_4      All        F  108003.22   9964.91
      2228 Region_4      All        G  104877.30  10129.64
      2229 Region_4      All        H   99946.87  10012.60
      2230 Region_4      All        I   94443.66   8998.97
      2231 Region_4      All        J   98352.45   9588.58
      2232 Region_4  Store_1      All   21368.75   2227.51
      2233 Region_4  Store_1        A     152.08     83.12
      2234 Region_4  Store_1        B    1343.94    130.99
      2235 Region_4  Store_1        C    3316.33    316.81
      2236 Region_4  Store_1        D    3809.52    401.42
      2237 Region_4  Store_1        E    3221.53    345.83
      2238 Region_4  Store_1        F    1994.92    232.07
      2239 Region_4  Store_1        H    2450.44    260.77
      2240 Region_4  Store_1        I    3152.29    319.27
      2241 Region_4  Store_1        J    1927.70    137.23
      2242 Region_4 Store_10      All   16007.14   1827.47
      2243 Region_4 Store_10        A    2070.17    282.39
      2244 Region_4 Store_10        B    3101.18    266.73
      2245 Region_4 Store_10        C     712.20    158.06
      2246 Region_4 Store_10        D      38.33     75.79
      2247 Region_4 Store_10        E    2576.56    188.97
      2248 Region_4 Store_10        F    2759.34    279.83
      2249 Region_4 Store_10        G     928.97    186.18
      2250 Region_4 Store_10        H     989.38    101.24
      2251 Region_4 Store_10        I     940.60    106.39
      2252 Region_4 Store_10        J    1890.41    181.89
      2253 Region_4 Store_11      All   16447.95   1668.04
      2254 Region_4 Store_11        A     391.26    113.22
      2255 Region_4 Store_11        B    3405.62    209.82
      2256 Region_4 Store_11        C    2359.26    194.64
      2257 Region_4 Store_11        D     347.78     41.79
      2258 Region_4 Store_11        E    1678.07    158.46
      2259 Region_4 Store_11        F     780.36     52.14
      2260 Region_4 Store_11        G    1298.20    189.62
      2261 Region_4 Store_11        H    1463.95    124.64
      2262 Region_4 Store_11        I    2117.98    311.64
      2263 Region_4 Store_11        J    2605.47    272.07
      2264 Region_4 Store_12      All   23770.15   2159.66
      2265 Region_4 Store_12        A    2936.29    311.06
      2266 Region_4 Store_12        B    2515.89    264.85
      2267 Region_4 Store_12        C    1263.52    125.36
      2268 Region_4 Store_12        D    3097.29    299.53
      2269 Region_4 Store_12        E    3784.97    315.33
      2270 Region_4 Store_12        F    2002.69    208.54
      2271 Region_4 Store_12        G    2304.61    122.20
      2272 Region_4 Store_12        H    2046.88    258.91
      2273 Region_4 Store_12        I    1264.36    148.80
      2274 Region_4 Store_12        J    2553.65    105.08
      2275 Region_4 Store_13      All   21140.16   2134.03
      2276 Region_4 Store_13        A     911.62    167.32
      2277 Region_4 Store_13        B    1837.94    171.62
      2278 Region_4 Store_13        C     517.04     79.86
      2279 Region_4 Store_13        D    1428.14    308.79
      2280 Region_4 Store_13        E    4027.97    248.00
      2281 Region_4 Store_13        F    2695.52    171.45
      2282 Region_4 Store_13        G    1377.34    182.01
      2283 Region_4 Store_13        H    2125.95    212.29
      2284 Region_4 Store_13        I    4315.62    317.18
      2285 Region_4 Store_13        J    1903.02    275.51
      2286 Region_4 Store_14      All   19762.34   2004.92
      2287 Region_4 Store_14        A    2034.87    359.04
      2288 Region_4 Store_14        B    2380.29    267.82
      2289 Region_4 Store_14        C     676.47     44.60
      2290 Region_4 Store_14        D    3422.00    257.36
      2291 Region_4 Store_14        E    2062.77    180.30
      2292 Region_4 Store_14        F    2751.02    187.05
      2293 Region_4 Store_14        G    1254.92    154.70
      2294 Region_4 Store_14        H    1382.02    186.14
      2295 Region_4 Store_14        I    1711.29    140.03
      2296 Region_4 Store_14        J    2086.69    227.88
      2297 Region_4 Store_15      All   21255.34   2010.38
      2298 Region_4 Store_15        A    1404.94    191.94
      2299 Region_4 Store_15        B    3355.40    366.03
      2300 Region_4 Store_15        C    3184.01    253.04
      2301 Region_4 Store_15        D    2430.15    142.75
      2302 Region_4 Store_15        E     567.41     42.98
      2303 Region_4 Store_15        F    1712.37    132.98
      2304 Region_4 Store_15        G    2578.17    259.23
      2305 Region_4 Store_15        H    2164.39    261.35
      2306 Region_4 Store_15        I     141.82     52.58
      2307 Region_4 Store_15        J    3716.68    307.50
      2308 Region_4 Store_16      All   19370.65   1813.07
      2309 Region_4 Store_16        A    2466.16    258.67
      2310 Region_4 Store_16        B    1773.99    147.59
      2311 Region_4 Store_16        C     253.51    135.30
      2312 Region_4 Store_16        D    1762.02    233.54
      2313 Region_4 Store_16        E    3624.50    233.35
      2314 Region_4 Store_16        F    3635.77    202.98
      2315 Region_4 Store_16        G    1495.14    186.78
      2316 Region_4 Store_16        H     125.35     56.73
      2317 Region_4 Store_16        I    1183.48    103.60
      2318 Region_4 Store_16        J    3050.73    254.53
      2319 Region_4 Store_17      All   23620.81   1964.41
      2320 Region_4 Store_17        A    3029.92    184.57
      2321 Region_4 Store_17        B    2392.74    215.15
      2322 Region_4 Store_17        C    2025.69    185.62
      2323 Region_4 Store_17        D    2461.75     92.64
      2324 Region_4 Store_17        E    1847.96    202.78
      2325 Region_4 Store_17        F    1526.43    101.10
      2326 Region_4 Store_17        G    1955.29    211.08
      2327 Region_4 Store_17        H    1464.95    153.14
      2328 Region_4 Store_17        I    2248.45    238.59
      2329 Region_4 Store_17        J    4667.63    379.74
      2330 Region_4 Store_18      All   23230.98   2141.28
      2331 Region_4 Store_18        A    3113.26    285.21
      2332 Region_4 Store_18        B    2486.40    277.02
      2333 Region_4 Store_18        C    2890.71    156.95
      2334 Region_4 Store_18        D    1248.62    145.60
      2335 Region_4 Store_18        E    1258.62    124.46
      2336 Region_4 Store_18        F    3133.43    316.20
      2337 Region_4 Store_18        G    3307.42    259.61
      2338 Region_4 Store_18        H    2503.59     97.35
      2339 Region_4 Store_18        I     453.82     56.39
      2340 Region_4 Store_18        J    2835.11    422.49
      2341 Region_4 Store_19      All   19655.47   1832.51
      2342 Region_4 Store_19        A    1871.26    152.14
      2343 Region_4 Store_19        B    2871.57    258.60
      2344 Region_4 Store_19        C     294.94     52.86
      2345 Region_4 Store_19        D    3107.52    222.13
      2346 Region_4 Store_19        E    2333.91    235.73
      2347 Region_4 Store_19        F     763.25    108.24
      2348 Region_4 Store_19        G    1822.70    173.23
      2349 Region_4 Store_19        H    2243.10    218.08
      2350 Region_4 Store_19        I    3518.26    283.43
      2351 Region_4 Store_19        J     828.96    128.07
      2352 Region_4  Store_2      All   23047.71   2223.46
      2353 Region_4  Store_2        A    2173.78    366.67
      2354 Region_4  Store_2        B    2447.51    174.73
      2355 Region_4  Store_2        C    5424.32    393.11
      2356 Region_4  Store_2        D    2869.14    287.35
      2357 Region_4  Store_2        E    3580.42    195.09
      2358 Region_4  Store_2        F    1828.35    306.76
      2359 Region_4  Store_2        G     613.07     78.46
      2360 Region_4  Store_2        H    2840.61    177.36
      2361 Region_4  Store_2        I     590.90    184.58
      2362 Region_4  Store_2        J     679.61     59.35
      2363 Region_4 Store_20      All   16398.06   1633.43
      2364 Region_4 Store_20        A     935.45    128.64
      2365 Region_4 Store_20        B    2513.80    198.35
      2366 Region_4 Store_20        C    1853.06    218.85
      2367 Region_4 Store_20        D    2123.90    270.48
      2368 Region_4 Store_20        E      97.91     58.05
      2369 Region_4 Store_20        F    1082.02    121.40
      2370 Region_4 Store_20        G    2544.66    108.73
      2371 Region_4 Store_20        H     165.85     49.17
      2372 Region_4 Store_20        I    2992.50    286.93
      2373 Region_4 Store_20        J    2088.91    192.83
      2374 Region_4 Store_21      All   28070.60   2431.32
      2375 Region_4 Store_21        A    2797.49    155.21
      2376 Region_4 Store_21        B    2522.03    237.29
      2377 Region_4 Store_21        C    5038.76    435.88
      2378 Region_4 Store_21        D    3609.17    315.34
      2379 Region_4 Store_21        E     602.70     73.11
      2380 Region_4 Store_21        F    4376.77    298.73
      2381 Region_4 Store_21        G    4702.72    391.61
      2382 Region_4 Store_21        H     827.59    148.31
      2383 Region_4 Store_21        I     317.20    131.18
      2384 Region_4 Store_21        J    3276.17    244.66
      2385 Region_4 Store_22      All   19168.75   1955.92
      2386 Region_4 Store_22        A    2286.14    193.95
      2387 Region_4 Store_22        B     111.39     19.23
      2388 Region_4 Store_22        C     477.89     62.66
      2389 Region_4 Store_22        D    3725.18    314.73
      2390 Region_4 Store_22        E    3548.16    228.38
      2391 Region_4 Store_22        F    1684.17    214.71
      2392 Region_4 Store_22        G    1789.91    264.73
      2393 Region_4 Store_22        H    1545.55    198.63
      2394 Region_4 Store_22        I    1241.57    106.95
      2395 Region_4 Store_22        J    2758.79    351.95
      2396 Region_4 Store_23      All   19567.22   1860.51
      2397 Region_4 Store_23        A    1803.09    136.83
      2398 Region_4 Store_23        B    1258.98     99.54
      2399 Region_4 Store_23        C    5586.75    581.41
      2400 Region_4 Store_23        D    1131.00    126.60
      2401 Region_4 Store_23        E    1824.09    151.51
      2402 Region_4 Store_23        F     468.81     62.12
      2403 Region_4 Store_23        G    1502.56    220.37
      2404 Region_4 Store_23        H    2445.92    147.80
      2405 Region_4 Store_23        I    2076.42    189.07
      2406 Region_4 Store_23        J    1469.60    145.26
      2407 Region_4 Store_24      All   22536.51   2119.43
      2408 Region_4 Store_24        A     439.09     47.53
      2409 Region_4 Store_24        B    1680.27    120.78
      2410 Region_4 Store_24        C    1858.74    176.02
      2411 Region_4 Store_24        D    4598.06    461.38
      2412 Region_4 Store_24        E    2094.50    352.71
      2413 Region_4 Store_24        G    3487.29    306.55
      2414 Region_4 Store_24        H    5580.70    402.97
      2415 Region_4 Store_24        I    2177.84    175.45
      2416 Region_4 Store_24        J     620.02     76.04
      2417 Region_4 Store_25      All   24007.93   2346.65
      2418 Region_4 Store_25        A    2003.94    239.65
      2419 Region_4 Store_25        B    1344.60    121.27
      2420 Region_4 Store_25        C     767.13     95.02
      2421 Region_4 Store_25        D    2893.86    331.14
      2422 Region_4 Store_25        E    1982.32    167.99
      2423 Region_4 Store_25        F    3565.77    313.81
      2424 Region_4 Store_25        G    3651.29    307.62
      2425 Region_4 Store_25        H    3146.92    384.41
      2426 Region_4 Store_25        I    2615.15    215.53
      2427 Region_4 Store_25        J    2036.95    170.21
      2428 Region_4 Store_26      All   30358.22   2347.39
      2429 Region_4 Store_26        A    4725.52    531.82
      2430 Region_4 Store_26        B    1666.74    118.90
      2431 Region_4 Store_26        C    3436.24    182.24
      2432 Region_4 Store_26        D    3949.58    424.87
      2433 Region_4 Store_26        E    3356.93    275.53
      2434 Region_4 Store_26        F    2300.01    117.83
      2435 Region_4 Store_26        G    1451.86    104.90
      2436 Region_4 Store_26        H    4071.03    328.70
      2437 Region_4 Store_26        I    2488.30     87.75
      2438 Region_4 Store_26        J    2912.01    174.85
      2439 Region_4 Store_27      All   13429.06   1779.53
      2440 Region_4 Store_27        A    2524.13    366.37
      2441 Region_4 Store_27        B    1503.60    251.03
      2442 Region_4 Store_27        C    2085.75    135.96
      2443 Region_4 Store_27        D     205.85     81.31
      2444 Region_4 Store_27        E     766.73     68.75
      2445 Region_4 Store_27        F    1196.22    196.85
      2446 Region_4 Store_27        G    1638.06    176.96
      2447 Region_4 Store_27        H    1573.98    302.18
      2448 Region_4 Store_27        I    1584.41    143.00
      2449 Region_4 Store_27        J     350.33     57.12
      2450 Region_4 Store_28      All   23672.03   2309.14
      2451 Region_4 Store_28        A    3944.05    370.60
      2452 Region_4 Store_28        B     510.23    165.74
      2453 Region_4 Store_28        C    2858.17    203.99
      2454 Region_4 Store_28        D    3789.09    230.46
      2455 Region_4 Store_28        E    2151.44    263.72
      2456 Region_4 Store_28        F    2515.18    236.58
      2457 Region_4 Store_28        G    3035.10    414.59
      2458 Region_4 Store_28        H    1437.30     55.76
      2459 Region_4 Store_28        I    1050.05    142.63
      2460 Region_4 Store_28        J    2381.42    225.07
      2461 Region_4 Store_29      All   23188.26   2407.69
      2462 Region_4 Store_29        A    1655.41    218.94
      2463 Region_4 Store_29        B     887.10     29.96
      2464 Region_4 Store_29        C    6493.58    502.98
      2465 Region_4 Store_29        D     234.60    139.46
      2466 Region_4 Store_29        E    2066.72    242.67
      2467 Region_4 Store_29        F    2597.13    138.56
      2468 Region_4 Store_29        G    2612.31    174.07
      2469 Region_4 Store_29        H    2570.41    491.01
      2470 Region_4 Store_29        I    2430.48    284.02
      2471 Region_4 Store_29        J    1640.52    186.02
      2472 Region_4  Store_3      All   20303.07   2298.59
      2473 Region_4  Store_3        A    3716.06    269.15
      2474 Region_4  Store_3        B    1231.44    143.38
      2475 Region_4  Store_3        C     508.61    137.46
      2476 Region_4  Store_3        D    1118.40    201.49
      2477 Region_4  Store_3        E    5740.53    506.58
      2478 Region_4  Store_3        F    3697.38    355.87
      2479 Region_4  Store_3        G     906.30     41.14
      2480 Region_4  Store_3        H    1565.38    266.25
      2481 Region_4  Store_3        I     392.95    106.37
      2482 Region_4  Store_3        J    1426.02    270.90
      2483 Region_4 Store_30      All   22493.48   2188.79
      2484 Region_4 Store_30        A     760.14     99.71
      2485 Region_4 Store_30        B    3917.87    262.83
      2486 Region_4 Store_30        C    3302.07    363.67
      2487 Region_4 Store_30        D    1029.75    137.88
      2488 Region_4 Store_30        E    2305.65    307.24
      2489 Region_4 Store_30        F    2361.08    182.40
      2490 Region_4 Store_30        G    2098.15    235.39
      2491 Region_4 Store_30        H    1557.22    205.20
      2492 Region_4 Store_30        I    2029.97    230.45
      2493 Region_4 Store_30        J    3131.58    164.02
      2494 Region_4 Store_31      All   22050.39   2530.48
      2495 Region_4 Store_31        A    1861.58    165.20
      2496 Region_4 Store_31        B    1850.16    262.08
      2497 Region_4 Store_31        C    2820.46    236.58
      2498 Region_4 Store_31        D     994.78    208.91
      2499 Region_4 Store_31        E    1335.60    252.51
      2500 Region_4 Store_31        F    2638.35    247.49
      2501 Region_4 Store_31        G    3517.47    386.33
      2502 Region_4 Store_31        H    2547.11    316.27
      2503 Region_4 Store_31        I    3185.35    313.44
      2504 Region_4 Store_31        J    1299.53    141.67
      2505 Region_4 Store_32      All   14471.03   1439.74
      2506 Region_4 Store_32        A    2491.10    211.27
      2507 Region_4 Store_32        B     942.56    112.10
      2508 Region_4 Store_32        C    1527.17    147.57
      2509 Region_4 Store_32        D    1183.22    155.31
      2510 Region_4 Store_32        E    1567.69    223.75
      2511 Region_4 Store_32        F    2290.20    124.25
      2512 Region_4 Store_32        G     677.57     51.28
      2513 Region_4 Store_32        H    1803.69    134.94
      2514 Region_4 Store_32        I     555.88     64.21
      2515 Region_4 Store_32        J    1431.95    215.06
      2516 Region_4 Store_33      All   22834.47   2088.52
      2517 Region_4 Store_33        A    1336.44     85.51
      2518 Region_4 Store_33        B     711.82     73.69
      2519 Region_4 Store_33        C    3190.20    299.32
      2520 Region_4 Store_33        D    4877.60    394.03
      2521 Region_4 Store_33        E    1360.65     80.14
      2522 Region_4 Store_33        F    2261.81    263.96
      2523 Region_4 Store_33        G     876.79     81.87
      2524 Region_4 Store_33        H    1850.29    165.62
      2525 Region_4 Store_33        I    2937.59    367.74
      2526 Region_4 Store_33        J    3431.28    276.64
      2527 Region_4 Store_34      All   23119.25   1881.79
      2528 Region_4 Store_34        A    1435.76    137.06
      2529 Region_4 Store_34        B    3837.57    311.71
      2530 Region_4 Store_34        C    4414.96    440.68
      2531 Region_4 Store_34        D    1090.50    115.00
      2532 Region_4 Store_34        E    1996.45    177.14
      2533 Region_4 Store_34        F    1589.23     95.89
      2534 Region_4 Store_34        G    2947.17    255.90
      2535 Region_4 Store_34        H     420.47      5.71
      2536 Region_4 Store_34        I    3332.01    171.01
      2537 Region_4 Store_34        J    2055.13    171.69
      2538 Region_4 Store_35      All   21251.18   2060.38
      2539 Region_4 Store_35        A    1598.17    100.08
      2540 Region_4 Store_35        B    3276.09    228.48
      2541 Region_4 Store_35        C    1888.66    264.79
      2542 Region_4 Store_35        D    2349.49    225.54
      2543 Region_4 Store_35        E     869.44     59.77
      2544 Region_4 Store_35        F    1402.96    214.71
      2545 Region_4 Store_35        G    1577.68    191.58
      2546 Region_4 Store_35        H    1386.99    177.66
      2547 Region_4 Store_35        I    3960.94    420.90
      2548 Region_4 Store_35        J    2940.76    176.87
      2549 Region_4 Store_36      All   17555.18   1563.51
      2550 Region_4 Store_36        A     701.89     84.88
      2551 Region_4 Store_36        B     408.78     28.11
      2552 Region_4 Store_36        C    1467.88     79.62
      2553 Region_4 Store_36        D    2143.53    192.00
      2554 Region_4 Store_36        E      25.68     55.05
      2555 Region_4 Store_36        F    1820.66    193.79
      2556 Region_4 Store_36        G    1970.99    111.32
      2557 Region_4 Store_36        H    3380.77    369.54
      2558 Region_4 Store_36        I    3420.81    297.93
      2559 Region_4 Store_36        J    2214.19    151.27
      2560 Region_4 Store_37      All   15780.64   1458.86
      2561 Region_4 Store_37        A    1436.25    145.49
      2562 Region_4 Store_37        B     322.44     42.58
      2563 Region_4 Store_37        C    2382.18    250.02
      2564 Region_4 Store_37        D    1386.82    170.88
      2565 Region_4 Store_37        E     972.83     82.84
      2566 Region_4 Store_37        F    3396.28    206.35
      2567 Region_4 Store_37        G    2372.43    141.36
      2568 Region_4 Store_37        H    2144.12    304.35
      2569 Region_4 Store_37        I     975.44     67.45
      2570 Region_4 Store_37        J     391.85     47.54
      2571 Region_4 Store_38      All   23751.76   2034.60
      2572 Region_4 Store_38        A    2023.55    197.61
      2573 Region_4 Store_38        B    1234.95    115.25
      2574 Region_4 Store_38        C    1629.36    102.62
      2575 Region_4 Store_38        D    2682.24    223.63
      2576 Region_4 Store_38        E    3994.10    295.50
      2577 Region_4 Store_38        F    4230.12    334.07
      2578 Region_4 Store_38        G    1185.01    200.53
      2579 Region_4 Store_38        H    1625.63    187.04
      2580 Region_4 Store_38        I    3057.37    193.08
      2581 Region_4 Store_38        J    2089.43    185.27
      2582 Region_4 Store_39      All   25558.45   2307.60
      2583 Region_4 Store_39        A    1250.16    170.62
      2584 Region_4 Store_39        B    1398.50    172.49
      2585 Region_4 Store_39        C    4401.80    238.92
      2586 Region_4 Store_39        D    3542.51    221.05
      2587 Region_4 Store_39        E    2019.81    164.37
      2588 Region_4 Store_39        F    1765.77    271.36
      2589 Region_4 Store_39        G    3967.80    313.38
      2590 Region_4 Store_39        H    3296.16    320.01
      2591 Region_4 Store_39        I    1955.00    215.47
      2592 Region_4 Store_39        J    1960.94    219.93
      2593 Region_4  Store_4      All   19942.91   1621.87
      2594 Region_4  Store_4        A    2509.62    118.03
      2595 Region_4  Store_4        B     897.88     32.98
      2596 Region_4  Store_4        C     276.89      5.29
      2597 Region_4  Store_4        D    2066.23    215.05
      2598 Region_4  Store_4        E     783.71    120.78
      2599 Region_4  Store_4        F    3662.19    334.03
      2600 Region_4  Store_4        G    1391.34    171.46
      2601 Region_4  Store_4        H    2040.99    142.25
      2602 Region_4  Store_4        I    3629.69    170.59
      2603 Region_4  Store_4        J    2684.37    311.41
      2604 Region_4 Store_40      All   19187.54   1983.90
      2605 Region_4 Store_40        A    6330.50    407.02
      2606 Region_4 Store_40        B    2221.21    328.85
      2607 Region_4 Store_40        C     135.19     41.64
      2608 Region_4 Store_40        D    2511.21    306.97
      2609 Region_4 Store_40        E    2391.04    230.11
      2610 Region_4 Store_40        F     980.32     48.17
      2611 Region_4 Store_40        G    1492.82    156.76
      2612 Region_4 Store_40        H     911.28    197.70
      2613 Region_4 Store_40        I    1941.56    179.87
      2614 Region_4 Store_40        J     272.41     86.81
      2615 Region_4 Store_41      All   15473.45   1718.05
      2616 Region_4 Store_41        A    2365.58    270.79
      2617 Region_4 Store_41        B    1606.12    140.64
      2618 Region_4 Store_41        C    2126.19    189.62
      2619 Region_4 Store_41        D    1975.95    240.04
      2620 Region_4 Store_41        E    3004.81    250.90
      2621 Region_4 Store_41        F     624.56     48.25
      2622 Region_4 Store_41        G    1803.80    205.00
      2623 Region_4 Store_41        I    1045.41    173.87
      2624 Region_4 Store_41        J     921.03    198.94
      2625 Region_4 Store_42      All   24831.12   2715.93
      2626 Region_4 Store_42        A    1478.91    176.38
      2627 Region_4 Store_42        B    2585.05    216.26
      2628 Region_4 Store_42        C    3209.83    453.78
      2629 Region_4 Store_42        D    2237.33    281.54
      2630 Region_4 Store_42        E    3693.43    343.91
      2631 Region_4 Store_42        F    1368.94    275.15
      2632 Region_4 Store_42        G    3148.42    214.02
      2633 Region_4 Store_42        H    4330.98    389.17
      2634 Region_4 Store_42        I    1357.23    153.65
      2635 Region_4 Store_42        J    1421.00    212.07
      2636 Region_4 Store_43      All   22235.17   1951.43
      2637 Region_4 Store_43        A    1897.39    149.98
      2638 Region_4 Store_43        B    2955.26    317.57
      2639 Region_4 Store_43        C    3040.84    215.67
      2640 Region_4 Store_43        D    1274.27    162.98
      2641 Region_4 Store_43        E    1968.02    236.66
      2642 Region_4 Store_43        F    4173.03    277.06
      2643 Region_4 Store_43        G    1187.15    155.26
      2644 Region_4 Store_43        H     907.73     73.33
      2645 Region_4 Store_43        I    3141.52    200.17
      2646 Region_4 Store_43        J    1689.96    162.75
      2647 Region_4 Store_44      All   20780.65   2311.69
      2648 Region_4 Store_44        A    2731.31    284.28
      2649 Region_4 Store_44        B    1563.82    249.94
      2650 Region_4 Store_44        C    1653.79    229.72
      2651 Region_4 Store_44        D    1727.99    173.13
      2652 Region_4 Store_44        E    1863.31    262.00
      2653 Region_4 Store_44        F     891.44    204.75
      2654 Region_4 Store_44        G    2223.89    241.39
      2655 Region_4 Store_44        H    2677.95    244.65
      2656 Region_4 Store_44        I    3486.75    239.66
      2657 Region_4 Store_44        J    1960.40    182.17
      2658 Region_4 Store_45      All   17889.48   1825.83
      2659 Region_4 Store_45        A    2341.73    230.25
      2660 Region_4 Store_45        B     890.22     38.78
      2661 Region_4 Store_45        C    3036.94    289.77
      2662 Region_4 Store_45        D    3353.70    347.29
      2663 Region_4 Store_45        E    2367.88    318.73
      2664 Region_4 Store_45        F    1761.15    208.99
      2665 Region_4 Store_45        G     799.08     78.72
      2666 Region_4 Store_45        H    1089.99    146.29
      2667 Region_4 Store_45        I    1313.44     96.93
      2668 Region_4 Store_45        J     935.35     70.08
      2669 Region_4 Store_46      All   17558.98   1907.65
      2670 Region_4 Store_46        A     118.60     94.79
      2671 Region_4 Store_46        B    2574.89    356.69
      2672 Region_4 Store_46        C    1232.13     73.89
      2673 Region_4 Store_46        D     950.80     30.38
      2674 Region_4 Store_46        E    1621.67    157.71
      2675 Region_4 Store_46        F    2620.65    324.18
      2676 Region_4 Store_46        G    2644.58    351.45
      2677 Region_4 Store_46        H    2757.10    208.93
      2678 Region_4 Store_46        I    1913.06    196.71
      2679 Region_4 Store_46        J    1125.50    112.92
      2680 Region_4 Store_47      All   21217.40   2052.58
      2681 Region_4 Store_47        A    2464.44    169.85
      2682 Region_4 Store_47        B    3218.71    381.80
      2683 Region_4 Store_47        C     370.48     44.68
      2684 Region_4 Store_47        D    1897.67    157.76
      2685 Region_4 Store_47        E     339.01    106.61
      2686 Region_4 Store_47        F    2093.89    210.86
      2687 Region_4 Store_47        G    3218.56    201.31
      2688 Region_4 Store_47        H    2618.45    311.51
      2689 Region_4 Store_47        I    4193.18    365.30
      2690 Region_4 Store_47        J     803.01    102.90
      2691 Region_4 Store_48      All   17938.49   1660.02
      2692 Region_4 Store_48        A    3150.29    303.42
      2693 Region_4 Store_48        B    1904.80    116.40
      2694 Region_4 Store_48        C     759.41     44.79
      2695 Region_4 Store_48        D    1201.18     88.85
      2696 Region_4 Store_48        E    1185.81    156.15
      2697 Region_4 Store_48        F    3224.01    266.82
      2698 Region_4 Store_48        G    1722.51    244.67
      2699 Region_4 Store_48        H    3380.74    264.33
      2700 Region_4 Store_48        I     237.94     20.18
      2701 Region_4 Store_48        J    1171.80    154.41
      2702 Region_4 Store_49      All   22802.92   1991.39
      2703 Region_4 Store_49        A    3364.98    305.18
      2704 Region_4 Store_49        B    2166.65    330.86
      2705 Region_4 Store_49        C     224.96    113.35
      2706 Region_4 Store_49        D    2386.87    192.67
      2707 Region_4 Store_49        E    1980.18    199.87
      2708 Region_4 Store_49        F    2786.38    222.50
      2709 Region_4 Store_49        G    5802.32    314.98
      2710 Region_4 Store_49        H     641.73     58.47
      2711 Region_4 Store_49        I     119.31     24.35
      2712 Region_4 Store_49        J    3329.54    229.16
      2713 Region_4  Store_5      All   18768.40   1470.54
      2714 Region_4  Store_5        A    2081.30    248.47
      2715 Region_4  Store_5        B     778.05     55.59
      2716 Region_4  Store_5        C    3074.25    246.70
      2717 Region_4  Store_5        D    2232.94    119.26
      2718 Region_4  Store_5        E    2677.19    233.38
      2719 Region_4  Store_5        F    2833.88    194.52
      2720 Region_4  Store_5        G    1112.03    126.07
      2721 Region_4  Store_5        H    2947.26    143.10
      2722 Region_4  Store_5        I      33.55     33.03
      2723 Region_4  Store_5        J     997.95     70.42
      2724 Region_4 Store_50      All   17126.42   1821.21
      2725 Region_4 Store_50        A    1361.98    229.80
      2726 Region_4 Store_50        B    1567.06    233.32
      2727 Region_4 Store_50        C     972.80    123.67
      2728 Region_4 Store_50        D    1089.39    147.45
      2729 Region_4 Store_50        E     425.18    127.93
      2730 Region_4 Store_50        F    2665.91    208.92
      2731 Region_4 Store_50        G    2932.39    194.59
      2732 Region_4 Store_50        H    1619.28    186.61
      2733 Region_4 Store_50        J    4492.43    368.92
      2734 Region_4  Store_6      All   18119.50   1870.30
      2735 Region_4  Store_6        A     995.04     27.17
      2736 Region_4  Store_6        B     787.15      6.96
      2737 Region_4  Store_6        C    2131.12    147.75
      2738 Region_4  Store_6        D    3657.56    324.40
      2739 Region_4  Store_6        E    1769.28    309.40
      2740 Region_4  Store_6        F    1152.61    111.49
      2741 Region_4  Store_6        G    1810.12    313.46
      2742 Region_4  Store_6        H    2102.98    180.94
      2743 Region_4  Store_6        I    1572.95    198.43
      2744 Region_4  Store_6        J    2140.69    250.30
      2745 Region_4  Store_7      All   17378.92   2031.65
      2746 Region_4  Store_7        A     462.05    102.57
      2747 Region_4  Store_7        B    2858.64    279.17
      2748 Region_4  Store_7        C    2741.61    364.77
      2749 Region_4  Store_7        D    1275.26    249.22
      2750 Region_4  Store_7        E    1691.89    184.64
      2751 Region_4  Store_7        F    1835.00    154.23
      2752 Region_4  Store_7        G    2907.43    372.50
      2753 Region_4  Store_7        H    1992.06    105.77
      2754 Region_4  Store_7        I     713.96    123.55
      2755 Region_4  Store_7        J     901.02     95.23
      2756 Region_4  Store_8      All   21959.35   2261.77
      2757 Region_4  Store_8        A    3052.35    339.04
      2758 Region_4  Store_8        B    1167.67     82.78
      2759 Region_4  Store_8        C    3507.49    221.45
      2760 Region_4  Store_8        D    1707.62    188.04
      2761 Region_4  Store_8        E    1510.42    154.62
      2762 Region_4  Store_8        F    1547.96    261.09
      2763 Region_4  Store_8        G    2099.15    173.42
      2764 Region_4  Store_8        H    3117.45    235.08
      2765 Region_4  Store_8        I    2333.52    321.46
      2766 Region_4  Store_8        J    1915.72    284.79
      2767 Region_4  Store_9      All   15976.29   1790.31
      2768 Region_4  Store_9        A    2228.00    362.69
      2769 Region_4  Store_9        B    3059.23    364.63
      2770 Region_4  Store_9        C    1623.48    173.54
      2771 Region_4  Store_9        D     728.32     65.41
      2772 Region_4  Store_9        E    4247.64    386.73
      2773 Region_4  Store_9        F     957.93    123.83
      2774 Region_4  Store_9        G    1132.76    131.27
      2775 Region_4  Store_9        H      67.21     54.94
      2776 Region_4  Store_9        I     994.49     28.18
      2777 Region_4  Store_9        J     937.23     99.09
      2778 Region_5      All      All 1029631.18 104040.28
      2779 Region_5      All        A   96126.51  10127.70
      2780 Region_5      All        B  103686.64  10879.23
      2781 Region_5      All        C  113419.92  11012.36
      2782 Region_5      All        D  105417.99  10198.47
      2783 Region_5      All        E  107921.87  11120.94
      2784 Region_5      All        F  107019.09  11054.98
      2785 Region_5      All        G  103399.03  10343.61
      2786 Region_5      All        H   98243.80  10468.57
      2787 Region_5      All        I  105855.39  10702.44
      2788 Region_5      All        J   88540.94   8131.98
      2789 Region_5  Store_1      All   22074.92   2205.39
      2790 Region_5  Store_1        A    1665.27    324.82
      2791 Region_5  Store_1        B     963.63    111.71
      2792 Region_5  Store_1        C    2581.16    187.53
      2793 Region_5  Store_1        D    1698.93    184.52
      2794 Region_5  Store_1        E    1919.22    144.73
      2795 Region_5  Store_1        F    1949.71     76.50
      2796 Region_5  Store_1        G      81.07     29.04
      2797 Region_5  Store_1        H    4345.87    509.36
      2798 Region_5  Store_1        I    5013.57    469.60
      2799 Region_5  Store_1        J    1856.49    167.58
      2800 Region_5 Store_10      All   21703.05   2054.55
      2801 Region_5 Store_10        A    2081.81    349.13
      2802 Region_5 Store_10        B    2615.40    247.97
      2803 Region_5 Store_10        C    2444.57     84.71
      2804 Region_5 Store_10        D    3148.14    292.38
      2805 Region_5 Store_10        E    3709.43    309.87
      2806 Region_5 Store_10        F    1857.70    213.63
      2807 Region_5 Store_10        G    1850.37    211.02
      2808 Region_5 Store_10        H    1499.02    165.87
      2809 Region_5 Store_10        I     135.40     62.12
      2810 Region_5 Store_10        J    2361.21    117.85
      2811 Region_5 Store_11      All   21348.15   1906.64
      2812 Region_5 Store_11        A    2427.64    108.13
      2813 Region_5 Store_11        B    3094.36    180.30
      2814 Region_5 Store_11        C    1671.48    214.72
      2815 Region_5 Store_11        D     207.95     54.04
      2816 Region_5 Store_11        E    1128.38    137.45
      2817 Region_5 Store_11        F    2106.96    155.92
      2818 Region_5 Store_11        G    2582.31    258.31
      2819 Region_5 Store_11        H    1049.72    173.48
      2820 Region_5 Store_11        I    4504.04    393.06
      2821 Region_5 Store_11        J    2575.31    231.23
      2822 Region_5 Store_12      All   23730.41   2535.80
      2823 Region_5 Store_12        A    3407.42    281.78
      2824 Region_5 Store_12        B    1721.01    276.88
      2825 Region_5 Store_12        C    2047.39    189.19
      2826 Region_5 Store_12        D    2525.63    191.72
      2827 Region_5 Store_12        E    4087.38    425.36
      2828 Region_5 Store_12        F     801.32    136.23
      2829 Region_5 Store_12        G    2805.23    300.70
      2830 Region_5 Store_12        H    1879.36    156.59
      2831 Region_5 Store_12        I    3735.25    401.23
      2832 Region_5 Store_12        J     720.42    176.12
      2833 Region_5 Store_13      All   21356.63   2253.44
      2834 Region_5 Store_13        A    3231.24    456.59
      2835 Region_5 Store_13        B    1169.60    137.45
      2836 Region_5 Store_13        C     972.37    150.47
      2837 Region_5 Store_13        D    2042.71    183.36
      2838 Region_5 Store_13        E    1342.39    238.97
      2839 Region_5 Store_13        F    3001.77    227.88
      2840 Region_5 Store_13        G    4005.26    321.35
      2841 Region_5 Store_13        H    2157.69    288.62
      2842 Region_5 Store_13        I    2054.93    183.38
      2843 Region_5 Store_13        J    1378.67     65.37
      2844 Region_5 Store_14      All   28258.73   2954.79
      2845 Region_5 Store_14        A    1730.95    225.98
      2846 Region_5 Store_14        B    3867.53    266.80
      2847 Region_5 Store_14        C    2225.46    262.03
      2848 Region_5 Store_14        D    2140.43    273.09
      2849 Region_5 Store_14        E    2202.74    412.50
      2850 Region_5 Store_14        F    4583.76    441.78
      2851 Region_5 Store_14        G    2488.30    286.64
      2852 Region_5 Store_14        H    2828.00    259.52
      2853 Region_5 Store_14        I    3271.45    296.06
      2854 Region_5 Store_14        J    2920.11    230.39
      2855 Region_5 Store_15      All   23263.50   2124.46
      2856 Region_5 Store_15        A    2977.02    100.27
      2857 Region_5 Store_15        B    2621.47    194.99
      2858 Region_5 Store_15        C    1533.69    267.97
      2859 Region_5 Store_15        D    2084.58    132.10
      2860 Region_5 Store_15        E    2381.65    244.29
      2861 Region_5 Store_15        F    4248.97    337.26
      2862 Region_5 Store_15        G    1302.06    320.36
      2863 Region_5 Store_15        H    1553.10    172.14
      2864 Region_5 Store_15        I    2125.01    137.50
      2865 Region_5 Store_15        J    2435.95    217.58
      2866 Region_5 Store_16      All   19803.52   2011.86
      2867 Region_5 Store_16        A    1821.60    110.04
      2868 Region_5 Store_16        B    1587.10    215.48
      2869 Region_5 Store_16        C    1777.36    199.30
      2870 Region_5 Store_16        D    1988.10    178.51
      2871 Region_5 Store_16        F    2608.88    238.63
      2872 Region_5 Store_16        G    1182.77    118.20
      2873 Region_5 Store_16        H    3659.23    277.59
      2874 Region_5 Store_16        I    3618.72    470.30
      2875 Region_5 Store_16        J    1559.76    203.81
      2876 Region_5 Store_17      All   27843.47   2701.97
      2877 Region_5 Store_17        A    2902.92    308.16
      2878 Region_5 Store_17        B    3737.47    356.58
      2879 Region_5 Store_17        C    3778.30    333.11
      2880 Region_5 Store_17        D    1001.63    173.60
      2881 Region_5 Store_17        E    1791.15    176.76
      2882 Region_5 Store_17        F    4913.59    428.31
      2883 Region_5 Store_17        G    3408.81    241.74
      2884 Region_5 Store_17        H    2381.91    263.94
      2885 Region_5 Store_17        I    1718.34    196.02
      2886 Region_5 Store_17        J    2209.35    223.75
      2887 Region_5 Store_18      All   15626.56   1425.74
      2888 Region_5 Store_18        A     520.11     26.43
      2889 Region_5 Store_18        B    1534.95    173.27
      2890 Region_5 Store_18        C    1423.36    165.13
      2891 Region_5 Store_18        D    2152.80    180.89
      2892 Region_5 Store_18        E    4488.60    296.32
      2893 Region_5 Store_18        F    1117.14    127.37
      2894 Region_5 Store_18        G    1063.98    119.90
      2895 Region_5 Store_18        H    3140.20    283.27
      2896 Region_5 Store_18        J     185.42     53.16
      2897 Region_5 Store_19      All   17583.49   2255.14
      2898 Region_5 Store_19        A    1839.36    350.38
      2899 Region_5 Store_19        B    2029.11    191.46
      2900 Region_5 Store_19        C    1344.91     94.04
      2901 Region_5 Store_19        D    3205.89    301.34
      2902 Region_5 Store_19        E      54.49     87.27
      2903 Region_5 Store_19        F    3247.71    335.91
      2904 Region_5 Store_19        G    2212.36    330.11
      2905 Region_5 Store_19        I    2842.41    332.84
      2906 Region_5 Store_19        J     807.25    231.79
      2907 Region_5  Store_2      All   27719.55   2398.08
      2908 Region_5  Store_2        A    3321.22    382.96
      2909 Region_5  Store_2        B    5449.14    380.67
      2910 Region_5  Store_2        C    4492.29    284.51
      2911 Region_5  Store_2        D    2207.60    195.25
      2912 Region_5  Store_2        E    3298.19    310.65
      2913 Region_5  Store_2        F    1548.40    226.13
      2914 Region_5  Store_2        G    2030.29    165.89
      2915 Region_5  Store_2        H    1236.20    103.44
      2916 Region_5  Store_2        I    2188.34    246.10
      2917 Region_5  Store_2        J    1947.88    102.48
      2918 Region_5 Store_20      All   11398.40   1232.23
      2919 Region_5 Store_20        A     948.92    204.51
      2920 Region_5 Store_20        B     303.14    117.41
      2921 Region_5 Store_20        C    2407.26    205.97
      2922 Region_5 Store_20        D     935.83     99.61
      2923 Region_5 Store_20        E     520.73     35.75
      2924 Region_5 Store_20        F     470.88     73.26
      2925 Region_5 Store_20        G     712.86    131.12
      2926 Region_5 Store_20        H    3630.10    261.43
      2927 Region_5 Store_20        I     769.00     55.39
      2928 Region_5 Store_20        J     699.68     47.78
      2929 Region_5 Store_21      All   16330.46   1690.20
      2930 Region_5 Store_21        A    1175.90     86.93
      2931 Region_5 Store_21        B    2284.05    283.72
      2932 Region_5 Store_21        C    2095.02    128.47
      2933 Region_5 Store_21        D    2389.31    226.99
      2934 Region_5 Store_21        E    1567.79    229.60
      2935 Region_5 Store_21        F    2645.54    245.68
      2936 Region_5 Store_21        G    2367.81    211.10
      2937 Region_5 Store_21        H     280.73    105.45
      2938 Region_5 Store_21        I    1256.09    113.33
      2939 Region_5 Store_21        J     268.22     58.93
      2940 Region_5 Store_22      All   25807.75   2467.69
      2941 Region_5 Store_22        A    2549.81    288.83
      2942 Region_5 Store_22        B    2433.48    247.30
      2943 Region_5 Store_22        C    2687.47    311.48
      2944 Region_5 Store_22        D    3050.65    305.95
      2945 Region_5 Store_22        E    4681.54    208.06
      2946 Region_5 Store_22        F    1628.25    101.96
      2947 Region_5 Store_22        G    2049.82    239.40
      2948 Region_5 Store_22        H    3390.45    384.56
      2949 Region_5 Store_22        I    1304.67    171.33
      2950 Region_5 Store_22        J    2031.61    208.82
      2951 Region_5 Store_23      All   21221.11   2151.79
      2952 Region_5 Store_23        A    1484.66    133.36
      2953 Region_5 Store_23        B    2138.77    232.55
      2954 Region_5 Store_23        C    3857.25    384.53
      2955 Region_5 Store_23        D    1033.83    173.02
      2956 Region_5 Store_23        E    2999.19    253.86
      2957 Region_5 Store_23        F    2316.33    226.64
      2958 Region_5 Store_23        G    3314.77    288.04
      2959 Region_5 Store_23        H    1318.08    104.18
      2960 Region_5 Store_23        I    2080.41    241.26
      2961 Region_5 Store_23        J     677.82    114.35
      2962 Region_5 Store_24      All   21115.99   1938.27
      2963 Region_5 Store_24        A    2633.44    292.51
      2964 Region_5 Store_24        B     220.06     46.49
      2965 Region_5 Store_24        C    3173.57    348.61
      2966 Region_5 Store_24        D    4813.95    382.62
      2967 Region_5 Store_24        E    2115.18    134.66
      2968 Region_5 Store_24        F     397.65     46.05
      2969 Region_5 Store_24        G    2848.70    231.39
      2970 Region_5 Store_24        H    3273.63    354.27
      2971 Region_5 Store_24        I    1639.81    101.67
      2972 Region_5 Store_25      All   13006.39   1648.57
      2973 Region_5 Store_25        A    3743.95    385.95
      2974 Region_5 Store_25        C     898.08    116.00
      2975 Region_5 Store_25        D    2138.12    227.31
      2976 Region_5 Store_25        E    1078.57    154.87
      2977 Region_5 Store_25        F    1257.62    160.17
      2978 Region_5 Store_25        G    1454.38    301.64
      2979 Region_5 Store_25        H     447.44    165.44
      2980 Region_5 Store_25        I     683.27     63.42
      2981 Region_5 Store_25        J    1304.96     73.77
      2982 Region_5 Store_26      All   16206.43   1841.72
      2983 Region_5 Store_26        A    4608.51    315.78
      2984 Region_5 Store_26        B    1198.78    162.36
      2985 Region_5 Store_26        C    1169.35    202.76
      2986 Region_5 Store_26        D    3414.52    336.44
      2987 Region_5 Store_26        E     140.12    150.29
      2988 Region_5 Store_26        F    1978.29    191.55
      2989 Region_5 Store_26        G     892.33     21.62
      2990 Region_5 Store_26        H     415.11    127.47
      2991 Region_5 Store_26        I    2100.04    272.35
      2992 Region_5 Store_26        J     289.38     61.10
      2993 Region_5 Store_27      All   19170.87   2006.36
      2994 Region_5 Store_27        B    1563.41     84.21
      2995 Region_5 Store_27        C    1891.14    171.24
      2996 Region_5 Store_27        D     870.47     27.35
      2997 Region_5 Store_27        E    4458.00    429.39
      2998 Region_5 Store_27        F    1147.16    140.93
      2999 Region_5 Store_27        G    1965.68    170.00
      3000 Region_5 Store_27        H    2261.93    310.40
      3001 Region_5 Store_27        I    3165.04    385.87
      3002 Region_5 Store_27        J    1848.04    286.97
      3003 Region_5 Store_28      All   21977.57   2546.28
      3004 Region_5 Store_28        A    3683.34    265.79
      3005 Region_5 Store_28        B    2097.19    303.98
      3006 Region_5 Store_28        C    2557.23    315.90
      3007 Region_5 Store_28        D    4040.00    418.72
      3008 Region_5 Store_28        E    1721.31    206.40
      3009 Region_5 Store_28        F    2814.51    269.30
      3010 Region_5 Store_28        G    1647.27    207.57
      3011 Region_5 Store_28        H    2550.44    442.71
      3012 Region_5 Store_28        J     866.28    115.91
      3013 Region_5 Store_29      All   20521.75   1899.54
      3014 Region_5 Store_29        A     617.35     21.05
      3015 Region_5 Store_29        B    3263.14    330.79
      3016 Region_5 Store_29        C    2070.89    307.75
      3017 Region_5 Store_29        D    1468.52    128.82
      3018 Region_5 Store_29        E    2846.22    296.27
      3019 Region_5 Store_29        F    1046.14    149.60
      3020 Region_5 Store_29        G    3581.30    287.21
      3021 Region_5 Store_29        I    2837.24    270.60
      3022 Region_5 Store_29        J    2790.95    107.45
      3023 Region_5  Store_3      All   22692.96   2249.81
      3024 Region_5  Store_3        A    1692.89    151.61
      3025 Region_5  Store_3        B    1262.85    170.67
      3026 Region_5  Store_3        C    3913.74    246.74
      3027 Region_5  Store_3        D     119.19     74.66
      3028 Region_5  Store_3        E     680.05     56.99
      3029 Region_5  Store_3        F    4511.37    633.01
      3030 Region_5  Store_3        G    1961.99    159.57
      3031 Region_5  Store_3        H    1326.75    141.28
      3032 Region_5  Store_3        I    3514.59    456.05
      3033 Region_5  Store_3        J    3709.54    159.23
      3034 Region_5 Store_30      All   25511.28   2389.27
      3035 Region_5 Store_30        A      63.31     20.88
      3036 Region_5 Store_30        B    4042.00    302.97
      3037 Region_5 Store_30        C    2681.35    369.67
      3038 Region_5 Store_30        D     987.79     90.17
      3039 Region_5 Store_30        E    1547.47    286.05
      3040 Region_5 Store_30        F    3981.60    432.45
      3041 Region_5 Store_30        G    2077.88    192.62
      3042 Region_5 Store_30        H    3039.88    213.25
      3043 Region_5 Store_30        I    4112.55    221.12
      3044 Region_5 Store_30        J    2977.45    260.09
      3045 Region_5 Store_31      All   17845.57   1742.92
      3046 Region_5 Store_31        A    2148.83    150.20
      3047 Region_5 Store_31        B     850.79    184.96
      3048 Region_5 Store_31        C    2141.81    284.05
      3049 Region_5 Store_31        D     758.15     68.72
      3050 Region_5 Store_31        E     814.78    148.06
      3051 Region_5 Store_31        F    4211.06    283.07
      3052 Region_5 Store_31        G    1757.78    121.81
      3053 Region_5 Store_31        H    1714.78    213.93
      3054 Region_5 Store_31        I    1435.00    123.87
      3055 Region_5 Store_31        J    2012.59    164.25
      3056 Region_5 Store_32      All   18250.12   1836.05
      3057 Region_5 Store_32        A    1919.26    279.69
      3058 Region_5 Store_32        B    2544.37    167.22
      3059 Region_5 Store_32        C    1673.46     84.29
      3060 Region_5 Store_32        D    2572.95    316.52
      3061 Region_5 Store_32        E    1782.48    169.03
      3062 Region_5 Store_32        G    1735.51    177.71
      3063 Region_5 Store_32        H    2562.32    191.52
      3064 Region_5 Store_32        I    2352.75    290.89
      3065 Region_5 Store_32        J    1107.02    159.18
      3066 Region_5 Store_33      All   15186.07   1554.19
      3067 Region_5 Store_33        A    1064.09     97.81
      3068 Region_5 Store_33        B    1580.86    164.90
      3069 Region_5 Store_33        C    2893.65    206.36
      3070 Region_5 Store_33        D    1806.88    243.22
      3071 Region_5 Store_33        E    2320.84    283.06
      3072 Region_5 Store_33        F    1668.79    142.49
      3073 Region_5 Store_33        G    1592.50    155.47
      3074 Region_5 Store_33        H     434.78     65.44
      3075 Region_5 Store_33        I     943.13    121.41
      3076 Region_5 Store_33        J     880.55     74.03
      3077 Region_5 Store_34      All   18137.03   2006.50
      3078 Region_5 Store_34        A     917.70    142.07
      3079 Region_5 Store_34        B    1531.69    158.04
      3080 Region_5 Store_34        C    3376.53    293.10
      3081 Region_5 Store_34        D    1899.38    170.28
      3082 Region_5 Store_34        E    1367.40    215.63
      3083 Region_5 Store_34        F    1666.47    177.37
      3084 Region_5 Store_34        G    4043.77    481.76
      3085 Region_5 Store_34        H    1526.82    123.19
      3086 Region_5 Store_34        I    1807.27    245.06
      3087 Region_5 Store_35      All   21884.95   2101.97
      3088 Region_5 Store_35        A    1398.40    189.33
      3089 Region_5 Store_35        B    1033.97    169.84
      3090 Region_5 Store_35        C    4064.11    391.09
      3091 Region_5 Store_35        D    1891.52    147.97
      3092 Region_5 Store_35        E    3607.55    408.87
      3093 Region_5 Store_35        F    1175.01    144.49
      3094 Region_5 Store_35        G     753.45     57.98
      3095 Region_5 Store_35        H    3228.04    274.37
      3096 Region_5 Store_35        I    1784.93    153.74
      3097 Region_5 Store_35        J    2947.97    164.29
      3098 Region_5 Store_36      All   16132.25   1825.15
      3099 Region_5 Store_36        A     869.20     90.41
      3100 Region_5 Store_36        B    1578.76    256.49
      3101 Region_5 Store_36        C    3081.66    308.22
      3102 Region_5 Store_36        D    2886.56    290.09
      3103 Region_5 Store_36        E     757.92     52.55
      3104 Region_5 Store_36        F    4357.07    420.99
      3105 Region_5 Store_36        H     653.08    177.61
      3106 Region_5 Store_36        I     991.79     92.98
      3107 Region_5 Store_36        J     956.21    135.81
      3108 Region_5 Store_37      All   13676.88   1649.83
      3109 Region_5 Store_37        A     669.08    169.15
      3110 Region_5 Store_37        B     263.82     54.07
      3111 Region_5 Store_37        C    1959.43    260.27
      3112 Region_5 Store_37        D    1848.14    155.43
      3113 Region_5 Store_37        E     451.09     37.47
      3114 Region_5 Store_37        F    1801.21    245.99
      3115 Region_5 Store_37        G     522.23    118.03
      3116 Region_5 Store_37        H    4312.17    325.81
      3117 Region_5 Store_37        I     499.18    159.35
      3118 Region_5 Store_37        J    1350.53    124.26
      3119 Region_5 Store_38      All   16600.22   1766.54
      3120 Region_5 Store_38        A     881.64    170.42
      3121 Region_5 Store_38        B    1664.67    243.14
      3122 Region_5 Store_38        C     637.17     33.56
      3123 Region_5 Store_38        D    2577.79    401.84
      3124 Region_5 Store_38        E    2178.42    198.56
      3125 Region_5 Store_38        F     872.65     74.16
      3126 Region_5 Store_38        G     868.11    177.77
      3127 Region_5 Store_38        I    5991.00    380.90
      3128 Region_5 Store_38        J     928.77     86.19
      3129 Region_5 Store_39      All   20095.47   2003.05
      3130 Region_5 Store_39        A    2283.55    228.59
      3131 Region_5 Store_39        B    2256.16    425.84
      3132 Region_5 Store_39        C    1641.54    144.24
      3133 Region_5 Store_39        D    1323.26    124.53
      3134 Region_5 Store_39        E    3638.63    261.55
      3135 Region_5 Store_39        F    1518.19    141.56
      3136 Region_5 Store_39        G    2407.33    203.65
      3137 Region_5 Store_39        H    2528.18    309.82
      3138 Region_5 Store_39        I    1107.56    100.07
      3139 Region_5 Store_39        J    1391.07     63.20
      3140 Region_5  Store_4      All   13372.67   1805.89
      3141 Region_5  Store_4        A    1474.65    250.36
      3142 Region_5  Store_4        B    2012.08    273.26
      3143 Region_5  Store_4        C    1107.48    139.01
      3144 Region_5  Store_4        D    1095.48    208.01
      3145 Region_5  Store_4        E    1080.38    190.66
      3146 Region_5  Store_4        G    2088.21    339.99
      3147 Region_5  Store_4        H    2852.10    242.72
      3148 Region_5  Store_4        I      88.84     60.99
      3149 Region_5  Store_4        J    1573.45    100.89
      3150 Region_5 Store_40      All   24494.72   2731.16
      3151 Region_5 Store_40        A    3537.45    275.13
      3152 Region_5 Store_40        B    3563.02    346.18
      3153 Region_5 Store_40        C    2881.76    267.02
      3154 Region_5 Store_40        D    2032.14    173.40
      3155 Region_5 Store_40        E     867.26    338.04
      3156 Region_5 Store_40        F     843.72    195.09
      3157 Region_5 Store_40        G    2466.12    200.26
      3158 Region_5 Store_40        H    2824.02    365.12
      3159 Region_5 Store_40        I    3090.74    297.70
      3160 Region_5 Store_40        J    2388.49    273.22
      3161 Region_5 Store_41      All   16654.43   1590.77
      3162 Region_5 Store_41        A    2288.64    237.22
      3163 Region_5 Store_41        B    2199.02    230.67
      3164 Region_5 Store_41        C    1220.41    150.43
      3165 Region_5 Store_41        D     875.91     41.45
      3166 Region_5 Store_41        E    2293.73    151.09
      3167 Region_5 Store_41        F    1316.15    147.45
      3168 Region_5 Store_41        G    2464.95    283.25
      3169 Region_5 Store_41        H    1381.48    115.97
      3170 Region_5 Store_41        I    1153.50     70.05
      3171 Region_5 Store_41        J    1460.64    163.19
      3172 Region_5 Store_42      All   17638.57   1628.92
      3173 Region_5 Store_42        A    1914.46    173.27
      3174 Region_5 Store_42        B    2028.62    109.86
      3175 Region_5 Store_42        C    1016.22     67.45
      3176 Region_5 Store_42        D    1675.80     86.67
      3177 Region_5 Store_42        E    2862.16    275.50
      3178 Region_5 Store_42        F    1322.84    155.58
      3179 Region_5 Store_42        H    1500.79    160.04
      3180 Region_5 Store_42        I    3138.11    436.14
      3181 Region_5 Store_42        J    2179.57    164.41
      3182 Region_5 Store_43      All   30284.20   2518.03
      3183 Region_5 Store_43        A    2387.67    140.40
      3184 Region_5 Store_43        B    1886.39    272.13
      3185 Region_5 Store_43        C    3581.61    272.38
      3186 Region_5 Store_43        D    2860.71    279.85
      3187 Region_5 Store_43        E    2160.13    134.96
      3188 Region_5 Store_43        F    1537.18    105.50
      3189 Region_5 Store_43        G    3785.76    246.84
      3190 Region_5 Store_43        H    5176.53    497.81
      3191 Region_5 Store_43        I    2555.34    206.28
      3192 Region_5 Store_43        J    4352.88    361.88
      3193 Region_5 Store_44      All   28616.69   2607.22
      3194 Region_5 Store_44        A    2461.09    316.84
      3195 Region_5 Store_44        B     434.52     33.53
      3196 Region_5 Store_44        C    2318.91     96.08
      3197 Region_5 Store_44        D     659.48     55.67
      3198 Region_5 Store_44        E    5779.40    378.37
      3199 Region_5 Store_44        F    4567.49    346.60
      3200 Region_5 Store_44        G    2824.11    329.35
      3201 Region_5 Store_44        H    2651.81    292.60
      3202 Region_5 Store_44        I    4029.29    496.38
      3203 Region_5 Store_44        J    2890.59    261.80
      3204 Region_5 Store_45      All   23990.01   2305.93
      3205 Region_5 Store_45        A    1162.35    140.81
      3206 Region_5 Store_45        B     493.74    111.62
      3207 Region_5 Store_45        C    3350.92    270.09
      3208 Region_5 Store_45        D    3084.48    241.00
      3209 Region_5 Store_45        E    4168.33    334.51
      3210 Region_5 Store_45        F    2430.95    434.38
      3211 Region_5 Store_45        G    1591.93     91.47
      3212 Region_5 Store_45        H    2397.77    263.96
      3213 Region_5 Store_45        I    2703.65    253.61
      3214 Region_5 Store_45        J    2605.89    164.48
      3215 Region_5 Store_46      All   21732.41   2240.31
      3216 Region_5 Store_46        A    1256.38    197.66
      3217 Region_5 Store_46        B    3444.31    367.24
      3218 Region_5 Store_46        C    2596.26    217.07
      3219 Region_5 Store_46        D    2458.85    148.40
      3220 Region_5 Store_46        E    1095.53    204.78
      3221 Region_5 Store_46        F    4326.23    403.61
      3222 Region_5 Store_46        G    1330.60    185.36
      3223 Region_5 Store_46        H    1514.18    200.02
      3224 Region_5 Store_46        I    1366.97    103.27
      3225 Region_5 Store_46        J    2343.10    212.90
      3226 Region_5 Store_47      All   18829.68   2412.83
      3227 Region_5 Store_47        A    2624.10    241.29
      3228 Region_5 Store_47        B    2532.36    355.92
      3229 Region_5 Store_47        C    2290.54    254.19
      3230 Region_5 Store_47        D    2169.26    195.84
      3231 Region_5 Store_47        E     519.51    132.90
      3232 Region_5 Store_47        F    1025.90    181.07
      3233 Region_5 Store_47        G    3613.10    354.02
      3234 Region_5 Store_47        H    1199.53    212.33
      3235 Region_5 Store_47        I     509.87     94.33
      3236 Region_5 Store_47        J    2345.51    390.94
      3237 Region_5 Store_48      All   21937.32   2092.83
      3238 Region_5 Store_48        A    1984.94    292.05
      3239 Region_5 Store_48        B    2188.54    180.85
      3240 Region_5 Store_48        C    2864.51    287.14
      3241 Region_5 Store_48        D    2164.81    159.23
      3242 Region_5 Store_48        E    3066.34    237.57
      3243 Region_5 Store_48        F    1888.97    196.86
      3244 Region_5 Store_48        G    1340.79    114.06
      3245 Region_5 Store_48        H    1423.70    229.10
      3246 Region_5 Store_48        I    2185.46    144.83
      3247 Region_5 Store_48        J    2829.26    251.14
      3248 Region_5 Store_49      All   15120.70   1788.31
      3249 Region_5 Store_49        A     502.87    143.80
      3250 Region_5 Store_49        B    3180.76    519.02
      3251 Region_5 Store_49        C    1719.27    214.77
      3252 Region_5 Store_49        E    1544.54    241.82
      3253 Region_5 Store_49        F     451.59     48.43
      3254 Region_5 Store_49        G    1647.49     70.65
      3255 Region_5 Store_49        H    2110.75    168.55
      3256 Region_5 Store_49        I    2586.76    194.84
      3257 Region_5 Store_49        J    1376.67    186.43
      3258 Region_5  Store_5      All   24603.85   2249.40
      3259 Region_5  Store_5        A    1257.67    137.36
      3260 Region_5  Store_5        B    2469.70    356.74
      3261 Region_5  Store_5        C    1210.56    166.30
      3262 Region_5  Store_5        D    5010.55    326.10
      3263 Region_5  Store_5        E    4514.44    573.45
      3264 Region_5  Store_5        G    4878.28    287.65
      3265 Region_5  Store_5        H     999.07    115.55
      3266 Region_5  Store_5        I    2702.87    149.16
      3267 Region_5  Store_5        J    1560.71    137.09
      3268 Region_5 Store_50      All   16601.17   1619.69
      3269 Region_5 Store_50        A    3916.18    320.54
      3270 Region_5 Store_50        B     814.33     82.92
      3271 Region_5 Store_50        C    2319.51    268.72
      3272 Region_5 Store_50        D    2407.04    241.71
      3273 Region_5 Store_50        E    2393.80    234.77
      3274 Region_5 Store_50        G    1302.43    158.02
      3275 Region_5 Store_50        H     854.69     70.21
      3276 Region_5 Store_50        I     708.16     37.10
      3277 Region_5 Store_50        J    1885.03    205.70
      3278 Region_5  Store_6      All   28138.63   2439.31
      3279 Region_5  Store_6        A    1432.62     91.22
      3280 Region_5  Store_6        B    5276.71    357.99
      3281 Region_5  Store_6        C    1357.02    174.68
      3282 Region_5  Store_6        D    3787.70    340.73
      3283 Region_5  Store_6        E    2830.13    197.48
      3284 Region_5  Store_6        F    3209.12    389.14
      3285 Region_5  Store_6        G    5138.70    454.25
      3286 Region_5  Store_6        H    1264.87     48.57
      3287 Region_5  Store_6        I    2081.19    238.64
      3288 Region_5  Store_6        J    1760.57    146.61
      3289 Region_5  Store_7      All   26034.56   2223.50
      3290 Region_5  Store_7        A    2169.17    209.09
      3291 Region_5  Store_7        B    3838.85    182.43
      3292 Region_5  Store_7        C    2492.77    258.97
      3293 Region_5  Store_7        D    3215.42    279.15
      3294 Region_5  Store_7        E    3235.34    268.92
      3295 Region_5  Store_7        F    3448.27    435.76
      3296 Region_5  Store_7        G    2729.11    187.28
      3297 Region_5  Store_7        H    3156.96    212.84
      3298 Region_5  Store_7        I     244.26     44.50
      3299 Region_5  Store_7        J    1504.41    144.56
      3300 Region_5  Store_8      All   16557.49   2162.19
      3301 Region_5  Store_8        A     404.73     56.66
      3302 Region_5  Store_8        B     641.04    149.94
      3303 Region_5  Store_8        C    2177.15    183.69
      3304 Region_5  Store_8        D    1975.27    368.18
      3305 Region_5  Store_8        E    1604.32    102.09
      3306 Region_5  Store_8        F    2963.36    372.42
      3307 Region_5  Store_8        G     792.96    167.73
      3308 Region_5  Store_8        H     983.90    181.09
      3309 Region_5  Store_8        I    3658.69    422.45
      3310 Region_5  Store_8        J    1356.07    157.94
      3311 Region_5  Store_9      All   21942.58   2248.20
      3312 Region_5  Store_9        A    2071.15    194.46
      3313 Region_5  Store_9        B    2179.92    108.42
      3314 Region_5  Store_9        C    1750.97    177.36
      3315 Region_5  Store_9        D    2713.89    302.02
      3316 Region_5  Store_9        E     227.63    122.89
      3317 Region_5  Store_9        F    4235.62    396.82
      3318 Region_5  Store_9        G    1836.21    234.71
      3319 Region_5  Store_9        H    1326.64    146.14
      3320 Region_5  Store_9        I    1468.91    243.30
      3321 Region_5  Store_9        J    4131.64    322.08

# Snapshot: Exclude parameter, median aggregator, uneven distribution

    Code
      as.data.frame(out)
    Output
         department   role  salary
      1         All    All 59897.0
      2         All Junior 60564.0
      3         All   Lead 59214.0
      4         All    Mid 59841.0
      5         All Senior 59922.0
      6   Executive    All 58999.0
      7   Executive Junior 54253.0
      8   Executive   Lead 59520.0
      9   Executive    Mid 62031.0
      10  Executive Senior 59759.0
      11         HR    All 59541.5
      12         HR Junior 62828.0
      13         HR   Lead 60077.0
      14         HR    Mid 57051.0
      15         HR Senior 59514.5
      16         IT    All 59334.0
      17         IT Junior 58969.5
      18         IT   Lead 58936.0
      19         IT    Mid 59829.0
      20         IT Senior 59106.0
      21  Marketing    All 60836.0
      22  Marketing Junior 64361.5
      23  Marketing   Lead 58265.5
      24  Marketing    Mid 60744.0
      25  Marketing Senior 61393.5
      26      Sales    All 60326.0
      27      Sales Junior 61650.5
      28      Sales   Lead 59707.0
      29      Sales    Mid 59853.0
      30      Sales Senior 60008.0

# Snapshot: Deep grouping (4 levels), custom function, missing values

    Code
      as.data.frame(out)
    Output
          year quarter product_line status    uptime   latency
      1    All     All          All    All        NA 107.18273
      2    All     All          All Active        NA 107.02616
      3    All     All          All   Beta        NA 106.81201
      4    All     All          All Legacy        NA 107.18273
      5    All     All     Hardware    All        NA 103.95742
      6    All     All     Hardware Active        NA 103.95742
      7    All     All     Hardware   Beta        NA  94.37186
      8    All     All     Hardware Legacy        NA 102.01668
      9    All     All     Services    All        NA 107.18273
      10   All     All     Services Active        NA 107.02616
      11   All     All     Services   Beta        NA 106.81201
      12   All     All     Services Legacy        NA 107.18273
      13   All     All     Software    All        NA 105.31166
      14   All     All     Software Active        NA 105.31166
      15   All     All     Software   Beta        NA 100.31194
      16   All     All     Software Legacy        NA  99.94089
      17   All      Q1          All    All        NA 106.81201
      18   All      Q1          All Active        NA 103.27638
      19   All      Q1          All   Beta        NA 106.81201
      20   All      Q1          All Legacy        NA 102.01668
      21   All      Q1     Hardware    All        NA 102.01668
      22   All      Q1     Hardware Active        NA  88.76496
      23   All      Q1     Hardware   Beta        NA  94.37186
      24   All      Q1     Hardware Legacy        NA 102.01668
      25   All      Q1     Services    All        NA 106.81201
      26   All      Q1     Services Active        NA  97.25918
      27   All      Q1     Services   Beta        NA 106.81201
      28   All      Q1     Services Legacy        NA  88.32933
      29   All      Q1     Software    All        NA 103.27638
      30   All      Q1     Software Active        NA 103.27638
      31   All      Q1     Software   Beta        NA 100.31194
      32   All      Q1     Software Legacy        NA  95.34901
      33   All      Q2          All    All        NA 107.18273
      34   All      Q2          All Active        NA 107.02616
      35   All      Q2          All   Beta        NA  94.25913
      36   All      Q2          All Legacy        NA 107.18273
      37   All      Q2     Hardware    All        NA 100.32530
      38   All      Q2     Hardware Active        NA  92.50345
      39   All      Q2     Hardware   Beta        NA  85.12854
      40   All      Q2     Hardware Legacy        NA 100.32530
      41   All      Q2     Services    All        NA 107.18273
      42   All      Q2     Services Active        NA 107.02616
      43   All      Q2     Services   Beta        NA  93.73007
      44   All      Q2     Services Legacy        NA 107.18273
      45   All      Q2     Software    All        NA  99.94089
      46   All      Q2     Software Active        NA  95.33030
      47   All      Q2     Software   Beta        NA  94.25913
      48   All      Q2     Software Legacy        NA  99.94089
      49   All      Q3          All    All        NA 103.95742
      50   All      Q3          All Active        NA 103.95742
      51   All      Q3          All   Beta        NA  93.77057
      52   All      Q3          All Legacy        NA  99.22131
      53   All      Q3     Hardware    All        NA 103.95742
      54   All      Q3     Hardware Active        NA 103.95742
      55   All      Q3     Hardware   Beta        NA  93.77057
      56   All      Q3     Hardware Legacy        NA  94.22959
      57   All      Q3     Services    All        NA  94.61035
      58   All      Q3     Services Active        NA  93.23882
      59   All      Q3     Services   Beta        NA  89.32941
      60   All      Q3     Services Legacy        NA  94.61035
      61   All      Q3     Software    All        NA  99.22131
      62   All      Q3     Software Active        NA  92.24991
      63   All      Q3     Software   Beta        NA  88.63519
      64   All      Q3     Software Legacy        NA  99.22131
      65   All      Q4          All    All        NA 105.31166
      66   All      Q4          All Active        NA 105.31166
      67   All      Q4          All   Beta        NA  99.11469
      68   All      Q4          All Legacy        NA  96.24582
      69   All      Q4     Hardware    All        NA  96.18525
      70   All      Q4     Hardware Active        NA  96.18525
      71   All      Q4     Hardware   Beta        NA  94.15057
      72   All      Q4     Hardware Legacy        NA  94.05339
      73   All      Q4     Services    All        NA  99.11469
      74   All      Q4     Services Active        NA  89.05565
      75   All      Q4     Services   Beta        NA  99.11469
      76   All      Q4     Services Legacy        NA  96.06654
      77   All      Q4     Software    All        NA 105.31166
      78   All      Q4     Software Active        NA 105.31166
      79   All      Q4     Software   Beta        NA  89.26530
      80   All      Q4     Software Legacy        NA  96.24582
      81  2023     All          All    All        NA 105.31166
      82  2023     All          All Active        NA 105.31166
      83  2023     All          All   Beta        NA 104.76454
      84  2023     All          All Legacy        NA  94.61419
      85  2023     All     Hardware    All        NA  94.31105
      86  2023     All     Hardware Active        NA  91.89029
      87  2023     All     Hardware   Beta        NA  93.52433
      88  2023     All     Hardware Legacy        NA  94.31105
      89  2023     All     Services    All        NA 104.76454
      90  2023     All     Services Active        NA  95.42915
      91  2023     All     Services   Beta        NA 104.76454
      92  2023     All     Services Legacy        NA  94.61419
      93  2023     All     Software    All        NA 105.31166
      94  2023     All     Software Active        NA 105.31166
      95  2023     All     Software   Beta        NA  92.46293
      96  2023     All     Software Legacy        NA  89.19316
      97  2023      Q1          All    All        NA 104.76454
      98  2023      Q1          All Active        NA  96.45162
      99  2023      Q1          All   Beta        NA 104.76454
      100 2023      Q1          All Legacy        NA  94.31105
      101 2023      Q1     Hardware    All        NA  94.31105
      102 2023      Q1     Hardware Active        NA  88.76496
      103 2023      Q1     Hardware   Beta        NA  87.98984
      104 2023      Q1     Hardware Legacy        NA  94.31105
      105 2023      Q1     Services    All        NA 104.76454
      106 2023      Q1     Services Active        NA  95.42915
      107 2023      Q1     Services   Beta        NA 104.76454
      108 2023      Q1     Services Legacy        NA  82.10461
      109 2023      Q1     Software    All        NA  96.45162
      110 2023      Q1     Software Active        NA  96.45162
      111 2023      Q1     Software   Beta        NA  78.03797
      112 2023      Q1     Software Legacy        NA  85.18238
      113 2023      Q2          All    All        NA  94.85008
      114 2023      Q2          All Active        NA  94.85008
      115 2023      Q2          All   Beta        NA  93.73007
      116 2023      Q2          All Legacy        NA  92.41703
      117 2023      Q2     Hardware    All        NA  91.89029
      118 2023      Q2     Hardware Active        NA  91.89029
      119 2023      Q2     Hardware   Beta        NA  82.22047
      120 2023      Q2     Hardware Legacy        NA  91.29365
      121 2023      Q2     Services    All        NA  93.73007
      122 2023      Q2     Services Active 0.9989941  79.64368
      123 2023      Q2     Services   Beta        NA  93.73007
      124 2023      Q2     Services Legacy        NA  92.41703
      125 2023      Q2     Software    All        NA  94.85008
      126 2023      Q2     Software Active        NA  94.85008
      127 2023      Q2     Software   Beta        NA  92.46293
      128 2023      Q2     Software Legacy        NA  84.73367
      129 2023      Q3          All    All        NA  93.23882
      130 2023      Q3          All Active        NA  93.23882
      131 2023      Q3          All   Beta        NA  87.41538
      132 2023      Q3          All Legacy        NA  90.24683
      133 2023      Q3     Hardware    All        NA  90.24683
      134 2023      Q3     Hardware Active        NA  85.44652
      135 2023      Q3     Hardware   Beta        NA  87.41538
      136 2023      Q3     Hardware Legacy        NA  90.24683
      137 2023      Q3     Services    All        NA  93.23882
      138 2023      Q3     Services Active        NA  93.23882
      139 2023      Q3     Services   Beta        NA  86.26983
      140 2023      Q3     Services Legacy        NA  90.01847
      141 2023      Q3     Software    All        NA  89.19316
      142 2023      Q3     Software Active        NA  86.04667
      143 2023      Q3     Software   Beta        NA  83.61986
      144 2023      Q3     Software Legacy        NA  89.19316
      145 2023      Q4          All    All        NA 105.31166
      146 2023      Q4          All Active        NA 105.31166
      147 2023      Q4          All   Beta        NA  93.52433
      148 2023      Q4          All Legacy        NA  94.61419
      149 2023      Q4     Hardware    All        NA  93.52433
      150 2023      Q4     Hardware Active        NA  84.32392
      151 2023      Q4     Hardware   Beta        NA  93.52433
      152 2023      Q4     Hardware Legacy        NA  88.63187
      153 2023      Q4     Services    All        NA  94.61419
      154 2023      Q4     Services Active        NA  89.05565
      155 2023      Q4     Services   Beta        NA  79.02691
      156 2023      Q4     Services Legacy        NA  94.61419
      157 2023      Q4     Software    All        NA 105.31166
      158 2023      Q4     Software Active        NA 105.31166
      159 2023      Q4     Software   Beta        NA  81.99127
      160 2023      Q4     Software Legacy        NA  85.96418
      161 2024     All          All    All        NA 107.02616
      162 2024     All          All Active        NA 107.02616
      163 2024     All          All   Beta        NA 100.76058
      164 2024     All          All Legacy        NA 100.32530
      165 2024     All     Hardware    All        NA 100.32530
      166 2024     All     Hardware Active        NA  96.18525
      167 2024     All     Hardware   Beta        NA  94.15057
      168 2024     All     Hardware Legacy        NA 100.32530
      169 2024     All     Services    All        NA 107.02616
      170 2024     All     Services Active        NA 107.02616
      171 2024     All     Services   Beta        NA 100.76058
      172 2024     All     Services Legacy        NA  87.99931
      173 2024     All     Software    All        NA 103.27638
      174 2024     All     Software Active        NA 103.27638
      175 2024     All     Software   Beta        NA  94.25913
      176 2024     All     Software Legacy        NA  96.24582
      177 2024      Q1          All    All        NA 103.27638
      178 2024      Q1          All Active        NA 103.27638
      179 2024      Q1          All   Beta        NA 100.76058
      180 2024      Q1          All Legacy        NA  92.51212
      181 2024      Q1     Hardware    All        NA  92.51212
      182 2024      Q1     Hardware Active        NA  84.13708
      183 2024      Q1     Hardware   Beta        NA  86.26764
      184 2024      Q1     Hardware Legacy        NA  92.51212
      185 2024      Q1     Services    All        NA 100.76058
      186 2024      Q1     Services Active        NA  87.65166
      187 2024      Q1     Services   Beta        NA 100.76058
      188 2024      Q1     Services Legacy        NA  87.99931
      189 2024      Q1     Software    All        NA 103.27638
      190 2024      Q1     Software Active        NA 103.27638
      191 2024      Q1     Software   Beta        NA  90.69435
      192 2024      Q1     Software Legacy        NA  77.32029
      193 2024      Q2          All    All        NA 107.02616
      194 2024      Q2          All Active        NA 107.02616
      195 2024      Q2          All   Beta        NA  94.25913
      196 2024      Q2          All Legacy        NA 100.32530
      197 2024      Q2     Hardware    All        NA 100.32530
      198 2024      Q2     Hardware Active        NA  92.50345
      199 2024      Q2     Hardware   Beta        NA  85.12854
      200 2024      Q2     Hardware Legacy        NA 100.32530
      201 2024      Q2     Services    All        NA 107.02616
      202 2024      Q2     Services Active        NA 107.02616
      203 2024      Q2     Services   Beta        NA  91.23858
      204 2024      Q2     Services Legacy        NA  85.93120
      205 2024      Q2     Software    All        NA  95.33030
      206 2024      Q2     Software Active        NA  95.33030
      207 2024      Q2     Software   Beta        NA  94.25913
      208 2024      Q2     Software Legacy        NA  87.06624
      209 2024      Q3          All    All        NA  94.22959
      210 2024      Q3          All Active        NA  89.12568
      211 2024      Q3          All   Beta        NA  89.81565
      212 2024      Q3          All Legacy        NA  94.22959
      213 2024      Q3     Hardware    All        NA  94.22959
      214 2024      Q3     Hardware Active        NA  87.66900
      215 2024      Q3     Hardware   Beta        NA  89.81565
      216 2024      Q3     Hardware Legacy 0.9983621  94.22959
      217 2024      Q3     Services    All        NA  89.32941
      218 2024      Q3     Services Active        NA  86.33139
      219 2024      Q3     Services   Beta        NA  89.32941
      220 2024      Q3     Services Legacy        NA  79.26121
      221 2024      Q3     Software    All        NA  92.29189
      222 2024      Q3     Software Active        NA  89.12568
      223 2024      Q3     Software   Beta        NA  83.25743
      224 2024      Q3     Software Legacy        NA  92.29189
      225 2024      Q4          All    All        NA  99.11469
      226 2024      Q4          All Active        NA  96.18525
      227 2024      Q4          All   Beta        NA  99.11469
      228 2024      Q4          All Legacy        NA  96.24582
      229 2024      Q4     Hardware    All        NA  96.18525
      230 2024      Q4     Hardware Active        NA  96.18525
      231 2024      Q4     Hardware   Beta        NA  94.15057
      232 2024      Q4     Hardware Legacy        NA  90.93024
      233 2024      Q4     Services    All        NA  99.11469
      234 2024      Q4     Services Active        NA  87.56534
      235 2024      Q4     Services   Beta        NA  99.11469
      236 2024      Q4     Services Legacy        NA  85.44180
      237 2024      Q4     Software    All        NA  96.24582
      238 2024      Q4     Software Active        NA  82.64145
      239 2024      Q4     Software   Beta        NA  89.26530
      240 2024      Q4     Software Legacy        NA  96.24582
      241 2025     All          All    All        NA 107.18273
      242 2025     All          All Active        NA 103.95742
      243 2025     All          All   Beta        NA  94.37186
      244 2025     All          All Legacy        NA 107.18273
      245 2025     All     Hardware    All        NA 103.95742
      246 2025     All     Hardware Active        NA 103.95742
      247 2025     All     Hardware   Beta        NA  94.37186
      248 2025     All     Hardware Legacy        NA  94.05339
      249 2025     All     Services    All        NA 107.18273
      250 2025     All     Services Active        NA  97.25918
      251 2025     All     Services   Beta        NA  88.39337
      252 2025     All     Services Legacy        NA 107.18273
      253 2025     All     Software    All        NA  99.94089
      254 2025     All     Software Active        NA  86.69707
      255 2025     All     Software   Beta        NA  87.86580
      256 2025     All     Software Legacy        NA  99.94089
      257 2025      Q1          All    All        NA  97.25918
      258 2025      Q1          All Active        NA  97.25918
      259 2025      Q1          All   Beta        NA  94.37186
      260 2025      Q1          All Legacy        NA  95.34901
      261 2025      Q1     Hardware    All        NA  94.37186
      262 2025      Q1     Hardware Active        NA  83.49536
      263 2025      Q1     Hardware   Beta        NA  94.37186
      264 2025      Q1     Hardware Legacy        NA  90.79322
      265 2025      Q1     Services    All        NA  97.25918
      266 2025      Q1     Services Active        NA  97.25918
      267 2025      Q1     Services   Beta        NA  82.78508
      268 2025      Q1     Services Legacy        NA  88.32933
      269 2025      Q1     Software    All        NA  95.34901
      270 2025      Q1     Software Active        NA  84.74648
      271 2025      Q1     Software   Beta        NA  83.41262
      272 2025      Q1     Software Legacy        NA  95.34901
      273 2025      Q2          All    All        NA 107.18273
      274 2025      Q2          All Active        NA  87.42067
      275 2025      Q2          All   Beta        NA  88.20556
      276 2025      Q2          All Legacy        NA 107.18273
      277 2025      Q2     Hardware    All        NA  87.42067
      278 2025      Q2     Hardware Active        NA  87.42067
      279 2025      Q2     Hardware   Beta        NA  84.97868
      280 2025      Q2     Hardware Legacy        NA  85.00606
      281 2025      Q2     Services    All        NA 107.18273
      282 2025      Q2     Services Active        NA  85.95338
      283 2025      Q2     Services   Beta        NA  88.20556
      284 2025      Q2     Services Legacy        NA 107.18273
      285 2025      Q2     Software    All        NA  99.94089
      286 2025      Q2     Software Active        NA  79.94355
      287 2025      Q2     Software   Beta        NA  82.15443
      288 2025      Q2     Software Legacy        NA  99.94089
      289 2025      Q3          All    All        NA 103.95742
      290 2025      Q3          All Active        NA 103.95742
      291 2025      Q3          All   Beta        NA  93.77057
      292 2025      Q3          All Legacy        NA  94.61035
      293 2025      Q3     Hardware    All        NA 103.95742
      294 2025      Q3     Hardware Active        NA 103.95742
      295 2025      Q3     Hardware   Beta        NA  93.77057
      296 2025      Q3     Hardware Legacy        NA  83.97922
      297 2025      Q3     Services    All        NA  94.61035
      298 2025      Q3     Services Active        NA  87.70826
      299 2025      Q3     Services   Beta        NA  88.39337
      300 2025      Q3     Services Legacy        NA  94.61035
      301 2025      Q3     Software    All        NA  87.86580
      302 2025      Q3     Software Active 0.9989865  86.08656
      303 2025      Q3     Software   Beta        NA  87.86580
      304 2025      Q3     Software Legacy        NA  84.63630
      305 2025      Q4          All    All        NA  94.14985
      306 2025      Q4          All Active        NA  93.99216
      307 2025      Q4          All   Beta        NA  86.36526
      308 2025      Q4          All Legacy        NA  94.14985
      309 2025      Q4     Hardware    All        NA  94.05339
      310 2025      Q4     Hardware Active        NA  93.99216
      311 2025      Q4     Hardware   Beta        NA  86.33136
      312 2025      Q4     Hardware Legacy        NA  94.05339
      313 2025      Q4     Services    All        NA  84.82086
      314 2025      Q4     Services Active        NA  84.45343
      315 2025      Q4     Services   Beta        NA  84.82086
      316 2025      Q4     Services Legacy        NA  82.83307
      317 2025      Q4     Software    All        NA  94.14985
      318 2025      Q4     Software Active        NA  86.69707
      319 2025      Q4     Software   Beta        NA  86.36526
      320 2025      Q4     Software Legacy        NA  94.14985
      321 2026     All          All    All        NA 106.81201
      322 2026     All          All Active        NA  94.20024
      323 2026     All          All   Beta        NA 106.81201
      324 2026     All          All Legacy        NA 102.01668
      325 2026     All     Hardware    All        NA 102.01668
      326 2026     All     Hardware Active        NA  90.50004
      327 2026     All     Hardware   Beta        NA  93.57481
      328 2026     All     Hardware Legacy        NA 102.01668
      329 2026     All     Services    All        NA 106.81201
      330 2026     All     Services Active        NA  94.20024
      331 2026     All     Services   Beta        NA 106.81201
      332 2026     All     Services Legacy        NA  96.06654
      333 2026     All     Software    All        NA 100.31194
      334 2026     All     Software Active        NA  92.24991
      335 2026     All     Software   Beta        NA 100.31194
      336 2026     All     Software Legacy        NA  99.22131
      337 2026      Q1          All    All        NA 106.81201
      338 2026      Q1          All Active        NA  88.23661
      339 2026      Q1          All   Beta        NA 106.81201
      340 2026      Q1          All Legacy        NA 102.01668
      341 2026      Q1     Hardware    All        NA 102.01668
      342 2026      Q1     Hardware Active        NA  88.23661
      343 2026      Q1     Hardware   Beta        NA  91.50204
      344 2026      Q1     Hardware Legacy        NA 102.01668
      345 2026      Q1     Services    All        NA 106.81201
      346 2026      Q1     Services Active        NA  85.56141
      347 2026      Q1     Services   Beta        NA 106.81201
      348 2026      Q1     Services Legacy        NA  84.99886
      349 2026      Q1     Software    All        NA 100.31194
      350 2026      Q1     Software Active        NA  80.21152
      351 2026      Q1     Software   Beta        NA 100.31194
      352 2026      Q1     Software Legacy        NA  79.99686
      353 2026      Q2          All    All        NA  94.20024
      354 2026      Q2          All Active        NA  94.20024
      355 2026      Q2          All   Beta        NA  84.96221
      356 2026      Q2          All Legacy        NA  94.17776
      357 2026      Q2     Hardware    All        NA  94.17776
      358 2026      Q2     Hardware Active        NA  90.50004
      359 2026      Q2     Hardware   Beta        NA  80.92110
      360 2026      Q2     Hardware Legacy        NA  94.17776
      361 2026      Q2     Services    All        NA  94.20024
      362 2026      Q2     Services Active        NA  94.20024
      363 2026      Q2     Services   Beta        NA  80.14392
      364 2026      Q2     Services Legacy        NA  86.62683
      365 2026      Q2     Software    All        NA  85.14869
      366 2026      Q2     Software Active        NA  85.14869
      367 2026      Q2     Software   Beta        NA  84.96221
      368 2026      Q2     Software Legacy        NA  83.51899
      369 2026      Q3          All    All        NA  99.22131
      370 2026      Q3          All Active        NA  92.24991
      371 2026      Q3          All   Beta        NA  88.63519
      372 2026      Q3          All Legacy        NA  99.22131
      373 2026      Q3     Hardware    All        NA  92.95587
      374 2026      Q3     Hardware Active        NA  85.35227
      375 2026      Q3     Hardware   Beta        NA  87.04109
      376 2026      Q3     Hardware Legacy        NA  92.95587
      377 2026      Q3     Services    All        NA  86.04510
      378 2026      Q3     Services Active        NA  86.04510
      379 2026      Q3     Services   Beta        NA  83.86242
      380 2026      Q3     Services Legacy        NA  85.29336
      381 2026      Q3     Software    All        NA  99.22131
      382 2026      Q3     Software Active        NA  92.24991
      383 2026      Q3     Software   Beta        NA  88.63519
      384 2026      Q3     Software Legacy        NA  99.22131
      385 2026      Q4          All    All        NA  96.06654
      386 2026      Q4          All Active        NA  89.42575
      387 2026      Q4          All   Beta        NA  94.94703
      388 2026      Q4          All Legacy        NA  96.06654
      389 2026      Q4     Hardware    All        NA  93.57481
      390 2026      Q4     Hardware Active        NA  89.42575
      391 2026      Q4     Hardware   Beta        NA  93.57481
      392 2026      Q4     Hardware Legacy        NA  87.51579
      393 2026      Q4     Services    All        NA  96.06654
      394 2026      Q4     Services Active        NA  85.82399
      395 2026      Q4     Services   Beta        NA  94.94703
      396 2026      Q4     Services Legacy        NA  96.06654
      397 2026      Q4     Software    All        NA  86.65151
      398 2026      Q4     Software Active        NA  81.22171
      399 2026      Q4     Software   Beta        NA  83.29960
      400 2026      Q4     Software Legacy        NA  86.65151

