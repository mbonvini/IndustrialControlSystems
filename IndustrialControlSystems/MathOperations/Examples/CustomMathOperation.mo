within IndustrialControlSystems.MathOperations.Examples;
model CustomMathOperation "test of custom real math operations"
  extends Modelica.Icons.Example;

  IntegerType.Expression INTexp(
    nInput=4,
    redeclare function f =
        IndustrialControlSystems.MathOperations.Examples.SumSquare,
    fname="Sum Square")
    annotation (Placement(transformation(extent={{-50,0},{-30,20}})));
  Modelica.Blocks.Sources.IntegerConstant u4(k=5)
    annotation (Placement(transformation(extent={{-100,60},{-80,80}})));
  Modelica.Blocks.Sources.IntegerConstant u1(k=2)
    annotation (Placement(transformation(extent={{-100,-60},{-80,-40}})));
  Modelica.Blocks.Sources.IntegerConstant u2(k=4)
    annotation (Placement(transformation(extent={{-100,-20},{-80,0}})));
  Modelica.Blocks.Sources.IntegerConstant u3(k=-4)
    annotation (Placement(transformation(extent={{-100,20},{-80,40}})));
  RealType.Expression REALexp(
    nInput=4,
    redeclare function f =
        IndustrialControlSystems.MathOperations.Examples.Mean,
    redeclare function g =
        IndustrialControlSystems.MathOperations.Examples.reScale,
    fname="Mean",
    FixedPoint=true)
    annotation (Placement(transformation(extent={{20,0},{40,20}})));
  Modelica.Blocks.Math.IntegerToReal integerToReal
    annotation (Placement(transformation(extent={{-20,60},{0,80}})));
  Modelica.Blocks.Math.IntegerToReal integerToReal1
    annotation (Placement(transformation(extent={{-20,20},{0,40}})));
  Modelica.Blocks.Math.IntegerToReal integerToReal2
    annotation (Placement(transformation(extent={{-20,-20},{0,0}})));
  Modelica.Blocks.Math.IntegerToReal integerToReal3
    annotation (Placement(transformation(extent={{-20,-60},{0,-40}})));
equation
  connect(u4.y, INTexp.u[4])     annotation (Line(
      points={{-79,70},{-60,70},{-60,11.5},{-48,11.5}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(u3.y, INTexp.u[3])     annotation (Line(
      points={{-79,30},{-62,30},{-62,10.5},{-48,10.5}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(u2.y, INTexp.u[2])     annotation (Line(
      points={{-79,-10},{-62,-10},{-62,9.5},{-48,9.5}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(u1.y, INTexp.u[1])     annotation (Line(
      points={{-79,-50},{-60,-50},{-60,8.5},{-48,8.5}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(u4.y, integerToReal.u) annotation (Line(
      points={{-79,70},{-22,70}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(u3.y, integerToReal1.u) annotation (Line(
      points={{-79,30},{-22,30}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(u2.y, integerToReal2.u) annotation (Line(
      points={{-79,-10},{-22,-10}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(u1.y, integerToReal3.u) annotation (Line(
      points={{-79,-50},{-22,-50}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(integerToReal.y, REALexp.u[4])     annotation (Line(
      points={{1,70},{16,70},{16,11.5},{22,11.5}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(integerToReal1.y, REALexp.u[3])     annotation (Line(
      points={{1,30},{10,30},{10,10.5},{22,10.5}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(integerToReal2.y, REALexp.u[2])     annotation (Line(
      points={{1,-10},{10,-10},{10,9.5},{22,9.5}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(integerToReal3.y, REALexp.u[1])     annotation (Line(
      points={{1,-50},{16,-50},{16,8.5},{22,8.5}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(graphics),
    experiment,
    __Dymola_experimentSetupOutput,
    Documentation(revisions="<html>
<dl><dt>Industrial Control Systems (v 1.0.0) : April-May 2012</dt>
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
<dd><i>The IndustrialControlSystems package is <b>free</b> software; it can be redistributed and/or modified under the terms of the <b>Modelica license</b>.</i><br/></dd>
</dl></html>"));
end CustomMathOperation;
