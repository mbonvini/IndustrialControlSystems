within IndustrialControlSystems.Logical.Comparisons.Examples;
model TestComparison
  extends Modelica.Icons.Example;
  parameter Real Ts = 0.001 "|Sampling| Sampling time";
  parameter Real eps = 0.01 "|Real numbers| Comparison threshold";
  RealType.Equal equal(Ts=Ts, eps=eps)
    annotation (Placement(transformation(extent={{-40,40},{-20,60}})));
  Modelica.Blocks.Sources.Sine sine(amplitude=1, freqHz=1)
    annotation (Placement(transformation(extent={{-100,60},{-80,80}})));
  Modelica.Blocks.Sources.Sine cosine(
    amplitude=1,
    freqHz=1,
    phase=1.5707963267949)
    annotation (Placement(transformation(extent={{-100,20},{-80,40}})));
  RealType.Less less(Ts=Ts, eps=eps)
    annotation (Placement(transformation(extent={{-40,-20},{-20,0}})));
equation
  connect(sine.y, equal.u1) annotation (Line(
      points={{-79,70},{-60,70},{-60,55},{-38,55}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(cosine.y, equal.u2) annotation (Line(
      points={{-79,30},{-60,30},{-60,45},{-38,45}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(sine.y, less.u1) annotation (Line(
      points={{-79,70},{-70,70},{-70,-5},{-38,-5}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(cosine.y, less.u2) annotation (Line(
      points={{-79,30},{-74,30},{-74,-15},{-38,-15}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(graphics), Documentation(info="<html>
<h4>Description</h4>
<p>
In this examples are tested the Real comparison operations.<br>
The two signals compared are:
<pre>
u1(t) = sin(t)
u2(t) = cos(t)
</pre>
<br>
The boolean signals are true if<br>
<pre>
u1(t) == u2(t)
u2(t) &lt; u2(t)
</pre><br>
Depending on the value of the sampling time <FONT FACE=Courier>Ts</FONT> adopted and the tolerance value of <FONT FACE=Courier>eps</FONT>,
the conditions can be <FONT FACE=Courier>true</FONT> or not.<br>
In this case <FONT FACE=Courier>Ts = 0.001</FONT> and <FONT FACE=Courier>eps = 0.01</FONT>
<br><br>
<img src=\"modelica://IndustrialControlSystems/help/images/Logical/Comparisons/Examples/OutputSignals.png\"><br><br>
In this case <FONT FACE=Courier>Ts = 0.001</FONT> and <FONT FACE=Courier>eps = 0.001</FONT>
<br><br>
<img src=\"modelica://IndustrialControlSystems/help/images/Logical/Comparisons/Examples/Signals.png\"><br><br>
It is evident that with a smaller tolerance, the boolean signal that represents the equality of the two signals becames shorter.
</p>
</html>", revisions="<html>
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
</dl></html>"),
    experiment,
    __Dymola_experimentSetupOutput);
end TestComparison;
