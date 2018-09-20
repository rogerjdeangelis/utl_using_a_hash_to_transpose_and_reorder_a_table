Single datastep elegant hash solution(traspose add and order) by

github
https://tinyurl.com/ybu9ypgf
https://github.com/rogerjdeangelis/utl_using_a_hash_to_transpose_and_reorder_a_table

sas forum
https://communities.sas.com/t5/SAS-Procedures/Stacking-columns-into-new-dataset/m-p/497084

Novinosrin
https://communities.sas.com/t5/user/viewprofilepage/user-id/138205


Stacking columns into new dataset

INPUT
=====

 WORK.HAVE total obs=6

  TRT    REP    F1    F2

   1      1     20    25
   1      2     17    15

   2      1     35    33
   2      2     30    35

   3      1     42    44
   3      2     43    45

EXAMPLE OUTPUT
--------------

   WORK.WANT total obs=12

                              | RULES (Stacking F1 then F2)
                              |
     TRT   REP  FIELD  YIELD  |  F1
                              |
      11    1     1      20   |  20
      12    2     1      17   |  17
      21    1     1      35   |  35
      22    2     1      30   |  30
      31    1     1      42   |  42
      32    2     1      43   |  43
                              |
                              |  F2
                              |
      11    1     2      25   |  25
      12    2     2      15   |  15
      21    1     2      33   |  33
      22    2     2      35   |  35
      31    1     2      44   |  44
      32    2     2      45   |  45


PROCESS
=======

  data _null_;
  if _n_=1 then do;
       dcl hash h(multidata:'y',ordered:'y'); ** ordered;
       h.definekey('field');
       h.definedata('trt', 'rep', 'field', 'yield');
       h.definedone();
  end;

  set have  end=dne;

  array t(*) f:;  * F1 and F2;

  do field=1 to dim(t);
     yield=t(field);
     rc=h.add();        * add ordered;
  end;

  if dne then h.output(dataset:'want');

  run;

*                _              _       _
 _ __ ___   __ _| | _____    __| | __ _| |_ __ _
| '_ ` _ \ / _` | |/ / _ \  / _` |/ _` | __/ _` |
| | | | | | (_| |   <  __/ | (_| | (_| | || (_| |
|_| |_| |_|\__,_|_|\_\___|  \__,_|\__,_|\__\__,_|

;

data have;
input trt rep f1 f2;
cards;
1 1 20 25
1 2 17 15
2 1 35 33
2 2 30 35
3 1 42 44
3 2 43 45
;;;;
run;quit;

