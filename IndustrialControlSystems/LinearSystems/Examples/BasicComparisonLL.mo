within IndustrialControlSystems.LinearSystems.Examples;
model BasicComparisonLL
  "Comparison of the various discretisation methods (Lead Lag)"
  extends Modelica.Icons.Example;
  // Lead lag
  parameter Real mu_LL = 2 "|Lead Lag | Lead Lag process gain";
  parameter Real y_start_LL = 0 "|Lead Lag | Lead Lag initial condition";
  parameter Real T1_LL = 2 "|Lead Lag | Lead Lag time constant of the zero";
  parameter Real T2_LL = 3 "|Lead Lag | Lead Lag time constant of the pole";
  // Discretisation
  parameter Real Ts = 0.5 "|Discretisation| Sampling time";
  // Errors
  Real error_BE = ll.y - ll_dig_BE.y;
  Real error_FE = ll.y - ll_dig_FE.y;
  Real error_TU = ll.y - ll_dig_TU.y;
  Continuous.LeadLag    ll(
    mu=mu_LL,
    y_start=y_start_LL,
    T1=T1_LL,
    T2=T2_LL)
    annotation (Placement(transformation(extent={{-40,40},{0,80}})));
  Discrete.LeadLag    ll_dig_BE(
    mu=mu_LL,
    y_start=y_start_LL,
    T1=T1_LL,
    T2=T2_LL,
    Ts=Ts,
    method=IndustrialControlSystems.LinearSystems.Discrete.Types.discrMethod.BE)
    annotation (Placement(transformation(extent={{-40,0},{0,40}})));
  Modelica.Blocks.Sources.Step stepSignal(height=2, startTime=10)
    annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));
  Discrete.LeadLag    ll_dig_FE(
    mu=mu_LL,
    y_start=y_start_LL,
    T1=T1_LL,
    T2=T2_LL,
    Ts=Ts,
    method=IndustrialControlSystems.LinearSystems.Discrete.Types.discrMethod.FE)
    annotation (Placement(transformation(extent={{-40,-40},{0,0}})));
  Discrete.LeadLag    ll_dig_TU(
    mu=mu_LL,
    y_start=y_start_LL,
    T1=T1_LL,
    T2=T2_LL,
    Ts=Ts,
    method=IndustrialControlSystems.LinearSystems.Discrete.Types.discrMethod.TU)
    annotation (Placement(transformation(extent={{-40,-80},{0,-40}})));
equation
  connect(stepSignal.y, ll.u) annotation (Line(
      points={{-79,6.10623e-16},{-60,6.10623e-16},{-60,60},{-36,60}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(stepSignal.y, ll_dig_BE.u)
                                  annotation (Line(
      points={{-79,6.10623e-16},{-60,6.10623e-16},{-60,20},{-36,20}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(stepSignal.y, ll_dig_FE.u) annotation (Line(
      points={{-79,6.10623e-16},{-60,6.10623e-16},{-60,-20},{-36,-20}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(stepSignal.y, ll_dig_TU.u) annotation (Line(
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
  <img src=\"modelica://IndustrialControlSystems/help/images/LinearSystems/Examples/Comparison_LL.png\">
  </p>
  </HTML>", revisions="<html>
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
end BasicComparisonLL;
