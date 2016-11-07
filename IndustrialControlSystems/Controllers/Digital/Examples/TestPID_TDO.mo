within IndustrialControlSystems.Controllers.Digital.Examples;
model TestPID_TDO
  "Test of the 2DoF digital PID controller with Time Division Output (TDO)"
  extends Modelica.Icons.Example;

  Modelica.Blocks.Sources.Step step(startTime=10)
                                    annotation (
      Placement(transformation(extent={{-100,70},{-80,90}},rotation=0)));
  PID_2dof_TDO ControllerTDO(
    AntiWindup=true,
    CSmin=0,
    CSmax=2,
    Ti=2,
    Td=0.2,
    b=1,
    c=0,
    N=5,
    useTS=false,
    useBIAS=false,
    useMAN=false,
    useForbid=false,
    Kp=10,
    TDsteps=100,
    Ts=0.2)
    annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
  LinearSystems.Continuous.TransferFunction ProcessTDO(num={5,1}, den={20,12,1})
    annotation (Placement(transformation(extent={{18,20},{42,40}})));
  Modelica.Blocks.Math.Feedback sub annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={0,30})));
  Modelica.Blocks.Sources.Step disturb(height=0.2, startTime=50)
                                    annotation (
      Placement(transformation(extent={{-60,70},{-40,90}}, rotation=0)));
  PID_2dof Controller(
    AntiWindup=true,
    CSmin=0,
    CSmax=2,
    Ti=2,
    Td=0.2,
    b=1,
    c=0,
    N=5,
    useTS=false,
    useBIAS=false,
    useMAN=false,
    useForbid=false,
    Kp=10,
    Ts=0.2)
    annotation (Placement(transformation(extent={{-40,-40},{-20,-20}})));
  LinearSystems.Continuous.TransferFunction Process(num={5,1}, den={20,12,1})
    annotation (Placement(transformation(extent={{20,-40},{44,-20}})));
  LinearSystems.Continuous.TransferFunction ProcessNoControl(num={5,1}, den={20,
        12,1})
    annotation (Placement(transformation(extent={{20,70},{50,90}})));
  Modelica.Blocks.Math.Feedback sub1
                                    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={0,-30})));
equation
  connect(step.y, ControllerTDO.SP)
                           annotation (Line(
      points={{-79,80},{-76,80},{-76,38},{-38,38}},
      color={0,0,127},
      smooth=Smooth.None));

  connect(ControllerTDO.CS, sub.u1)
                                 annotation (Line(
      points={{-21,30},{-8,30}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(sub.y, ProcessTDO.u)
                            annotation (Line(
      points={{9,30},{20.4,30}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(disturb.y, sub.u2) annotation (Line(
      points={{-39,80},{-14,80},{-14,14},{6.66134e-16,14},{6.66134e-16,22}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(ProcessTDO.y, ControllerTDO.PV)
                                    annotation (Line(
      points={{40.8,30},{52,30},{52,0},{-48,0},{-48,34},{-38,34}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(step.y, Controller.SP) annotation (Line(
      points={{-79,80},{-76,80},{-76,-22},{-38,-22}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(step.y, ProcessNoControl.u) annotation (Line(
      points={{-79,80},{-70,80},{-70,98},{0,98},{0,80},{23,80}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(Process.y, Controller.PV) annotation (Line(
      points={{42.8,-30},{54,-30},{54,-60},{-48,-60},{-48,-26},{-38,-26}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(sub1.y, Process.u) annotation (Line(
      points={{9,-30},{22.4,-30}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(disturb.y, sub1.u2) annotation (Line(
      points={{-39,80},{-14,80},{-14,-46},{6.66134e-16,-46},{6.66134e-16,-38}},
      color={0,0,127},
      smooth=Smooth.None));

  connect(Controller.CS, sub1.u1) annotation (Line(
      points={{-21,-30},{-8,-30}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(graphics),
    experiment(StopTime=70),
    experimentSetupOutput,Documentation(info="
  <HTML>
  <h4>Description</h4>
  <p>
  In this example have been compared the 2DoF incremental PID, with its Time Division Output implementation.<br>
  The PIDs have to control the process with transfer function
  <pre>
   Y(s)             5*s +1
   ----  =  -----------------------
   U(s)        20*s^2 + 12*s + 1
  </pre>
  The image compares the outputs of the process <FONT FACE=Courier>y</FONT> with and without the controllers action.<br>
  <img src=\"modelica://IndustrialControlSystems/help/images/Controllers/Digital/Examples/PIDTDO.png\"><br>
  The following image compares the CS computed by the TDO controller (before its conversion), and the CS comuted by the<br>
  controller without TDO. 
  <img src=\"modelica://IndustrialControlSystems/help/images/Controllers/Digital/Examples/PIDTDO_CS.png\"><br>
  </p>
  <h4>Basic implementation</h4>
  <p>
  The basic implementation of the digital incremental PID with TDO, introduces an high number of time events, thus the time spent<br>
  for simulating the model is high. Here follows the simulation results for the considere examples
  <pre>     
  Integration started at T = 0 using integration method DASSL
  (DAE multi-step solver (dassl/dasslrt of Petzold modified by Dynasim))
  Integration terminated successfully at T = 70
    WARNING: You have many time events. This is probably due to fast sampling.
    Enable logging of event in Simulation/Setup/Debug/Events during simulation
     CPU-time for integration      : 5.68 seconds
     CPU-time for one GRID interval: 11.4 milli-seconds
     Number of result points       : 70000
     Number of GRID   points       : 501
     Number of (successful) steps  : 350000
     Number of F-evaluations       : 1295000
     Number of Jacobian-evaluations: 315000
     Number of (model) time events : 35000
     Number of (U) time events     : 0
     Number of state    events     : 0
     Number of step     events     : 0
     Minimum integration stepsize  : 2e-06
     Maximum integration stepsize  : 0.000978
     Maximum integration order     : 2
  </pre>
  </p>
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
end TestPID_TDO;
