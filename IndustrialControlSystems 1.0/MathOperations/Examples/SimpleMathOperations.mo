within IndustrialControlSystems.MathOperations.Examples;
model SimpleMathOperations "test of real math operations"
  extends Modelica.Icons.Example;

  RealType.Add add(FixedPoint=true,
    Nbit=8,
    Ts=0,
    scaleFactor=20)
    annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
  RealType.Mult mult(      FixedPoint=true,
    Ts=0,
    scaleFactor=20,
    Nbit=12)
    annotation (Placement(transformation(extent={{20,0},{40,20}})));
  Modelica.Blocks.Sources.Constant n1(k=1.23)
    annotation (Placement(transformation(extent={{-100,60},{-80,80}})));
  Modelica.Blocks.Sources.Constant n2(k=1.3)
    annotation (Placement(transformation(extent={{-100,20},{-80,40}})));
  Modelica.Blocks.Sources.Constant n4(k=2)
    annotation (Placement(transformation(extent={{-100,-20},{-80,0}})));
  RealType.Div div(
    FixedPoint=true,
    Ts=0,
    Nbit=10,
    scaleFactor=80)
    annotation (Placement(transformation(extent={{60,-20},{80,0}})));
  Modelica.Blocks.Sources.Constant n6(k=-0.3)
    annotation (Placement(transformation(extent={{0,-40},{20,-20}})));
  RealType.Sub sub(
    Ts=0,
    FixedPoint=true,
    Nbit=8,
    scaleFactor=20)
    annotation (Placement(transformation(extent={{-20,20},{0,40}})));
  Modelica.Blocks.Sources.Constant n3(k=-0.34)
    annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
  RealType.Pow pow(
    FixedPoint=true,
    scaleFactor=20,
    Nbit=11)
    annotation (Placement(transformation(extent={{-40,-80},{-20,-60}})));
equation
  connect(n1.y, add.u1)   annotation (Line(
      points={{-79,70},{-70,70},{-70,54},{-58,54}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(n2.y, add.u2)   annotation (Line(
      points={{-79,30},{-70,30},{-70,46},{-58,46}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(n4.y, mult.u2)    annotation (Line(
      points={{-79,-10},{10,-10},{10,6},{22,6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(mult.y, div.u1) annotation (Line(
      points={{39,10},{50,10},{50,-6},{62,-6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(n6.y, div.u2) annotation (Line(
      points={{21,-30},{50,-30},{50,-14},{62,-14}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(add.y, sub.u1) annotation (Line(
      points={{-41,50},{-30,50},{-30,34},{-18,34}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(sub.y, mult.u1) annotation (Line(
      points={{-1,30},{10,30},{10,14},{22,14}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(n3.y, sub.u2) annotation (Line(
      points={{-39,10},{-30,10},{-30,26},{-18,26}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(n2.y, pow.u1) annotation (Line(
      points={{-79,30},{-70,30},{-70,-66},{-38,-66}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(n4.y, pow.u2) annotation (Line(
      points={{-79,-10},{-74,-10},{-74,-74},{-38,-74}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(graphics), Documentation(revisions="<html>
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
end SimpleMathOperations;
