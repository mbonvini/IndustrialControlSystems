within IndustrialControlSystems.Logical.LogicalOperations.Examples;
model basicLogicOperations "generic logic operations"
  extends Modelica.Icons.Example;
  parameter Real Ts = 0.15 "Sampling time of each logical block";
  And and_gate(nInput=4, Ts=Ts)
    annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
  Modelica.Blocks.Sources.BooleanTable    booleanConstant(startValue=false,
      table={1,3,4,7,8,10})
    annotation (Placement(transformation(extent={{-100,60},{-80,80}})));
  Modelica.Blocks.Sources.BooleanTable    booleanConstant1(startValue=true,
      table={1.2,1.3,5.6,7.8,10})
    annotation (Placement(transformation(extent={{-100,20},{-80,40}})));
  Modelica.Blocks.Sources.BooleanTable    booleanConstant2(startValue=true,
      table={1.15,2.3,5.3,8.8,11})
    annotation (Placement(transformation(extent={{-100,-20},{-80,0}})));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant3(k=true)
    annotation (Placement(transformation(extent={{-100,-60},{-80,-40}})));
  Not not_gate(Ts=Ts,
    nInput=1,
    nOutput=1)
    annotation (Placement(transformation(extent={{-40,70},{-20,90}})));
  Or or_gate(nInput=3, Ts=Ts)
    annotation (Placement(transformation(extent={{-40,-20},{-20,0}})));
  Xor xor_gate(Ts=Ts, nInput=2)
    annotation (Placement(transformation(extent={{-40,-60},{-20,-40}})));
  Not not_gate_C(
    Ts=0,
    nInput=1,
    nOutput=1)
    annotation (Placement(transformation(extent={{-40,50},{-20,70}})));
equation
  connect(booleanConstant.y, not_gate.u[1])
                                        annotation (Line(
      points={{-79,70},{-56,70},{-56,80},{-38,80}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(booleanConstant.y, and_gate.u[4])
                                        annotation (Line(
      points={{-79,70},{-70,70},{-70,31.5},{-38,31.5}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(booleanConstant2.y, and_gate.u[2])
                                         annotation (Line(
      points={{-79,-10},{-74,-10},{-74,29.5},{-38,29.5}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(booleanConstant3.y, and_gate.u[1])
                                         annotation (Line(
      points={{-79,-50},{-70,-50},{-70,28.5},{-38,28.5}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(booleanConstant1.y, and_gate.u[3])
                                         annotation (Line(
      points={{-79,30},{-74.5,30},{-74.5,30.5},{-38,30.5}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(booleanConstant3.y, or_gate.u[1])
                                        annotation (Line(
      points={{-79,-50},{-56,-50},{-56,-11.3333},{-38,-11.3333}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(booleanConstant2.y, or_gate.u[2])
                                        annotation (Line(
      points={{-79,-10},{-38,-10}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(booleanConstant.y, or_gate.u[3])
                                       annotation (Line(
      points={{-79,70},{-56,70},{-56,-8.66667},{-38,-8.66667}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(booleanConstant3.y, xor_gate.u[1])
                                        annotation (Line(
      points={{-79,-50},{-48.5,-50},{-48.5,-51},{-38,-51}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(booleanConstant.y, xor_gate.u[2])
                                       annotation (Line(
      points={{-79,70},{-44,70},{-44,-49},{-38,-49}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(booleanConstant.y, not_gate_C.u[1]) annotation (Line(
      points={{-79,70},{-44,70},{-44,60},{-38,60}},
      color={255,0,255},
      smooth=Smooth.None));
  annotation (Diagram(graphics), Documentation(revisions="<html>
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
</dl></html>", info="<html>
<h4>Description</h4>
<p>
In this examples are tested the basic logic operations.<br>

Depending on the value of the sampling time <FONT FACE=Courier>Ts</FONT> the behaviour of the logic blocks may vary. 
In the following figure the output of two different NOT operators are compared. The blue line is the input signal while the green one is the output
of a NOT with <FONT FACE=Courier>Ts = 0.15</FONT> and the red one the output of a NOT with <FONT FACE=Courier>Ts = 0</FONT> (thus continuous time).
<br><br>
<img src=\"modelica://IndustrialControlSystems/help/images/Logical/LogicalOperations/Examples/NotDelay.png\"><br><br>
To note that the red line is exactly the NOT of the input, while the green one is approximately the NOT of the input. This is due to the time discretisation.
<br><br>
This is the output of the AND operation, where the blue lines are the four inputs while the red one is the output
<img src=\"modelica://IndustrialControlSystems/help/images/Logical/LogicalOperations/Examples/ANDoperator.png\"><br><br>
Even in this case small delays are introduced by the time discretisation.
</p>
</html>"),
    experiment(StopTime=15),
    __Dymola_experimentSetupOutput);
end basicLogicOperations;
