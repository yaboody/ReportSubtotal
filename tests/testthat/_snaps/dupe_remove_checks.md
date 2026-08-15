# subtotal_dupe_removal output matches historical baseline

    Code
      subtotal_dupe_removal(data1, 2)
    Output
      # A tibble: 10 x 3
         cyl   vs    `sum(wt)`
         <fct> <fct>     <dbl>
       1 Total Total    103.  
       2 Total 0         66.4 
       3 Total 1         36.6 
       4 4     Total     25.1 
       5 4     0          2.14
       6 4     1         23.0 
       7 6     Total     21.8 
       8 6     0          8.26
       9 6     1         13.6 
      10 8     0         56.0 

---

    Code
      subtotal_dupe_removal(data2, 3, iterator = 3, skip = 1)
    Output
      # A tibble: 23 x 4
         cyl   vs    am    `mean(hp)`
         <fct> <fct> <fct>      <dbl>
       1 Total Total Total      147. 
       2 Total Total 0          160. 
       3 Total Total 1          127. 
       4 Total 0     0          194. 
       5 Total 0     1          181. 
       6 Total 1     0          102. 
       7 Total 1     1           80.6
       8 4     Total 0           84.7
       9 4     Total 1           81.9
      10 4     0     Total       91  
      # i 13 more rows

