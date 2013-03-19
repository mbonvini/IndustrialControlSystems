within IndustrialControlSystems.Applications.ControlProblems.DecoupledControl;
model Decoupler "Model of the 2x2 decoupler"
  parameter Real P_21_22_num[:] = {1} "|P_21_22| Transfer function num.";
  parameter Real P_21_22_den[:] = {1,1} "|P_21_22| Transfer function den.";
  parameter Real P_12_11_num[:] = {1} "|P_12_11| Transfer function num.";
  parameter Real P_12_11_den[:] = {1,1} "|P_12_11| Transfer function den.";
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
  LinearSystems.Continuous.TransferFunction P_21_22(
                    num=P_21_22_num, den=P_21_22_den)
    annotation (Placement(transformation(extent={{-12,20},{8,40}})));
  LinearSystems.Continuous.TransferFunction P_12_11(num=P_12_11_num, den=
        P_12_11_den)
    annotation (Placement(transformation(extent={{-12,-20},{8,0}})));
  Modelica.Blocks.Interfaces.RealOutput toU1 "output"
    annotation (Placement(transformation(extent={{80,20},{100,40}})));
  Modelica.Blocks.Interfaces.RealOutput toU2 "output"
    annotation (Placement(transformation(extent={{80,-20},{100,0}})));
  Modelica.Blocks.Math.Gain gainA(k=-1)
    annotation (Placement(transformation(extent={{34,20},{54,40}})));
  Modelica.Blocks.Math.Gain gainB(k=-1)
    annotation (Placement(transformation(extent={{34,-20},{54,0}})));
equation
  connect(u1, y1) annotation (Line(
      points={{-80,60},{90,60}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(u2, y2) annotation (Line(
      points={{-80,-40},{90,-40}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(P_21_22.y, gainA.u)
                         annotation (Line(
      points={{7,30},{32,30}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(gainB.u,P_12_11. y)
                         annotation (Line(
      points={{32,-10},{7,-10}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(u1, P_21_22.u) annotation (Line(
      points={{-80,60},{-40,60},{-40,30},{-10,30}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(u2, P_12_11.u) annotation (Line(
      points={{-80,-40},{-40,-40},{-40,-10},{-10,-10}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(gainA.y, toU2) annotation (Line(
      points={{55,30},{66,30},{66,-10},{90,-10}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(gainB.y, toU1) annotation (Line(
      points={{55,-10},{66,-10},{66,30},{90,30}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(graphics), Icon(graphics={Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid), Text(
          extent={{-100,18},{100,-2}},
          lineColor={0,0,0},
          fillColor={170,170,255},
          fillPattern=FillPattern.Solid,
          textString="Decoupler 2x2")}),
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
  Decoupler for a two input two output process 
  (see <a href=\"modelica://IndustrialControlSystems.Applications.ControlProblems.DecoupledControl.Process\">Process</a> ).<br>
  The aim of the decoupler (represented in the following figure) is to reduce (ideally to delete them) the effects of the first 
  input U1 on the second output Y2 and vice versa.<br> This can be done introducing the new variables (V1,V2) and placing the decoupler between them and the real process. 
  <br>
  <img src=\"modelica://IndustrialControlSystems/help/images/Applications/ControlProblems/DecoupledController/Decoupler1.png\"><br><br>
  The decoupler is described by the following scheme (backward decoupler)
  <br>
  <img src=\"modelica://IndustrialControlSystems/help/images/Applications/ControlProblems/DecoupledController/Decoupler2.png\"><br><br>
  The effect of the decoupler is shown in the following picture where the decoupler with its backward action deletes the relation between V1 and Y2 (the sum of the blue and red paths).
  <br>
  <img src=\"modelica://IndustrialControlSystems/help/images/Applications/ControlProblems/DecoupledController/Decoupler3.png\"><br><br>
  
  Once the process is known (P11,P21,P21,P22), the decoupler can be specified by the definition of the two rational trasfer functions
  <pre>
  P12(s)
  ------ 
  P11(s)
  </pre>
  and<br>
  <pre>
  P21(s)
  ------
  P22(s)
  </pre><br>
  <b>N.B.</b> If the transfer functions have more zeroes than poles or have instable poles have to be carefully modified.
</html>"));
end Decoupler;
