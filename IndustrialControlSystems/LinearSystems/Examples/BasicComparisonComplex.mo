within IndustrialControlSystems.LinearSystems.Examples;
model BasicComparisonComplex
  "Comparison of the various discretisation methods (Complex Poles)"
  extends Modelica.Icons.Example;
  // Complex poles
  parameter Real mu_cpx = 2 "|Complex poles| Complex poles process gain";
  parameter Real omegan_cpx = 1
    "|Complex poles| Complex poles natural frequency";
  parameter Real xi_cpx = 0.4 "|Complex poles| Complex poles damping factor";
  parameter Real y_start_cpx = 0 "|Complex poles| Complex poles initial value";
  parameter Real dy_start_cpx = 0 "|Complex poles| Complex poles initial slope";
  // Discretisation
  parameter Real Ts = 0.5 "|Discretisation| Sampling time";
  // Errors
  Real error_BE = cplxP.y - cplxP_dig_BE.y;
  Real error_FE = cplxP.y - cplxP_dig_FE.y;
  Real error_TU = cplxP.y - cplxP_dig_TU.y;
  Continuous.ComplexPoles cplxP(
    xi=xi_cpx,
    omegan=omegan_cpx,
    mu=mu_cpx,
    y_start=y_start_cpx,
    dy_start=dy_start_cpx)
    annotation (Placement(transformation(extent={{-40,60},{0,100}})));
  Discrete.ComplexPoles cplxP_dig_BE(
    xi=xi_cpx,
    omegan=omegan_cpx,
    mu=mu_cpx,
    y_start=y_start_cpx,
    dy_start=dy_start_cpx,
    Ts=Ts,
    method=IndustrialControlSystems.LinearSystems.Discrete.Types.discrMethod.BE)
    annotation (Placement(transformation(extent={{-40,12},{0,52}})));
  Discrete.ComplexPoles cplxP_dig_FE(
    xi=xi_cpx,
    omegan=omegan_cpx,
    mu=mu_cpx,
    y_start=y_start_cpx,
    dy_start=dy_start_cpx,
    Ts=Ts,
    method=IndustrialControlSystems.LinearSystems.Discrete.Types.discrMethod.FE)
    annotation (Placement(transformation(extent={{-40,-40},{0,0}})));
  Discrete.ComplexPoles cplxP_dig_TU(
    xi=xi_cpx,
    omegan=omegan_cpx,
    mu=mu_cpx,
    y_start=y_start_cpx,
    dy_start=dy_start_cpx,
    Ts=Ts,
    method=IndustrialControlSystems.LinearSystems.Discrete.Types.discrMethod.TU)
    annotation (Placement(transformation(extent={{-40,-88},{0,-48}})));
  Modelica.Blocks.Sources.Step stepSignal(height=2, startTime=5,
    offset=0)
    annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));
equation
  connect(stepSignal.y, cplxP.u)        annotation (Line(
      points={{-79,6.10623e-16},{-60,6.10623e-16},{-60,80},{-36,80}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(stepSignal.y, cplxP_dig_BE.u)  annotation (Line(
      points={{-79,6.10623e-16},{-60,6.10623e-16},{-60,32},{-36,32}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(stepSignal.y, cplxP_dig_FE.u)  annotation (Line(
      points={{-79,6.10623e-16},{-60,6.10623e-16},{-60,-20},{-36,-20}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(stepSignal.y, cplxP_dig_TU.u)  annotation (Line(
      points={{-79,6.10623e-16},{-60,6.10623e-16},{-60,-68},{-36,-68}},
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
  <img src=\"modelica://IndustrialControlSystems/help/images/LinearSystems/Examples/Comparison_CPX.png\">
  
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
end BasicComparisonComplex;
