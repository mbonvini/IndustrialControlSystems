within IndustrialControlSystems.Controllers.Blocks.Examples;
model TestAntiWindupBlocks "Antiwindup TEST"
  extends Modelica.Icons.Example;

  Modelica.Blocks.Sources.TimeTable
                               signal(
    offset=0,
    startTime=0,
    table=[0,0; 2,0; 2,1; 40,1; 40,-1; 20,-1])
    annotation (                          Placement(transformation(extent={{-100,
            -10},{-80,10}},
                       rotation=0)));
  IndustrialControlSystems.Controllers.Blocks.P Gain(
    Kp=2,
    Ymin=0,
    Ymax=1.8,
    AntiWindup=false)
    annotation (Placement(transformation(extent={{-60,70},{-40,90}})));
  IndustrialControlSystems.Controllers.Blocks.I Integrator(
    y_start=1,
    T=20,
    Ymin=0,
    Ymax=1.8,
    AntiWindup=false)
    annotation (Placement(transformation(extent={{-60,30},{-40,50}})));
  IndustrialControlSystems.Controllers.Blocks.FO FirstOrder(
    mu=2,
    T=4,
    Ymin=0,
    Ymax=1.8,
    AntiWindup=false)
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  IndustrialControlSystems.Controllers.Blocks.LeadLAG LeadLAG(
    mu=2,
    Tp=4,
    Tz=1,
    Ymin=0,
    Ymax=1.8,
    AntiWindup=false)
    annotation (Placement(transformation(extent={{-60,-50},{-40,-30}})));
  IndustrialControlSystems.Controllers.Blocks.ComplexPoles complexPoles(
    xi=0.3,
    mu=2,
    Ymin=0,
    Ymax=1.8,
    AntiWindup=false,
    omega=1.2)
    annotation (Placement(transformation(extent={{-60,-90},{-40,-70}})));
equation
  connect(signal.y, Gain.u) annotation (Line(
      points={{-79,6.10623e-16},{-72,6.10623e-16},{-72,80},{-58,80}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(signal.y, Integrator.u) annotation (Line(
      points={{-79,6.10623e-16},{-72,6.10623e-16},{-72,40},{-58,40}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(signal.y, FirstOrder.u) annotation (Line(
      points={{-79,6.10623e-16},{-68.5,6.10623e-16},{-68.5,6.66134e-16},{-58,
          6.66134e-16}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(signal.y, LeadLAG.u) annotation (Line(
      points={{-79,6.10623e-16},{-72,6.10623e-16},{-72,-40},{-58,-40}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(signal.y, complexPoles.u) annotation (Line(
      points={{-79,6.10623e-16},{-72,6.10623e-16},{-72,-80},{-58,-80}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(graphics),
    experiment(StopTime=80),
    experimentSetupOutput,Documentation(info="
  <HTML>
  <h4>Description</h4>
  <p>
  In this example has been tested the AntiWindup.<br>
  The images show the step responces of the transfer functions without limiter, and with an higher limit of <FONT FACE=Courier>Ymax = 1.8</FONT>
  
  <h4>No Antiwindup</h4>
  <img src=\"modelica://IndustrialControlSystems/help/images/Controllers/Blocks/Examples/NotSaturatedBlocks.png\"><br>
  
  <h4>Antiwindup</h4>
  <img src=\"modelica://IndustrialControlSystems/help/images/Controllers/Blocks/Examples/saturatedBlocks.png\">
  
  </HTML>",
      revisions="<html>
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
end TestAntiWindupBlocks;
