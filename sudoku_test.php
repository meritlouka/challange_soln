<?php
// Time Consumed two and half(2:45) hours
$solution = [1,8,2,5,4,3,6,9,7,9,6,5,1,7,8,3,4,2,7,4,3,9,6,2,8,1,5,3,7,4,8,9,6,5,2,1,6,2,8,4,5,1,7,3,9,5,1,9,2,3,7,4,6,8,2,9,7,6,8,4,1,5,3,4,3,1,7,2,5,9,8,6,8,5,6,3,1,9,2,7,4];


function trace_rows($solution){
  $row = [];
  $row_counter = 0;
  //Trace Rows
  for ($i = 0; $i  < count($solution); $i++)
  {
     if($i !=0 && $i % 9 == 0){
      $row = [];
      $row_counter = $row_counter + 1;  
    }

    if (intdiv($i,9) == $row_counter){
      array_push($row,$solution[$i]);
      if (array_count_values($row)[$solution[$i]] > 1){
        return "false";
      }    
    }  
  }
}
function trace_columns($solution){
  $col = []; 
  $col_cycle = 0;
  // Trace Colmns
  $start = 0;
  for ($i = 0; $col_cycle  < 9; $i = $i+9)
  {    

       if($i >= 81){
        $col = [];
        $col_cycle =$col_cycle + 1; 
        $start = $start+1;
        $i = $start; 
       }
      array_push($col,$solution[$i]);
      if (array_count_values($col)[$solution[$i]] > 1)
      {
        return "false";
      }
  }
}


//Trace Cubes
function trace_cubes($solution){
  $cube = [];
  $cube_cycle = 0;
  $pointer = 1;
  $start = 0;
  $start_arr = [0,3,6,27,30,33,54,57,60];
  for ($i = 0; $cube_cycle < 9; $i = $i + $pointer)
  {
       if(count($cube) == 9){
          $cube = [];
          $cube_cycle = $cube_cycle + 1;
          if ($cube_cycle < 9){
              $start = $start_arr[$cube_cycle];
              $i = $start;
          }
       }
       if ($cube_cycle < 9){
          array_push($cube,$solution[$i]);
           if (array_count_values($cube)[$solution[$i]] > 1)
           {  
             return "false";
           } 

          if(($i + 1)%3 == 0){
            $pointer = 7;
          }else{
            $pointer = 1;
          }
       }
  }
}

  if(
    count($solution) != 81 ||trace_rows($solution)== "false" ||trace_columns($solution)=="false"||trace_cubes($solution) == "false"
  ){
     echo "false";
  } else{
     echo "true";
  }
  return ;
?>
