within IndustrialControlSystems.MathOperations.RealType.Functions;
function f
  input Boolean up;
  input Boolean down;
  input Real t;
  input Real ts;
  input Real td;
  input Real alfa;
  input Real m;
  input Real yin;
  input Real yfin;
  output Real x;
algorithm
  if
    (up == true and down==false) then
    x := fSmoothStep(t,ts,alfa,m,yin,yfin);
  elseif
        (up==true) then
    x := fSmoothStep(t,td,alfa,m,yfin,yin);
  else
    x := yin;
  end if;
  annotation (Documentation(revisions="<html>
<dl><dt>Industrial Control Systems (v 1.0.0) : April-May 2012</dt>
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
<dd><i>The IndustrialControlSystems package is <b>free</b> software; it can be redistributed and/or modified under the terms of the <b>Modelica license</b>.</i><br/></dd>
</dl></html>"));
end f;
