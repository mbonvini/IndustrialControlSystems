within IndustrialControlSystems.Applications.ControlProblems;
model CascadeAntiWindup "Example of cascade control with external lock"
  extends Modelica.Icons.Example;
  Controllers.Digital.PID_2dof PID_outer_extLock(
    useForbid=true,
    Ts=0.01,
    Kp=0.2,
    Ti=1) annotation (Placement(transformation(extent={{-60,60},{-40,80}})));
  Controllers.Digital.PID_2dof PID_inner_extLock(
    AntiWindup=true,
    CSmin=0,
    CSmax=1,
    Ti=0.1,
    Ts=0.01,
    Kp=0.8) annotation (Placement(transformation(extent={{-20,52},{0,72}})));
  LinearSystems.Continuous.TransferFunction P1(num={0.5}, den={0.1,1})
    "inner process trasfer function"
    annotation (Placement(transformation(extent={{26,52},{46,72}})));
  LinearSystems.Continuous.TransferFunction P2(num={4}, den={2.5,1})
    "outer process trasfer function"
    annotation (Placement(transformation(extent={{60,52},{80,72}})));
  Modelica.Blocks.Sources.TimeTable
                               SetPoint(table=[0,0; 1,0; 1,1; 15,1; 15,2; 30,2;
        30,1; 50,1], startTime=0)
    annotation (Placement(transformation(extent={{-100,68},{-80,88}})));
  Controllers.Digital.PID_2dof PID_outer(
    Ts=0.01,
    useForbid=false,
    Kp=0.2,
    Ti=1) annotation (Placement(transformation(extent={{-60,-20},{-40,0}})));
  Controllers.Digital.PID_2dof PID_inner(
    AntiWindup=true,
    CSmin=0,
    CSmax=1,
    Ti=0.1,
    Ts=0.01,
    Kp=0.8) annotation (Placement(transformation(extent={{-20,-28},{0,-8}})));
  LinearSystems.Continuous.TransferFunction P3(num={0.5}, den={0.1,1})
    "inner process trasfer function"
    annotation (Placement(transformation(extent={{26,-28},{46,-8}})));
  LinearSystems.Continuous.TransferFunction P4(num={4}, den={2.5,1})
    "outer process trasfer function"
    annotation (Placement(transformation(extent={{60,-28},{80,-8}})));
equation

  connect(PID_inner_extLock.CS, P1.u) annotation (Line(
      points={{-1,62},{28,62}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(P1.y, P2.u) annotation (Line(
      points={{45,62},{62,62}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(P2.y, PID_outer_extLock.PV) annotation (Line(
      points={{79,62},{94,62},{94,28},{-66,28},{-66,74},{-58,74}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(SetPoint.y, PID_outer_extLock.SP) annotation (Line(
      points={{-79,78},{-58,78}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(PID_outer_extLock.CS, PID_inner_extLock.SP) annotation (Line(
      points={{-41,70},{-18,70}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(PID_inner_extLock.satHI, PID_outer_extLock.Finc) annotation (Line(
      points={{-1,68},{12,68},{12,42},{-54,42},{-54,62}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(PID_inner_extLock.satLOW, PID_outer_extLock.Fdec) annotation (Line(
      points={{-1,56},{4,56},{4,46},{-48,46},{-48,62}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(P1.y, PID_inner_extLock.PV) annotation (Line(
      points={{45,62},{50,62},{50,36},{-28,36},{-28,66},{-18,66}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(PID_inner.CS, P3.u) annotation (Line(
      points={{-1,-18},{28,-18}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(P3.y, P4.u) annotation (Line(
      points={{45,-18},{62,-18}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(P4.y, PID_outer.PV) annotation (Line(
      points={{79,-18},{94,-18},{94,-52},{-66,-52},{-66,-6},{-58,-6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(SetPoint.y, PID_outer.SP) annotation (Line(
      points={{-79,78},{-73.5,78},{-73.5,-2},{-58,-2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(PID_outer.CS, PID_inner.SP) annotation (Line(
      points={{-41,-10},{-18,-10}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(P3.y, PID_inner.PV) annotation (Line(
      points={{45,-18},{50,-18},{50,-44},{-28,-44},{-28,-14},{-18,-14}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (
    Diagram(graphics),
    experiment(StopTime=50),
    __Dymola_experimentSetupOutput,
    Documentation(info="<HTML>
  <h4>Description</h4>
  <p>
  In this examples are compared two cascade control schemes: with and without external lock.<br><br>
  When two controllers are connected together in a cascade control scheme, the inner controller typically regulates the actuator, while
  the outer one provides the Set Point reference for the inner one.<br>
  Since the inner controller acts on the plants, its Control Signal have to be limited, using AntiWindup. Unfortunately it is not possible for the outer
  controller, to know the values for which the inner regulator saturates.<br>
  Such a problem can be voided by using the PID in its incremental form, using the Increment/Decrement lock feature, and creating 
  an external loop between the controllers.<br>
  If the inner regulator saturates, its <FONT FACE=Courier>satHi</FONT> signal becomes true. Connecting this signal to the 
  <FONT FACE=Courier>forbidIncrement</FONT> input of the outer controller, avoid an useless and potentially dangerous increase of its Control Signal ( that is the
  Set point of the inner controller that saturated). With such a scheme a windup-like effect can be avoided.<br>
  In the following figure, the green line is the CS of the outer controller with Increment/Decrement lock, while the black one is the output of the outer 
  controller whitout Increment/Decrement lock.<br>
  The black line shows a windup like effect that turns in a slower reaction when the Set Point changes at time t = 30.<br><br>
  Set Point, Process Variables (with and without external lock) and outer control signals (with and without external lock) 
  <img src=\"modelica://IndustrialControlSystems/help/images/Applications/ControlProblems/PID_extLock.png\"><br><br>
  inner regulators Control Signal (with and without external lock)
  <img src=\"modelica://IndustrialControlSystems/help/images/Applications/ControlProblems/PID_extLockCS.png\"><br>
</html>", revisions="<html>
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
end CascadeAntiWindup;
