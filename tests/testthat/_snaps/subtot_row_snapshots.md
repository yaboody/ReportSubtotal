# subtotal_row outputs are consistent

    Code
      subtotal_row(df_simple, mtcars, vars = "mpg")
    Output
      # A tibble: 4 x 2
      # Groups:   cyl [4]
        cyl     mpg
        <fct> <dbl>
      1 Total 643. 
      2 4      26.7
      3 6      19.7
      4 8      15.1

---

    Code
      subtotal_row(df_multi, mtcars, vars = "hp")
    Output
      # A tibble: 22 x 4
      # Groups:   cyl, gear, vs [22]
         cyl   gear  vs       hp
         <fct> <fct> <fct> <dbl>
       1 Total Total Total  4694
       2 4     Total Total   909
       3 4     3     Total    97
       4 4     3     1        97
       5 4     4     Total   608
       6 4     4     1       608
       7 4     5     Total   204
       8 4     5     0        91
       9 4     5     1       113
      10 6     Total Total   856
      # i 12 more rows

---

    Code
      subtotal_row(df_bad, mtcars, vars = "mpg")
    Condition
      Error:
      ! 
      Your data report has only one column!

# subtotal_row advanced scenarios

    Code
      subtotal_row(df_iris, iris, vars = c("Sepal.Length", "Sepal.Width"))
    Output
      # A tibble: 4 x 3
      # Groups:   Species [4]
        Species    Sepal.Length Sepal.Width
        <fct>             <dbl>       <dbl>
      1 Total              876.        459.
      2 setosa             250.        171.
      3 versicolor         297.        138.
      4 virginica          329.        149.

---

    Code
      subtotal_row(df_dia, ggplot2::diamonds, vars = "price", aggregator = "mean",
      exclude = 1)
    Output
      # A tibble: 316 x 4
      # Groups:   cut, color, clarity [316]
         cut   color clarity price
         <fct> <fct> <fct>   <dbl>
       1 Fair  Total Total   4359.
       2 Fair  D     Total   4291.
       3 Fair  D     I1      7383 
       4 Fair  D     SI2     4355.
       5 Fair  D     SI1     4273.
       6 Fair  D     VS2     4513.
       7 Fair  D     VS1     2921.
       8 Fair  D     VVS2    3607 
       9 Fair  D     VVS1    4473 
      10 Fair  D     IF      1620.
      # i 306 more rows

---

    Code
      subtotal_row(df_cars, mtcars, vars = "mpg", aggregator = "max", subtotal_label = "Grand Total",
        agg_parameter = list(na.rm = TRUE))
    Output
      # A tibble: 12 x 3
      # Groups:   cyl, gear [12]
         cyl         gear          mpg
         <fct>       <fct>       <dbl>
       1 Grand Total Grand Total  33.9
       2 4           Grand Total  33.9
       3 4           3            21.5
       4 4           4            33.9
       5 4           5            30.4
       6 6           Grand Total  21.4
       7 6           3            21.4
       8 6           4            21  
       9 6           5            19.7
      10 8           Grand Total  19.2
      11 8           3            19.2
      12 8           5            15.8

---

    Code
      subtotal_row(df_na, airquality, vars = "Ozone")
    Condition
      Warning in `subtotal_row()`:
      NA values detected in output. Setting agg_parameter to "na.rm" may resolve this.
    Output
      # A tibble: 6 x 2
      # Groups:   Month [6]
        Month Ozone
        <fct> <dbl>
      1 Total  NA  
      2 5      23.6
      3 6      29.4
      4 7      59.1
      5 8      60.0
      6 9      31.4

---

    Code
      subtotal_row(df_complex, mtcars, vars = c("mpg", "disp"), aggregator = "median",
      exclude = c(2, 3))
    Output
      # A tibble: 13 x 5
      # Groups:   cyl, gear, carb [13]
         cyl   gear  carb    mpg  disp
         <fct> <fct> <fct> <dbl> <dbl>
       1 Total Total Total  19.2 196. 
       2 4     3     1      21.5 120. 
       3 4     4     1      29.8  78.8
       4 4     4     2      23.6 131. 
       5 4     5     2      28.2 108. 
       6 6     3     1      19.8 242. 
       7 6     4     4      20.1 164. 
       8 6     5     6      19.7 145  
       9 8     3     2      17.1 339  
      10 8     3     3      16.4 276. 
      11 8     3     4      13.3 440  
      12 8     5     4      15.8 351  
      13 8     5     8      15   301  

---

    Code
      subtotal_row(df_breaks, warpbreaks, vars = "breaks", aggregator = "sd")
    Output
      # A tibble: 9 x 3
      # Groups:   wool, tension [9]
        wool  tension breaks
        <fct> <fct>    <dbl>
      1 Total Total    13.2 
      2 A     Total    15.9 
      3 A     L        18.1 
      4 A     M         8.66
      5 A     H        10.3 
      6 B     Total     9.30
      7 B     L         9.86
      8 B     M         9.43
      9 B     H         4.89

---

    Code
      subtotal_row(df_dates, data.frame(report_date = as.Date(c("2026-07-01",
        "2026-07-01", "2026-08-01", "2026-08-01")), is_active = c(TRUE, TRUE, FALSE,
        TRUE), revenue = c(100, 200, 150, 300)), vars = "revenue")
    Output
      # A tibble: 6 x 3
      # Groups:   report_date, is_active [6]
        report_date is_active revenue
        <fct>       <fct>       <dbl>
      1 Total       Total         750
      2 2026-07-01  Total         300
      3 2026-07-01  TRUE          300
      4 2026-08-01  Total         450
      5 2026-08-01  FALSE         150
      6 2026-08-01  TRUE          300

---

    Code
      subtotal_row(df_weird_groups, data.frame(category = c("A", "A", NA, "B"),
      value = c(10, 15, 20, 25)), vars = "value")
    Output
      # A tibble: 4 x 2
      # Groups:   category [4]
        category value
        <fct>    <dbl>
      1 Total       70
      2 A           25
      3 B           25
      4 <NA>        20

# Snapshot: High cardinality, multiple variables, default aggregator

    Code
      as.data.frame(out)
    Output
             region store_id category      sales    profit
      1       Total    Total    Total 5020833.09 502176.26
      2    Region_1    Total    Total  994863.18 100430.84
      3    Region_1  Store_1    Total   16471.71   1788.90
      4    Region_1  Store_1        A    4436.84    312.89
      5    Region_1  Store_1        B     738.26     80.67
      6    Region_1  Store_1        C     621.44    181.42
      7    Region_1  Store_1        D    1106.61     77.55
      8    Region_1  Store_1        E    1811.71    249.61
      9    Region_1  Store_1        F     840.92     31.98
      10   Region_1  Store_1        G    2558.41    260.23
      11   Region_1  Store_1        H     948.59    290.47
      12   Region_1  Store_1        I    1299.94     97.52
      13   Region_1  Store_1        J    2108.99    206.56
      14   Region_1 Store_10    Total   24460.17   2602.37
      15   Region_1 Store_10        A    2588.44    401.84
      16   Region_1 Store_10        B    2250.00    324.87
      17   Region_1 Store_10        C    5131.09    404.29
      18   Region_1 Store_10        D     182.62    116.11
      19   Region_1 Store_10        E    2551.14    237.12
      20   Region_1 Store_10        F    2104.68    204.86
      21   Region_1 Store_10        G    2808.11    241.59
      22   Region_1 Store_10        H    2793.10    210.11
      23   Region_1 Store_10        I    2104.89    188.42
      24   Region_1 Store_10        J    1946.10    273.16
      25   Region_1 Store_11    Total   17145.76   1783.43
      26   Region_1 Store_11        A    1373.57    258.41
      27   Region_1 Store_11        B      43.76     35.82
      28   Region_1 Store_11        C     936.02    137.67
      29   Region_1 Store_11        D    2103.96    220.61
      30   Region_1 Store_11        E    1700.39    196.41
      31   Region_1 Store_11        F    2096.39    234.31
      32   Region_1 Store_11        G    3877.20    295.40
      33   Region_1 Store_11        H    1628.00     93.40
      34   Region_1 Store_11        I    2412.16    199.12
      35   Region_1 Store_11        J     974.31    112.28
      36   Region_1 Store_12    Total   14373.55   1441.41
      37   Region_1 Store_12        A     848.38     74.89
      38   Region_1 Store_12        B    1590.61     28.80
      39   Region_1 Store_12        C    1065.18     86.24
      40   Region_1 Store_12        E    2609.55    307.86
      41   Region_1 Store_12        F     820.79    107.57
      42   Region_1 Store_12        G    2297.95    227.20
      43   Region_1 Store_12        H    1460.53     75.60
      44   Region_1 Store_12        I    1701.99    249.88
      45   Region_1 Store_12        J    1978.57    283.37
      46   Region_1 Store_13    Total   22708.94   2328.06
      47   Region_1 Store_13        A    3648.88    380.22
      48   Region_1 Store_13        B    2779.47    247.03
      49   Region_1 Store_13        C    2587.52    280.14
      50   Region_1 Store_13        D    1507.03    101.38
      51   Region_1 Store_13        E    1752.58    243.96
      52   Region_1 Store_13        F    1432.52    150.65
      53   Region_1 Store_13        G    5840.18    578.30
      54   Region_1 Store_13        H    2196.65    228.83
      55   Region_1 Store_13        J     964.11    117.55
      56   Region_1 Store_14    Total   16695.21   1589.06
      57   Region_1 Store_14        A     650.93     97.03
      58   Region_1 Store_14        B    4054.89    312.91
      59   Region_1 Store_14        C    1049.82    171.74
      60   Region_1 Store_14        D    2179.96    106.78
      61   Region_1 Store_14        E     277.28     30.91
      62   Region_1 Store_14        F    1999.54    156.16
      63   Region_1 Store_14        G    1505.84    131.85
      64   Region_1 Store_14        H     836.81    114.41
      65   Region_1 Store_14        I    1367.81    216.03
      66   Region_1 Store_14        J    2772.33    251.24
      67   Region_1 Store_15    Total   25571.90   2049.30
      68   Region_1 Store_15        A    2803.09    210.48
      69   Region_1 Store_15        B     120.67     39.52
      70   Region_1 Store_15        C    3498.90    176.78
      71   Region_1 Store_15        D    1763.58    254.66
      72   Region_1 Store_15        E    1989.07    108.40
      73   Region_1 Store_15        F    2975.93    201.72
      74   Region_1 Store_15        G    2367.72     92.91
      75   Region_1 Store_15        H    4310.02    474.26
      76   Region_1 Store_15        I    3186.23    254.68
      77   Region_1 Store_15        J    2556.69    235.89
      78   Region_1 Store_16    Total   22049.18   2334.04
      79   Region_1 Store_16        A    1118.80     97.98
      80   Region_1 Store_16        B    2718.33    257.93
      81   Region_1 Store_16        C    3056.71    340.85
      82   Region_1 Store_16        D    2146.88    266.52
      83   Region_1 Store_16        E    3278.44    343.00
      84   Region_1 Store_16        F    3399.12    384.34
      85   Region_1 Store_16        G    1774.81    125.67
      86   Region_1 Store_16        H    1612.77    176.74
      87   Region_1 Store_16        I    2192.90    225.27
      88   Region_1 Store_16        J     750.42    115.74
      89   Region_1 Store_17    Total   19439.02   2084.60
      90   Region_1 Store_17        A     856.14    163.97
      91   Region_1 Store_17        B    2487.46    327.90
      92   Region_1 Store_17        C    1420.02    253.57
      93   Region_1 Store_17        D    3024.62    311.70
      94   Region_1 Store_17        E    2098.12    205.03
      95   Region_1 Store_17        F    1758.51    198.62
      96   Region_1 Store_17        G     801.16     21.49
      97   Region_1 Store_17        H    1655.88    201.78
      98   Region_1 Store_17        I    3128.73    212.47
      99   Region_1 Store_17        J    2208.38    188.07
      100  Region_1 Store_18    Total   21998.46   2262.64
      101  Region_1 Store_18        A    2423.85    324.31
      102  Region_1 Store_18        B    2298.90    326.16
      103  Region_1 Store_18        C    4208.74    377.65
      104  Region_1 Store_18        D    1551.75    166.10
      105  Region_1 Store_18        E    2540.81    212.47
      106  Region_1 Store_18        F    2479.26    124.13
      107  Region_1 Store_18        G     649.88    189.88
      108  Region_1 Store_18        H    1896.41    191.46
      109  Region_1 Store_18        I     739.25     57.86
      110  Region_1 Store_18        J    3209.61    292.62
      111  Region_1 Store_19    Total   19369.46   2069.86
      112  Region_1 Store_19        A    3022.42     81.28
      113  Region_1 Store_19        B    2804.99    156.01
      114  Region_1 Store_19        C     655.29    120.23
      115  Region_1 Store_19        D    2082.68    181.26
      116  Region_1 Store_19        E    1791.99    220.51
      117  Region_1 Store_19        F    1650.50    126.84
      118  Region_1 Store_19        G    1395.58    283.75
      119  Region_1 Store_19        H    2229.61    381.51
      120  Region_1 Store_19        I    1307.78    128.03
      121  Region_1 Store_19        J    2428.62    390.44
      122  Region_1  Store_2    Total   16375.35   1663.60
      123  Region_1  Store_2        A     426.59     67.39
      124  Region_1  Store_2        B    2652.46    161.28
      125  Region_1  Store_2        C    1805.02    214.79
      126  Region_1  Store_2        D    3198.07    214.80
      127  Region_1  Store_2        E    2799.48    197.10
      128  Region_1  Store_2        F    3077.03    347.81
      129  Region_1  Store_2        G     663.44    134.69
      130  Region_1  Store_2        H     208.47    124.25
      131  Region_1  Store_2        I    1254.63    130.92
      132  Region_1  Store_2        J     290.16     70.57
      133  Region_1 Store_20    Total   20213.15   1838.45
      134  Region_1 Store_20        A    2682.60    249.59
      135  Region_1 Store_20        B    2440.99    141.38
      136  Region_1 Store_20        C    1800.21    155.62
      137  Region_1 Store_20        D    2399.14    260.55
      138  Region_1 Store_20        E    1306.69    216.37
      139  Region_1 Store_20        F    1259.06    150.83
      140  Region_1 Store_20        G    2470.00    197.30
      141  Region_1 Store_20        H     504.13     54.57
      142  Region_1 Store_20        I    2349.09    178.24
      143  Region_1 Store_20        J    3001.24    234.00
      144  Region_1 Store_21    Total   19101.95   2189.04
      145  Region_1 Store_21        A     797.62    105.86
      146  Region_1 Store_21        B    1119.50     87.59
      147  Region_1 Store_21        C    2242.25    330.27
      148  Region_1 Store_21        D    2709.16    391.88
      149  Region_1 Store_21        E    3762.47    360.34
      150  Region_1 Store_21        F    2158.87    259.88
      151  Region_1 Store_21        G     647.47    131.79
      152  Region_1 Store_21        H    1032.60    170.17
      153  Region_1 Store_21        I    3577.34    267.11
      154  Region_1 Store_21        J    1054.67     84.15
      155  Region_1 Store_22    Total   11811.25   1216.59
      156  Region_1 Store_22        A    2227.38    109.04
      157  Region_1 Store_22        B     388.20     35.11
      158  Region_1 Store_22        C     759.04    227.67
      159  Region_1 Store_22        D    1280.38    109.02
      160  Region_1 Store_22        E    1492.24    200.88
      161  Region_1 Store_22        F    1609.20    116.12
      162  Region_1 Store_22        H     467.31     57.94
      163  Region_1 Store_22        I    3002.92    232.38
      164  Region_1 Store_22        J     584.58    128.43
      165  Region_1 Store_23    Total   16086.21   1846.32
      166  Region_1 Store_23        A    1971.32    235.24
      167  Region_1 Store_23        B     851.28    145.51
      168  Region_1 Store_23        C    1504.61    167.35
      169  Region_1 Store_23        D    1505.57    119.48
      170  Region_1 Store_23        E     169.90     87.25
      171  Region_1 Store_23        F    5060.49    357.93
      172  Region_1 Store_23        G     855.67    102.63
      173  Region_1 Store_23        H    2663.07    451.98
      174  Region_1 Store_23        J    1504.30    178.95
      175  Region_1 Store_24    Total   22948.03   2273.19
      176  Region_1 Store_24        A    2089.75    288.44
      177  Region_1 Store_24        B    5505.98    513.83
      178  Region_1 Store_24        C    1722.15    131.07
      179  Region_1 Store_24        D     658.10    101.12
      180  Region_1 Store_24        E    2961.80    267.19
      181  Region_1 Store_24        F    1623.12    122.02
      182  Region_1 Store_24        G    2807.64    225.53
      183  Region_1 Store_24        H    2741.85    405.50
      184  Region_1 Store_24        I    2664.03    175.50
      185  Region_1 Store_24        J     173.61     42.99
      186  Region_1 Store_25    Total   17593.06   2165.49
      187  Region_1 Store_25        A    3129.83    389.66
      188  Region_1 Store_25        B      96.46     56.54
      189  Region_1 Store_25        C    1299.96    166.53
      190  Region_1 Store_25        D    1119.02    159.81
      191  Region_1 Store_25        E    3912.25    340.34
      192  Region_1 Store_25        F    2005.93    168.60
      193  Region_1 Store_25        G    2027.92    273.72
      194  Region_1 Store_25        H     781.26    144.42
      195  Region_1 Store_25        I    2905.42    394.58
      196  Region_1 Store_25        J     315.01     71.29
      197  Region_1 Store_26    Total   22775.88   1960.61
      198  Region_1 Store_26        A    3157.95    201.08
      199  Region_1 Store_26        B    3070.71    268.64
      200  Region_1 Store_26        C    1113.12    108.76
      201  Region_1 Store_26        D     969.90     89.50
      202  Region_1 Store_26        E    3667.87    477.11
      203  Region_1 Store_26        F    2589.99    171.32
      204  Region_1 Store_26        G    1542.68    133.13
      205  Region_1 Store_26        H    2016.57    187.81
      206  Region_1 Store_26        I    2373.86    206.15
      207  Region_1 Store_26        J    2273.23    117.11
      208  Region_1 Store_27    Total   16783.46   1788.57
      209  Region_1 Store_27        A    2872.81    288.45
      210  Region_1 Store_27        B     942.39     25.14
      211  Region_1 Store_27        C    4371.54    458.31
      212  Region_1 Store_27        D      70.37     21.62
      213  Region_1 Store_27        E     994.16    120.25
      214  Region_1 Store_27        F    3445.92    338.71
      215  Region_1 Store_27        G    2415.61    272.15
      216  Region_1 Store_27        H     171.19     49.41
      217  Region_1 Store_27        I      29.47     43.08
      218  Region_1 Store_27        J    1470.00    171.45
      219  Region_1 Store_28    Total   23542.49   2129.54
      220  Region_1 Store_28        A    1618.48    197.83
      221  Region_1 Store_28        B      66.85     54.91
      222  Region_1 Store_28        C    3160.12    212.55
      223  Region_1 Store_28        D    1789.69     72.16
      224  Region_1 Store_28        E    4592.39    447.49
      225  Region_1 Store_28        F     686.04     58.89
      226  Region_1 Store_28        G    2726.95    221.58
      227  Region_1 Store_28        H    1368.99    254.17
      228  Region_1 Store_28        I    3417.24    287.07
      229  Region_1 Store_28        J    4115.74    322.89
      230  Region_1 Store_29    Total   17831.62   1870.71
      231  Region_1 Store_29        A    2669.50    169.94
      232  Region_1 Store_29        B     394.66     34.39
      233  Region_1 Store_29        C     737.79    168.47
      234  Region_1 Store_29        D    2985.79    261.65
      235  Region_1 Store_29        E    3175.27    339.61
      236  Region_1 Store_29        F    1585.17    196.20
      237  Region_1 Store_29        G    1422.65    169.30
      238  Region_1 Store_29        H    1919.46    235.29
      239  Region_1 Store_29        J    2941.33    295.86
      240  Region_1  Store_3    Total   19252.98   2131.14
      241  Region_1  Store_3        A    1632.94    197.50
      242  Region_1  Store_3        B     835.65     73.99
      243  Region_1  Store_3        C    1973.76    179.41
      244  Region_1  Store_3        D     419.54     47.81
      245  Region_1  Store_3        E    2387.54    270.41
      246  Region_1  Store_3        F    1867.02    260.95
      247  Region_1  Store_3        G    2309.65    344.50
      248  Region_1  Store_3        H    4231.23    324.18
      249  Region_1  Store_3        I    1779.48    237.97
      250  Region_1  Store_3        J    1816.17    194.42
      251  Region_1 Store_30    Total   19778.03   2005.46
      252  Region_1 Store_30        A    1975.25    157.03
      253  Region_1 Store_30        B    1860.73    250.97
      254  Region_1 Store_30        C    3777.78    290.56
      255  Region_1 Store_30        D    1200.15     67.30
      256  Region_1 Store_30        E    1830.30    145.77
      257  Region_1 Store_30        F    1960.18    220.29
      258  Region_1 Store_30        G     657.68    127.49
      259  Region_1 Store_30        H    2548.78    185.69
      260  Region_1 Store_30        I    1472.01    197.82
      261  Region_1 Store_30        J    2495.17    362.54
      262  Region_1 Store_31    Total   21632.84   1998.07
      263  Region_1 Store_31        A    3059.29    262.02
      264  Region_1 Store_31        B    3043.66    280.19
      265  Region_1 Store_31        C     759.81    178.54
      266  Region_1 Store_31        D    1663.51    268.53
      267  Region_1 Store_31        E    3462.70    245.15
      268  Region_1 Store_31        F      95.05     62.44
      269  Region_1 Store_31        G    1249.22     93.13
      270  Region_1 Store_31        H    2656.37    183.90
      271  Region_1 Store_31        I    4906.58    378.91
      272  Region_1 Store_31        J     736.65     45.26
      273  Region_1 Store_32    Total   20140.45   2365.58
      274  Region_1 Store_32        A    3308.40    381.76
      275  Region_1 Store_32        B     681.27     96.16
      276  Region_1 Store_32        C    1146.18    181.93
      277  Region_1 Store_32        D    4209.09    349.92
      278  Region_1 Store_32        E    1710.47     86.66
      279  Region_1 Store_32        F    1181.43    116.68
      280  Region_1 Store_32        G    1512.43    133.88
      281  Region_1 Store_32        H    3828.74    544.79
      282  Region_1 Store_32        I    1871.94    197.99
      283  Region_1 Store_32        J     690.50    275.81
      284  Region_1 Store_33    Total   22959.03   2227.77
      285  Region_1 Store_33        A    2973.53    268.50
      286  Region_1 Store_33        B    2329.05    206.02
      287  Region_1 Store_33        C    4098.02    276.67
      288  Region_1 Store_33        D    1032.79    131.73
      289  Region_1 Store_33        E    1926.61    129.36
      290  Region_1 Store_33        F    1894.16     92.99
      291  Region_1 Store_33        G    3893.00    353.35
      292  Region_1 Store_33        H     918.46    129.92
      293  Region_1 Store_33        I    1444.33    343.56
      294  Region_1 Store_33        J    2449.08    295.67
      295  Region_1 Store_34    Total   21443.80   2154.08
      296  Region_1 Store_34        A    3556.97    409.15
      297  Region_1 Store_34        B    1931.56    203.17
      298  Region_1 Store_34        C     612.14     66.19
      299  Region_1 Store_34        D    2956.15    284.42
      300  Region_1 Store_34        E    1465.69    186.98
      301  Region_1 Store_34        F    3114.00    386.31
      302  Region_1 Store_34        G    2725.56    271.56
      303  Region_1 Store_34        H     816.05     57.64
      304  Region_1 Store_34        I    2514.73    202.92
      305  Region_1 Store_34        J    1750.95     85.74
      306  Region_1 Store_35    Total   17779.60   1922.91
      307  Region_1 Store_35        A    2192.50    248.62
      308  Region_1 Store_35        B    1422.29    252.77
      309  Region_1 Store_35        C    1624.55    251.84
      310  Region_1 Store_35        D    2378.02    348.42
      311  Region_1 Store_35        E    2444.75    139.11
      312  Region_1 Store_35        F    2048.42    139.49
      313  Region_1 Store_35        G    2025.33    147.96
      314  Region_1 Store_35        H    1395.00    178.97
      315  Region_1 Store_35        I    1447.63    104.45
      316  Region_1 Store_35        J     801.11    111.28
      317  Region_1 Store_36    Total   21079.27   1916.71
      318  Region_1 Store_36        A    2138.10    323.56
      319  Region_1 Store_36        B    1661.28    152.40
      320  Region_1 Store_36        C    1724.72    129.63
      321  Region_1 Store_36        D    2219.57    149.67
      322  Region_1 Store_36        E    2166.27    241.05
      323  Region_1 Store_36        F    1008.34    128.08
      324  Region_1 Store_36        G    1078.54     75.92
      325  Region_1 Store_36        H    2971.71    280.15
      326  Region_1 Store_36        I    4594.70    303.15
      327  Region_1 Store_36        J    1516.04    133.10
      328  Region_1 Store_37    Total   17838.35   2097.81
      329  Region_1 Store_37        A    4161.47    442.85
      330  Region_1 Store_37        B     598.97    184.70
      331  Region_1 Store_37        C    2321.30     68.03
      332  Region_1 Store_37        D     379.46    190.58
      333  Region_1 Store_37        E    3208.72    340.85
      334  Region_1 Store_37        F    3053.90    302.62
      335  Region_1 Store_37        G    2539.91    278.74
      336  Region_1 Store_37        H     172.09     62.75
      337  Region_1 Store_37        I     685.15     62.44
      338  Region_1 Store_37        J     717.38    164.25
      339  Region_1 Store_38    Total   14678.55   1458.44
      340  Region_1 Store_38        A    1852.37    156.05
      341  Region_1 Store_38        B    1284.87     61.78
      342  Region_1 Store_38        C    2316.93    181.31
      343  Region_1 Store_38        D    2182.09    220.74
      344  Region_1 Store_38        E     727.59     88.63
      345  Region_1 Store_38        F     654.17     74.91
      346  Region_1 Store_38        G     884.57    136.65
      347  Region_1 Store_38        H     935.25    196.94
      348  Region_1 Store_38        I    1499.33    101.61
      349  Region_1 Store_38        J    2341.38    239.82
      350  Region_1 Store_39    Total   19277.09   1916.09
      351  Region_1 Store_39        A    3699.07    347.85
      352  Region_1 Store_39        B    2189.84    225.20
      353  Region_1 Store_39        C     384.40     37.67
      354  Region_1 Store_39        D    1322.21     98.61
      355  Region_1 Store_39        E    2590.07    313.78
      356  Region_1 Store_39        F    1399.99    131.65
      357  Region_1 Store_39        G    3074.97    358.94
      358  Region_1 Store_39        H    2024.68    249.02
      359  Region_1 Store_39        I     257.86     33.95
      360  Region_1 Store_39        J    2334.00    119.42
      361  Region_1  Store_4    Total   15228.48   1426.57
      362  Region_1  Store_4        A     845.09     43.81
      363  Region_1  Store_4        B     664.21    107.90
      364  Region_1  Store_4        C    1490.06    181.33
      365  Region_1  Store_4        D    1198.98     84.62
      366  Region_1  Store_4        E    3262.71    303.26
      367  Region_1  Store_4        F    3236.00    253.03
      368  Region_1  Store_4        G    1042.85    123.35
      369  Region_1  Store_4        H    1051.31     79.84
      370  Region_1  Store_4        I    1373.55    124.56
      371  Region_1  Store_4        J    1063.72    124.87
      372  Region_1 Store_40    Total   24758.09   2302.20
      373  Region_1 Store_40        A    1184.11    205.19
      374  Region_1 Store_40        B    3657.48    319.32
      375  Region_1 Store_40        C    2714.36    224.80
      376  Region_1 Store_40        D    2891.53    266.95
      377  Region_1 Store_40        E    1175.73    171.31
      378  Region_1 Store_40        F    1431.22     72.57
      379  Region_1 Store_40        G    2744.90    195.63
      380  Region_1 Store_40        H    4653.45    436.18
      381  Region_1 Store_40        I    2222.24    198.84
      382  Region_1 Store_40        J    2083.07    211.41
      383  Region_1 Store_41    Total   21447.51   2147.05
      384  Region_1 Store_41        A    1403.21    183.75
      385  Region_1 Store_41        B    1854.49    102.62
      386  Region_1 Store_41        C    1836.44    112.06
      387  Region_1 Store_41        D    3853.42    373.95
      388  Region_1 Store_41        E    1154.89    185.11
      389  Region_1 Store_41        F    5256.49    491.03
      390  Region_1 Store_41        G     950.60    105.47
      391  Region_1 Store_41        H    1928.50    230.44
      392  Region_1 Store_41        I     580.28    148.86
      393  Region_1 Store_41        J    2629.19    213.76
      394  Region_1 Store_42    Total   23954.95   2516.12
      395  Region_1 Store_42        A    1307.34    238.81
      396  Region_1 Store_42        B    2864.08    230.63
      397  Region_1 Store_42        C    3869.02    494.45
      398  Region_1 Store_42        D    2491.61    275.04
      399  Region_1 Store_42        E    1298.68     83.71
      400  Region_1 Store_42        F     836.52    162.60
      401  Region_1 Store_42        G    4342.45    409.36
      402  Region_1 Store_42        H    3523.78    333.72
      403  Region_1 Store_42        I     942.48     56.45
      404  Region_1 Store_42        J    2478.99    231.35
      405  Region_1 Store_43    Total   26798.00   2872.72
      406  Region_1 Store_43        A    1938.19    132.95
      407  Region_1 Store_43        B    2015.16    217.92
      408  Region_1 Store_43        C    5796.77    688.33
      409  Region_1 Store_43        D     943.70    137.97
      410  Region_1 Store_43        E    3496.00    248.48
      411  Region_1 Store_43        F    2746.74    265.87
      412  Region_1 Store_43        G     307.54     70.10
      413  Region_1 Store_43        H    2793.22    338.14
      414  Region_1 Store_43        I    3198.05    354.73
      415  Region_1 Store_43        J    3562.63    418.23
      416  Region_1 Store_44    Total   24887.50   2242.19
      417  Region_1 Store_44        A    3795.46    347.19
      418  Region_1 Store_44        B    4667.35    289.80
      419  Region_1 Store_44        C    3153.34    301.45
      420  Region_1 Store_44        D    1547.92    159.38
      421  Region_1 Store_44        E     474.21     54.53
      422  Region_1 Store_44        F    2427.12    132.21
      423  Region_1 Store_44        G    2573.97    219.46
      424  Region_1 Store_44        H    3121.26    289.46
      425  Region_1 Store_44        I    2036.38    237.91
      426  Region_1 Store_44        J    1090.49    210.80
      427  Region_1 Store_45    Total   22725.40   1974.21
      428  Region_1 Store_45        A     119.27     53.64
      429  Region_1 Store_45        B    2253.93    194.93
      430  Region_1 Store_45        C    3439.32    404.65
      431  Region_1 Store_45        D    1257.48    166.61
      432  Region_1 Store_45        E    2342.85    161.27
      433  Region_1 Store_45        F    4249.21    323.80
      434  Region_1 Store_45        G    2251.99    176.14
      435  Region_1 Store_45        H    2088.03    160.70
      436  Region_1 Store_45        I    3259.40    138.18
      437  Region_1 Store_45        J    1463.92    194.29
      438  Region_1 Store_46    Total   17529.19   1623.50
      439  Region_1 Store_46        A    1252.01    105.99
      440  Region_1 Store_46        B    1360.33    126.94
      441  Region_1 Store_46        C    2613.19    274.97
      442  Region_1 Store_46        D     225.39     46.87
      443  Region_1 Store_46        E    5468.62    485.01
      444  Region_1 Store_46        F     857.99     94.39
      445  Region_1 Store_46        G    1169.74    120.60
      446  Region_1 Store_46        H    1518.86    150.72
      447  Region_1 Store_46        I    1706.08    130.69
      448  Region_1 Store_46        J    1356.98     87.32
      449  Region_1 Store_47    Total   15700.86   1850.39
      450  Region_1 Store_47        A     773.21    165.31
      451  Region_1 Store_47        B    1020.54    293.09
      452  Region_1 Store_47        C    2756.39    231.85
      453  Region_1 Store_47        D     820.87     48.39
      454  Region_1 Store_47        E    2119.75    198.31
      455  Region_1 Store_47        F     272.73     65.42
      456  Region_1 Store_47        G    2013.41    247.91
      457  Region_1 Store_47        H    1685.99    141.62
      458  Region_1 Store_47        I    2763.18    274.38
      459  Region_1 Store_47        J    1474.79    184.11
      460  Region_1 Store_48    Total   15758.87   1752.94
      461  Region_1 Store_48        B    2918.83    403.21
      462  Region_1 Store_48        C    2433.59    324.09
      463  Region_1 Store_48        D    1080.84    108.73
      464  Region_1 Store_48        E    2090.51    266.11
      465  Region_1 Store_48        F    1782.57    220.60
      466  Region_1 Store_48        G    1661.50    141.34
      467  Region_1 Store_48        H     123.40     38.99
      468  Region_1 Store_48        I    1754.91     70.40
      469  Region_1 Store_48        J    1912.72    179.47
      470  Region_1 Store_49    Total   19879.34   2030.56
      471  Region_1 Store_49        A    2345.80    263.13
      472  Region_1 Store_49        B    1331.82    201.88
      473  Region_1 Store_49        C    1804.86    226.67
      474  Region_1 Store_49        D    2879.70    315.49
      475  Region_1 Store_49        E    1619.57     28.99
      476  Region_1 Store_49        F     745.36     34.11
      477  Region_1 Store_49        G    4291.93    417.25
      478  Region_1 Store_49        H    2998.84    222.70
      479  Region_1 Store_49        I    1813.68    221.10
      480  Region_1 Store_49        J      47.78     99.24
      481  Region_1  Store_5    Total   24420.48   2353.31
      482  Region_1  Store_5        A     612.55     72.02
      483  Region_1  Store_5        B    3504.32    515.05
      484  Region_1  Store_5        C    1429.81    139.33
      485  Region_1  Store_5        D    5648.20    458.51
      486  Region_1  Store_5        E    1375.57    109.94
      487  Region_1  Store_5        F     644.46     93.89
      488  Region_1  Store_5        G    1949.69    177.73
      489  Region_1  Store_5        H    4862.80    338.71
      490  Region_1  Store_5        I    2225.56    320.37
      491  Region_1  Store_5        J    2167.52    127.76
      492  Region_1 Store_50    Total   21524.56   2098.06
      493  Region_1 Store_50        A    1614.47    212.45
      494  Region_1 Store_50        B    1661.08    162.44
      495  Region_1 Store_50        C    2857.86    319.60
      496  Region_1 Store_50        D    1681.12    193.04
      497  Region_1 Store_50        E    2257.26    204.75
      498  Region_1 Store_50        F    3288.10    334.09
      499  Region_1 Store_50        G    2266.35    210.30
      500  Region_1 Store_50        H    1409.54    200.28
      501  Region_1 Store_50        I    1487.00     98.13
      502  Region_1 Store_50        J    3001.78    162.98
      503  Region_1  Store_6    Total   17610.40   1744.50
      504  Region_1  Store_6        A     175.87     -6.44
      505  Region_1  Store_6        B     969.08    219.24
      506  Region_1  Store_6        C    2103.70    264.39
      507  Region_1  Store_6        D    2726.30    265.13
      508  Region_1  Store_6        E    1684.58    119.71
      509  Region_1  Store_6        F    2192.96    161.23
      510  Region_1  Store_6        G    1640.32    196.51
      511  Region_1  Store_6        H    2515.12    192.38
      512  Region_1  Store_6        I    1131.85    218.74
      513  Region_1  Store_6        J    2470.62    113.61
      514  Region_1  Store_7    Total   17994.48   1967.46
      515  Region_1  Store_7        A    1764.27     84.46
      516  Region_1  Store_7        B    1770.49    286.53
      517  Region_1  Store_7        C    2118.69    198.66
      518  Region_1  Store_7        D    1272.22    204.47
      519  Region_1  Store_7        E    2030.76    222.65
      520  Region_1  Store_7        F     965.97    156.20
      521  Region_1  Store_7        G    1986.07    264.47
      522  Region_1  Store_7        H    1688.07     76.82
      523  Region_1  Store_7        I    2592.25    165.67
      524  Region_1  Store_7        J    1805.69    307.53
      525  Region_1  Store_8    Total   21508.74   2017.19
      526  Region_1  Store_8        A    2493.61    167.71
      527  Region_1  Store_8        C    1739.72     95.04
      528  Region_1  Store_8        D    3228.03    379.71
      529  Region_1  Store_8        E    3134.01    247.91
      530  Region_1  Store_8        F    2507.08    218.45
      531  Region_1  Store_8        G    3104.81    216.64
      532  Region_1  Store_8        H    1222.19    243.94
      533  Region_1  Store_8        I    3301.50    342.45
      534  Region_1  Store_8        J     777.79    105.34
      535  Region_1  Store_9    Total   21930.53   2042.03
      536  Region_1  Store_9        A    1619.19    191.38
      537  Region_1  Store_9        B    1318.51    208.85
      538  Region_1  Store_9        C    1490.85    101.91
      539  Region_1  Store_9        D    3864.34    405.49
      540  Region_1  Store_9        E    1362.05    143.79
      541  Region_1  Store_9        F    1402.54    124.91
      542  Region_1  Store_9        G    3534.09    265.56
      543  Region_1  Store_9        H    2381.45    227.80
      544  Region_1  Store_9        I    4742.65    326.88
      545  Region_1  Store_9        J     214.86     45.46
      546  Region_2    Total    Total 1012103.39 102412.14
      547  Region_2  Store_1    Total   19929.55   2118.97
      548  Region_2  Store_1        A    1609.70    247.43
      549  Region_2  Store_1        B    2999.45    407.69
      550  Region_2  Store_1        C    2940.68    198.30
      551  Region_2  Store_1        D    1498.64    175.89
      552  Region_2  Store_1        E    2666.10    126.91
      553  Region_2  Store_1        F    1002.84     85.12
      554  Region_2  Store_1        G    2002.67    244.24
      555  Region_2  Store_1        H    2820.51    227.67
      556  Region_2  Store_1        I    1355.76    244.21
      557  Region_2  Store_1        J    1033.20    161.51
      558  Region_2 Store_10    Total   15909.05   1614.55
      559  Region_2 Store_10        A     867.47    148.68
      560  Region_2 Store_10        B    2039.46    202.00
      561  Region_2 Store_10        C    1786.99    208.81
      562  Region_2 Store_10        D    1274.40     65.87
      563  Region_2 Store_10        E    1880.71    133.84
      564  Region_2 Store_10        F    1724.93    214.69
      565  Region_2 Store_10        G    1692.02    123.44
      566  Region_2 Store_10        H    1648.91    223.79
      567  Region_2 Store_10        I    1551.14    148.95
      568  Region_2 Store_10        J    1443.02    144.48
      569  Region_2 Store_11    Total   20382.79   2083.00
      570  Region_2 Store_11        A    1012.76    169.79
      571  Region_2 Store_11        B    1161.48    129.47
      572  Region_2 Store_11        C    4810.12    426.23
      573  Region_2 Store_11        D    1145.76    106.37
      574  Region_2 Store_11        E     638.98    132.69
      575  Region_2 Store_11        F    5560.33    537.14
      576  Region_2 Store_11        G    2897.89    260.49
      577  Region_2 Store_11        H    1076.52    104.25
      578  Region_2 Store_11        I     225.67     33.57
      579  Region_2 Store_11        J    1853.28    183.00
      580  Region_2 Store_12    Total   21715.10   2296.40
      581  Region_2 Store_12        A    1915.03    322.24
      582  Region_2 Store_12        B    4203.12    410.46
      583  Region_2 Store_12        C    3382.98    256.47
      584  Region_2 Store_12        D    2435.69    242.70
      585  Region_2 Store_12        E    2323.08    217.37
      586  Region_2 Store_12        F    1657.53    167.49
      587  Region_2 Store_12        G     509.12     58.10
      588  Region_2 Store_12        H    2392.01    308.75
      589  Region_2 Store_12        I    1097.91     74.97
      590  Region_2 Store_12        J    1798.63    237.85
      591  Region_2 Store_13    Total   25926.67   2493.92
      592  Region_2 Store_13        A    2126.17    211.71
      593  Region_2 Store_13        B    2232.60    104.28
      594  Region_2 Store_13        C    2376.80    262.77
      595  Region_2 Store_13        D    4004.23    335.16
      596  Region_2 Store_13        E    1413.84    179.07
      597  Region_2 Store_13        F    1673.78    179.19
      598  Region_2 Store_13        G    2716.52    261.96
      599  Region_2 Store_13        H    3069.51    387.49
      600  Region_2 Store_13        I    4822.85    399.84
      601  Region_2 Store_13        J    1490.37    172.45
      602  Region_2 Store_14    Total   24779.73   2559.72
      603  Region_2 Store_14        A    1235.98    245.56
      604  Region_2 Store_14        B    2314.36    226.84
      605  Region_2 Store_14        D    5607.76    521.02
      606  Region_2 Store_14        E    3023.12    226.84
      607  Region_2 Store_14        F    2174.21    123.02
      608  Region_2 Store_14        G    3888.56    538.41
      609  Region_2 Store_14        H    2380.50    237.60
      610  Region_2 Store_14        I    2436.57    248.61
      611  Region_2 Store_14        J    1718.67    191.82
      612  Region_2 Store_15    Total   23995.89   2204.15
      613  Region_2 Store_15        A    1121.01     97.80
      614  Region_2 Store_15        B    2152.58    114.17
      615  Region_2 Store_15        C    3187.79    261.24
      616  Region_2 Store_15        D    3340.03    382.28
      617  Region_2 Store_15        E    2458.81    132.67
      618  Region_2 Store_15        F    2482.40    113.49
      619  Region_2 Store_15        G    1347.98    219.58
      620  Region_2 Store_15        H    2890.46    243.73
      621  Region_2 Store_15        I    1900.40    194.98
      622  Region_2 Store_15        J    3114.43    444.21
      623  Region_2 Store_16    Total   16054.11   1862.15
      624  Region_2 Store_16        A    2982.19    377.02
      625  Region_2 Store_16        B    1973.06    171.11
      626  Region_2 Store_16        C     525.46    119.05
      627  Region_2 Store_16        D     938.18    115.26
      628  Region_2 Store_16        E    1720.57    268.19
      629  Region_2 Store_16        F    3017.39    202.11
      630  Region_2 Store_16        G     345.82     78.23
      631  Region_2 Store_16        H    1625.91    263.43
      632  Region_2 Store_16        I    1832.34    119.67
      633  Region_2 Store_16        J    1093.19    148.08
      634  Region_2 Store_17    Total   18287.28   1735.53
      635  Region_2 Store_17        A    2898.33    213.51
      636  Region_2 Store_17        B    2236.91    308.23
      637  Region_2 Store_17        C     788.63     54.24
      638  Region_2 Store_17        D    4241.67    306.23
      639  Region_2 Store_17        E    1936.51    152.76
      640  Region_2 Store_17        F     144.96     14.64
      641  Region_2 Store_17        G     766.87    133.53
      642  Region_2 Store_17        H    1715.37    141.85
      643  Region_2 Store_17        I    1348.15    199.54
      644  Region_2 Store_17        J    2209.88    211.00
      645  Region_2 Store_18    Total   19386.40   2038.59
      646  Region_2 Store_18        A    1817.42    157.16
      647  Region_2 Store_18        B    1967.67    133.61
      648  Region_2 Store_18        C     485.27     52.47
      649  Region_2 Store_18        D     862.91    160.46
      650  Region_2 Store_18        E    1722.34    144.03
      651  Region_2 Store_18        F    2030.85    187.54
      652  Region_2 Store_18        G    2420.15    254.14
      653  Region_2 Store_18        H    3302.29    412.65
      654  Region_2 Store_18        I    3069.76    275.41
      655  Region_2 Store_18        J    1707.74    261.12
      656  Region_2 Store_19    Total   13375.53   1411.75
      657  Region_2 Store_19        A     871.90     61.78
      658  Region_2 Store_19        B     655.72    145.53
      659  Region_2 Store_19        C    2020.93    306.58
      660  Region_2 Store_19        E    3986.54    264.02
      661  Region_2 Store_19        F    2019.51    150.28
      662  Region_2 Store_19        G     559.02     41.78
      663  Region_2 Store_19        H    2692.01    292.45
      664  Region_2 Store_19        I     440.00     75.71
      665  Region_2 Store_19        J     129.90     73.62
      666  Region_2  Store_2    Total   18227.22   1851.36
      667  Region_2  Store_2        A     933.22    163.55
      668  Region_2  Store_2        B    2400.13    407.51
      669  Region_2  Store_2        C    2054.83    149.25
      670  Region_2  Store_2        D    3727.45    251.32
      671  Region_2  Store_2        E    1794.71    227.76
      672  Region_2  Store_2        F     712.54     95.21
      673  Region_2  Store_2        G    1028.35     71.80
      674  Region_2  Store_2        H    1486.83    188.59
      675  Region_2  Store_2        I    2076.49    191.67
      676  Region_2  Store_2        J    2012.67    104.70
      677  Region_2 Store_20    Total   24940.42   2289.91
      678  Region_2 Store_20        A    4785.76    410.13
      679  Region_2 Store_20        B    1877.60    114.66
      680  Region_2 Store_20        C    2857.89    168.82
      681  Region_2 Store_20        D     986.91    110.49
      682  Region_2 Store_20        E     704.17    140.72
      683  Region_2 Store_20        F     777.79    151.25
      684  Region_2 Store_20        G    4239.49    252.52
      685  Region_2 Store_20        H     677.69    121.61
      686  Region_2 Store_20        I    4901.93    432.41
      687  Region_2 Store_20        J    3131.19    387.30
      688  Region_2 Store_21    Total   23207.23   2309.17
      689  Region_2 Store_21        A    4546.19    488.30
      690  Region_2 Store_21        B    2720.44    193.04
      691  Region_2 Store_21        C    2273.17    192.00
      692  Region_2 Store_21        D     365.47     41.96
      693  Region_2 Store_21        E    1619.07    123.49
      694  Region_2 Store_21        F    3787.49    444.71
      695  Region_2 Store_21        G    2559.32    189.29
      696  Region_2 Store_21        H    1352.84    319.07
      697  Region_2 Store_21        I    3067.05    305.64
      698  Region_2 Store_21        J     916.19     11.67
      699  Region_2 Store_22    Total   16022.42   1741.13
      700  Region_2 Store_22        A    1431.43    178.06
      701  Region_2 Store_22        B     598.53     51.74
      702  Region_2 Store_22        C    1437.78     99.47
      703  Region_2 Store_22        D    1337.61    189.00
      704  Region_2 Store_22        E    1501.85    255.62
      705  Region_2 Store_22        F    1221.09    185.89
      706  Region_2 Store_22        G    2854.32    320.06
      707  Region_2 Store_22        H     856.60    102.45
      708  Region_2 Store_22        I    3378.71    290.66
      709  Region_2 Store_22        J    1404.50     68.18
      710  Region_2 Store_23    Total   11662.95   1941.90
      711  Region_2 Store_23        A    1367.96    228.67
      712  Region_2 Store_23        B     351.27    176.11
      713  Region_2 Store_23        C     959.31    207.21
      714  Region_2 Store_23        D    1969.04    366.10
      715  Region_2 Store_23        E    1015.02    148.71
      716  Region_2 Store_23        F    2067.29    248.12
      717  Region_2 Store_23        G     597.96     36.89
      718  Region_2 Store_23        H    1733.44     77.54
      719  Region_2 Store_23        I     300.00    149.00
      720  Region_2 Store_23        J    1301.66    303.55
      721  Region_2 Store_24    Total   23733.43   1963.04
      722  Region_2 Store_24        A    2847.06    214.88
      723  Region_2 Store_24        B    4460.66    403.60
      724  Region_2 Store_24        D    2060.38    129.54
      725  Region_2 Store_24        E    3543.24    340.72
      726  Region_2 Store_24        F    1177.04    123.89
      727  Region_2 Store_24        G    2596.85    164.68
      728  Region_2 Store_24        H    2427.73    255.46
      729  Region_2 Store_24        I    4111.35    272.75
      730  Region_2 Store_24        J     509.12     57.52
      731  Region_2 Store_25    Total   17501.46   2058.27
      732  Region_2 Store_25        A      96.87     86.49
      733  Region_2 Store_25        B    2200.73    244.22
      734  Region_2 Store_25        C     971.55     82.39
      735  Region_2 Store_25        D    1339.23    167.49
      736  Region_2 Store_25        E    2685.00    223.90
      737  Region_2 Store_25        F    3234.67    390.93
      738  Region_2 Store_25        G    2235.29    288.81
      739  Region_2 Store_25        H    3418.40    378.83
      740  Region_2 Store_25        I     727.53     84.59
      741  Region_2 Store_25        J     592.19    110.62
      742  Region_2 Store_26    Total   23712.90   2101.26
      743  Region_2 Store_26        A    1941.53    153.37
      744  Region_2 Store_26        B    3440.56    317.61
      745  Region_2 Store_26        C    1650.74    170.84
      746  Region_2 Store_26        D    3434.87    348.19
      747  Region_2 Store_26        E     742.07    113.60
      748  Region_2 Store_26        F    2367.98    304.36
      749  Region_2 Store_26        G    3127.28    224.97
      750  Region_2 Store_26        H    2420.99    128.23
      751  Region_2 Store_26        I    4277.24    280.71
      752  Region_2 Store_26        J     309.64     59.38
      753  Region_2 Store_27    Total   21472.86   2186.78
      754  Region_2 Store_27        A     988.19     95.82
      755  Region_2 Store_27        B     811.10     51.19
      756  Region_2 Store_27        C     901.91    152.89
      757  Region_2 Store_27        D     679.02    132.23
      758  Region_2 Store_27        E    2713.52    308.33
      759  Region_2 Store_27        F    2963.23    264.55
      760  Region_2 Store_27        G    3840.65    316.55
      761  Region_2 Store_27        H    1764.67    131.73
      762  Region_2 Store_27        I    3244.49    443.60
      763  Region_2 Store_27        J    3566.08    289.89
      764  Region_2 Store_28    Total   17614.86   1760.81
      765  Region_2 Store_28        A    2871.30    231.24
      766  Region_2 Store_28        B    1883.64    189.75
      767  Region_2 Store_28        C    1370.12    133.63
      768  Region_2 Store_28        D     308.05     86.74
      769  Region_2 Store_28        E    3100.72    305.36
      770  Region_2 Store_28        F    1694.10    165.45
      771  Region_2 Store_28        G    2801.40    215.91
      772  Region_2 Store_28        H     708.64     55.95
      773  Region_2 Store_28        I     550.81    142.76
      774  Region_2 Store_28        J    2326.08    234.02
      775  Region_2 Store_29    Total   17484.83   1855.84
      776  Region_2 Store_29        A    1234.80    204.07
      777  Region_2 Store_29        B     763.36     25.99
      778  Region_2 Store_29        C    2999.79    384.17
      779  Region_2 Store_29        D    2529.89    274.11
      780  Region_2 Store_29        E    2170.88    161.37
      781  Region_2 Store_29        F    1145.04    146.53
      782  Region_2 Store_29        G    3057.97    254.77
      783  Region_2 Store_29        H     687.23    118.10
      784  Region_2 Store_29        I    1567.97    189.76
      785  Region_2 Store_29        J    1327.90     96.97
      786  Region_2  Store_3    Total   19085.44   1579.21
      787  Region_2  Store_3        A    4399.07    274.82
      788  Region_2  Store_3        B    2416.41    178.11
      789  Region_2  Store_3        C    1315.04    212.67
      790  Region_2  Store_3        D    2527.32    228.39
      791  Region_2  Store_3        E    2310.78    184.44
      792  Region_2  Store_3        F     604.96     62.72
      793  Region_2  Store_3        G    1988.67    136.00
      794  Region_2  Store_3        H     434.66     37.34
      795  Region_2  Store_3        I    3088.53    264.72
      796  Region_2 Store_30    Total   21085.00   2177.38
      797  Region_2 Store_30        A    2600.41    404.10
      798  Region_2 Store_30        B    1808.69    197.21
      799  Region_2 Store_30        C    2608.80    221.51
      800  Region_2 Store_30        D     747.13    140.26
      801  Region_2 Store_30        E     310.44     34.94
      802  Region_2 Store_30        F    1148.72    133.40
      803  Region_2 Store_30        G    4319.57    344.40
      804  Region_2 Store_30        H    4148.66    310.78
      805  Region_2 Store_30        I    2504.96    207.52
      806  Region_2 Store_30        J     887.62    183.26
      807  Region_2 Store_31    Total   24542.44   2324.30
      808  Region_2 Store_31        A     572.66     71.45
      809  Region_2 Store_31        B    2631.06    217.30
      810  Region_2 Store_31        C    3803.33    348.72
      811  Region_2 Store_31        D    5193.02    398.31
      812  Region_2 Store_31        E     786.67    125.33
      813  Region_2 Store_31        F    3672.48    346.65
      814  Region_2 Store_31        G    1334.27    138.67
      815  Region_2 Store_31        H    2451.35    291.49
      816  Region_2 Store_31        I     871.79    128.84
      817  Region_2 Store_31        J    3225.81    257.54
      818  Region_2 Store_32    Total   22671.58   2387.79
      819  Region_2 Store_32        A    1245.92    106.73
      820  Region_2 Store_32        B    1019.68    114.98
      821  Region_2 Store_32        C    3117.32    300.17
      822  Region_2 Store_32        D    2219.97    171.70
      823  Region_2 Store_32        E    2627.64    161.30
      824  Region_2 Store_32        F    2899.82    583.87
      825  Region_2 Store_32        G    2819.54    295.21
      826  Region_2 Store_32        H    1791.49    267.89
      827  Region_2 Store_32        I    2273.77    134.37
      828  Region_2 Store_32        J    2656.43    251.57
      829  Region_2 Store_33    Total   21337.16   1958.41
      830  Region_2 Store_33        A     664.54    170.40
      831  Region_2 Store_33        B     349.91     79.45
      832  Region_2 Store_33        C    2480.66    146.50
      833  Region_2 Store_33        D    3778.57    316.48
      834  Region_2 Store_33        E    2885.57    239.05
      835  Region_2 Store_33        F    2891.88    238.47
      836  Region_2 Store_33        G    1503.42    175.12
      837  Region_2 Store_33        H    2504.71    260.36
      838  Region_2 Store_33        I    1721.37    205.59
      839  Region_2 Store_33        J    2556.53    126.99
      840  Region_2 Store_34    Total   15494.88   1693.53
      841  Region_2 Store_34        A     888.78    199.16
      842  Region_2 Store_34        B    1743.73    223.91
      843  Region_2 Store_34        C    2269.59    149.33
      844  Region_2 Store_34        D    2733.58    285.48
      845  Region_2 Store_34        E     892.95    149.26
      846  Region_2 Store_34        F    1743.19    266.24
      847  Region_2 Store_34        G     443.05     81.33
      848  Region_2 Store_34        H    1673.59    143.52
      849  Region_2 Store_34        I    1448.84     83.69
      850  Region_2 Store_34        J    1657.58    111.61
      851  Region_2 Store_35    Total   21686.34   2066.68
      852  Region_2 Store_35        A    4472.83    295.19
      853  Region_2 Store_35        B     386.56    167.88
      854  Region_2 Store_35        C    1183.93    103.31
      855  Region_2 Store_35        D    5532.00    433.91
      856  Region_2 Store_35        E     296.73     91.34
      857  Region_2 Store_35        F    1536.63    214.68
      858  Region_2 Store_35        G    3596.71    264.65
      859  Region_2 Store_35        H    2207.46    306.20
      860  Region_2 Store_35        I    1891.73    136.53
      861  Region_2 Store_35        J     581.76     52.99
      862  Region_2 Store_36    Total   19780.57   2033.61
      863  Region_2 Store_36        A     809.28    103.33
      864  Region_2 Store_36        B     623.37     86.98
      865  Region_2 Store_36        C    2370.71    215.10
      866  Region_2 Store_36        D    1905.00    301.71
      867  Region_2 Store_36        E    1295.04     80.52
      868  Region_2 Store_36        F    2313.52    209.81
      869  Region_2 Store_36        G    2221.97    210.51
      870  Region_2 Store_36        H    3845.27    330.26
      871  Region_2 Store_36        I    1114.10    241.36
      872  Region_2 Store_36        J    3282.31    254.03
      873  Region_2 Store_37    Total   24298.75   2007.98
      874  Region_2 Store_37        A    1386.56     61.21
      875  Region_2 Store_37        B    4949.12    379.15
      876  Region_2 Store_37        C    3620.35    166.14
      877  Region_2 Store_37        D     763.19    191.24
      878  Region_2 Store_37        E    1736.13    172.89
      879  Region_2 Store_37        F    1887.71    323.12
      880  Region_2 Store_37        G    2240.57    124.97
      881  Region_2 Store_37        H     709.38     77.88
      882  Region_2 Store_37        I    3714.26    288.35
      883  Region_2 Store_37        J    3291.48    223.03
      884  Region_2 Store_38    Total   23005.56   2683.20
      885  Region_2 Store_38        A    1649.94    146.62
      886  Region_2 Store_38        B    2131.22    215.39
      887  Region_2 Store_38        C    3754.83    402.38
      888  Region_2 Store_38        D    2219.29    124.56
      889  Region_2 Store_38        E    3110.21    517.96
      890  Region_2 Store_38        F    1946.43    235.71
      891  Region_2 Store_38        G    2734.82    429.28
      892  Region_2 Store_38        H    3496.77    371.55
      893  Region_2 Store_38        I    1759.35    165.58
      894  Region_2 Store_38        J     202.70     74.17
      895  Region_2 Store_39    Total   23509.19   2372.05
      896  Region_2 Store_39        A    3469.31    321.35
      897  Region_2 Store_39        B    2245.83    198.25
      898  Region_2 Store_39        C    2610.93    228.55
      899  Region_2 Store_39        D    1588.36    126.45
      900  Region_2 Store_39        E     428.36     50.64
      901  Region_2 Store_39        F    1959.80    199.08
      902  Region_2 Store_39        G    4199.91    520.22
      903  Region_2 Store_39        H    1175.11    119.96
      904  Region_2 Store_39        I    3953.27    423.01
      905  Region_2 Store_39        J    1878.31    184.54
      906  Region_2  Store_4    Total   13314.58   1709.55
      907  Region_2  Store_4        A    1466.78    153.64
      908  Region_2  Store_4        B     938.68    164.19
      909  Region_2  Store_4        C     836.52    258.32
      910  Region_2  Store_4        D     947.99     91.67
      911  Region_2  Store_4        E    1993.79    231.04
      912  Region_2  Store_4        F    2166.07    252.60
      913  Region_2  Store_4        G    1230.91    198.97
      914  Region_2  Store_4        H     919.67    103.04
      915  Region_2  Store_4        I     175.77     31.11
      916  Region_2  Store_4        J    2638.40    224.97
      917  Region_2 Store_40    Total   21039.55   1877.40
      918  Region_2 Store_40        A    2375.26    139.42
      919  Region_2 Store_40        B    2460.29    239.70
      920  Region_2 Store_40        C     449.65     74.58
      921  Region_2 Store_40        D    2566.04    258.35
      922  Region_2 Store_40        E    1081.29    115.03
      923  Region_2 Store_40        F      85.15     48.35
      924  Region_2 Store_40        G    2771.15    220.76
      925  Region_2 Store_40        H    3785.88    339.19
      926  Region_2 Store_40        I    2106.09    179.94
      927  Region_2 Store_40        J    3358.75    262.08
      928  Region_2 Store_41    Total   22052.44   2433.62
      929  Region_2 Store_41        A     856.71    150.92
      930  Region_2 Store_41        B    1977.84    359.33
      931  Region_2 Store_41        C    2153.47    161.34
      932  Region_2 Store_41        D    1906.38    175.52
      933  Region_2 Store_41        E    1256.61     53.95
      934  Region_2 Store_41        F    3117.72    219.79
      935  Region_2 Store_41        G    4104.98    400.84
      936  Region_2 Store_41        H    2228.26    232.62
      937  Region_2 Store_41        I    2075.66    265.35
      938  Region_2 Store_41        J    2374.81    413.96
      939  Region_2 Store_42    Total   23696.60   2137.57
      940  Region_2 Store_42        A    1358.70    111.23
      941  Region_2 Store_42        B    2012.51     97.83
      942  Region_2 Store_42        C    3707.65    342.89
      943  Region_2 Store_42        D     450.67     34.24
      944  Region_2 Store_42        E    2351.69    222.96
      945  Region_2 Store_42        F    2076.03    235.59
      946  Region_2 Store_42        G    4008.26    331.76
      947  Region_2 Store_42        H    2342.67    247.12
      948  Region_2 Store_42        I    4284.96    363.98
      949  Region_2 Store_42        J    1103.46    149.97
      950  Region_2 Store_43    Total   23057.44   1957.19
      951  Region_2 Store_43        A    3767.62    298.18
      952  Region_2 Store_43        B    1828.76    190.71
      953  Region_2 Store_43        C    1241.57    130.10
      954  Region_2 Store_43        D    2166.49    291.57
      955  Region_2 Store_43        E     882.74    102.88
      956  Region_2 Store_43        F    1123.56     72.80
      957  Region_2 Store_43        G    1722.33    102.26
      958  Region_2 Store_43        H    3339.34    273.32
      959  Region_2 Store_43        I    2748.31    218.04
      960  Region_2 Store_43        J    4236.72    277.33
      961  Region_2 Store_44    Total   20683.31   1946.66
      962  Region_2 Store_44        A    2383.83     89.11
      963  Region_2 Store_44        B     982.06     96.57
      964  Region_2 Store_44        C    2652.41    295.71
      965  Region_2 Store_44        D    3903.23    267.13
      966  Region_2 Store_44        E     172.48     42.80
      967  Region_2 Store_44        F    2222.75    227.18
      968  Region_2 Store_44        G    4075.20    429.37
      969  Region_2 Store_44        H     949.08     78.38
      970  Region_2 Store_44        I     808.75     98.01
      971  Region_2 Store_44        J    2533.52    322.40
      972  Region_2 Store_45    Total   13468.45   1634.47
      973  Region_2 Store_45        A     467.99     30.74
      974  Region_2 Store_45        B    2277.74    273.42
      975  Region_2 Store_45        C     538.36     82.85
      976  Region_2 Store_45        D    1947.60    221.53
      977  Region_2 Store_45        E     703.50    219.54
      978  Region_2 Store_45        F    2364.97    348.24
      979  Region_2 Store_45        G     139.53     63.63
      980  Region_2 Store_45        H    2071.19    180.91
      981  Region_2 Store_45        J    2957.57    213.61
      982  Region_2 Store_46    Total   19763.86   2349.71
      983  Region_2 Store_46        A    1780.61    203.12
      984  Region_2 Store_46        B    2607.58    207.92
      985  Region_2 Store_46        C    1722.67    168.21
      986  Region_2 Store_46        D    4916.89    489.16
      987  Region_2 Store_46        E    1426.77    144.78
      988  Region_2 Store_46        F    1196.91    254.27
      989  Region_2 Store_46        G    1000.21    147.73
      990  Region_2 Store_46        H    1445.44    136.90
      991  Region_2 Store_46        I    1690.30    261.99
      992  Region_2 Store_46        J    1976.48    335.63
      993  Region_2 Store_47    Total   20017.18   2208.78
      994  Region_2 Store_47        A    2105.77    375.45
      995  Region_2 Store_47        B    1217.68    131.67
      996  Region_2 Store_47        C    2507.91    149.34
      997  Region_2 Store_47        D    2592.18    196.30
      998  Region_2 Store_47        E    2164.29    267.70
      999  Region_2 Store_47        F    3251.70    290.74
      1000 Region_2 Store_47        G    2089.88    239.66
      1001 Region_2 Store_47        H    1291.94    201.57
      1002 Region_2 Store_47        I    2151.99    261.70
      1003 Region_2 Store_47        J     643.84     94.65
      1004 Region_2 Store_48    Total   20734.89   1707.21
      1005 Region_2 Store_48        A    2599.61     80.19
      1006 Region_2 Store_48        B    2847.72    194.97
      1007 Region_2 Store_48        C     213.11     38.66
      1008 Region_2 Store_48        D    3295.38    245.58
      1009 Region_2 Store_48        E    1569.88    149.91
      1010 Region_2 Store_48        F     741.77    114.69
      1011 Region_2 Store_48        G    4335.31    380.46
      1012 Region_2 Store_48        H    1286.77    151.79
      1013 Region_2 Store_48        I    1398.70    121.21
      1014 Region_2 Store_48        J    2446.64    229.75
      1015 Region_2 Store_49    Total   20326.76   2046.31
      1016 Region_2 Store_49        A    2836.66    316.95
      1017 Region_2 Store_49        B    2691.81    248.97
      1018 Region_2 Store_49        C    2375.65    174.84
      1019 Region_2 Store_49        D     967.54     42.06
      1020 Region_2 Store_49        E    1431.47    225.11
      1021 Region_2 Store_49        F    1761.39    175.33
      1022 Region_2 Store_49        G    1181.75    151.86
      1023 Region_2 Store_49        H    1797.17    138.74
      1024 Region_2 Store_49        I    1926.07    175.62
      1025 Region_2 Store_49        J    3357.25    396.83
      1026 Region_2  Store_5    Total   19933.70   2116.91
      1027 Region_2  Store_5        A    4245.08    266.92
      1028 Region_2  Store_5        B    1433.44    209.76
      1029 Region_2  Store_5        C     628.55     70.49
      1030 Region_2  Store_5        D    1665.57    199.57
      1031 Region_2  Store_5        E    1307.08    215.75
      1032 Region_2  Store_5        F    1933.01    215.19
      1033 Region_2  Store_5        G    2711.13    151.68
      1034 Region_2  Store_5        H    2109.65    299.11
      1035 Region_2  Store_5        I    1795.99    239.41
      1036 Region_2  Store_5        J    2104.20    249.03
      1037 Region_2 Store_50    Total   19210.48   1729.15
      1038 Region_2 Store_50        A    2583.79    208.73
      1039 Region_2 Store_50        B     655.57     95.20
      1040 Region_2 Store_50        C    2185.32    331.81
      1041 Region_2 Store_50        D    1381.40    114.30
      1042 Region_2 Store_50        E    2291.98    207.66
      1043 Region_2 Store_50        F    1356.95     88.54
      1044 Region_2 Store_50        G    3840.48    171.90
      1045 Region_2 Store_50        H    3529.47    292.98
      1046 Region_2 Store_50        I     991.50     95.45
      1047 Region_2 Store_50        J     394.02    122.58
      1048 Region_2  Store_6    Total   23203.18   2198.74
      1049 Region_2  Store_6        A    2772.52    334.39
      1050 Region_2  Store_6        B    3920.51    272.57
      1051 Region_2  Store_6        C    1727.34    182.27
      1052 Region_2  Store_6        D    1608.29    127.51
      1053 Region_2  Store_6        E    2548.65    169.28
      1054 Region_2  Store_6        F    1467.92    146.37
      1055 Region_2  Store_6        G    2699.54    318.06
      1056 Region_2  Store_6        H    2148.85    189.34
      1057 Region_2  Store_6        I    2657.75    231.11
      1058 Region_2  Store_6        J    1651.81    227.84
      1059 Region_2  Store_7    Total   17928.64   2308.62
      1060 Region_2  Store_7        A    2373.44    333.62
      1061 Region_2  Store_7        B    1453.55    188.04
      1062 Region_2  Store_7        C     198.62     46.82
      1063 Region_2  Store_7        D    1995.08    268.11
      1064 Region_2  Store_7        E    1303.88    137.14
      1065 Region_2  Store_7        F    1528.64    114.35
      1066 Region_2  Store_7        G    2341.27    234.40
      1067 Region_2  Store_7        H    1004.82    250.23
      1068 Region_2  Store_7        I    2415.12    299.48
      1069 Region_2  Store_7        J    3314.22    436.43
      1070 Region_2  Store_8    Total   22673.67   2345.06
      1071 Region_2  Store_8        A    1565.21    134.75
      1072 Region_2  Store_8        B    3088.09    409.10
      1073 Region_2  Store_8        C     678.55    134.69
      1074 Region_2  Store_8        D    2544.52    245.06
      1075 Region_2  Store_8        E    3364.25    234.09
      1076 Region_2  Store_8        F    2572.99    208.18
      1077 Region_2  Store_8        G    3161.02    358.90
      1078 Region_2  Store_8        H    2229.49    208.25
      1079 Region_2  Store_8        I    2533.98    295.73
      1080 Region_2  Store_8        J     935.57    116.31
      1081 Region_2  Store_9    Total   19179.07   1942.85
      1082 Region_2  Store_9        A    2071.26    200.98
      1083 Region_2  Store_9        B     892.66    118.37
      1084 Region_2  Store_9        C    1308.02     95.88
      1085 Region_2  Store_9        D    2484.15    255.30
      1086 Region_2  Store_9        E    2537.44    302.90
      1087 Region_2  Store_9        F    1836.22    178.76
      1088 Region_2  Store_9        G    1666.42    156.87
      1089 Region_2  Store_9        H    2101.93    237.05
      1090 Region_2  Store_9        I    2925.10    220.66
      1091 Region_2  Store_9        J    1355.87    176.08
      1092 Region_3    Total    Total  956805.36  95256.27
      1093 Region_3  Store_1    Total   19499.06   1788.21
      1094 Region_3  Store_1        A    1522.15    116.63
      1095 Region_3  Store_1        B     941.71     38.60
      1096 Region_3  Store_1        C    3901.46    254.00
      1097 Region_3  Store_1        D    3817.03    207.21
      1098 Region_3  Store_1        E     415.68     62.63
      1099 Region_3  Store_1        F    2247.18    326.41
      1100 Region_3  Store_1        G    1402.40    177.35
      1101 Region_3  Store_1        H    1150.93     61.63
      1102 Region_3  Store_1        I    1660.98    181.92
      1103 Region_3  Store_1        J    2439.54    361.83
      1104 Region_3 Store_10    Total   20984.96   2027.90
      1105 Region_3 Store_10        A    2324.74    175.67
      1106 Region_3 Store_10        B    1789.21    153.23
      1107 Region_3 Store_10        C    2073.95    142.02
      1108 Region_3 Store_10        D    4031.96    402.35
      1109 Region_3 Store_10        E    2884.25    262.62
      1110 Region_3 Store_10        F    2142.31    162.38
      1111 Region_3 Store_10        G    1544.52    196.45
      1112 Region_3 Store_10        H    1848.06    194.74
      1113 Region_3 Store_10        I    1358.56    243.97
      1114 Region_3 Store_10        J     987.40     94.47
      1115 Region_3 Store_11    Total   19731.80   2226.53
      1116 Region_3 Store_11        A    2436.40    233.73
      1117 Region_3 Store_11        B    1729.70    156.80
      1118 Region_3 Store_11        C    1746.14    240.06
      1119 Region_3 Store_11        D     926.57    131.89
      1120 Region_3 Store_11        E    2660.56    258.36
      1121 Region_3 Store_11        F      64.90     69.69
      1122 Region_3 Store_11        G    2626.37    309.46
      1123 Region_3 Store_11        H    4654.40    473.27
      1124 Region_3 Store_11        I    1200.20    121.96
      1125 Region_3 Store_11        J    1686.56    231.31
      1126 Region_3 Store_12    Total   18702.90   1674.62
      1127 Region_3 Store_12        A    3747.68    349.49
      1128 Region_3 Store_12        C    1749.98    130.19
      1129 Region_3 Store_12        D     573.25    114.46
      1130 Region_3 Store_12        E    2229.68    170.86
      1131 Region_3 Store_12        F    2215.56    179.90
      1132 Region_3 Store_12        G     898.91     65.37
      1133 Region_3 Store_12        H    2183.36    244.04
      1134 Region_3 Store_12        I    2362.43    185.41
      1135 Region_3 Store_12        J    2742.05    234.90
      1136 Region_3 Store_13    Total   22757.84   2718.54
      1137 Region_3 Store_13        A    1775.07     77.40
      1138 Region_3 Store_13        B    2700.46    337.61
      1139 Region_3 Store_13        C    1445.31    239.22
      1140 Region_3 Store_13        D    1252.72    178.60
      1141 Region_3 Store_13        E    3967.24    510.14
      1142 Region_3 Store_13        F    2343.45    280.56
      1143 Region_3 Store_13        G    2487.91    279.08
      1144 Region_3 Store_13        H    2745.12    240.94
      1145 Region_3 Store_13        I    3495.79    484.59
      1146 Region_3 Store_13        J     544.77     90.40
      1147 Region_3 Store_14    Total   21850.50   2004.43
      1148 Region_3 Store_14        A    1598.32    248.30
      1149 Region_3 Store_14        B    2542.06    186.51
      1150 Region_3 Store_14        C    2476.92    216.11
      1151 Region_3 Store_14        D     359.66     19.07
      1152 Region_3 Store_14        E    2479.62    189.18
      1153 Region_3 Store_14        F    1615.29    164.10
      1154 Region_3 Store_14        G    2565.79    238.58
      1155 Region_3 Store_14        H    3591.66    196.00
      1156 Region_3 Store_14        I    1870.14    306.68
      1157 Region_3 Store_14        J    2751.04    239.90
      1158 Region_3 Store_15    Total   13889.40   1503.67
      1159 Region_3 Store_15        A      50.57     31.69
      1160 Region_3 Store_15        B     462.55     59.42
      1161 Region_3 Store_15        C    1512.73    148.20
      1162 Region_3 Store_15        D     417.85    104.29
      1163 Region_3 Store_15        E    1027.13    142.01
      1164 Region_3 Store_15        F    1441.71    127.69
      1165 Region_3 Store_15        G    2777.51    299.58
      1166 Region_3 Store_15        H    1941.47    225.06
      1167 Region_3 Store_15        I    1400.62    194.05
      1168 Region_3 Store_15        J    2857.26    171.68
      1169 Region_3 Store_16    Total   15805.88   1588.58
      1170 Region_3 Store_16        A    1599.32    117.96
      1171 Region_3 Store_16        B     739.00    123.77
      1172 Region_3 Store_16        C    1246.10    188.63
      1173 Region_3 Store_16        D     387.87     67.01
      1174 Region_3 Store_16        E     817.21     44.76
      1175 Region_3 Store_16        F    3764.62    387.92
      1176 Region_3 Store_16        G    3024.86    292.74
      1177 Region_3 Store_16        H    1064.89     88.51
      1178 Region_3 Store_16        I    1030.86    111.93
      1179 Region_3 Store_16        J    2131.15    165.35
      1180 Region_3 Store_17    Total   21450.63   2245.19
      1181 Region_3 Store_17        A    1308.46    176.49
      1182 Region_3 Store_17        B    1351.93    180.67
      1183 Region_3 Store_17        C    2178.49    187.16
      1184 Region_3 Store_17        D    3267.09    246.05
      1185 Region_3 Store_17        E    2154.29    237.65
      1186 Region_3 Store_17        F    1943.43    210.15
      1187 Region_3 Store_17        G    4573.85    386.31
      1188 Region_3 Store_17        H    1131.32    119.32
      1189 Region_3 Store_17        I    2177.24    331.56
      1190 Region_3 Store_17        J    1364.53    169.83
      1191 Region_3 Store_18    Total   13950.90   1091.49
      1192 Region_3 Store_18        A    1262.85     69.02
      1193 Region_3 Store_18        B     474.55     49.67
      1194 Region_3 Store_18        C    1896.31    203.85
      1195 Region_3 Store_18        D    3684.92    223.01
      1196 Region_3 Store_18        E    1086.51    117.01
      1197 Region_3 Store_18        F    1126.39    111.89
      1198 Region_3 Store_18        H     609.36     49.14
      1199 Region_3 Store_18        I     822.39     50.22
      1200 Region_3 Store_18        J    2987.62    217.68
      1201 Region_3 Store_19    Total   18715.86   1906.84
      1202 Region_3 Store_19        A    2669.47    228.17
      1203 Region_3 Store_19        B     911.52     64.37
      1204 Region_3 Store_19        C    1946.71    186.37
      1205 Region_3 Store_19        D    2754.23    221.51
      1206 Region_3 Store_19        E    2712.81    378.09
      1207 Region_3 Store_19        F    1389.25    177.62
      1208 Region_3 Store_19        G    1275.22    160.67
      1209 Region_3 Store_19        H     227.15     48.98
      1210 Region_3 Store_19        I    3860.47    300.33
      1211 Region_3 Store_19        J     969.03    140.73
      1212 Region_3  Store_2    Total   12593.75   1587.00
      1213 Region_3  Store_2        A    1688.46    283.38
      1214 Region_3  Store_2        B    3401.29    527.04
      1215 Region_3  Store_2        C    2047.20    231.95
      1216 Region_3  Store_2        E    1073.69     76.16
      1217 Region_3  Store_2        F    1304.43    191.58
      1218 Region_3  Store_2        G     852.21     80.97
      1219 Region_3  Store_2        H     838.66    113.88
      1220 Region_3  Store_2        J    1387.81     82.04
      1221 Region_3 Store_20    Total   17180.06   2054.33
      1222 Region_3 Store_20        A    1632.00    223.77
      1223 Region_3 Store_20        B    1250.58     90.17
      1224 Region_3 Store_20        C     514.13    114.51
      1225 Region_3 Store_20        D    1774.79    252.79
      1226 Region_3 Store_20        E    3363.72    192.06
      1227 Region_3 Store_20        F    2929.50    355.74
      1228 Region_3 Store_20        G     924.04    157.19
      1229 Region_3 Store_20        H    1059.40    187.25
      1230 Region_3 Store_20        I    1257.16    241.03
      1231 Region_3 Store_20        J    2474.74    239.82
      1232 Region_3 Store_21    Total   19687.80   1731.12
      1233 Region_3 Store_21        A    3052.72    216.37
      1234 Region_3 Store_21        B    2470.27    371.83
      1235 Region_3 Store_21        C    2707.62    154.95
      1236 Region_3 Store_21        D     962.09    129.86
      1237 Region_3 Store_21        E    1998.21     93.87
      1238 Region_3 Store_21        F    2316.56    255.79
      1239 Region_3 Store_21        G    1975.08    157.73
      1240 Region_3 Store_21        H    1745.47     83.12
      1241 Region_3 Store_21        I    1563.39    126.19
      1242 Region_3 Store_21        J     896.39    141.41
      1243 Region_3 Store_22    Total   20118.27   1788.34
      1244 Region_3 Store_22        A    1294.08    267.71
      1245 Region_3 Store_22        B    1751.10    159.09
      1246 Region_3 Store_22        C    1913.92    132.75
      1247 Region_3 Store_22        D    1319.53    159.06
      1248 Region_3 Store_22        E    2630.30    185.03
      1249 Region_3 Store_22        F    3158.09    248.38
      1250 Region_3 Store_22        G    1687.68    187.56
      1251 Region_3 Store_22        H     882.60     98.38
      1252 Region_3 Store_22        I    3274.87    191.05
      1253 Region_3 Store_22        J    2206.10    159.33
      1254 Region_3 Store_23    Total   20351.31   2285.13
      1255 Region_3 Store_23        A    1398.17    185.21
      1256 Region_3 Store_23        B    2296.43    246.87
      1257 Region_3 Store_23        C    1382.13    224.71
      1258 Region_3 Store_23        D    1699.24    167.15
      1259 Region_3 Store_23        E    2631.81    226.77
      1260 Region_3 Store_23        F    2094.66    367.45
      1261 Region_3 Store_23        G     536.47    101.95
      1262 Region_3 Store_23        H    2257.43    152.01
      1263 Region_3 Store_23        I    3073.92    401.38
      1264 Region_3 Store_23        J    2981.05    211.63
      1265 Region_3 Store_24    Total   20074.20   2046.90
      1266 Region_3 Store_24        A    3217.83    354.11
      1267 Region_3 Store_24        B     550.46     62.09
      1268 Region_3 Store_24        C    2623.10    322.44
      1269 Region_3 Store_24        D    3791.83    302.68
      1270 Region_3 Store_24        E     889.40    140.59
      1271 Region_3 Store_24        F    2300.62    152.61
      1272 Region_3 Store_24        G    2389.96    256.18
      1273 Region_3 Store_24        H     826.08    108.60
      1274 Region_3 Store_24        I    3067.24    285.78
      1275 Region_3 Store_24        J     417.68     61.82
      1276 Region_3 Store_25    Total   20500.60   2101.12
      1277 Region_3 Store_25        A    1264.65    201.09
      1278 Region_3 Store_25        B    3660.64    330.44
      1279 Region_3 Store_25        C    2787.24    219.12
      1280 Region_3 Store_25        D    1006.26    129.59
      1281 Region_3 Store_25        E     285.19    126.78
      1282 Region_3 Store_25        F    3177.13    313.04
      1283 Region_3 Store_25        G     518.11    129.77
      1284 Region_3 Store_25        H    1901.48    245.78
      1285 Region_3 Store_25        I    1416.47     82.76
      1286 Region_3 Store_25        J    4483.43    322.75
      1287 Region_3 Store_26    Total   13394.93   1550.84
      1288 Region_3 Store_26        A      48.05     36.12
      1289 Region_3 Store_26        B    2573.82    238.55
      1290 Region_3 Store_26        C    1839.26    179.80
      1291 Region_3 Store_26        D    2269.71    209.77
      1292 Region_3 Store_26        E    1702.60    190.07
      1293 Region_3 Store_26        G     799.39    181.25
      1294 Region_3 Store_26        H    2288.10    250.10
      1295 Region_3 Store_26        I    1215.14    127.64
      1296 Region_3 Store_26        J     658.86    137.54
      1297 Region_3 Store_27    Total   17727.66   1750.54
      1298 Region_3 Store_27        A    2064.35    133.97
      1299 Region_3 Store_27        B    1988.60    212.59
      1300 Region_3 Store_27        C    1497.92    134.68
      1301 Region_3 Store_27        D    3000.08    276.27
      1302 Region_3 Store_27        E    2851.59    391.49
      1303 Region_3 Store_27        F    1453.07    111.11
      1304 Region_3 Store_27        G    1696.25    156.71
      1305 Region_3 Store_27        H    1726.61     77.86
      1306 Region_3 Store_27        I    1021.39    155.09
      1307 Region_3 Store_27        J     427.80    100.77
      1308 Region_3 Store_28    Total   11984.16   1437.85
      1309 Region_3 Store_28        B     946.88    103.70
      1310 Region_3 Store_28        C     598.44     28.37
      1311 Region_3 Store_28        D    2426.29    270.80
      1312 Region_3 Store_28        E    1028.60    185.19
      1313 Region_3 Store_28        F     729.46    129.43
      1314 Region_3 Store_28        G     505.65     44.38
      1315 Region_3 Store_28        H    2172.85    314.48
      1316 Region_3 Store_28        I     362.66    104.94
      1317 Region_3 Store_28        J    3213.33    256.56
      1318 Region_3 Store_29    Total   23868.25   2200.30
      1319 Region_3 Store_29        A     685.06    100.27
      1320 Region_3 Store_29        B    1928.16    217.81
      1321 Region_3 Store_29        C    3076.29    262.63
      1322 Region_3 Store_29        D    4033.61    156.48
      1323 Region_3 Store_29        E    2796.50    203.06
      1324 Region_3 Store_29        F    4399.34    391.47
      1325 Region_3 Store_29        G    1199.41     87.98
      1326 Region_3 Store_29        H    2340.51    291.32
      1327 Region_3 Store_29        I    1981.23    287.92
      1328 Region_3 Store_29        J    1428.14    201.36
      1329 Region_3  Store_3    Total   20854.22   2236.06
      1330 Region_3  Store_3        A    3909.78    384.79
      1331 Region_3  Store_3        B    2941.71    337.72
      1332 Region_3  Store_3        C    2024.46    260.44
      1333 Region_3  Store_3        D     687.61     63.69
      1334 Region_3  Store_3        E    1158.17    153.90
      1335 Region_3  Store_3        F    2014.45    302.35
      1336 Region_3  Store_3        G    2121.42    227.30
      1337 Region_3  Store_3        H    3880.87    291.08
      1338 Region_3  Store_3        I    1605.73    183.06
      1339 Region_3  Store_3        J     510.02     31.73
      1340 Region_3 Store_30    Total   23695.93   1873.76
      1341 Region_3 Store_30        A    2668.99    162.77
      1342 Region_3 Store_30        B    3736.22    181.83
      1343 Region_3 Store_30        C    3089.28    283.68
      1344 Region_3 Store_30        D    1608.37    180.64
      1345 Region_3 Store_30        E    1770.61    112.11
      1346 Region_3 Store_30        F     877.20    106.49
      1347 Region_3 Store_30        G    1819.33    121.92
      1348 Region_3 Store_30        H    3299.67    220.86
      1349 Region_3 Store_30        I    1616.34    202.13
      1350 Region_3 Store_30        J    3209.92    301.33
      1351 Region_3 Store_31    Total   15877.76   1868.81
      1352 Region_3 Store_31        A    2553.69    297.14
      1353 Region_3 Store_31        B    2815.55    321.41
      1354 Region_3 Store_31        C    1600.11    214.96
      1355 Region_3 Store_31        D    1904.67    160.98
      1356 Region_3 Store_31        E     870.73     67.17
      1357 Region_3 Store_31        F    1294.22    187.89
      1358 Region_3 Store_31        G     284.25     68.51
      1359 Region_3 Store_31        H    2239.16    238.41
      1360 Region_3 Store_31        I    1050.75    222.60
      1361 Region_3 Store_31        J    1264.63     89.74
      1362 Region_3 Store_32    Total   20724.14   2151.44
      1363 Region_3 Store_32        A     912.71     37.45
      1364 Region_3 Store_32        B    2153.94    327.46
      1365 Region_3 Store_32        C    2210.00    277.12
      1366 Region_3 Store_32        D    2689.49    281.55
      1367 Region_3 Store_32        E    3007.52    258.13
      1368 Region_3 Store_32        F    1912.18    278.15
      1369 Region_3 Store_32        G    3828.40    251.12
      1370 Region_3 Store_32        H    1254.79    108.31
      1371 Region_3 Store_32        I    2755.11    332.15
      1372 Region_3 Store_33    Total   22739.86   2295.14
      1373 Region_3 Store_33        A    1810.94     85.57
      1374 Region_3 Store_33        B    3091.45    350.07
      1375 Region_3 Store_33        C    1046.79     68.58
      1376 Region_3 Store_33        D    3792.46    268.14
      1377 Region_3 Store_33        E    1296.00    184.36
      1378 Region_3 Store_33        F    2712.19    267.78
      1379 Region_3 Store_33        G     334.48     56.09
      1380 Region_3 Store_33        H    1767.58    260.15
      1381 Region_3 Store_33        I     860.63    123.81
      1382 Region_3 Store_33        J    6027.34    630.59
      1383 Region_3 Store_34    Total   19932.00   1733.03
      1384 Region_3 Store_34        A    1509.31    180.95
      1385 Region_3 Store_34        B    1436.79    102.98
      1386 Region_3 Store_34        C    3337.51    287.13
      1387 Region_3 Store_34        D    2045.58    242.71
      1388 Region_3 Store_34        E    3460.84    192.46
      1389 Region_3 Store_34        F    2518.75    237.94
      1390 Region_3 Store_34        G    1994.24    276.11
      1391 Region_3 Store_34        H    3128.51    185.33
      1392 Region_3 Store_34        I     500.47     27.42
      1393 Region_3 Store_35    Total   18246.05   1887.09
      1394 Region_3 Store_35        A    2894.72    203.95
      1395 Region_3 Store_35        B    2049.90    269.69
      1396 Region_3 Store_35        C     270.25     14.63
      1397 Region_3 Store_35        D    1591.87    350.25
      1398 Region_3 Store_35        E    2865.08    227.13
      1399 Region_3 Store_35        F     976.01     44.43
      1400 Region_3 Store_35        G     310.80     38.96
      1401 Region_3 Store_35        H    2714.31    150.74
      1402 Region_3 Store_35        I    1485.82    276.24
      1403 Region_3 Store_35        J    3087.29    311.07
      1404 Region_3 Store_36    Total   15254.76   1617.80
      1405 Region_3 Store_36        A     278.87     89.74
      1406 Region_3 Store_36        B     816.73     39.59
      1407 Region_3 Store_36        C     674.97    125.78
      1408 Region_3 Store_36        D    3306.54    316.27
      1409 Region_3 Store_36        E    1201.72     81.95
      1410 Region_3 Store_36        F    2536.53    241.72
      1411 Region_3 Store_36        G    1538.96     51.35
      1412 Region_3 Store_36        H    1685.14    285.02
      1413 Region_3 Store_36        I    1550.08    213.81
      1414 Region_3 Store_36        J    1665.22    172.57
      1415 Region_3 Store_37    Total   21441.29   1929.15
      1416 Region_3 Store_37        A    1649.45    138.93
      1417 Region_3 Store_37        B    4384.27    367.41
      1418 Region_3 Store_37        C    2429.56    176.75
      1419 Region_3 Store_37        D    1021.56    142.39
      1420 Region_3 Store_37        E    3042.33    308.96
      1421 Region_3 Store_37        F    2148.17    172.31
      1422 Region_3 Store_37        G    1210.22    157.78
      1423 Region_3 Store_37        H    1674.65    226.22
      1424 Region_3 Store_37        J    3881.08    238.40
      1425 Region_3 Store_38    Total   14560.54   1312.31
      1426 Region_3 Store_38        A    2769.57    211.14
      1427 Region_3 Store_38        B     456.22     28.83
      1428 Region_3 Store_38        C    1072.26    113.15
      1429 Region_3 Store_38        D    1174.90    202.61
      1430 Region_3 Store_38        E     884.54    129.66
      1431 Region_3 Store_38        F     840.52     74.80
      1432 Region_3 Store_38        G    1868.79    167.51
      1433 Region_3 Store_38        H     632.77     54.33
      1434 Region_3 Store_38        I    2726.07    208.96
      1435 Region_3 Store_38        J    2134.90    121.32
      1436 Region_3 Store_39    Total   22350.60   2019.54
      1437 Region_3 Store_39        A     504.43     85.44
      1438 Region_3 Store_39        B    2732.83    409.32
      1439 Region_3 Store_39        C    1877.28    215.05
      1440 Region_3 Store_39        D    1695.91    130.28
      1441 Region_3 Store_39        E    5408.39    362.77
      1442 Region_3 Store_39        F    1429.51     81.75
      1443 Region_3 Store_39        G    1424.50    123.22
      1444 Region_3 Store_39        H    1476.96    108.19
      1445 Region_3 Store_39        I    2537.76    152.82
      1446 Region_3 Store_39        J    3263.03    350.70
      1447 Region_3  Store_4    Total   25182.53   2207.09
      1448 Region_3  Store_4        A     121.77     61.11
      1449 Region_3  Store_4        B    4153.10    420.95
      1450 Region_3  Store_4        C    3264.61    316.52
      1451 Region_3  Store_4        D     773.79     79.27
      1452 Region_3  Store_4        E    2575.89    124.89
      1453 Region_3  Store_4        F    2103.37    235.10
      1454 Region_3  Store_4        G    4295.23    252.78
      1455 Region_3  Store_4        H    4232.61    394.77
      1456 Region_3  Store_4        I    2723.06    213.82
      1457 Region_3  Store_4        J     939.10    107.88
      1458 Region_3 Store_40    Total   20050.76   1983.01
      1459 Region_3 Store_40        A    2812.75    212.47
      1460 Region_3 Store_40        B    2612.86    287.30
      1461 Region_3 Store_40        C    1401.42    139.39
      1462 Region_3 Store_40        D    3244.51    146.88
      1463 Region_3 Store_40        E     516.81    180.48
      1464 Region_3 Store_40        F    2262.04    240.91
      1465 Region_3 Store_40        G    1121.70    143.52
      1466 Region_3 Store_40        H    2065.60    173.35
      1467 Region_3 Store_40        I    1473.97     74.96
      1468 Region_3 Store_40        J    2539.10    383.75
      1469 Region_3 Store_41    Total   20142.81   2099.26
      1470 Region_3 Store_41        A    1918.59    215.60
      1471 Region_3 Store_41        B    1691.28    305.81
      1472 Region_3 Store_41        C    2154.33    261.56
      1473 Region_3 Store_41        D    1059.50    180.35
      1474 Region_3 Store_41        E    2483.38    288.55
      1475 Region_3 Store_41        F    1415.51    143.45
      1476 Region_3 Store_41        G    1928.23    192.04
      1477 Region_3 Store_41        H    2573.87    194.88
      1478 Region_3 Store_41        I    3413.65    190.84
      1479 Region_3 Store_41        J    1504.47    126.18
      1480 Region_3 Store_42    Total   22347.33   2456.70
      1481 Region_3 Store_42        A    1021.26    233.85
      1482 Region_3 Store_42        B    1529.50    212.65
      1483 Region_3 Store_42        C     770.32     82.38
      1484 Region_3 Store_42        D    1842.66    175.24
      1485 Region_3 Store_42        E    2107.37    272.55
      1486 Region_3 Store_42        F    3629.99    319.54
      1487 Region_3 Store_42        G    2508.52    187.31
      1488 Region_3 Store_42        H    3117.87    330.53
      1489 Region_3 Store_42        I    2795.88    271.94
      1490 Region_3 Store_42        J    3023.96    370.71
      1491 Region_3 Store_43    Total   25185.39   2224.01
      1492 Region_3 Store_43        A    3193.65    253.85
      1493 Region_3 Store_43        B    2837.53    290.59
      1494 Region_3 Store_43        C    1855.68    139.48
      1495 Region_3 Store_43        D    2519.99    216.54
      1496 Region_3 Store_43        E    1525.29    228.53
      1497 Region_3 Store_43        F    2692.44    223.59
      1498 Region_3 Store_43        G    3200.21    209.00
      1499 Region_3 Store_43        H    2052.13    262.23
      1500 Region_3 Store_43        I    2620.94    262.01
      1501 Region_3 Store_43        J    2687.53    138.19
      1502 Region_3 Store_44    Total   19839.15   1927.34
      1503 Region_3 Store_44        A    2450.42    170.10
      1504 Region_3 Store_44        B     695.09     70.79
      1505 Region_3 Store_44        C     793.22    125.18
      1506 Region_3 Store_44        D    1497.94    270.50
      1507 Region_3 Store_44        E    1504.60     73.75
      1508 Region_3 Store_44        F    1383.15    109.27
      1509 Region_3 Store_44        G    3280.74    220.43
      1510 Region_3 Store_44        H    2490.33    266.21
      1511 Region_3 Store_44        I    1884.58    237.22
      1512 Region_3 Store_44        J    3859.08    383.89
      1513 Region_3 Store_45    Total   16410.67   1401.60
      1514 Region_3 Store_45        A    1198.94    129.84
      1515 Region_3 Store_45        B    1706.27     51.91
      1516 Region_3 Store_45        C     600.73     97.97
      1517 Region_3 Store_45        D     290.59    109.14
      1518 Region_3 Store_45        E    3577.66    178.84
      1519 Region_3 Store_45        F    5253.72    407.10
      1520 Region_3 Store_45        G    1806.70    151.19
      1521 Region_3 Store_45        H     377.73     67.03
      1522 Region_3 Store_45        I     391.71     92.74
      1523 Region_3 Store_45        J    1206.62    115.84
      1524 Region_3 Store_46    Total   22560.55   1957.18
      1525 Region_3 Store_46        A    6357.79    433.14
      1526 Region_3 Store_46        B     958.86    136.31
      1527 Region_3 Store_46        C    1129.87    170.89
      1528 Region_3 Store_46        D    1361.21    115.90
      1529 Region_3 Store_46        E    1721.19    106.57
      1530 Region_3 Store_46        F    4871.08    369.66
      1531 Region_3 Store_46        G    2661.72    286.84
      1532 Region_3 Store_46        H     787.97     35.62
      1533 Region_3 Store_46        I    1352.22    171.56
      1534 Region_3 Store_46        J    1358.64    130.69
      1535 Region_3 Store_47    Total   15196.64   1880.66
      1536 Region_3 Store_47        A    2463.61    293.75
      1537 Region_3 Store_47        B    1574.08    143.08
      1538 Region_3 Store_47        C    1170.50    169.52
      1539 Region_3 Store_47        D    1929.58    227.41
      1540 Region_3 Store_47        E    1141.26    248.48
      1541 Region_3 Store_47        F    2075.73    194.78
      1542 Region_3 Store_47        G    1880.32    260.92
      1543 Region_3 Store_47        H    1416.51    175.57
      1544 Region_3 Store_47        I     277.34     92.39
      1545 Region_3 Store_47        J    1267.71     74.76
      1546 Region_3 Store_48    Total   17034.78   1716.47
      1547 Region_3 Store_48        A    2032.74    289.66
      1548 Region_3 Store_48        B    1325.82    165.84
      1549 Region_3 Store_48        C    2394.69    175.71
      1550 Region_3 Store_48        E    1613.91     83.91
      1551 Region_3 Store_48        F     112.11     72.26
      1552 Region_3 Store_48        G    1760.85    294.79
      1553 Region_3 Store_48        H    2828.59    187.32
      1554 Region_3 Store_48        I    1865.04    150.05
      1555 Region_3 Store_48        J    3101.03    296.93
      1556 Region_3 Store_49    Total   24192.17   2824.99
      1557 Region_3 Store_49        A    4069.06    446.80
      1558 Region_3 Store_49        B    1817.69    355.56
      1559 Region_3 Store_49        C    4235.63    399.82
      1560 Region_3 Store_49        D    2242.93    238.78
      1561 Region_3 Store_49        E    1385.35    231.24
      1562 Region_3 Store_49        F    1192.33    194.57
      1563 Region_3 Store_49        G    2088.95    225.89
      1564 Region_3 Store_49        H    2769.15    227.09
      1565 Region_3 Store_49        I    2558.86    318.65
      1566 Region_3 Store_49        J    1832.22    186.59
      1567 Region_3  Store_5    Total   22069.38   1939.55
      1568 Region_3  Store_5        A    1784.94    166.03
      1569 Region_3  Store_5        B     435.22     80.97
      1570 Region_3  Store_5        C    2491.65    132.63
      1571 Region_3  Store_5        D    2136.79    181.38
      1572 Region_3  Store_5        E    2280.78    208.56
      1573 Region_3  Store_5        F     987.27    108.42
      1574 Region_3  Store_5        G    3190.86    258.51
      1575 Region_3  Store_5        H    3315.52    302.82
      1576 Region_3  Store_5        I    2878.23    321.87
      1577 Region_3  Store_5        J    2568.12    178.36
      1578 Region_3 Store_50    Total   16695.18   1671.83
      1579 Region_3 Store_50        A    3031.65    266.09
      1580 Region_3 Store_50        B    1485.92    201.38
      1581 Region_3 Store_50        C    2547.41    154.07
      1582 Region_3 Store_50        D    2307.21    153.79
      1583 Region_3 Store_50        E     992.89    128.12
      1584 Region_3 Store_50        F    1304.47    206.22
      1585 Region_3 Store_50        G    3373.11    333.44
      1586 Region_3 Store_50        H     702.32     53.85
      1587 Region_3 Store_50        I     191.55     75.64
      1588 Region_3 Store_50        J     758.65     99.23
      1589 Region_3  Store_6    Total   19593.97   1728.10
      1590 Region_3  Store_6        A    3180.10    210.18
      1591 Region_3  Store_6        B    1632.23    107.75
      1592 Region_3  Store_6        C     197.92     42.79
      1593 Region_3  Store_6        D    1717.93     55.90
      1594 Region_3  Store_6        E    3482.23    363.93
      1595 Region_3  Store_6        F     312.23     92.39
      1596 Region_3  Store_6        G    2603.87    225.64
      1597 Region_3  Store_6        H    1255.72    118.24
      1598 Region_3  Store_6        I    1559.20    173.17
      1599 Region_3  Store_6        J    3652.54    338.11
      1600 Region_3  Store_7    Total   15237.82   1392.77
      1601 Region_3  Store_7        A    1651.87    194.94
      1602 Region_3  Store_7        B     898.96    129.96
      1603 Region_3  Store_7        C    2111.01    158.57
      1604 Region_3  Store_7        D    1046.33     49.46
      1605 Region_3  Store_7        E    2671.11    280.27
      1606 Region_3  Store_7        F    2828.98    137.67
      1607 Region_3  Store_7        G     198.23     33.95
      1608 Region_3  Store_7        H    1657.16    219.92
      1609 Region_3  Store_7        I    1217.22     96.97
      1610 Region_3  Store_7        J     956.95     91.06
      1611 Region_3  Store_8    Total   17686.98   1931.74
      1612 Region_3  Store_8        B    2632.81    299.23
      1613 Region_3  Store_8        C    1490.39    148.13
      1614 Region_3  Store_8        D    2542.76    253.05
      1615 Region_3  Store_8        E    2381.78    292.33
      1616 Region_3  Store_8        F    1489.54    159.45
      1617 Region_3  Store_8        G    1853.34    123.58
      1618 Region_3  Store_8        H    2359.03    243.95
      1619 Region_3  Store_8        I    1740.06    310.84
      1620 Region_3  Store_8        J    1197.27    101.18
      1621 Region_3  Store_9    Total   16881.38   1680.37
      1622 Region_3  Store_9        A    3585.41    306.70
      1623 Region_3  Store_9        B    2416.61    180.05
      1624 Region_3  Store_9        D    1432.08     87.16
      1625 Region_3  Store_9        E    1953.79    243.13
      1626 Region_3  Store_9        F     612.26     59.25
      1627 Region_3  Store_9        G    3240.20    292.79
      1628 Region_3  Store_9        H    1473.54    170.38
      1629 Region_3  Store_9        I     140.30     49.69
      1630 Region_3  Store_9        J    2027.19    291.22
      1631 Region_4    Total    Total 1027429.98 100036.73
      1632 Region_4  Store_1    Total   21368.75   2227.51
      1633 Region_4  Store_1        A     152.08     83.12
      1634 Region_4  Store_1        B    1343.94    130.99
      1635 Region_4  Store_1        C    3316.33    316.81
      1636 Region_4  Store_1        D    3809.52    401.42
      1637 Region_4  Store_1        E    3221.53    345.83
      1638 Region_4  Store_1        F    1994.92    232.07
      1639 Region_4  Store_1        H    2450.44    260.77
      1640 Region_4  Store_1        I    3152.29    319.27
      1641 Region_4  Store_1        J    1927.70    137.23
      1642 Region_4 Store_10    Total   16007.14   1827.47
      1643 Region_4 Store_10        A    2070.17    282.39
      1644 Region_4 Store_10        B    3101.18    266.73
      1645 Region_4 Store_10        C     712.20    158.06
      1646 Region_4 Store_10        D      38.33     75.79
      1647 Region_4 Store_10        E    2576.56    188.97
      1648 Region_4 Store_10        F    2759.34    279.83
      1649 Region_4 Store_10        G     928.97    186.18
      1650 Region_4 Store_10        H     989.38    101.24
      1651 Region_4 Store_10        I     940.60    106.39
      1652 Region_4 Store_10        J    1890.41    181.89
      1653 Region_4 Store_11    Total   16447.95   1668.04
      1654 Region_4 Store_11        A     391.26    113.22
      1655 Region_4 Store_11        B    3405.62    209.82
      1656 Region_4 Store_11        C    2359.26    194.64
      1657 Region_4 Store_11        D     347.78     41.79
      1658 Region_4 Store_11        E    1678.07    158.46
      1659 Region_4 Store_11        F     780.36     52.14
      1660 Region_4 Store_11        G    1298.20    189.62
      1661 Region_4 Store_11        H    1463.95    124.64
      1662 Region_4 Store_11        I    2117.98    311.64
      1663 Region_4 Store_11        J    2605.47    272.07
      1664 Region_4 Store_12    Total   23770.15   2159.66
      1665 Region_4 Store_12        A    2936.29    311.06
      1666 Region_4 Store_12        B    2515.89    264.85
      1667 Region_4 Store_12        C    1263.52    125.36
      1668 Region_4 Store_12        D    3097.29    299.53
      1669 Region_4 Store_12        E    3784.97    315.33
      1670 Region_4 Store_12        F    2002.69    208.54
      1671 Region_4 Store_12        G    2304.61    122.20
      1672 Region_4 Store_12        H    2046.88    258.91
      1673 Region_4 Store_12        I    1264.36    148.80
      1674 Region_4 Store_12        J    2553.65    105.08
      1675 Region_4 Store_13    Total   21140.16   2134.03
      1676 Region_4 Store_13        A     911.62    167.32
      1677 Region_4 Store_13        B    1837.94    171.62
      1678 Region_4 Store_13        C     517.04     79.86
      1679 Region_4 Store_13        D    1428.14    308.79
      1680 Region_4 Store_13        E    4027.97    248.00
      1681 Region_4 Store_13        F    2695.52    171.45
      1682 Region_4 Store_13        G    1377.34    182.01
      1683 Region_4 Store_13        H    2125.95    212.29
      1684 Region_4 Store_13        I    4315.62    317.18
      1685 Region_4 Store_13        J    1903.02    275.51
      1686 Region_4 Store_14    Total   19762.34   2004.92
      1687 Region_4 Store_14        A    2034.87    359.04
      1688 Region_4 Store_14        B    2380.29    267.82
      1689 Region_4 Store_14        C     676.47     44.60
      1690 Region_4 Store_14        D    3422.00    257.36
      1691 Region_4 Store_14        E    2062.77    180.30
      1692 Region_4 Store_14        F    2751.02    187.05
      1693 Region_4 Store_14        G    1254.92    154.70
      1694 Region_4 Store_14        H    1382.02    186.14
      1695 Region_4 Store_14        I    1711.29    140.03
      1696 Region_4 Store_14        J    2086.69    227.88
      1697 Region_4 Store_15    Total   21255.34   2010.38
      1698 Region_4 Store_15        A    1404.94    191.94
      1699 Region_4 Store_15        B    3355.40    366.03
      1700 Region_4 Store_15        C    3184.01    253.04
      1701 Region_4 Store_15        D    2430.15    142.75
      1702 Region_4 Store_15        E     567.41     42.98
      1703 Region_4 Store_15        F    1712.37    132.98
      1704 Region_4 Store_15        G    2578.17    259.23
      1705 Region_4 Store_15        H    2164.39    261.35
      1706 Region_4 Store_15        I     141.82     52.58
      1707 Region_4 Store_15        J    3716.68    307.50
      1708 Region_4 Store_16    Total   19370.65   1813.07
      1709 Region_4 Store_16        A    2466.16    258.67
      1710 Region_4 Store_16        B    1773.99    147.59
      1711 Region_4 Store_16        C     253.51    135.30
      1712 Region_4 Store_16        D    1762.02    233.54
      1713 Region_4 Store_16        E    3624.50    233.35
      1714 Region_4 Store_16        F    3635.77    202.98
      1715 Region_4 Store_16        G    1495.14    186.78
      1716 Region_4 Store_16        H     125.35     56.73
      1717 Region_4 Store_16        I    1183.48    103.60
      1718 Region_4 Store_16        J    3050.73    254.53
      1719 Region_4 Store_17    Total   23620.81   1964.41
      1720 Region_4 Store_17        A    3029.92    184.57
      1721 Region_4 Store_17        B    2392.74    215.15
      1722 Region_4 Store_17        C    2025.69    185.62
      1723 Region_4 Store_17        D    2461.75     92.64
      1724 Region_4 Store_17        E    1847.96    202.78
      1725 Region_4 Store_17        F    1526.43    101.10
      1726 Region_4 Store_17        G    1955.29    211.08
      1727 Region_4 Store_17        H    1464.95    153.14
      1728 Region_4 Store_17        I    2248.45    238.59
      1729 Region_4 Store_17        J    4667.63    379.74
      1730 Region_4 Store_18    Total   23230.98   2141.28
      1731 Region_4 Store_18        A    3113.26    285.21
      1732 Region_4 Store_18        B    2486.40    277.02
      1733 Region_4 Store_18        C    2890.71    156.95
      1734 Region_4 Store_18        D    1248.62    145.60
      1735 Region_4 Store_18        E    1258.62    124.46
      1736 Region_4 Store_18        F    3133.43    316.20
      1737 Region_4 Store_18        G    3307.42    259.61
      1738 Region_4 Store_18        H    2503.59     97.35
      1739 Region_4 Store_18        I     453.82     56.39
      1740 Region_4 Store_18        J    2835.11    422.49
      1741 Region_4 Store_19    Total   19655.47   1832.51
      1742 Region_4 Store_19        A    1871.26    152.14
      1743 Region_4 Store_19        B    2871.57    258.60
      1744 Region_4 Store_19        C     294.94     52.86
      1745 Region_4 Store_19        D    3107.52    222.13
      1746 Region_4 Store_19        E    2333.91    235.73
      1747 Region_4 Store_19        F     763.25    108.24
      1748 Region_4 Store_19        G    1822.70    173.23
      1749 Region_4 Store_19        H    2243.10    218.08
      1750 Region_4 Store_19        I    3518.26    283.43
      1751 Region_4 Store_19        J     828.96    128.07
      1752 Region_4  Store_2    Total   23047.71   2223.46
      1753 Region_4  Store_2        A    2173.78    366.67
      1754 Region_4  Store_2        B    2447.51    174.73
      1755 Region_4  Store_2        C    5424.32    393.11
      1756 Region_4  Store_2        D    2869.14    287.35
      1757 Region_4  Store_2        E    3580.42    195.09
      1758 Region_4  Store_2        F    1828.35    306.76
      1759 Region_4  Store_2        G     613.07     78.46
      1760 Region_4  Store_2        H    2840.61    177.36
      1761 Region_4  Store_2        I     590.90    184.58
      1762 Region_4  Store_2        J     679.61     59.35
      1763 Region_4 Store_20    Total   16398.06   1633.43
      1764 Region_4 Store_20        A     935.45    128.64
      1765 Region_4 Store_20        B    2513.80    198.35
      1766 Region_4 Store_20        C    1853.06    218.85
      1767 Region_4 Store_20        D    2123.90    270.48
      1768 Region_4 Store_20        E      97.91     58.05
      1769 Region_4 Store_20        F    1082.02    121.40
      1770 Region_4 Store_20        G    2544.66    108.73
      1771 Region_4 Store_20        H     165.85     49.17
      1772 Region_4 Store_20        I    2992.50    286.93
      1773 Region_4 Store_20        J    2088.91    192.83
      1774 Region_4 Store_21    Total   28070.60   2431.32
      1775 Region_4 Store_21        A    2797.49    155.21
      1776 Region_4 Store_21        B    2522.03    237.29
      1777 Region_4 Store_21        C    5038.76    435.88
      1778 Region_4 Store_21        D    3609.17    315.34
      1779 Region_4 Store_21        E     602.70     73.11
      1780 Region_4 Store_21        F    4376.77    298.73
      1781 Region_4 Store_21        G    4702.72    391.61
      1782 Region_4 Store_21        H     827.59    148.31
      1783 Region_4 Store_21        I     317.20    131.18
      1784 Region_4 Store_21        J    3276.17    244.66
      1785 Region_4 Store_22    Total   19168.75   1955.92
      1786 Region_4 Store_22        A    2286.14    193.95
      1787 Region_4 Store_22        B     111.39     19.23
      1788 Region_4 Store_22        C     477.89     62.66
      1789 Region_4 Store_22        D    3725.18    314.73
      1790 Region_4 Store_22        E    3548.16    228.38
      1791 Region_4 Store_22        F    1684.17    214.71
      1792 Region_4 Store_22        G    1789.91    264.73
      1793 Region_4 Store_22        H    1545.55    198.63
      1794 Region_4 Store_22        I    1241.57    106.95
      1795 Region_4 Store_22        J    2758.79    351.95
      1796 Region_4 Store_23    Total   19567.22   1860.51
      1797 Region_4 Store_23        A    1803.09    136.83
      1798 Region_4 Store_23        B    1258.98     99.54
      1799 Region_4 Store_23        C    5586.75    581.41
      1800 Region_4 Store_23        D    1131.00    126.60
      1801 Region_4 Store_23        E    1824.09    151.51
      1802 Region_4 Store_23        F     468.81     62.12
      1803 Region_4 Store_23        G    1502.56    220.37
      1804 Region_4 Store_23        H    2445.92    147.80
      1805 Region_4 Store_23        I    2076.42    189.07
      1806 Region_4 Store_23        J    1469.60    145.26
      1807 Region_4 Store_24    Total   22536.51   2119.43
      1808 Region_4 Store_24        A     439.09     47.53
      1809 Region_4 Store_24        B    1680.27    120.78
      1810 Region_4 Store_24        C    1858.74    176.02
      1811 Region_4 Store_24        D    4598.06    461.38
      1812 Region_4 Store_24        E    2094.50    352.71
      1813 Region_4 Store_24        G    3487.29    306.55
      1814 Region_4 Store_24        H    5580.70    402.97
      1815 Region_4 Store_24        I    2177.84    175.45
      1816 Region_4 Store_24        J     620.02     76.04
      1817 Region_4 Store_25    Total   24007.93   2346.65
      1818 Region_4 Store_25        A    2003.94    239.65
      1819 Region_4 Store_25        B    1344.60    121.27
      1820 Region_4 Store_25        C     767.13     95.02
      1821 Region_4 Store_25        D    2893.86    331.14
      1822 Region_4 Store_25        E    1982.32    167.99
      1823 Region_4 Store_25        F    3565.77    313.81
      1824 Region_4 Store_25        G    3651.29    307.62
      1825 Region_4 Store_25        H    3146.92    384.41
      1826 Region_4 Store_25        I    2615.15    215.53
      1827 Region_4 Store_25        J    2036.95    170.21
      1828 Region_4 Store_26    Total   30358.22   2347.39
      1829 Region_4 Store_26        A    4725.52    531.82
      1830 Region_4 Store_26        B    1666.74    118.90
      1831 Region_4 Store_26        C    3436.24    182.24
      1832 Region_4 Store_26        D    3949.58    424.87
      1833 Region_4 Store_26        E    3356.93    275.53
      1834 Region_4 Store_26        F    2300.01    117.83
      1835 Region_4 Store_26        G    1451.86    104.90
      1836 Region_4 Store_26        H    4071.03    328.70
      1837 Region_4 Store_26        I    2488.30     87.75
      1838 Region_4 Store_26        J    2912.01    174.85
      1839 Region_4 Store_27    Total   13429.06   1779.53
      1840 Region_4 Store_27        A    2524.13    366.37
      1841 Region_4 Store_27        B    1503.60    251.03
      1842 Region_4 Store_27        C    2085.75    135.96
      1843 Region_4 Store_27        D     205.85     81.31
      1844 Region_4 Store_27        E     766.73     68.75
      1845 Region_4 Store_27        F    1196.22    196.85
      1846 Region_4 Store_27        G    1638.06    176.96
      1847 Region_4 Store_27        H    1573.98    302.18
      1848 Region_4 Store_27        I    1584.41    143.00
      1849 Region_4 Store_27        J     350.33     57.12
      1850 Region_4 Store_28    Total   23672.03   2309.14
      1851 Region_4 Store_28        A    3944.05    370.60
      1852 Region_4 Store_28        B     510.23    165.74
      1853 Region_4 Store_28        C    2858.17    203.99
      1854 Region_4 Store_28        D    3789.09    230.46
      1855 Region_4 Store_28        E    2151.44    263.72
      1856 Region_4 Store_28        F    2515.18    236.58
      1857 Region_4 Store_28        G    3035.10    414.59
      1858 Region_4 Store_28        H    1437.30     55.76
      1859 Region_4 Store_28        I    1050.05    142.63
      1860 Region_4 Store_28        J    2381.42    225.07
      1861 Region_4 Store_29    Total   23188.26   2407.69
      1862 Region_4 Store_29        A    1655.41    218.94
      1863 Region_4 Store_29        B     887.10     29.96
      1864 Region_4 Store_29        C    6493.58    502.98
      1865 Region_4 Store_29        D     234.60    139.46
      1866 Region_4 Store_29        E    2066.72    242.67
      1867 Region_4 Store_29        F    2597.13    138.56
      1868 Region_4 Store_29        G    2612.31    174.07
      1869 Region_4 Store_29        H    2570.41    491.01
      1870 Region_4 Store_29        I    2430.48    284.02
      1871 Region_4 Store_29        J    1640.52    186.02
      1872 Region_4  Store_3    Total   20303.07   2298.59
      1873 Region_4  Store_3        A    3716.06    269.15
      1874 Region_4  Store_3        B    1231.44    143.38
      1875 Region_4  Store_3        C     508.61    137.46
      1876 Region_4  Store_3        D    1118.40    201.49
      1877 Region_4  Store_3        E    5740.53    506.58
      1878 Region_4  Store_3        F    3697.38    355.87
      1879 Region_4  Store_3        G     906.30     41.14
      1880 Region_4  Store_3        H    1565.38    266.25
      1881 Region_4  Store_3        I     392.95    106.37
      1882 Region_4  Store_3        J    1426.02    270.90
      1883 Region_4 Store_30    Total   22493.48   2188.79
      1884 Region_4 Store_30        A     760.14     99.71
      1885 Region_4 Store_30        B    3917.87    262.83
      1886 Region_4 Store_30        C    3302.07    363.67
      1887 Region_4 Store_30        D    1029.75    137.88
      1888 Region_4 Store_30        E    2305.65    307.24
      1889 Region_4 Store_30        F    2361.08    182.40
      1890 Region_4 Store_30        G    2098.15    235.39
      1891 Region_4 Store_30        H    1557.22    205.20
      1892 Region_4 Store_30        I    2029.97    230.45
      1893 Region_4 Store_30        J    3131.58    164.02
      1894 Region_4 Store_31    Total   22050.39   2530.48
      1895 Region_4 Store_31        A    1861.58    165.20
      1896 Region_4 Store_31        B    1850.16    262.08
      1897 Region_4 Store_31        C    2820.46    236.58
      1898 Region_4 Store_31        D     994.78    208.91
      1899 Region_4 Store_31        E    1335.60    252.51
      1900 Region_4 Store_31        F    2638.35    247.49
      1901 Region_4 Store_31        G    3517.47    386.33
      1902 Region_4 Store_31        H    2547.11    316.27
      1903 Region_4 Store_31        I    3185.35    313.44
      1904 Region_4 Store_31        J    1299.53    141.67
      1905 Region_4 Store_32    Total   14471.03   1439.74
      1906 Region_4 Store_32        A    2491.10    211.27
      1907 Region_4 Store_32        B     942.56    112.10
      1908 Region_4 Store_32        C    1527.17    147.57
      1909 Region_4 Store_32        D    1183.22    155.31
      1910 Region_4 Store_32        E    1567.69    223.75
      1911 Region_4 Store_32        F    2290.20    124.25
      1912 Region_4 Store_32        G     677.57     51.28
      1913 Region_4 Store_32        H    1803.69    134.94
      1914 Region_4 Store_32        I     555.88     64.21
      1915 Region_4 Store_32        J    1431.95    215.06
      1916 Region_4 Store_33    Total   22834.47   2088.52
      1917 Region_4 Store_33        A    1336.44     85.51
      1918 Region_4 Store_33        B     711.82     73.69
      1919 Region_4 Store_33        C    3190.20    299.32
      1920 Region_4 Store_33        D    4877.60    394.03
      1921 Region_4 Store_33        E    1360.65     80.14
      1922 Region_4 Store_33        F    2261.81    263.96
      1923 Region_4 Store_33        G     876.79     81.87
      1924 Region_4 Store_33        H    1850.29    165.62
      1925 Region_4 Store_33        I    2937.59    367.74
      1926 Region_4 Store_33        J    3431.28    276.64
      1927 Region_4 Store_34    Total   23119.25   1881.79
      1928 Region_4 Store_34        A    1435.76    137.06
      1929 Region_4 Store_34        B    3837.57    311.71
      1930 Region_4 Store_34        C    4414.96    440.68
      1931 Region_4 Store_34        D    1090.50    115.00
      1932 Region_4 Store_34        E    1996.45    177.14
      1933 Region_4 Store_34        F    1589.23     95.89
      1934 Region_4 Store_34        G    2947.17    255.90
      1935 Region_4 Store_34        H     420.47      5.71
      1936 Region_4 Store_34        I    3332.01    171.01
      1937 Region_4 Store_34        J    2055.13    171.69
      1938 Region_4 Store_35    Total   21251.18   2060.38
      1939 Region_4 Store_35        A    1598.17    100.08
      1940 Region_4 Store_35        B    3276.09    228.48
      1941 Region_4 Store_35        C    1888.66    264.79
      1942 Region_4 Store_35        D    2349.49    225.54
      1943 Region_4 Store_35        E     869.44     59.77
      1944 Region_4 Store_35        F    1402.96    214.71
      1945 Region_4 Store_35        G    1577.68    191.58
      1946 Region_4 Store_35        H    1386.99    177.66
      1947 Region_4 Store_35        I    3960.94    420.90
      1948 Region_4 Store_35        J    2940.76    176.87
      1949 Region_4 Store_36    Total   17555.18   1563.51
      1950 Region_4 Store_36        A     701.89     84.88
      1951 Region_4 Store_36        B     408.78     28.11
      1952 Region_4 Store_36        C    1467.88     79.62
      1953 Region_4 Store_36        D    2143.53    192.00
      1954 Region_4 Store_36        E      25.68     55.05
      1955 Region_4 Store_36        F    1820.66    193.79
      1956 Region_4 Store_36        G    1970.99    111.32
      1957 Region_4 Store_36        H    3380.77    369.54
      1958 Region_4 Store_36        I    3420.81    297.93
      1959 Region_4 Store_36        J    2214.19    151.27
      1960 Region_4 Store_37    Total   15780.64   1458.86
      1961 Region_4 Store_37        A    1436.25    145.49
      1962 Region_4 Store_37        B     322.44     42.58
      1963 Region_4 Store_37        C    2382.18    250.02
      1964 Region_4 Store_37        D    1386.82    170.88
      1965 Region_4 Store_37        E     972.83     82.84
      1966 Region_4 Store_37        F    3396.28    206.35
      1967 Region_4 Store_37        G    2372.43    141.36
      1968 Region_4 Store_37        H    2144.12    304.35
      1969 Region_4 Store_37        I     975.44     67.45
      1970 Region_4 Store_37        J     391.85     47.54
      1971 Region_4 Store_38    Total   23751.76   2034.60
      1972 Region_4 Store_38        A    2023.55    197.61
      1973 Region_4 Store_38        B    1234.95    115.25
      1974 Region_4 Store_38        C    1629.36    102.62
      1975 Region_4 Store_38        D    2682.24    223.63
      1976 Region_4 Store_38        E    3994.10    295.50
      1977 Region_4 Store_38        F    4230.12    334.07
      1978 Region_4 Store_38        G    1185.01    200.53
      1979 Region_4 Store_38        H    1625.63    187.04
      1980 Region_4 Store_38        I    3057.37    193.08
      1981 Region_4 Store_38        J    2089.43    185.27
      1982 Region_4 Store_39    Total   25558.45   2307.60
      1983 Region_4 Store_39        A    1250.16    170.62
      1984 Region_4 Store_39        B    1398.50    172.49
      1985 Region_4 Store_39        C    4401.80    238.92
      1986 Region_4 Store_39        D    3542.51    221.05
      1987 Region_4 Store_39        E    2019.81    164.37
      1988 Region_4 Store_39        F    1765.77    271.36
      1989 Region_4 Store_39        G    3967.80    313.38
      1990 Region_4 Store_39        H    3296.16    320.01
      1991 Region_4 Store_39        I    1955.00    215.47
      1992 Region_4 Store_39        J    1960.94    219.93
      1993 Region_4  Store_4    Total   19942.91   1621.87
      1994 Region_4  Store_4        A    2509.62    118.03
      1995 Region_4  Store_4        B     897.88     32.98
      1996 Region_4  Store_4        C     276.89      5.29
      1997 Region_4  Store_4        D    2066.23    215.05
      1998 Region_4  Store_4        E     783.71    120.78
      1999 Region_4  Store_4        F    3662.19    334.03
      2000 Region_4  Store_4        G    1391.34    171.46
      2001 Region_4  Store_4        H    2040.99    142.25
      2002 Region_4  Store_4        I    3629.69    170.59
      2003 Region_4  Store_4        J    2684.37    311.41
      2004 Region_4 Store_40    Total   19187.54   1983.90
      2005 Region_4 Store_40        A    6330.50    407.02
      2006 Region_4 Store_40        B    2221.21    328.85
      2007 Region_4 Store_40        C     135.19     41.64
      2008 Region_4 Store_40        D    2511.21    306.97
      2009 Region_4 Store_40        E    2391.04    230.11
      2010 Region_4 Store_40        F     980.32     48.17
      2011 Region_4 Store_40        G    1492.82    156.76
      2012 Region_4 Store_40        H     911.28    197.70
      2013 Region_4 Store_40        I    1941.56    179.87
      2014 Region_4 Store_40        J     272.41     86.81
      2015 Region_4 Store_41    Total   15473.45   1718.05
      2016 Region_4 Store_41        A    2365.58    270.79
      2017 Region_4 Store_41        B    1606.12    140.64
      2018 Region_4 Store_41        C    2126.19    189.62
      2019 Region_4 Store_41        D    1975.95    240.04
      2020 Region_4 Store_41        E    3004.81    250.90
      2021 Region_4 Store_41        F     624.56     48.25
      2022 Region_4 Store_41        G    1803.80    205.00
      2023 Region_4 Store_41        I    1045.41    173.87
      2024 Region_4 Store_41        J     921.03    198.94
      2025 Region_4 Store_42    Total   24831.12   2715.93
      2026 Region_4 Store_42        A    1478.91    176.38
      2027 Region_4 Store_42        B    2585.05    216.26
      2028 Region_4 Store_42        C    3209.83    453.78
      2029 Region_4 Store_42        D    2237.33    281.54
      2030 Region_4 Store_42        E    3693.43    343.91
      2031 Region_4 Store_42        F    1368.94    275.15
      2032 Region_4 Store_42        G    3148.42    214.02
      2033 Region_4 Store_42        H    4330.98    389.17
      2034 Region_4 Store_42        I    1357.23    153.65
      2035 Region_4 Store_42        J    1421.00    212.07
      2036 Region_4 Store_43    Total   22235.17   1951.43
      2037 Region_4 Store_43        A    1897.39    149.98
      2038 Region_4 Store_43        B    2955.26    317.57
      2039 Region_4 Store_43        C    3040.84    215.67
      2040 Region_4 Store_43        D    1274.27    162.98
      2041 Region_4 Store_43        E    1968.02    236.66
      2042 Region_4 Store_43        F    4173.03    277.06
      2043 Region_4 Store_43        G    1187.15    155.26
      2044 Region_4 Store_43        H     907.73     73.33
      2045 Region_4 Store_43        I    3141.52    200.17
      2046 Region_4 Store_43        J    1689.96    162.75
      2047 Region_4 Store_44    Total   20780.65   2311.69
      2048 Region_4 Store_44        A    2731.31    284.28
      2049 Region_4 Store_44        B    1563.82    249.94
      2050 Region_4 Store_44        C    1653.79    229.72
      2051 Region_4 Store_44        D    1727.99    173.13
      2052 Region_4 Store_44        E    1863.31    262.00
      2053 Region_4 Store_44        F     891.44    204.75
      2054 Region_4 Store_44        G    2223.89    241.39
      2055 Region_4 Store_44        H    2677.95    244.65
      2056 Region_4 Store_44        I    3486.75    239.66
      2057 Region_4 Store_44        J    1960.40    182.17
      2058 Region_4 Store_45    Total   17889.48   1825.83
      2059 Region_4 Store_45        A    2341.73    230.25
      2060 Region_4 Store_45        B     890.22     38.78
      2061 Region_4 Store_45        C    3036.94    289.77
      2062 Region_4 Store_45        D    3353.70    347.29
      2063 Region_4 Store_45        E    2367.88    318.73
      2064 Region_4 Store_45        F    1761.15    208.99
      2065 Region_4 Store_45        G     799.08     78.72
      2066 Region_4 Store_45        H    1089.99    146.29
      2067 Region_4 Store_45        I    1313.44     96.93
      2068 Region_4 Store_45        J     935.35     70.08
      2069 Region_4 Store_46    Total   17558.98   1907.65
      2070 Region_4 Store_46        A     118.60     94.79
      2071 Region_4 Store_46        B    2574.89    356.69
      2072 Region_4 Store_46        C    1232.13     73.89
      2073 Region_4 Store_46        D     950.80     30.38
      2074 Region_4 Store_46        E    1621.67    157.71
      2075 Region_4 Store_46        F    2620.65    324.18
      2076 Region_4 Store_46        G    2644.58    351.45
      2077 Region_4 Store_46        H    2757.10    208.93
      2078 Region_4 Store_46        I    1913.06    196.71
      2079 Region_4 Store_46        J    1125.50    112.92
      2080 Region_4 Store_47    Total   21217.40   2052.58
      2081 Region_4 Store_47        A    2464.44    169.85
      2082 Region_4 Store_47        B    3218.71    381.80
      2083 Region_4 Store_47        C     370.48     44.68
      2084 Region_4 Store_47        D    1897.67    157.76
      2085 Region_4 Store_47        E     339.01    106.61
      2086 Region_4 Store_47        F    2093.89    210.86
      2087 Region_4 Store_47        G    3218.56    201.31
      2088 Region_4 Store_47        H    2618.45    311.51
      2089 Region_4 Store_47        I    4193.18    365.30
      2090 Region_4 Store_47        J     803.01    102.90
      2091 Region_4 Store_48    Total   17938.49   1660.02
      2092 Region_4 Store_48        A    3150.29    303.42
      2093 Region_4 Store_48        B    1904.80    116.40
      2094 Region_4 Store_48        C     759.41     44.79
      2095 Region_4 Store_48        D    1201.18     88.85
      2096 Region_4 Store_48        E    1185.81    156.15
      2097 Region_4 Store_48        F    3224.01    266.82
      2098 Region_4 Store_48        G    1722.51    244.67
      2099 Region_4 Store_48        H    3380.74    264.33
      2100 Region_4 Store_48        I     237.94     20.18
      2101 Region_4 Store_48        J    1171.80    154.41
      2102 Region_4 Store_49    Total   22802.92   1991.39
      2103 Region_4 Store_49        A    3364.98    305.18
      2104 Region_4 Store_49        B    2166.65    330.86
      2105 Region_4 Store_49        C     224.96    113.35
      2106 Region_4 Store_49        D    2386.87    192.67
      2107 Region_4 Store_49        E    1980.18    199.87
      2108 Region_4 Store_49        F    2786.38    222.50
      2109 Region_4 Store_49        G    5802.32    314.98
      2110 Region_4 Store_49        H     641.73     58.47
      2111 Region_4 Store_49        I     119.31     24.35
      2112 Region_4 Store_49        J    3329.54    229.16
      2113 Region_4  Store_5    Total   18768.40   1470.54
      2114 Region_4  Store_5        A    2081.30    248.47
      2115 Region_4  Store_5        B     778.05     55.59
      2116 Region_4  Store_5        C    3074.25    246.70
      2117 Region_4  Store_5        D    2232.94    119.26
      2118 Region_4  Store_5        E    2677.19    233.38
      2119 Region_4  Store_5        F    2833.88    194.52
      2120 Region_4  Store_5        G    1112.03    126.07
      2121 Region_4  Store_5        H    2947.26    143.10
      2122 Region_4  Store_5        I      33.55     33.03
      2123 Region_4  Store_5        J     997.95     70.42
      2124 Region_4 Store_50    Total   17126.42   1821.21
      2125 Region_4 Store_50        A    1361.98    229.80
      2126 Region_4 Store_50        B    1567.06    233.32
      2127 Region_4 Store_50        C     972.80    123.67
      2128 Region_4 Store_50        D    1089.39    147.45
      2129 Region_4 Store_50        E     425.18    127.93
      2130 Region_4 Store_50        F    2665.91    208.92
      2131 Region_4 Store_50        G    2932.39    194.59
      2132 Region_4 Store_50        H    1619.28    186.61
      2133 Region_4 Store_50        J    4492.43    368.92
      2134 Region_4  Store_6    Total   18119.50   1870.30
      2135 Region_4  Store_6        A     995.04     27.17
      2136 Region_4  Store_6        B     787.15      6.96
      2137 Region_4  Store_6        C    2131.12    147.75
      2138 Region_4  Store_6        D    3657.56    324.40
      2139 Region_4  Store_6        E    1769.28    309.40
      2140 Region_4  Store_6        F    1152.61    111.49
      2141 Region_4  Store_6        G    1810.12    313.46
      2142 Region_4  Store_6        H    2102.98    180.94
      2143 Region_4  Store_6        I    1572.95    198.43
      2144 Region_4  Store_6        J    2140.69    250.30
      2145 Region_4  Store_7    Total   17378.92   2031.65
      2146 Region_4  Store_7        A     462.05    102.57
      2147 Region_4  Store_7        B    2858.64    279.17
      2148 Region_4  Store_7        C    2741.61    364.77
      2149 Region_4  Store_7        D    1275.26    249.22
      2150 Region_4  Store_7        E    1691.89    184.64
      2151 Region_4  Store_7        F    1835.00    154.23
      2152 Region_4  Store_7        G    2907.43    372.50
      2153 Region_4  Store_7        H    1992.06    105.77
      2154 Region_4  Store_7        I     713.96    123.55
      2155 Region_4  Store_7        J     901.02     95.23
      2156 Region_4  Store_8    Total   21959.35   2261.77
      2157 Region_4  Store_8        A    3052.35    339.04
      2158 Region_4  Store_8        B    1167.67     82.78
      2159 Region_4  Store_8        C    3507.49    221.45
      2160 Region_4  Store_8        D    1707.62    188.04
      2161 Region_4  Store_8        E    1510.42    154.62
      2162 Region_4  Store_8        F    1547.96    261.09
      2163 Region_4  Store_8        G    2099.15    173.42
      2164 Region_4  Store_8        H    3117.45    235.08
      2165 Region_4  Store_8        I    2333.52    321.46
      2166 Region_4  Store_8        J    1915.72    284.79
      2167 Region_4  Store_9    Total   15976.29   1790.31
      2168 Region_4  Store_9        A    2228.00    362.69
      2169 Region_4  Store_9        B    3059.23    364.63
      2170 Region_4  Store_9        C    1623.48    173.54
      2171 Region_4  Store_9        D     728.32     65.41
      2172 Region_4  Store_9        E    4247.64    386.73
      2173 Region_4  Store_9        F     957.93    123.83
      2174 Region_4  Store_9        G    1132.76    131.27
      2175 Region_4  Store_9        H      67.21     54.94
      2176 Region_4  Store_9        I     994.49     28.18
      2177 Region_4  Store_9        J     937.23     99.09
      2178 Region_5    Total    Total 1029631.18 104040.28
      2179 Region_5  Store_1    Total   22074.92   2205.39
      2180 Region_5  Store_1        A    1665.27    324.82
      2181 Region_5  Store_1        B     963.63    111.71
      2182 Region_5  Store_1        C    2581.16    187.53
      2183 Region_5  Store_1        D    1698.93    184.52
      2184 Region_5  Store_1        E    1919.22    144.73
      2185 Region_5  Store_1        F    1949.71     76.50
      2186 Region_5  Store_1        G      81.07     29.04
      2187 Region_5  Store_1        H    4345.87    509.36
      2188 Region_5  Store_1        I    5013.57    469.60
      2189 Region_5  Store_1        J    1856.49    167.58
      2190 Region_5 Store_10    Total   21703.05   2054.55
      2191 Region_5 Store_10        A    2081.81    349.13
      2192 Region_5 Store_10        B    2615.40    247.97
      2193 Region_5 Store_10        C    2444.57     84.71
      2194 Region_5 Store_10        D    3148.14    292.38
      2195 Region_5 Store_10        E    3709.43    309.87
      2196 Region_5 Store_10        F    1857.70    213.63
      2197 Region_5 Store_10        G    1850.37    211.02
      2198 Region_5 Store_10        H    1499.02    165.87
      2199 Region_5 Store_10        I     135.40     62.12
      2200 Region_5 Store_10        J    2361.21    117.85
      2201 Region_5 Store_11    Total   21348.15   1906.64
      2202 Region_5 Store_11        A    2427.64    108.13
      2203 Region_5 Store_11        B    3094.36    180.30
      2204 Region_5 Store_11        C    1671.48    214.72
      2205 Region_5 Store_11        D     207.95     54.04
      2206 Region_5 Store_11        E    1128.38    137.45
      2207 Region_5 Store_11        F    2106.96    155.92
      2208 Region_5 Store_11        G    2582.31    258.31
      2209 Region_5 Store_11        H    1049.72    173.48
      2210 Region_5 Store_11        I    4504.04    393.06
      2211 Region_5 Store_11        J    2575.31    231.23
      2212 Region_5 Store_12    Total   23730.41   2535.80
      2213 Region_5 Store_12        A    3407.42    281.78
      2214 Region_5 Store_12        B    1721.01    276.88
      2215 Region_5 Store_12        C    2047.39    189.19
      2216 Region_5 Store_12        D    2525.63    191.72
      2217 Region_5 Store_12        E    4087.38    425.36
      2218 Region_5 Store_12        F     801.32    136.23
      2219 Region_5 Store_12        G    2805.23    300.70
      2220 Region_5 Store_12        H    1879.36    156.59
      2221 Region_5 Store_12        I    3735.25    401.23
      2222 Region_5 Store_12        J     720.42    176.12
      2223 Region_5 Store_13    Total   21356.63   2253.44
      2224 Region_5 Store_13        A    3231.24    456.59
      2225 Region_5 Store_13        B    1169.60    137.45
      2226 Region_5 Store_13        C     972.37    150.47
      2227 Region_5 Store_13        D    2042.71    183.36
      2228 Region_5 Store_13        E    1342.39    238.97
      2229 Region_5 Store_13        F    3001.77    227.88
      2230 Region_5 Store_13        G    4005.26    321.35
      2231 Region_5 Store_13        H    2157.69    288.62
      2232 Region_5 Store_13        I    2054.93    183.38
      2233 Region_5 Store_13        J    1378.67     65.37
      2234 Region_5 Store_14    Total   28258.73   2954.79
      2235 Region_5 Store_14        A    1730.95    225.98
      2236 Region_5 Store_14        B    3867.53    266.80
      2237 Region_5 Store_14        C    2225.46    262.03
      2238 Region_5 Store_14        D    2140.43    273.09
      2239 Region_5 Store_14        E    2202.74    412.50
      2240 Region_5 Store_14        F    4583.76    441.78
      2241 Region_5 Store_14        G    2488.30    286.64
      2242 Region_5 Store_14        H    2828.00    259.52
      2243 Region_5 Store_14        I    3271.45    296.06
      2244 Region_5 Store_14        J    2920.11    230.39
      2245 Region_5 Store_15    Total   23263.50   2124.46
      2246 Region_5 Store_15        A    2977.02    100.27
      2247 Region_5 Store_15        B    2621.47    194.99
      2248 Region_5 Store_15        C    1533.69    267.97
      2249 Region_5 Store_15        D    2084.58    132.10
      2250 Region_5 Store_15        E    2381.65    244.29
      2251 Region_5 Store_15        F    4248.97    337.26
      2252 Region_5 Store_15        G    1302.06    320.36
      2253 Region_5 Store_15        H    1553.10    172.14
      2254 Region_5 Store_15        I    2125.01    137.50
      2255 Region_5 Store_15        J    2435.95    217.58
      2256 Region_5 Store_16    Total   19803.52   2011.86
      2257 Region_5 Store_16        A    1821.60    110.04
      2258 Region_5 Store_16        B    1587.10    215.48
      2259 Region_5 Store_16        C    1777.36    199.30
      2260 Region_5 Store_16        D    1988.10    178.51
      2261 Region_5 Store_16        F    2608.88    238.63
      2262 Region_5 Store_16        G    1182.77    118.20
      2263 Region_5 Store_16        H    3659.23    277.59
      2264 Region_5 Store_16        I    3618.72    470.30
      2265 Region_5 Store_16        J    1559.76    203.81
      2266 Region_5 Store_17    Total   27843.47   2701.97
      2267 Region_5 Store_17        A    2902.92    308.16
      2268 Region_5 Store_17        B    3737.47    356.58
      2269 Region_5 Store_17        C    3778.30    333.11
      2270 Region_5 Store_17        D    1001.63    173.60
      2271 Region_5 Store_17        E    1791.15    176.76
      2272 Region_5 Store_17        F    4913.59    428.31
      2273 Region_5 Store_17        G    3408.81    241.74
      2274 Region_5 Store_17        H    2381.91    263.94
      2275 Region_5 Store_17        I    1718.34    196.02
      2276 Region_5 Store_17        J    2209.35    223.75
      2277 Region_5 Store_18    Total   15626.56   1425.74
      2278 Region_5 Store_18        A     520.11     26.43
      2279 Region_5 Store_18        B    1534.95    173.27
      2280 Region_5 Store_18        C    1423.36    165.13
      2281 Region_5 Store_18        D    2152.80    180.89
      2282 Region_5 Store_18        E    4488.60    296.32
      2283 Region_5 Store_18        F    1117.14    127.37
      2284 Region_5 Store_18        G    1063.98    119.90
      2285 Region_5 Store_18        H    3140.20    283.27
      2286 Region_5 Store_18        J     185.42     53.16
      2287 Region_5 Store_19    Total   17583.49   2255.14
      2288 Region_5 Store_19        A    1839.36    350.38
      2289 Region_5 Store_19        B    2029.11    191.46
      2290 Region_5 Store_19        C    1344.91     94.04
      2291 Region_5 Store_19        D    3205.89    301.34
      2292 Region_5 Store_19        E      54.49     87.27
      2293 Region_5 Store_19        F    3247.71    335.91
      2294 Region_5 Store_19        G    2212.36    330.11
      2295 Region_5 Store_19        I    2842.41    332.84
      2296 Region_5 Store_19        J     807.25    231.79
      2297 Region_5  Store_2    Total   27719.55   2398.08
      2298 Region_5  Store_2        A    3321.22    382.96
      2299 Region_5  Store_2        B    5449.14    380.67
      2300 Region_5  Store_2        C    4492.29    284.51
      2301 Region_5  Store_2        D    2207.60    195.25
      2302 Region_5  Store_2        E    3298.19    310.65
      2303 Region_5  Store_2        F    1548.40    226.13
      2304 Region_5  Store_2        G    2030.29    165.89
      2305 Region_5  Store_2        H    1236.20    103.44
      2306 Region_5  Store_2        I    2188.34    246.10
      2307 Region_5  Store_2        J    1947.88    102.48
      2308 Region_5 Store_20    Total   11398.40   1232.23
      2309 Region_5 Store_20        A     948.92    204.51
      2310 Region_5 Store_20        B     303.14    117.41
      2311 Region_5 Store_20        C    2407.26    205.97
      2312 Region_5 Store_20        D     935.83     99.61
      2313 Region_5 Store_20        E     520.73     35.75
      2314 Region_5 Store_20        F     470.88     73.26
      2315 Region_5 Store_20        G     712.86    131.12
      2316 Region_5 Store_20        H    3630.10    261.43
      2317 Region_5 Store_20        I     769.00     55.39
      2318 Region_5 Store_20        J     699.68     47.78
      2319 Region_5 Store_21    Total   16330.46   1690.20
      2320 Region_5 Store_21        A    1175.90     86.93
      2321 Region_5 Store_21        B    2284.05    283.72
      2322 Region_5 Store_21        C    2095.02    128.47
      2323 Region_5 Store_21        D    2389.31    226.99
      2324 Region_5 Store_21        E    1567.79    229.60
      2325 Region_5 Store_21        F    2645.54    245.68
      2326 Region_5 Store_21        G    2367.81    211.10
      2327 Region_5 Store_21        H     280.73    105.45
      2328 Region_5 Store_21        I    1256.09    113.33
      2329 Region_5 Store_21        J     268.22     58.93
      2330 Region_5 Store_22    Total   25807.75   2467.69
      2331 Region_5 Store_22        A    2549.81    288.83
      2332 Region_5 Store_22        B    2433.48    247.30
      2333 Region_5 Store_22        C    2687.47    311.48
      2334 Region_5 Store_22        D    3050.65    305.95
      2335 Region_5 Store_22        E    4681.54    208.06
      2336 Region_5 Store_22        F    1628.25    101.96
      2337 Region_5 Store_22        G    2049.82    239.40
      2338 Region_5 Store_22        H    3390.45    384.56
      2339 Region_5 Store_22        I    1304.67    171.33
      2340 Region_5 Store_22        J    2031.61    208.82
      2341 Region_5 Store_23    Total   21221.11   2151.79
      2342 Region_5 Store_23        A    1484.66    133.36
      2343 Region_5 Store_23        B    2138.77    232.55
      2344 Region_5 Store_23        C    3857.25    384.53
      2345 Region_5 Store_23        D    1033.83    173.02
      2346 Region_5 Store_23        E    2999.19    253.86
      2347 Region_5 Store_23        F    2316.33    226.64
      2348 Region_5 Store_23        G    3314.77    288.04
      2349 Region_5 Store_23        H    1318.08    104.18
      2350 Region_5 Store_23        I    2080.41    241.26
      2351 Region_5 Store_23        J     677.82    114.35
      2352 Region_5 Store_24    Total   21115.99   1938.27
      2353 Region_5 Store_24        A    2633.44    292.51
      2354 Region_5 Store_24        B     220.06     46.49
      2355 Region_5 Store_24        C    3173.57    348.61
      2356 Region_5 Store_24        D    4813.95    382.62
      2357 Region_5 Store_24        E    2115.18    134.66
      2358 Region_5 Store_24        F     397.65     46.05
      2359 Region_5 Store_24        G    2848.70    231.39
      2360 Region_5 Store_24        H    3273.63    354.27
      2361 Region_5 Store_24        I    1639.81    101.67
      2362 Region_5 Store_25    Total   13006.39   1648.57
      2363 Region_5 Store_25        A    3743.95    385.95
      2364 Region_5 Store_25        C     898.08    116.00
      2365 Region_5 Store_25        D    2138.12    227.31
      2366 Region_5 Store_25        E    1078.57    154.87
      2367 Region_5 Store_25        F    1257.62    160.17
      2368 Region_5 Store_25        G    1454.38    301.64
      2369 Region_5 Store_25        H     447.44    165.44
      2370 Region_5 Store_25        I     683.27     63.42
      2371 Region_5 Store_25        J    1304.96     73.77
      2372 Region_5 Store_26    Total   16206.43   1841.72
      2373 Region_5 Store_26        A    4608.51    315.78
      2374 Region_5 Store_26        B    1198.78    162.36
      2375 Region_5 Store_26        C    1169.35    202.76
      2376 Region_5 Store_26        D    3414.52    336.44
      2377 Region_5 Store_26        E     140.12    150.29
      2378 Region_5 Store_26        F    1978.29    191.55
      2379 Region_5 Store_26        G     892.33     21.62
      2380 Region_5 Store_26        H     415.11    127.47
      2381 Region_5 Store_26        I    2100.04    272.35
      2382 Region_5 Store_26        J     289.38     61.10
      2383 Region_5 Store_27    Total   19170.87   2006.36
      2384 Region_5 Store_27        B    1563.41     84.21
      2385 Region_5 Store_27        C    1891.14    171.24
      2386 Region_5 Store_27        D     870.47     27.35
      2387 Region_5 Store_27        E    4458.00    429.39
      2388 Region_5 Store_27        F    1147.16    140.93
      2389 Region_5 Store_27        G    1965.68    170.00
      2390 Region_5 Store_27        H    2261.93    310.40
      2391 Region_5 Store_27        I    3165.04    385.87
      2392 Region_5 Store_27        J    1848.04    286.97
      2393 Region_5 Store_28    Total   21977.57   2546.28
      2394 Region_5 Store_28        A    3683.34    265.79
      2395 Region_5 Store_28        B    2097.19    303.98
      2396 Region_5 Store_28        C    2557.23    315.90
      2397 Region_5 Store_28        D    4040.00    418.72
      2398 Region_5 Store_28        E    1721.31    206.40
      2399 Region_5 Store_28        F    2814.51    269.30
      2400 Region_5 Store_28        G    1647.27    207.57
      2401 Region_5 Store_28        H    2550.44    442.71
      2402 Region_5 Store_28        J     866.28    115.91
      2403 Region_5 Store_29    Total   20521.75   1899.54
      2404 Region_5 Store_29        A     617.35     21.05
      2405 Region_5 Store_29        B    3263.14    330.79
      2406 Region_5 Store_29        C    2070.89    307.75
      2407 Region_5 Store_29        D    1468.52    128.82
      2408 Region_5 Store_29        E    2846.22    296.27
      2409 Region_5 Store_29        F    1046.14    149.60
      2410 Region_5 Store_29        G    3581.30    287.21
      2411 Region_5 Store_29        I    2837.24    270.60
      2412 Region_5 Store_29        J    2790.95    107.45
      2413 Region_5  Store_3    Total   22692.96   2249.81
      2414 Region_5  Store_3        A    1692.89    151.61
      2415 Region_5  Store_3        B    1262.85    170.67
      2416 Region_5  Store_3        C    3913.74    246.74
      2417 Region_5  Store_3        D     119.19     74.66
      2418 Region_5  Store_3        E     680.05     56.99
      2419 Region_5  Store_3        F    4511.37    633.01
      2420 Region_5  Store_3        G    1961.99    159.57
      2421 Region_5  Store_3        H    1326.75    141.28
      2422 Region_5  Store_3        I    3514.59    456.05
      2423 Region_5  Store_3        J    3709.54    159.23
      2424 Region_5 Store_30    Total   25511.28   2389.27
      2425 Region_5 Store_30        A      63.31     20.88
      2426 Region_5 Store_30        B    4042.00    302.97
      2427 Region_5 Store_30        C    2681.35    369.67
      2428 Region_5 Store_30        D     987.79     90.17
      2429 Region_5 Store_30        E    1547.47    286.05
      2430 Region_5 Store_30        F    3981.60    432.45
      2431 Region_5 Store_30        G    2077.88    192.62
      2432 Region_5 Store_30        H    3039.88    213.25
      2433 Region_5 Store_30        I    4112.55    221.12
      2434 Region_5 Store_30        J    2977.45    260.09
      2435 Region_5 Store_31    Total   17845.57   1742.92
      2436 Region_5 Store_31        A    2148.83    150.20
      2437 Region_5 Store_31        B     850.79    184.96
      2438 Region_5 Store_31        C    2141.81    284.05
      2439 Region_5 Store_31        D     758.15     68.72
      2440 Region_5 Store_31        E     814.78    148.06
      2441 Region_5 Store_31        F    4211.06    283.07
      2442 Region_5 Store_31        G    1757.78    121.81
      2443 Region_5 Store_31        H    1714.78    213.93
      2444 Region_5 Store_31        I    1435.00    123.87
      2445 Region_5 Store_31        J    2012.59    164.25
      2446 Region_5 Store_32    Total   18250.12   1836.05
      2447 Region_5 Store_32        A    1919.26    279.69
      2448 Region_5 Store_32        B    2544.37    167.22
      2449 Region_5 Store_32        C    1673.46     84.29
      2450 Region_5 Store_32        D    2572.95    316.52
      2451 Region_5 Store_32        E    1782.48    169.03
      2452 Region_5 Store_32        G    1735.51    177.71
      2453 Region_5 Store_32        H    2562.32    191.52
      2454 Region_5 Store_32        I    2352.75    290.89
      2455 Region_5 Store_32        J    1107.02    159.18
      2456 Region_5 Store_33    Total   15186.07   1554.19
      2457 Region_5 Store_33        A    1064.09     97.81
      2458 Region_5 Store_33        B    1580.86    164.90
      2459 Region_5 Store_33        C    2893.65    206.36
      2460 Region_5 Store_33        D    1806.88    243.22
      2461 Region_5 Store_33        E    2320.84    283.06
      2462 Region_5 Store_33        F    1668.79    142.49
      2463 Region_5 Store_33        G    1592.50    155.47
      2464 Region_5 Store_33        H     434.78     65.44
      2465 Region_5 Store_33        I     943.13    121.41
      2466 Region_5 Store_33        J     880.55     74.03
      2467 Region_5 Store_34    Total   18137.03   2006.50
      2468 Region_5 Store_34        A     917.70    142.07
      2469 Region_5 Store_34        B    1531.69    158.04
      2470 Region_5 Store_34        C    3376.53    293.10
      2471 Region_5 Store_34        D    1899.38    170.28
      2472 Region_5 Store_34        E    1367.40    215.63
      2473 Region_5 Store_34        F    1666.47    177.37
      2474 Region_5 Store_34        G    4043.77    481.76
      2475 Region_5 Store_34        H    1526.82    123.19
      2476 Region_5 Store_34        I    1807.27    245.06
      2477 Region_5 Store_35    Total   21884.95   2101.97
      2478 Region_5 Store_35        A    1398.40    189.33
      2479 Region_5 Store_35        B    1033.97    169.84
      2480 Region_5 Store_35        C    4064.11    391.09
      2481 Region_5 Store_35        D    1891.52    147.97
      2482 Region_5 Store_35        E    3607.55    408.87
      2483 Region_5 Store_35        F    1175.01    144.49
      2484 Region_5 Store_35        G     753.45     57.98
      2485 Region_5 Store_35        H    3228.04    274.37
      2486 Region_5 Store_35        I    1784.93    153.74
      2487 Region_5 Store_35        J    2947.97    164.29
      2488 Region_5 Store_36    Total   16132.25   1825.15
      2489 Region_5 Store_36        A     869.20     90.41
      2490 Region_5 Store_36        B    1578.76    256.49
      2491 Region_5 Store_36        C    3081.66    308.22
      2492 Region_5 Store_36        D    2886.56    290.09
      2493 Region_5 Store_36        E     757.92     52.55
      2494 Region_5 Store_36        F    4357.07    420.99
      2495 Region_5 Store_36        H     653.08    177.61
      2496 Region_5 Store_36        I     991.79     92.98
      2497 Region_5 Store_36        J     956.21    135.81
      2498 Region_5 Store_37    Total   13676.88   1649.83
      2499 Region_5 Store_37        A     669.08    169.15
      2500 Region_5 Store_37        B     263.82     54.07
      2501 Region_5 Store_37        C    1959.43    260.27
      2502 Region_5 Store_37        D    1848.14    155.43
      2503 Region_5 Store_37        E     451.09     37.47
      2504 Region_5 Store_37        F    1801.21    245.99
      2505 Region_5 Store_37        G     522.23    118.03
      2506 Region_5 Store_37        H    4312.17    325.81
      2507 Region_5 Store_37        I     499.18    159.35
      2508 Region_5 Store_37        J    1350.53    124.26
      2509 Region_5 Store_38    Total   16600.22   1766.54
      2510 Region_5 Store_38        A     881.64    170.42
      2511 Region_5 Store_38        B    1664.67    243.14
      2512 Region_5 Store_38        C     637.17     33.56
      2513 Region_5 Store_38        D    2577.79    401.84
      2514 Region_5 Store_38        E    2178.42    198.56
      2515 Region_5 Store_38        F     872.65     74.16
      2516 Region_5 Store_38        G     868.11    177.77
      2517 Region_5 Store_38        I    5991.00    380.90
      2518 Region_5 Store_38        J     928.77     86.19
      2519 Region_5 Store_39    Total   20095.47   2003.05
      2520 Region_5 Store_39        A    2283.55    228.59
      2521 Region_5 Store_39        B    2256.16    425.84
      2522 Region_5 Store_39        C    1641.54    144.24
      2523 Region_5 Store_39        D    1323.26    124.53
      2524 Region_5 Store_39        E    3638.63    261.55
      2525 Region_5 Store_39        F    1518.19    141.56
      2526 Region_5 Store_39        G    2407.33    203.65
      2527 Region_5 Store_39        H    2528.18    309.82
      2528 Region_5 Store_39        I    1107.56    100.07
      2529 Region_5 Store_39        J    1391.07     63.20
      2530 Region_5  Store_4    Total   13372.67   1805.89
      2531 Region_5  Store_4        A    1474.65    250.36
      2532 Region_5  Store_4        B    2012.08    273.26
      2533 Region_5  Store_4        C    1107.48    139.01
      2534 Region_5  Store_4        D    1095.48    208.01
      2535 Region_5  Store_4        E    1080.38    190.66
      2536 Region_5  Store_4        G    2088.21    339.99
      2537 Region_5  Store_4        H    2852.10    242.72
      2538 Region_5  Store_4        I      88.84     60.99
      2539 Region_5  Store_4        J    1573.45    100.89
      2540 Region_5 Store_40    Total   24494.72   2731.16
      2541 Region_5 Store_40        A    3537.45    275.13
      2542 Region_5 Store_40        B    3563.02    346.18
      2543 Region_5 Store_40        C    2881.76    267.02
      2544 Region_5 Store_40        D    2032.14    173.40
      2545 Region_5 Store_40        E     867.26    338.04
      2546 Region_5 Store_40        F     843.72    195.09
      2547 Region_5 Store_40        G    2466.12    200.26
      2548 Region_5 Store_40        H    2824.02    365.12
      2549 Region_5 Store_40        I    3090.74    297.70
      2550 Region_5 Store_40        J    2388.49    273.22
      2551 Region_5 Store_41    Total   16654.43   1590.77
      2552 Region_5 Store_41        A    2288.64    237.22
      2553 Region_5 Store_41        B    2199.02    230.67
      2554 Region_5 Store_41        C    1220.41    150.43
      2555 Region_5 Store_41        D     875.91     41.45
      2556 Region_5 Store_41        E    2293.73    151.09
      2557 Region_5 Store_41        F    1316.15    147.45
      2558 Region_5 Store_41        G    2464.95    283.25
      2559 Region_5 Store_41        H    1381.48    115.97
      2560 Region_5 Store_41        I    1153.50     70.05
      2561 Region_5 Store_41        J    1460.64    163.19
      2562 Region_5 Store_42    Total   17638.57   1628.92
      2563 Region_5 Store_42        A    1914.46    173.27
      2564 Region_5 Store_42        B    2028.62    109.86
      2565 Region_5 Store_42        C    1016.22     67.45
      2566 Region_5 Store_42        D    1675.80     86.67
      2567 Region_5 Store_42        E    2862.16    275.50
      2568 Region_5 Store_42        F    1322.84    155.58
      2569 Region_5 Store_42        H    1500.79    160.04
      2570 Region_5 Store_42        I    3138.11    436.14
      2571 Region_5 Store_42        J    2179.57    164.41
      2572 Region_5 Store_43    Total   30284.20   2518.03
      2573 Region_5 Store_43        A    2387.67    140.40
      2574 Region_5 Store_43        B    1886.39    272.13
      2575 Region_5 Store_43        C    3581.61    272.38
      2576 Region_5 Store_43        D    2860.71    279.85
      2577 Region_5 Store_43        E    2160.13    134.96
      2578 Region_5 Store_43        F    1537.18    105.50
      2579 Region_5 Store_43        G    3785.76    246.84
      2580 Region_5 Store_43        H    5176.53    497.81
      2581 Region_5 Store_43        I    2555.34    206.28
      2582 Region_5 Store_43        J    4352.88    361.88
      2583 Region_5 Store_44    Total   28616.69   2607.22
      2584 Region_5 Store_44        A    2461.09    316.84
      2585 Region_5 Store_44        B     434.52     33.53
      2586 Region_5 Store_44        C    2318.91     96.08
      2587 Region_5 Store_44        D     659.48     55.67
      2588 Region_5 Store_44        E    5779.40    378.37
      2589 Region_5 Store_44        F    4567.49    346.60
      2590 Region_5 Store_44        G    2824.11    329.35
      2591 Region_5 Store_44        H    2651.81    292.60
      2592 Region_5 Store_44        I    4029.29    496.38
      2593 Region_5 Store_44        J    2890.59    261.80
      2594 Region_5 Store_45    Total   23990.01   2305.93
      2595 Region_5 Store_45        A    1162.35    140.81
      2596 Region_5 Store_45        B     493.74    111.62
      2597 Region_5 Store_45        C    3350.92    270.09
      2598 Region_5 Store_45        D    3084.48    241.00
      2599 Region_5 Store_45        E    4168.33    334.51
      2600 Region_5 Store_45        F    2430.95    434.38
      2601 Region_5 Store_45        G    1591.93     91.47
      2602 Region_5 Store_45        H    2397.77    263.96
      2603 Region_5 Store_45        I    2703.65    253.61
      2604 Region_5 Store_45        J    2605.89    164.48
      2605 Region_5 Store_46    Total   21732.41   2240.31
      2606 Region_5 Store_46        A    1256.38    197.66
      2607 Region_5 Store_46        B    3444.31    367.24
      2608 Region_5 Store_46        C    2596.26    217.07
      2609 Region_5 Store_46        D    2458.85    148.40
      2610 Region_5 Store_46        E    1095.53    204.78
      2611 Region_5 Store_46        F    4326.23    403.61
      2612 Region_5 Store_46        G    1330.60    185.36
      2613 Region_5 Store_46        H    1514.18    200.02
      2614 Region_5 Store_46        I    1366.97    103.27
      2615 Region_5 Store_46        J    2343.10    212.90
      2616 Region_5 Store_47    Total   18829.68   2412.83
      2617 Region_5 Store_47        A    2624.10    241.29
      2618 Region_5 Store_47        B    2532.36    355.92
      2619 Region_5 Store_47        C    2290.54    254.19
      2620 Region_5 Store_47        D    2169.26    195.84
      2621 Region_5 Store_47        E     519.51    132.90
      2622 Region_5 Store_47        F    1025.90    181.07
      2623 Region_5 Store_47        G    3613.10    354.02
      2624 Region_5 Store_47        H    1199.53    212.33
      2625 Region_5 Store_47        I     509.87     94.33
      2626 Region_5 Store_47        J    2345.51    390.94
      2627 Region_5 Store_48    Total   21937.32   2092.83
      2628 Region_5 Store_48        A    1984.94    292.05
      2629 Region_5 Store_48        B    2188.54    180.85
      2630 Region_5 Store_48        C    2864.51    287.14
      2631 Region_5 Store_48        D    2164.81    159.23
      2632 Region_5 Store_48        E    3066.34    237.57
      2633 Region_5 Store_48        F    1888.97    196.86
      2634 Region_5 Store_48        G    1340.79    114.06
      2635 Region_5 Store_48        H    1423.70    229.10
      2636 Region_5 Store_48        I    2185.46    144.83
      2637 Region_5 Store_48        J    2829.26    251.14
      2638 Region_5 Store_49    Total   15120.70   1788.31
      2639 Region_5 Store_49        A     502.87    143.80
      2640 Region_5 Store_49        B    3180.76    519.02
      2641 Region_5 Store_49        C    1719.27    214.77
      2642 Region_5 Store_49        E    1544.54    241.82
      2643 Region_5 Store_49        F     451.59     48.43
      2644 Region_5 Store_49        G    1647.49     70.65
      2645 Region_5 Store_49        H    2110.75    168.55
      2646 Region_5 Store_49        I    2586.76    194.84
      2647 Region_5 Store_49        J    1376.67    186.43
      2648 Region_5  Store_5    Total   24603.85   2249.40
      2649 Region_5  Store_5        A    1257.67    137.36
      2650 Region_5  Store_5        B    2469.70    356.74
      2651 Region_5  Store_5        C    1210.56    166.30
      2652 Region_5  Store_5        D    5010.55    326.10
      2653 Region_5  Store_5        E    4514.44    573.45
      2654 Region_5  Store_5        G    4878.28    287.65
      2655 Region_5  Store_5        H     999.07    115.55
      2656 Region_5  Store_5        I    2702.87    149.16
      2657 Region_5  Store_5        J    1560.71    137.09
      2658 Region_5 Store_50    Total   16601.17   1619.69
      2659 Region_5 Store_50        A    3916.18    320.54
      2660 Region_5 Store_50        B     814.33     82.92
      2661 Region_5 Store_50        C    2319.51    268.72
      2662 Region_5 Store_50        D    2407.04    241.71
      2663 Region_5 Store_50        E    2393.80    234.77
      2664 Region_5 Store_50        G    1302.43    158.02
      2665 Region_5 Store_50        H     854.69     70.21
      2666 Region_5 Store_50        I     708.16     37.10
      2667 Region_5 Store_50        J    1885.03    205.70
      2668 Region_5  Store_6    Total   28138.63   2439.31
      2669 Region_5  Store_6        A    1432.62     91.22
      2670 Region_5  Store_6        B    5276.71    357.99
      2671 Region_5  Store_6        C    1357.02    174.68
      2672 Region_5  Store_6        D    3787.70    340.73
      2673 Region_5  Store_6        E    2830.13    197.48
      2674 Region_5  Store_6        F    3209.12    389.14
      2675 Region_5  Store_6        G    5138.70    454.25
      2676 Region_5  Store_6        H    1264.87     48.57
      2677 Region_5  Store_6        I    2081.19    238.64
      2678 Region_5  Store_6        J    1760.57    146.61
      2679 Region_5  Store_7    Total   26034.56   2223.50
      2680 Region_5  Store_7        A    2169.17    209.09
      2681 Region_5  Store_7        B    3838.85    182.43
      2682 Region_5  Store_7        C    2492.77    258.97
      2683 Region_5  Store_7        D    3215.42    279.15
      2684 Region_5  Store_7        E    3235.34    268.92
      2685 Region_5  Store_7        F    3448.27    435.76
      2686 Region_5  Store_7        G    2729.11    187.28
      2687 Region_5  Store_7        H    3156.96    212.84
      2688 Region_5  Store_7        I     244.26     44.50
      2689 Region_5  Store_7        J    1504.41    144.56
      2690 Region_5  Store_8    Total   16557.49   2162.19
      2691 Region_5  Store_8        A     404.73     56.66
      2692 Region_5  Store_8        B     641.04    149.94
      2693 Region_5  Store_8        C    2177.15    183.69
      2694 Region_5  Store_8        D    1975.27    368.18
      2695 Region_5  Store_8        E    1604.32    102.09
      2696 Region_5  Store_8        F    2963.36    372.42
      2697 Region_5  Store_8        G     792.96    167.73
      2698 Region_5  Store_8        H     983.90    181.09
      2699 Region_5  Store_8        I    3658.69    422.45
      2700 Region_5  Store_8        J    1356.07    157.94
      2701 Region_5  Store_9    Total   21942.58   2248.20
      2702 Region_5  Store_9        A    2071.15    194.46
      2703 Region_5  Store_9        B    2179.92    108.42
      2704 Region_5  Store_9        C    1750.97    177.36
      2705 Region_5  Store_9        D    2713.89    302.02
      2706 Region_5  Store_9        E     227.63    122.89
      2707 Region_5  Store_9        F    4235.62    396.82
      2708 Region_5  Store_9        G    1836.21    234.71
      2709 Region_5  Store_9        H    1326.64    146.14
      2710 Region_5  Store_9        I    1468.91    243.30
      2711 Region_5  Store_9        J    4131.64    322.08

# Snapshot: Exclude parameter, median aggregator, uneven distribution

    Code
      as.data.frame(out)
    Output
         department   role  salary
      1       Total  Total 59897.0
      2   Executive  Total 58999.0
      3   Executive Junior 54253.0
      4   Executive   Lead 59520.0
      5   Executive    Mid 62031.0
      6   Executive Senior 59759.0
      7          HR  Total 59541.5
      8          HR Junior 62828.0
      9          HR   Lead 60077.0
      10         HR    Mid 57051.0
      11         HR Senior 59514.5
      12         IT  Total 59334.0
      13         IT Junior 58969.5
      14         IT   Lead 58936.0
      15         IT    Mid 59829.0
      16         IT Senior 59106.0
      17  Marketing  Total 60836.0
      18  Marketing Junior 64361.5
      19  Marketing   Lead 58265.5
      20  Marketing    Mid 60744.0
      21  Marketing Senior 61393.5
      22      Sales  Total 60326.0
      23      Sales Junior 61650.5
      24      Sales   Lead 59707.0
      25      Sales    Mid 59853.0
      26      Sales Senior 60008.0

# Snapshot: Deep grouping (4 levels), custom function, missing values

    Code
      as.data.frame(out)
    Output
           year quarter product_line status    uptime   latency
      1   Total   Total        Total  Total        NA 107.18273
      2    2023   Total        Total  Total        NA 105.31166
      3    2023      Q1        Total  Total        NA 104.76454
      4    2023      Q1     Hardware  Total        NA  94.31105
      5    2023      Q1     Hardware Active        NA  88.76496
      6    2023      Q1     Hardware   Beta        NA  87.98984
      7    2023      Q1     Hardware Legacy        NA  94.31105
      8    2023      Q1     Services  Total        NA 104.76454
      9    2023      Q1     Services Active        NA  95.42915
      10   2023      Q1     Services   Beta        NA 104.76454
      11   2023      Q1     Services Legacy        NA  82.10461
      12   2023      Q1     Software  Total        NA  96.45162
      13   2023      Q1     Software Active        NA  96.45162
      14   2023      Q1     Software   Beta        NA  78.03797
      15   2023      Q1     Software Legacy        NA  85.18238
      16   2023      Q2        Total  Total        NA  94.85008
      17   2023      Q2     Hardware  Total        NA  91.89029
      18   2023      Q2     Hardware Active        NA  91.89029
      19   2023      Q2     Hardware   Beta        NA  82.22047
      20   2023      Q2     Hardware Legacy        NA  91.29365
      21   2023      Q2     Services  Total        NA  93.73007
      22   2023      Q2     Services Active 0.9989941  79.64368
      23   2023      Q2     Services   Beta        NA  93.73007
      24   2023      Q2     Services Legacy        NA  92.41703
      25   2023      Q2     Software  Total        NA  94.85008
      26   2023      Q2     Software Active        NA  94.85008
      27   2023      Q2     Software   Beta        NA  92.46293
      28   2023      Q2     Software Legacy        NA  84.73367
      29   2023      Q3        Total  Total        NA  93.23882
      30   2023      Q3     Hardware  Total        NA  90.24683
      31   2023      Q3     Hardware Active        NA  85.44652
      32   2023      Q3     Hardware   Beta        NA  87.41538
      33   2023      Q3     Hardware Legacy        NA  90.24683
      34   2023      Q3     Services  Total        NA  93.23882
      35   2023      Q3     Services Active        NA  93.23882
      36   2023      Q3     Services   Beta        NA  86.26983
      37   2023      Q3     Services Legacy        NA  90.01847
      38   2023      Q3     Software  Total        NA  89.19316
      39   2023      Q3     Software Active        NA  86.04667
      40   2023      Q3     Software   Beta        NA  83.61986
      41   2023      Q3     Software Legacy        NA  89.19316
      42   2023      Q4        Total  Total        NA 105.31166
      43   2023      Q4     Hardware  Total        NA  93.52433
      44   2023      Q4     Hardware Active        NA  84.32392
      45   2023      Q4     Hardware   Beta        NA  93.52433
      46   2023      Q4     Hardware Legacy        NA  88.63187
      47   2023      Q4     Services  Total        NA  94.61419
      48   2023      Q4     Services Active        NA  89.05565
      49   2023      Q4     Services   Beta        NA  79.02691
      50   2023      Q4     Services Legacy        NA  94.61419
      51   2023      Q4     Software  Total        NA 105.31166
      52   2023      Q4     Software Active        NA 105.31166
      53   2023      Q4     Software   Beta        NA  81.99127
      54   2023      Q4     Software Legacy        NA  85.96418
      55   2024   Total        Total  Total        NA 107.02616
      56   2024      Q1        Total  Total        NA 103.27638
      57   2024      Q1     Hardware  Total        NA  92.51212
      58   2024      Q1     Hardware Active        NA  84.13708
      59   2024      Q1     Hardware   Beta        NA  86.26764
      60   2024      Q1     Hardware Legacy        NA  92.51212
      61   2024      Q1     Services  Total        NA 100.76058
      62   2024      Q1     Services Active        NA  87.65166
      63   2024      Q1     Services   Beta        NA 100.76058
      64   2024      Q1     Services Legacy        NA  87.99931
      65   2024      Q1     Software  Total        NA 103.27638
      66   2024      Q1     Software Active        NA 103.27638
      67   2024      Q1     Software   Beta        NA  90.69435
      68   2024      Q1     Software Legacy        NA  77.32029
      69   2024      Q2        Total  Total        NA 107.02616
      70   2024      Q2     Hardware  Total        NA 100.32530
      71   2024      Q2     Hardware Active        NA  92.50345
      72   2024      Q2     Hardware   Beta        NA  85.12854
      73   2024      Q2     Hardware Legacy        NA 100.32530
      74   2024      Q2     Services  Total        NA 107.02616
      75   2024      Q2     Services Active        NA 107.02616
      76   2024      Q2     Services   Beta        NA  91.23858
      77   2024      Q2     Services Legacy        NA  85.93120
      78   2024      Q2     Software  Total        NA  95.33030
      79   2024      Q2     Software Active        NA  95.33030
      80   2024      Q2     Software   Beta        NA  94.25913
      81   2024      Q2     Software Legacy        NA  87.06624
      82   2024      Q3        Total  Total        NA  94.22959
      83   2024      Q3     Hardware  Total        NA  94.22959
      84   2024      Q3     Hardware Active        NA  87.66900
      85   2024      Q3     Hardware   Beta        NA  89.81565
      86   2024      Q3     Hardware Legacy 0.9983621  94.22959
      87   2024      Q3     Services  Total        NA  89.32941
      88   2024      Q3     Services Active        NA  86.33139
      89   2024      Q3     Services   Beta        NA  89.32941
      90   2024      Q3     Services Legacy        NA  79.26121
      91   2024      Q3     Software  Total        NA  92.29189
      92   2024      Q3     Software Active        NA  89.12568
      93   2024      Q3     Software   Beta        NA  83.25743
      94   2024      Q3     Software Legacy        NA  92.29189
      95   2024      Q4        Total  Total        NA  99.11469
      96   2024      Q4     Hardware  Total        NA  96.18525
      97   2024      Q4     Hardware Active        NA  96.18525
      98   2024      Q4     Hardware   Beta        NA  94.15057
      99   2024      Q4     Hardware Legacy        NA  90.93024
      100  2024      Q4     Services  Total        NA  99.11469
      101  2024      Q4     Services Active        NA  87.56534
      102  2024      Q4     Services   Beta        NA  99.11469
      103  2024      Q4     Services Legacy        NA  85.44180
      104  2024      Q4     Software  Total        NA  96.24582
      105  2024      Q4     Software Active        NA  82.64145
      106  2024      Q4     Software   Beta        NA  89.26530
      107  2024      Q4     Software Legacy        NA  96.24582
      108  2025   Total        Total  Total        NA 107.18273
      109  2025      Q1        Total  Total        NA  97.25918
      110  2025      Q1     Hardware  Total        NA  94.37186
      111  2025      Q1     Hardware Active        NA  83.49536
      112  2025      Q1     Hardware   Beta        NA  94.37186
      113  2025      Q1     Hardware Legacy        NA  90.79322
      114  2025      Q1     Services  Total        NA  97.25918
      115  2025      Q1     Services Active        NA  97.25918
      116  2025      Q1     Services   Beta        NA  82.78508
      117  2025      Q1     Services Legacy        NA  88.32933
      118  2025      Q1     Software  Total        NA  95.34901
      119  2025      Q1     Software Active        NA  84.74648
      120  2025      Q1     Software   Beta        NA  83.41262
      121  2025      Q1     Software Legacy        NA  95.34901
      122  2025      Q2        Total  Total        NA 107.18273
      123  2025      Q2     Hardware  Total        NA  87.42067
      124  2025      Q2     Hardware Active        NA  87.42067
      125  2025      Q2     Hardware   Beta        NA  84.97868
      126  2025      Q2     Hardware Legacy        NA  85.00606
      127  2025      Q2     Services  Total        NA 107.18273
      128  2025      Q2     Services Active        NA  85.95338
      129  2025      Q2     Services   Beta        NA  88.20556
      130  2025      Q2     Services Legacy        NA 107.18273
      131  2025      Q2     Software  Total        NA  99.94089
      132  2025      Q2     Software Active        NA  79.94355
      133  2025      Q2     Software   Beta        NA  82.15443
      134  2025      Q2     Software Legacy        NA  99.94089
      135  2025      Q3        Total  Total        NA 103.95742
      136  2025      Q3     Hardware  Total        NA 103.95742
      137  2025      Q3     Hardware Active        NA 103.95742
      138  2025      Q3     Hardware   Beta        NA  93.77057
      139  2025      Q3     Hardware Legacy        NA  83.97922
      140  2025      Q3     Services  Total        NA  94.61035
      141  2025      Q3     Services Active        NA  87.70826
      142  2025      Q3     Services   Beta        NA  88.39337
      143  2025      Q3     Services Legacy        NA  94.61035
      144  2025      Q3     Software  Total        NA  87.86580
      145  2025      Q3     Software Active 0.9989865  86.08656
      146  2025      Q3     Software   Beta        NA  87.86580
      147  2025      Q3     Software Legacy        NA  84.63630
      148  2025      Q4        Total  Total        NA  94.14985
      149  2025      Q4     Hardware  Total        NA  94.05339
      150  2025      Q4     Hardware Active        NA  93.99216
      151  2025      Q4     Hardware   Beta        NA  86.33136
      152  2025      Q4     Hardware Legacy        NA  94.05339
      153  2025      Q4     Services  Total        NA  84.82086
      154  2025      Q4     Services Active        NA  84.45343
      155  2025      Q4     Services   Beta        NA  84.82086
      156  2025      Q4     Services Legacy        NA  82.83307
      157  2025      Q4     Software  Total        NA  94.14985
      158  2025      Q4     Software Active        NA  86.69707
      159  2025      Q4     Software   Beta        NA  86.36526
      160  2025      Q4     Software Legacy        NA  94.14985
      161  2026   Total        Total  Total        NA 106.81201
      162  2026      Q1        Total  Total        NA 106.81201
      163  2026      Q1     Hardware  Total        NA 102.01668
      164  2026      Q1     Hardware Active        NA  88.23661
      165  2026      Q1     Hardware   Beta        NA  91.50204
      166  2026      Q1     Hardware Legacy        NA 102.01668
      167  2026      Q1     Services  Total        NA 106.81201
      168  2026      Q1     Services Active        NA  85.56141
      169  2026      Q1     Services   Beta        NA 106.81201
      170  2026      Q1     Services Legacy        NA  84.99886
      171  2026      Q1     Software  Total        NA 100.31194
      172  2026      Q1     Software Active        NA  80.21152
      173  2026      Q1     Software   Beta        NA 100.31194
      174  2026      Q1     Software Legacy        NA  79.99686
      175  2026      Q2        Total  Total        NA  94.20024
      176  2026      Q2     Hardware  Total        NA  94.17776
      177  2026      Q2     Hardware Active        NA  90.50004
      178  2026      Q2     Hardware   Beta        NA  80.92110
      179  2026      Q2     Hardware Legacy        NA  94.17776
      180  2026      Q2     Services  Total        NA  94.20024
      181  2026      Q2     Services Active        NA  94.20024
      182  2026      Q2     Services   Beta        NA  80.14392
      183  2026      Q2     Services Legacy        NA  86.62683
      184  2026      Q2     Software  Total        NA  85.14869
      185  2026      Q2     Software Active        NA  85.14869
      186  2026      Q2     Software   Beta        NA  84.96221
      187  2026      Q2     Software Legacy        NA  83.51899
      188  2026      Q3        Total  Total        NA  99.22131
      189  2026      Q3     Hardware  Total        NA  92.95587
      190  2026      Q3     Hardware Active        NA  85.35227
      191  2026      Q3     Hardware   Beta        NA  87.04109
      192  2026      Q3     Hardware Legacy        NA  92.95587
      193  2026      Q3     Services  Total        NA  86.04510
      194  2026      Q3     Services Active        NA  86.04510
      195  2026      Q3     Services   Beta        NA  83.86242
      196  2026      Q3     Services Legacy        NA  85.29336
      197  2026      Q3     Software  Total        NA  99.22131
      198  2026      Q3     Software Active        NA  92.24991
      199  2026      Q3     Software   Beta        NA  88.63519
      200  2026      Q3     Software Legacy        NA  99.22131
      201  2026      Q4        Total  Total        NA  96.06654
      202  2026      Q4     Hardware  Total        NA  93.57481
      203  2026      Q4     Hardware Active        NA  89.42575
      204  2026      Q4     Hardware   Beta        NA  93.57481
      205  2026      Q4     Hardware Legacy        NA  87.51579
      206  2026      Q4     Services  Total        NA  96.06654
      207  2026      Q4     Services Active        NA  85.82399
      208  2026      Q4     Services   Beta        NA  94.94703
      209  2026      Q4     Services Legacy        NA  96.06654
      210  2026      Q4     Software  Total        NA  86.65151
      211  2026      Q4     Software Active        NA  81.22171
      212  2026      Q4     Software   Beta        NA  83.29960
      213  2026      Q4     Software Legacy        NA  86.65151

