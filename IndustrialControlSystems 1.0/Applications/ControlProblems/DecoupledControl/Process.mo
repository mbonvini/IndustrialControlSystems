within IndustrialControlSystems.Applications.ControlProblems.DecoupledControl;
model Process "Two inputs Two outputs process
  Y1 = P11*u1 + P12*u2  and  Y2 = P21*u1 + P22*u2
  "
  parameter Real P11_num[:] = {1} "| P11 | Transfer function num.";
  parameter Real P11_den[:] = {1,1} "| P11 | Transfer function den.";
  parameter Real P12_num[:] = {1} "| P12 | Transfer function num.";
  parameter Real P12_den[:] = {1,1} "| P12 | Transfer function den.";
  parameter Real P21_num[:] = {1} "| P21 | Transfer function num.";
  parameter Real P21_den[:] = {1,1} "| P21 | Transfer function den.";
  parameter Real P22_num[:] = {1} "| P22 | Transfer function num.";
  parameter Real P22_den[:] = {1,1} "| P22 | Transfer function den.";
  LinearSystems.Continuous.TransferFunction
                                      P11(num=P11_num, den=P11_den)
    annotation (Placement(transformation(extent={{-20,50},{0,70}})));
  LinearSystems.Continuous.TransferFunction
                                      P12(num=P12_num, den=P12_den)
    annotation (Placement(transformation(extent={{-20,20},{0,40}})));
  LinearSystems.Continuous.TransferFunction
                                      P21(             den=P21_den, num=P21_num)
                                                         annotation (
      Placement(transformation(extent={{-20,-20},{0,0}})));
  LinearSystems.Continuous.TransferFunction
                                      P22(num=P22_num, den=P22_den)
                                                       annotation (
      Placement(transformation(extent={{-20,-50},{0,-30}})));
  Modelica.Blocks.Interfaces.RealInput u1 "input" annotation (Placement(
        transformation(extent={{-100,40},{-60,80}}), iconTransformation(
          extent={{-100,40},{-60,80}})));
  Modelica.Blocks.Interfaces.RealInput u2 "input" annotation (Placement(
        transformation(extent={{-100,-60},{-60,-20}}),
        iconTransformation(extent={{-100,-60},{-60,-20}})));
  Modelica.Blocks.Interfaces.RealOutput y1 "output" annotation (
      Placement(transformation(extent={{80,50},{100,70}}),
        iconTransformation(extent={{80,50},{100,70}})));
  Modelica.Blocks.Interfaces.RealOutput y2 "output" annotation (
      Placement(transformation(extent={{80,-50},{100,-30}}),
        iconTransformation(extent={{80,-50},{100,-30}})));
  Modelica.Blocks.Math.Add add
    annotation (Placement(transformation(extent={{40,50},{60,70}})));
  Modelica.Blocks.Math.Add add1
    annotation (Placement(transformation(extent={{40,-50},{60,-30}})));
equation
  connect(P11.u, u1) annotation (Line(
      points={{-18,60},{-80,60}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(u1, P21.u) annotation (Line(
      points={{-80,60},{-50,60},{-50,-10},{-18,-10}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(u2, P12.u) annotation (Line(
      points={{-80,-40},{-46,-40},{-46,30},{-18,30}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(u2, P22.u) annotation (Line(
      points={{-80,-40},{-18,-40}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(P11.y, add.u1) annotation (Line(
      points={{-1,60},{20,60},{20,66},{38,66}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(P12.y, add.u2) annotation (Line(
      points={{-1,30},{20,30},{20,54},{38,54}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(add.y, y1) annotation (Line(
      points={{61,60},{90,60}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(P21.y, add1.u1) annotation (Line(
      points={{-1,-10},{20.5,-10},{20.5,-34},{38,-34}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(P22.y, add1.u2) annotation (Line(
      points={{-1,-40},{20,-40},{20,-46},{38,-46}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(add1.y, y2) annotation (Line(
      points={{61,-40},{90,-40}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(graphics), Icon(graphics={Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid), Text(
          extent={{-100,16},{100,-6}},
          lineColor={0,0,0},
          fillColor={170,170,255},
          fillPattern=FillPattern.Solid,
          textString="Process 2x2")}),
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
</dl></html>", info="<HTML>
  <h4>Description</h4>
  <p>
  Two inputs two outputs process<br><br>
  <img src=\"modelica://IndustrialControlSystems/help/images/Applications/ControlProblems/DecoupledController/2x2Process.png\"><br><br>
  The four transfer functions are defined via their numerators and denumerators.
  
</html>"));
end Process;
