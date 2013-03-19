within IndustrialControlSystems.Logical.Counter.Functions;
function count "Function logic of a simple counter"
  input Integer val "Current value of counter";
  input Integer preset_val "Preset value";
  input Boolean S "Set signal at time t";
  input Boolean S_old "Set signal at time t-1";
  input Boolean CU "CountUp signal at time t";
  input Boolean CU_old "CountUp signal at time t-1";
  input Boolean CD "CountDown signal at time t";
  input Boolean CD_old "CountDown signal at time t-1";
  input Boolean R "Reset signal at time t";
  input Integer Max "module of the counter";
  output Integer NVal "Current up to date value of the counter ";
  output Boolean Q "Output logic value";
algorithm
  if (R==true) then
    NVal := 0;
    Q := false;
  elseif (S_old==false and S==true and R==false) then
    NVal := preset_val;
    Q := true;
  elseif (CU_old==false and CU==true and CD==false and S==true and R==false) then
    NVal := val + 1;
    Q := true;
  elseif (CD_old==false and CD==true and CU==false and S==true and R==false) then
    NVal := val - 1;
    Q := true;
  elseif (CU==true and CD==true and R==false and S==true) then
    NVal := val;
    Q := true;
  else
    NVal := val;
    Q := true;
  end if;

  if (NVal==-1) then
    NVal :=Max;
  elseif (NVal==Max+1) then
    NVal := 0;
  else
  end if;

  if (Q==true and NVal==0) then
    Q := false;
  else
  end if;
  annotation (Documentation(revisions="<html>
<dl><dt>First release of the Industrial Control Systems: April-May 2012</dt>
<dl><dt>List of revisions:</dt>
<p><ul>
<li>11 May 2012 (author: Marco Bonvini)</li>
</ul></p>
<dl><dt><b>Main Authors:</b> <br/></dt>
<dd>Marco Bonvini; &LT;<a href=\"mailto:bonvini@elet.polimi.it\">bonvini@elet.polimi.it</a>&GT;</dd>
<dd>Alberto Leva &LT;<a href=\"mailto:leva@elet.polimi.it\">leva@elet.polimi.it</a>&GT;<br/></dd>
<dd>Politecnico di Milano</dd>
<dd>Dipartimento di Elettronica e Informazione</dd>
<dd>Via Ponzio 34/5</dd>
<dd>20133 Milano - ITALIA -<br/></dd>
<dt><b>Copyright:</b> </dt>
<dd>Copyright &copy; 2010-2012, Marco Bonvini and Alberto Leva.<br/></dd>
<dd><i>The IndustrialControlSystems package is <b>free</b> software; it can be redistributed and/or modified under the terms of the <b>Modelica license</b>, see the license conditions and the accompanying <b>disclaimer</b> in the documentation of package Modelica in file &QUOT;Modelica/package.mo&QUOT;.</i><br/></dd>
</dl></html>"));
end count;
