within IndustrialControlSystems.LinearSystems.Examples;
model Basic "Comparison of the basic continuous and discrete time blocks"
  extends Modelica.Icons.Example;
  // Integrator
  parameter Real mu_int = 0.04 "|Integrator | Integrating process gain";
  parameter Real y_start_int = 1
    "|Integrator | Integrating process initial condition";
  // First order
  parameter Real mu_FO = 2 "|First Order | First order process gain";
  parameter Real tau_FO = 3 "|First Order | First order time constant";
  parameter Real y_start_FO = 0 "|First Order | initial condition";
  // Lead lag
  parameter Real mu_LL = 2 "|Lead Lag | Lead Lag process gain";
  parameter Real y_start_LL = 0 "|Lead Lag | Lead Lag initial condition";
  parameter Real T1_LL = 2 "|Lead Lag | Lead Lag time constant of the zero";
  parameter Real T2_LL = 3 "|Lead Lag | Lead Lag time constant of the pole";
  // Complex poles
  parameter Real mu_cpx = 2 "|Complex poles| Complex poles process gain";
  parameter Real omegan_cpx = 1
    "|Complex poles| Complex poles natural frequency";
  parameter Real xi_cpx = 0.4 "|Complex poles| Complex poles dumping factor";
  parameter Real y_start_cpx = 0 "|Complex poles| Complex poles initial value";
  parameter Real dy_start_cpx = 0 "|Complex poles| Complex poles initial slope";
  // Discretisation
  parameter Real Ts = 0.5 "|Discretisation| Sampling time";
  parameter IndustrialControlSystems.LinearSystems.Discrete.Types.discrMethod method=
      IndustrialControlSystems.LinearSystems.Discrete.Types.discrMethod.FE
    "|Discretisation| Method";
  Continuous.Integrator int(mu=mu_int, y_start=y_start_int)
    annotation (Placement(transformation(extent={{-40,60},{-20,80}})));
  Discrete.Integrator int_dig(mu=mu_int, y_start=y_start_int,
    Ts=Ts,
    method=method)
    annotation (Placement(transformation(extent={{-20,40},{0,60}})));
  Continuous.FirstOrder fO(
    tau=tau_FO,
    mu=mu_FO,
    y_start=y_start_FO)
    annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
  Discrete.FirstOrder fO_dig(
    tau=tau_FO,
    mu=mu_FO,
    y_start=y_start_FO,
    Ts=Ts,
    method=method)
    annotation (Placement(transformation(extent={{-20,0},{0,20}})));
  Continuous.LeadLag lLag(
    mu=mu_LL,
    y_start=y_start_LL,
    T1=T1_LL,
    T2=T2_LL)
    annotation (Placement(transformation(extent={{-40,-20},{-20,0}})));
  Discrete.LeadLag lLag_dig(
    mu=mu_LL,
    y_start=y_start_LL,
    T1=T1_LL,
    T2=T2_LL,
    Ts=Ts,
    method=method)
    annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
  Modelica.Blocks.Sources.Step stepSignal(height=2, startTime=10)
    annotation (Placement(transformation(extent={{-100,0},{-80,20}})));
  Continuous.ComplexPoles complexPoles(
    xi=xi_cpx,
    omegan=omegan_cpx,
    mu=mu_cpx,
    y_start=y_start_cpx,
    dy_start=dy_start_cpx)
    annotation (Placement(transformation(extent={{-40,-60},{-20,-40}})));
  Discrete.ComplexPoles complexPoles_dig(
    Ts=Ts,
    method=method,
    xi=xi_cpx,
    omegan=omegan_cpx,
    mu=mu_cpx,
    y_start=y_start_cpx,
    dy_start=dy_start_cpx)
    annotation (Placement(transformation(extent={{-20,-80},{0,-60}})));
equation
  connect(stepSignal.y, int.u) annotation (Line(
      points={{-79,10},{-60,10},{-60,70},{-38,70}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(stepSignal.y, int_dig.u) annotation (Line(
      points={{-79,10},{-60,10},{-60,50},{-18,50}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(stepSignal.y, fO.u) annotation (Line(
      points={{-79,10},{-60,10},{-60,30},{-38,30}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(stepSignal.y, fO_dig.u) annotation (Line(
      points={{-79,10},{-18,10}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(stepSignal.y, lLag.u) annotation (Line(
      points={{-79,10},{-60,10},{-60,-10},{-38,-10}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(stepSignal.y, lLag_dig.u) annotation (Line(
      points={{-79,10},{-60,10},{-60,-30},{-18,-30}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(stepSignal.y, complexPoles.u) annotation (Line(
      points={{-79,10},{-60,10},{-60,-50},{-38,-50}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(stepSignal.y, complexPoles_dig.u) annotation (Line(
      points={{-79,10},{-60,10},{-60,-70},{-18,-70}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(graphics),
    experiment(StopTime=60),
    experimentSetupOutput,  Documentation(info="
  <HTML>
  <h4>Description of the example</h4>
  <p>
  In this example are shown the step responces of various basic linear systems:
  <ul>
  <li>integrator,</li>
  <li>first order,</li>
  <li>lead lag,</li>
  <li>and complex poles</li>
  </ul><br/>
  
  For each continuous time system there is its discretised version. It is possible to modify the discretisation methods <br>
  as well the sampling time in order to see the changes.
  <br/><br/>
  <b> Continuous time </b><br>
  <img src=\"modelica://IndustrialControlSystems/help/images/LinearSystems/Examples/BasicStepresp.png\">
  <br/><br/>
  <b> Discrete time (Forward Euler) </b><br>
  <img src=\"modelica://IndustrialControlSystems/help/images/LinearSystems/Examples/BasicSteprespDig.png\">
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
end Basic;
