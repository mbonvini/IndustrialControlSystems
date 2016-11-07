within IndustrialControlSystems.LinearSystems.Examples;
model ComparisonTFunction
  "Comparison of the various discretisation methods (generic Trasfer Function)"
  extends Modelica.Icons.Example;
  // Transfer Function
  parameter Real a[:] = {-1,1} "|Transfer Function| Numerator coefficients";
  parameter Real b[:] = {2,4,1} "|Transfer Function| Denumerator coefficients";
  parameter Real y_start = 0 "|Transfer Function| Initial value";
  // Discretisation
  parameter Real Ts = 0.1 "|Discretisation| Sampling time";
  // Errors
  Real error_BE = tf.y - tf_BE.y;
  Real error_FE = tf.y - tf_FE.y;
  Real error_TU = tf.y - tf_TU.y;
  Continuous.TransferFunction tf(num=a, den=b)
    annotation (Placement(transformation(extent={{-20,60},{0,80}})));
  Modelica.Blocks.Sources.Step step(
    height=2,
    offset=0,
    startTime=5)
    annotation (Placement(transformation(extent={{-80,0},{-60,20}})));
  Discrete.TransferFunction tf_FE(
    method=IndustrialControlSystems.LinearSystems.Discrete.Types.discrMethod.FE,
    num=a,
    den=b,
    y_start=y_start,
    Ts=Ts)
    annotation (Placement(transformation(extent={{-20,20},{0,40}})));
  Discrete.TransferFunction tf_BE(
    method=IndustrialControlSystems.LinearSystems.Discrete.Types.discrMethod.BE,
    num=a,
    den=b,
    y_start=y_start,
    Ts=Ts)
    annotation (Placement(transformation(extent={{-20,-20},{0,0}})));
  Discrete.TransferFunction tf_TU(
    method=IndustrialControlSystems.LinearSystems.Discrete.Types.discrMethod.TU,
    num=a,
    den=b,
    y_start=y_start,
    Ts=Ts)
    annotation (Placement(transformation(extent={{-20,-60},{0,-40}})));
equation
  connect(step.y, tf.u)               annotation (Line(
      points={{-59,10},{-30,10},{-30,70},{-18,70}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(step.y, tf_FE.u)             annotation (Line(
      points={{-59,10},{-30,10},{-30,30},{-18,30}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(step.y, tf_BE.u)   annotation (Line(
      points={{-59,10},{-30,10},{-30,-10},{-18,-10}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(step.y, tf_TU.u)   annotation (Line(
      points={{-59,10},{-30,10},{-30,-50},{-18,-50}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(graphics),  Documentation(info="
  <HTML>
  <h4>Description of the example</h4>
  <p>
  In this example are shown the step responces of a first order linear systems:
  <ul>
  <li>continuous,</li>
  <li>discretised with BE,</li>
  <li>discretised with FE,</li>
  <li>and discretised with TU</li>
  </ul><br/>
  
  <b> Comparison </b><br>
  <img src=\"modelica://IndustrialControlSystems/help/images/LinearSystems/Examples/BasicStepresp.png\">
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
</dl></html>"),
    experiment(StopTime=50),
    __Dymola_experimentSetupOutput);
end ComparisonTFunction;
