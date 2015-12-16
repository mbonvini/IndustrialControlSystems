within IndustrialControlSystems.Logical.Counter.Examples;
model countZeroCrossing "test model of the counter"
  extends Modelica.Icons.Example;

  Counter counter
    annotation (Placement(transformation(extent={{0,20},{40,60}})));
  Modelica.Blocks.Sources.IntegerConstant x0(k=0) annotation (Placement(
        transformation(extent={{-20,-40},{0,-20}})));
  Modelica.Blocks.Sources.BooleanTable set(startValue=false, table={2.2,10.2})
    annotation (Placement(transformation(extent={{-100,-20},{-80,0}})));
  Modelica.Blocks.Sources.BooleanTable reset(startValue=false, table={15})
                                             annotation (Placement(
        transformation(extent={{-100,-50},{-80,-30}})));
  Modelica.Blocks.Sources.Sine sine(amplitude=1, freqHz=1)
    annotation (Placement(transformation(extent={{-100,70},{-80,90}})));
  Comparisons.RealType.Equal
                 equal(Ts=0.01, eps=0.005)
    annotation (Placement(transformation(extent={{-54,60},{-34,80}})));
  Modelica.Blocks.Sources.Constant zero(k=0)
    annotation (Placement(transformation(extent={{-100,40},{-80,60}})));
  Modelica.Blocks.Sources.BooleanConstant False(k=false)
    annotation (Placement(transformation(extent={{-100,10},{-80,30}})));
equation
  connect(x0.y, counter.PV) annotation (Line(
      points={{1,-30},{12,-30},{12,24}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(reset.y, counter.R) annotation (Line(
      points={{-79,-40},{-46,-40},{-46,32},{4,32}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(set.y, counter.S) annotation (Line(
      points={{-79,-10},{-50,-10},{-50,40},{4,40}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(sine.y, equal.u1) annotation (Line(
      points={{-79,80},{-61.5,80},{-61.5,75},{-52,75}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(zero.y, equal.u2) annotation (Line(
      points={{-79,50},{-62,50},{-62,65},{-52,65}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(equal.y, counter.CU) annotation (Line(
      points={{-35,70},{-16,70},{-16,56},{4,56}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(False.y, counter.CD) annotation (Line(
      points={{-79,20},{-54,20},{-54,48},{4,48}},
      color={255,0,255},
      smooth=Smooth.None));
  annotation (Diagram(graphics),
    experiment(StopTime=20),
    experimentSetupOutput,
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
</dl></html>", info="<html>
In this example have been tested the basic functionalities of the UP and DOWN counter, together with other logical blocks.<br>
The logical block compares the signal<br>
<pre>
y(t) = sin(t)
</pre>
<br>

with the zero value. For each zero crossing detection a boolean signal is rised. The boolean signals comprises between 2.2 and 10.2 second 
are counted by the counter.<br><br>
<img src=\"modelica://IndustrialControlSystems/help/images/Logical/Counter/LogicSignals.png\"><br>
<img src=\"modelica://IndustrialControlSystems/help/images/Logical/Counter/CounterSignal.png\"><br>
</html>"));
end countZeroCrossing;
