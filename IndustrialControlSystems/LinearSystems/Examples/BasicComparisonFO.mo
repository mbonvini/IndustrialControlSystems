within IndustrialControlSystems.LinearSystems.Examples;
model BasicComparisonFO
  "Comparison of the various discretisation methods (First Order)"
  extends Modelica.Icons.Example;
  // First order
  parameter Real mu_FO = 2 "|First Order | First order process gain";
  parameter Real tau_FO = 3 "|First Order | First order time constant";
  parameter Real y_start_FO = 0 "|First Order | initial condition";
  // Discretisation
  parameter Real Ts = 0.5 "|Discretisation| Sampling time";
  // Errors
  Real error_BE = fO.y - fO_dig_BE.y;
  Real error_FE = fO.y - fO_dig_FE.y;
  Real error_TU = fO.y - fO_dig_TU.y;
  Continuous.FirstOrder fO(
    tau=tau_FO,
    mu=mu_FO,
    y_start=y_start_FO)
    annotation (Placement(transformation(extent={{-40,40},{0,80}})));
  Discrete.FirstOrder fO_dig_BE(
    tau=tau_FO,
    mu=mu_FO,
    y_start=y_start_FO,
    Ts=Ts,
    method=IndustrialControlSystems.LinearSystems.Discrete.Types.discrMethod.BE)
    annotation (Placement(transformation(extent={{-40,0},{0,40}})));
  Modelica.Blocks.Sources.Step stepSignal(height=2, startTime=10)
    annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));
  Discrete.FirstOrder fO_dig_FE(
    tau=tau_FO,
    mu=mu_FO,
    y_start=y_start_FO,
    Ts=Ts,
    method=IndustrialControlSystems.LinearSystems.Discrete.Types.discrMethod.FE)
    annotation (Placement(transformation(extent={{-40,-40},{0,0}})));
  Discrete.FirstOrder fO_dig_TU(
    tau=tau_FO,
    mu=mu_FO,
    y_start=y_start_FO,
    Ts=Ts,
    method=IndustrialControlSystems.LinearSystems.Discrete.Types.discrMethod.TU)
    annotation (Placement(transformation(extent={{-40,-80},{0,-40}})));
equation
  connect(stepSignal.y, fO.u) annotation (Line(
      points={{-79,6.10623e-16},{-60,6.10623e-16},{-60,60},{-36,60}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(stepSignal.y, fO_dig_BE.u)
                                  annotation (Line(
      points={{-79,6.10623e-16},{-60,6.10623e-16},{-60,20},{-36,20}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(stepSignal.y, fO_dig_FE.u) annotation (Line(
      points={{-79,6.10623e-16},{-60,6.10623e-16},{-60,-20},{-36,-20}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(stepSignal.y, fO_dig_TU.u) annotation (Line(
      points={{-79,6.10623e-16},{-60,6.10623e-16},{-60,-60},{-36,-60}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(graphics),
    experiment(StopTime=30),
    experimentSetupOutput,  Documentation(info="
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
  <img src=\"modelica://IndustrialControlSystems/help/images/LinearSystems/Examples/Comparison_FO.png\">
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
end BasicComparisonFO;
