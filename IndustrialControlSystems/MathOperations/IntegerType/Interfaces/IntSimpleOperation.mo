within IndustrialControlSystems.MathOperations.IntegerType.Interfaces;
partial model IntSimpleOperation
  "Partial interface of a generic two input integer math operation"
  parameter Real Ts = 0.1 "sampling time" annotation(Evaluate=true);
  Modelica.Blocks.Interfaces.IntegerInput u1 "input"
    annotation (Placement(transformation(extent={{-100,20},{-60,60}},
          rotation=0), iconTransformation(extent={{-100,20},{-60,60}})));
  Modelica.Blocks.Interfaces.IntegerInput u2 "input"
    annotation (Placement(transformation(extent={{-100,-60},{-60,-20}},
          rotation=0), iconTransformation(extent={{-100,-60},{-60,-20}})));
  Modelica.Blocks.Interfaces.IntegerOutput y "output"
    annotation (Placement(transformation(extent={{80,-10},{100,10}},
          rotation=0), iconTransformation(extent={{80,-10},{100,10}})));
  annotation (Diagram(graphics),
                       Icon(graphics={Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillColor={255,170,85},
          fillPattern=FillPattern.Solid)}),
    Documentation(revisions="<html>
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
end IntSimpleOperation;
