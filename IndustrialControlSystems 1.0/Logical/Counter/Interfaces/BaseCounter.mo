within IndustrialControlSystems.Logical.Counter.Interfaces;
partial model BaseCounter "Partial interface of a generic counter"
  parameter Real Ts = 0.01 "Sampling time [s]";
  parameter Integer Max = 999 "module of counter";
  Modelica.Blocks.Interfaces.BooleanInput CU
    "Count Up: The counter is incremented by 1 if the signal state changes from 0 to 1"
                                                        annotation (Placement(
        transformation(extent={{-100,60},{-60,100}}), iconTransformation(extent=
           {{-100,60},{-60,100}})));
  Modelica.Blocks.Interfaces.BooleanInput CD
    "Count Down: The counter is decremented by 1 if the signal state changes from 0 to 1"
                                                          annotation (Placement(
        transformation(extent={{-100,20},{-60,60}}), iconTransformation(extent={
            {-100,20},{-60,60}})));
  Modelica.Blocks.Interfaces.BooleanInput S
    "set: Sets the counter with the value at the Preset Value (PV)"
                                                  annotation (Placement(
        transformation(extent={{-100,-20},{-60,20}}), iconTransformation(extent=
           {{-100,-20},{-60,20}})));
  Modelica.Blocks.Interfaces.BooleanInput R
    "reset: Sets the counter whit the value 0, and stop the counting"
                                                    annotation (Placement(
        transformation(extent={{-100,-60},{-60,-20}}), iconTransformation(
          extent={{-100,-60},{-60,-20}})));
  Modelica.Blocks.Interfaces.IntegerInput PV "Preset Value" annotation (
      Placement(transformation(extent={{-60,-100},{-20,-60}}),
        iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-40,-80})));
  Modelica.Blocks.Interfaces.IntegerOutput CV "Current Value" annotation (
      Placement(transformation(extent={{80,20},{100,40}}), iconTransformation(
          extent={{80,20},{100,40}})));
  Modelica.Blocks.Interfaces.BooleanOutput Q
    "status of the counter (1: counting, 0: not counting)"
    annotation (Placement(transformation(extent={{80,-40},{100,-20}}),
        iconTransformation(extent={{80,-40},{100,-20}})));
  annotation (Icon(graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillColor={213,255,170},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-72,90},{86,68}},
          lineColor={0,0,0},
          fillColor={213,255,170},
          fillPattern=FillPattern.Solid,
          textString="COUNT:%Max"),
        Text(
          extent={{-62,16},{80,-4}},
          lineColor={0,0,0},
          fillColor={213,255,170},
          fillPattern=FillPattern.Solid,
          textString="%name")}), Diagram(graphics),
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
end BaseCounter;
