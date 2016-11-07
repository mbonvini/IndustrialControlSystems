within IndustrialControlSystems.LinearSystems.Examples;
model testDelay
  "Test of the delay operator: continuous, discrete (with and without initialisation)"
  extends Modelica.Icons.Example;

  Modelica.Blocks.Sources.Sine signal(
    amplitude=2,
    offset=2,
    startTime=2,
    freqHz=0.2)
    annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));
  IndustrialControlSystems.LinearSystems.Continuous.Delay delay
    annotation (Placement(transformation(extent={{-40,40},{-16,62}})));
  IndustrialControlSystems.LinearSystems.Discrete.MultiStepsDelay multiStepsDelay(Ts=0.1, N=
       10)
    annotation (Placement(transformation(extent={{-40,-20},{0,20}})));
  IndustrialControlSystems.LinearSystems.Discrete.MultiStepsDelay multiStepsDelay_Init(
    Ts=0.1,
    N=10,
    y_start=2)
    annotation (Placement(transformation(extent={{-40,-80},{0,-40}})));
equation
  connect(signal.y, delay.u) annotation (Line(
      points={{-79,6.10623e-16},{-68,6.10623e-16},{-68,51},{-37.6,51}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(signal.y, multiStepsDelay.u) annotation (Line(
      points={{-79,6.10623e-16},{-68,6.10623e-16},{-68,1.33227e-15},{-36,
          1.33227e-15}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(multiStepsDelay_Init.u, signal.y)   annotation (Line(
      points={{-36,-60},{-68,-60},{-68,6.10623e-16},{-79,6.10623e-16}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (
    Diagram(graphics),
    experiment(StopTime=15),
    __Dymola_experimentSetupOutput,  Documentation(info="
  <HTML>
  <h4>Description of the example</h4>
  <p>
  In this example are shown the delay operators.<br>
  The figure shows both the continuous and the discrete delay operators. More in detail it is shown how the initialisation can <br>
  cause problems, in wrongly defined.
  <br/><br/>
  
  <img src=\"modelica://IndustrialControlSystems/help/images/LinearSystems/Examples/TestDelay1.png\"><br>
  <img src=\"modelica://IndustrialControlSystems/help/images/LinearSystems/Examples/TestDelay2.png\">
  <br/
  </p>
  </HTML>", revisions="<html>
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
end testDelay;
