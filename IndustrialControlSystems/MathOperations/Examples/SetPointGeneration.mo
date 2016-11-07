within IndustrialControlSystems.MathOperations.Examples;
model SetPointGeneration
  "various examples of set point generators and noise signal"
  extends Modelica.Icons.Example;

  RealType.Signals.SmoothStep smoothStep(
    alfa=0.3,
    yfin=3,
    m=0.2) annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
  IndustrialControlSystems.MathOperations.RealType.Signals.SmoothThooth smoothThooth_alpha_01
    annotation (Placement(transformation(extent={{-40,60},{-20,80}})));
  RealType.Signals.SmoothStepSignal smoothStepSignal(
    alfa=0.3,
    yfin=3,
    m=0.2,
    delay=1.5)
           annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
  Modelica.Blocks.Sources.BooleanStep startRise(startTime=15)
    annotation (Placement(transformation(extent={{-100,26},{-80,46}})));
  RealType.Signals.SmoothThoothSignal smoothThoothSignal
    annotation (Placement(transformation(extent={{0,-40},{20,-20}})));
  Modelica.Blocks.Sources.BooleanTable enRise(table={5,6})
    annotation (Placement(transformation(extent={{-40,-20},{-20,0}})));
  Modelica.Blocks.Sources.BooleanTable enFall(table={26,27})
    annotation (Placement(transformation(extent={{-40,-60},{-20,-40}})));
  Modelica.Blocks.Sources.Constant Ystart(k=0)
    annotation (Placement(transformation(extent={{-100,-58},{-80,-38}})));
  Modelica.Blocks.Sources.Constant Yend(k=1)
    annotation (Placement(transformation(extent={{-100,-20},{-80,0}})));
  RealType.Signals.noiseGen noiseGen
    annotation (Placement(transformation(extent={{0,60},{20,80}})));
  IndustrialControlSystems.MathOperations.RealType.Signals.SmoothThooth smoothThooth_alpha_04(alfa=0.4)
    annotation (Placement(transformation(extent={{40,60},{60,80}})));
equation
  connect(startRise.y, smoothStepSignal.ENup)   annotation (Line(
      points={{-79,36},{-38,36}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(enRise.y, smoothThoothSignal.ENup)       annotation (Line(
      points={{-19,-10},{-10,-10},{-10,-24},{2,-24}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(enFall.y, smoothThoothSignal.ENdown)       annotation (Line(
      points={{-19,-50},{-10,-50},{-10,-36},{2,-36}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(Yend.y, smoothThoothSignal.u[2]) annotation (Line(
      points={{-79,-10},{-60,-10},{-60,-29},{2,-29}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(Ystart.y, smoothThoothSignal.u[1]) annotation (Line(
      points={{-79,-48},{-60,-48},{-60,-31},{2,-31}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (
    experiment(StopTime=50),
    experimentSetupOutput,
    Diagram(graphics),
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
end SetPointGeneration;
