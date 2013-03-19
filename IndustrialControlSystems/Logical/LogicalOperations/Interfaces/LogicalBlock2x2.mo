within IndustrialControlSystems.Logical.LogicalOperations.Interfaces;
partial model LogicalBlock2x2
  "partial interface of a generic 2x2 logical block"
  parameter Real Ts = 0.1 "sampling time";
  Modelica.Blocks.Interfaces.BooleanInput u1 "input"
    annotation (Placement(transformation(extent={{-100,30},{-60,70}},
          rotation=0), iconTransformation(extent={{-100,30},{-60,70}})));
  Modelica.Blocks.Interfaces.BooleanOutput y1 "output"
    annotation (Placement(transformation(extent={{80,42},{100,62}},
          rotation=0), iconTransformation(extent={{80,42},{100,62}})));
  Modelica.Blocks.Interfaces.BooleanInput u2 "input"
    annotation (Placement(transformation(extent={{-100,-70},{-60,-30}},
          rotation=0), iconTransformation(extent={{-100,-70},{-60,-30}})));
  Modelica.Blocks.Interfaces.BooleanOutput y2 "output"
    annotation (Placement(transformation(extent={{80,-60},{100,-40}},
          rotation=0), iconTransformation(extent={{80,-54},{100,-34}})));
  annotation (Diagram(graphics),
                       Icon(graphics={Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillColor={255,170,255},
          fillPattern=FillPattern.Solid)}),
    Documentation(revisions="<html>
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
end LogicalBlock2x2;
