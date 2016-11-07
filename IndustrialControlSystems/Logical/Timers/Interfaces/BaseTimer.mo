within IndustrialControlSystems.Logical.Timers.Interfaces;
partial model BaseTimer "Partial interface of a generic timer"
  parameter Real Ts = 0.01 "Sampling time [s]" annotation(Evaluate=true);
  Modelica.Blocks.Interfaces.BooleanInput S "Set signal"
                                                  annotation (Placement(
        transformation(extent={{-100,-20},{-60,20}}), iconTransformation(extent={{-100,20},
            {-60,60}})));
  Modelica.Blocks.Interfaces.BooleanInput R "Reset signal"
                                                    annotation (Placement(
        transformation(extent={{-100,-60},{-60,-20}}), iconTransformation(
          extent={{-100,-60},{-60,-20}})));
  Modelica.Blocks.Interfaces.RealInput PV "timer Programmed Value"
                                                            annotation (
      Placement(transformation(extent={{-60,-100},{-20,-60}}),
        iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-40,-80})));
  Modelica.Blocks.Interfaces.BooleanOutput Q "status of the timer"
    annotation (Placement(transformation(extent={{80,-40},{100,-20}}),
        iconTransformation(extent={{80,-10},{100,10}})));
  annotation (Icon(graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-78,90},{80,68}},
          lineColor={0,0,0},
          fillColor={213,255,170},
          fillPattern=FillPattern.Solid,
          textString="TIMER"),
        Text(
          extent={{-100,122},{100,104}},
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
<dd>Marco Bonvini; &lt;<a href=\"mailto:bonvini@elet.polimi.it\">bonvini@elet.polimi.it</a>&gt;</dd>
<dd>Alberto Leva &lt;<a href=\"mailto:leva@elet.polimi.it\">leva@elet.polimi.it</a>&gt;<br/></dd>
<dd>Politecnico di Milano</dd>
<dd>Dipartimento di Elettronica e Informazione</dd>
<dd>Via Ponzio 34/5</dd>
<dd>20133 Milano - ITALIA -<br/></dd>
<dt><b>Copyright:</b> </dt>
<dd>Copyright &copy; 2010-2012, Marco Bonvini and Alberto Leva.<br/></dd>
<dd><i>The IndustrialControlSystems package is <b>free</b> software; it can be redistributed and/or modified under the terms of the <b>Modelica license</b>, see the license conditions and the accompanying <b>disclaimer</b> in the documentation of package Modelica in file &quot;Modelica/package.mo&quot;.</i><br/></dd>
</dl></html>"));
end BaseTimer;
