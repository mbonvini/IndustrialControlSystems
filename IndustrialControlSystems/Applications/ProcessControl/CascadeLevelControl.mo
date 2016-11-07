within IndustrialControlSystems.Applications.ProcessControl;
model CascadeLevelControl "Cascade level control with PI controllers"
  extends Modelica.Icons.Example;
  import Modelica.SIunits.*;
  parameter Length PipeL = 1 "|Process| Pipe length";
  parameter Length PipeD = 0.0254 "|Process| Pipe diameter";
  parameter Length Lstart = 1 "|Process| Initial water level";
  parameter Length H = 2 "|Process| Storage height";
  parameter Area A = 1.5 "|Process| Cross section storage area";
  parameter Real Tact = 2 "|Process| Actuator dynamics";

  parameter Real Ts_l = 0
    "|Controller level| Sampling time for the valve controller";
  parameter Real Kp_l = -200 "|Controller level| Proportional gain";
  parameter Real Ti_l = 100 "|Controller level| Integral time";
  parameter Boolean AntiWindup_l = true
    "|Controller level| Flag that enables the antiwindup feature";
  parameter Real CSmin_l = -2 "|Controller level| minimum value of the CS";
  parameter Real CSmax_l= 2 "|Controller level| maximum value of the CS";
  parameter Real CS_start_l = 0 "|Controller level| output initial value";

  parameter Real Ts_v = 0
    "|Controller valve| Sampling time for the valve controller";
  parameter Real Kp_v = 50 "|Controller valve| Proportional gain";
  parameter Real Ti_v = 2 "|Controller valve| Integral time";
  parameter Boolean AntiWindup_v = true
    "|Controller| Flag that enables the antiwindup feature";
  parameter Real CSmin_v = 0 "|Controller valve| minimum value of the CS";
  parameter Real CSmax_v = 1 "|Controller valve| maximum value of the CS";
  parameter Real CS_start_v = 0 "|Controller valve| output initial value";

  parameter Boolean FixedPoint = false
    "|Conversion| Use FP operations for level measurement operations";
  parameter Integer Nbit = 24 "|Conversion| number of bit for FP operations";
  parameter Real scaleF_div = 500 "|Conversion| division scale factor";
  parameter Real scaleF_sub = 20 "|Conversion| subtraction scale factor";
  Controllers.PID          PI_Level(
    Ts=Ts_l,
    CS_start=CS_start_l,
    Kp=Kp_l,
    Ti=Ti_l,
    AntiWindup=AntiWindup_l,
    CSmin=CSmin_l,
    CSmax=CSmax_l) "PI level controller"
    annotation (Placement(transformation(extent={{-72,-30},{-52,-10}})));
  Modelica.Blocks.Sources.Step disturb(
    startTime=3600,
    height=0.4,
    offset=0.4) "inlet water disturb"
    annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
  Modelica.Blocks.Sources.Step levelSetPoint(
    offset=1,
    height=-0.5,
    startTime=1200) "Set Point level"
    annotation (Placement(transformation(extent={{-100,20},{-80,40}})));
  Modelica.Fluid.Vessels.OpenTank tank(nPorts=3, redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    level_start=Lstart,
    use_HeatTransfer=false,
    height=H,
    crossArea=A,
    m_flow_small=0.001,
    portsData={Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(diameter=
        PipeD, height=H),Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(
        diameter=PipeD, height=0),
        Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(diameter=PipeD)},
    use_portsData=false) "water tank"
    annotation (Placement(transformation(extent={{42,0},{82,40}})));
  Modelica.Fluid.Valves.ValveLinear valveLinear(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    m_flow_nominal=2,
    dp_nominal=1000) "outlet valve"
    annotation (Placement(transformation(extent={{114,-68},{134,-48}})));
  Modelica.Fluid.Pipes.StaticPipe pipe(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    nParallel=1,
    length=PipeL,
    isCircular=true,
    height_ab=0,
    diameter=PipeD,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
          dp_nominal=10000, m_flow_nominal=2)) "outlet pipe"
    annotation (Placement(transformation(extent={{64,-68},{84,-48}})));
  Modelica.Fluid.Sources.FixedBoundary boundary(nPorts=1, redeclare package
      Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    use_p=true) "boundary pressure condition"             annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={150,-58})));
  Modelica.Fluid.Sources.MassFlowSource_T Inlet(
    nPorts=1,
    use_m_flow_in=true,
    redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater) "disturb water inlet"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={26,30})));
  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{114,0},{134,20}})));
  Modelica.Blocks.Continuous.FirstOrder actuator(
    k=1,
    initType=Modelica.Blocks.Types.Init.NoInit,
    T=Tact) "actuator dynamics"
    annotation (Placement(transformation(extent={{96,-36},{116,-16}})));
  Modelica.Fluid.Sensors.Pressure pSensor(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater) "pressure sensor"
    annotation (Placement(transformation(extent={{172,-10},{192,10}})));
  MathOperations.RealType.Div div(
    Nbit=Nbit,
    FixedPoint=FixedPoint,
    scaleFactor=scaleF_div,
    Ts=Ts_l) "water level"
                     annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={264,-24})));
  Modelica.Blocks.Sources.RealExpression rho_times_g(y=system.g*995.586)
    "density times the gravity acceleration"
    annotation (Placement(transformation(extent={{202,-46},{222,-26}})));
  MathOperations.RealType.Sub sub(
    Nbit=Nbit,
    FixedPoint=FixedPoint,
    scaleFactor=scaleF_sub,
    Ts=Ts_l) "hydrostatic pressure"
    annotation (Placement(transformation(extent={{218,-20},{238,0}})));
  Modelica.Blocks.Sources.RealExpression p_amb(y=system.p_ambient)
    "ambient pressure"
    annotation (Placement(transformation(extent={{174,-44},{194,-24}})));
  Controllers.PID          PI_Valve(
    Ts=Ts_v,
    AntiWindup=AntiWindup_v,
    CSmin=CSmin_v,
    CSmax=CSmax_v,
    CS_start=CS_start_v,
    Kp=Kp_v,
    Ti=Ti_v)
    annotation (Placement(transformation(extent={{-44,-36},{-24,-16}})));
  Modelica.Fluid.Sensors.MassFlowRate   flowRateSensor(redeclare package Medium
      = Modelica.Media.Water.ConstantPropertyLiquidWater)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={98,-58})));
equation
  connect(levelSetPoint.y, PI_Level.SP)
                               annotation (Line(
      points={{-79,30},{-76,30},{-76,-14},{-70,-14}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(valveLinear.port_b,boundary. ports[1]) annotation (Line(
      points={{134,-58},{140,-58}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(Inlet.ports[1], tank.ports[1])     annotation (Line(
      points={{26,20},{26,-12},{56,-12},{56,-1.11022e-15},{56.6667,-1.11022e-15}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pipe.port_a,tank. ports[2]) annotation (Line(
      points={{64,-58},{62,-58},{62,-1.11022e-15}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(actuator.y, valveLinear.opening)        annotation (Line(
      points={{117,-26},{124,-26},{124,-50}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(disturb.y, Inlet.m_flow_in)     annotation (Line(
      points={{-59,70},{34,70},{34,40}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(pSensor.port, tank.ports[3]) annotation (Line(
      points={{182,-10},{67.3333,-10},{67.3333,-1.11022e-15}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(rho_times_g.y, div.u2) annotation (Line(
      points={{223,-36},{246,-36},{246,-28},{256,-28}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(pSensor.p, sub.u1) annotation (Line(
      points={{193,6.10623e-16},{206,6.10623e-16},{206,-6},{220,-6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(p_amb.y, sub.u2) annotation (Line(
      points={{195,-34},{200,-34},{200,-14},{220,-14}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(sub.y, div.u1) annotation (Line(
      points={{237,-10},{246,-10},{246,-20},{256,-20}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(div.y, PI_Level.PV) annotation (Line(
      points={{273,-24},{280,-24},{280,-84},{-90,-84},{-90,-21},{-70,-21}},
      color={0,0,127},
      smooth=Smooth.None));

  connect(PI_Level.CS, PI_Valve.SP) annotation (Line(
      points={{-53,-20},{-42,-20}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(PI_Valve.CS, actuator.u) annotation (Line(
      points={{-25,-26},{94,-26}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(flowRateSensor.port_a, pipe.port_b) annotation (Line(
      points={{88,-58},{84,-58}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(flowRateSensor.port_b, valveLinear.port_a) annotation (Line(
      points={{108,-58},{114,-58}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(flowRateSensor.m_flow, PI_Valve.PV) annotation (Line(
      points={{98,-47},{98,-44},{-50,-44},{-50,-27},{-42,-27}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
            {300,100}}),
                      graphics={
        Rectangle(
          extent={{-10,50},{164,-74}},
          lineColor={0,0,0},
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-94,8},{-16,8},{-16,-76},{168,-76},{168,18},{288,18},{288,-92},
              {-94,-92},{-94,8}},
          lineColor={0,0,0},
          smooth=Smooth.None,
          fillColor={213,255,170},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{86,44},{136,32}},
          lineColor={0,0,0},
          fillColor={213,255,170},
          fillPattern=FillPattern.Solid,
          textString="Process"),
        Text(
          extent={{-62,4},{-12,-8}},
          lineColor={0,0,0},
          fillColor={213,255,170},
          fillPattern=FillPattern.Solid,
          textString="Control")}),
                                 Icon(coordinateSystem(preserveAspectRatio=true,
          extent={{-100,-100},{300,100}})),
    experiment(StopTime=4500),
    __Dymola_experimentSetupOutput(events=false),
    Documentation(info="<HTML>
  <h4>Description</h4>
  <p>
  Level control with two PI controllers, connected with a cascade arrangement.<br>
  The considered system is a tank filled with water. The water level is the process variable to be controlled.<br>
  The system (see the figure below) is composed by a tank and one pipe connected to a linear valve that discharges 
  the water in the atmosphere. The valve actuator is represented by a first order filter.<br>
  The control system is composed by the measurement part and the controller. The pressure sensor measures the absolute pressure<br>
  on the bottom of the tank.<br>
  <img src=\"modelica://IndustrialControlSystems/help/images/Applications/ControlProblems/LevelValveCascade.png\"><br>
  The measured pressure is subtracted from the atmospheric pressure and then divided by the<br>
  gravity acceleration and the water density in order to obtain the water level.
  <pre>
  level = (p - p0)/(rho*g)
  </pre>
  The PI controller, given the level measurement and the set point reference compute the control action. Such a control<br>
  action is the water mass flow rate flowing through the pipe. Such a mass flow rate becomes the set point reference for the second<br>
  PI that with its control action regulates the valve aperture
  <ul>
  <li>CS = 0 valve closed,</li>
  <li>CS = 1 valve fully open</li>
  </ul><br>
  
  The tank is 2 m height, and the water level at t=0 is L = 1 m.<br>
  In the first phase the controller is asked to maintain the level at the initial value (SP = 1 m), at t = 1200 s the level set point<br>
  decrease as a step (SP = 0.5 m). The controller has to act on the valve in order to decrease the water level to the desired value.<br>
  A disturb represented by a water mass flow rate entering the tank, becomes different from zero at time t = 3600 s.<br>
  <br>Set Point reference, water level<br>
  <img src=\"modelica://IndustrialControlSystems/help/images/Applications/ControlProblems/CascadeLevelPV.png\"><br>
  <br>Set Point reference (the Control signal of the Level PI) and valve command<br>
  <img src=\"modelica://IndustrialControlSystems/help/images/Applications/ControlProblems/CascadeValvePV.png\"><br>
  The simulation can be perfomed at an initial stage assuming that the controller is a continuous time one (<FONT FACE=Courier>Ts = 0</FONT>)
  , that the math<br> operations are in double precision (<FONT FACE=Courier>FixedPoint = false</FONT>). 
  In such a phase it is possible to concentrate on the controller design.
  </p>
  <h4>Further stages</h4>
  <p>
  Once the controller has been designed and the parameters assigned, one should introduce more details in order to simulate
  a more realistic system. Please refers to the previous example 
  ( <a src=\"modelica://IndustrialControlSystems.Applications.ProcessControl.LevelControl\">LevelControl</a> ) for more information.
  </p>
  
  
</html>", revisions="<html>
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
end CascadeLevelControl;
