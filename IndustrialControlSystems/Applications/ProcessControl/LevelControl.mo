within IndustrialControlSystems.Applications.ProcessControl;
model LevelControl "Level control with a PI controller"
  extends Modelica.Icons.Example;
  import Modelica.SIunits.*;
  parameter Length PipeL = 1 "|Process| Pipe length";
  parameter Length PipeD = 0.0254 "|Process| Pipe diameter";
  parameter Length Lstart = 1 "|Process| Initial water level";
  parameter Length H = 2 "|Process| Storage height";
  parameter Area A = 1.5 "|Process| Cross section storage area";
  parameter Real Tact = 2 "|Process| Actuator dynamics";
  parameter Real Ts = 5 "|Controller| Sampling time for the valve controller";
  parameter Real Kp = -50 "|Controller| Proportional gain";
  parameter Real Ti = 100 "|Controller| Integral time";
  parameter Boolean AntiWindup = true
    "|Controller| Flag that enables the antiwindup feature";
  parameter Real CSmin = 0 "|Controller| minimum value of the CS";
  parameter Real CSmax = 1 "|Controller| maximum value of the CS";
  parameter Real CS_start = 0 "|Controller| output initial value";
  parameter Boolean FixedPoint = true
    "|Conversion| Use FP operations for level measurement operations";
  parameter Integer Nbit = 24 "|Conversion| number of bit for FP operations";
  parameter Real scaleF_div = 500 "|Conversion| division scale factor";
  parameter Real scaleF_sub = 20 "|Conversion| subtraction scale factor";
  IndustrialControlSystems.Controllers.PI PI_Level(
    Kp=Kp,
    Ti=Ti,
    Ts=Ts,
    AntiWindup=AntiWindup,
    CSmin=CSmin,
    CSmax=CSmax,
    CS_start=CS_start) "PI level controller"
    annotation (Placement(transformation(extent={{-46,-42},{-26,-22}})));
  Modelica.Blocks.Sources.Step disturb(
    startTime=3600,
    height=0.4,
    offset=0.4) "inlet water disturb"
    annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
  Modelica.Blocks.Sources.Step levelSetPoint(
    offset=1,
    height=-0.5,
    startTime=1200) "Set Point level"
    annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
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
    annotation (Placement(transformation(extent={{94,-64},{114,-44}})));
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
    annotation (Placement(transformation(extent={{66,-64},{86,-44}})));
  Modelica.Fluid.Sources.FixedBoundary boundary(nPorts=1, redeclare package
      Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    use_p=true) "boundary pressure condition"             annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={132,-54})));
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
    annotation (Placement(transformation(extent={{72,-42},{92,-22}})));
  Modelica.Fluid.Sensors.Pressure pSensor(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater) "pressure sensor"
    annotation (Placement(transformation(extent={{160,-16},{180,4}})));
  MathOperations.RealType.Div div(
    Ts=Ts,
    Nbit=Nbit,
    FixedPoint=FixedPoint,
    scaleFactor=scaleF_div) "water level"
                     annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={250,-24})));
  Modelica.Blocks.Sources.RealExpression rho_times_g(y=system.g*995.586)
    "density times the gravity acceleration"
    annotation (Placement(transformation(extent={{198,-46},{218,-26}})));
  MathOperations.RealType.Sub sub(
    Ts=Ts,
    Nbit=Nbit,
    FixedPoint=FixedPoint,
    scaleFactor=scaleF_sub) "hydrostatic pressure"
    annotation (Placement(transformation(extent={{198,-20},{218,0}})));
  Modelica.Blocks.Sources.RealExpression p_amb(y=system.p_ambient)
    "ambient pressure"
    annotation (Placement(transformation(extent={{164,-44},{184,-24}})));
equation
  connect(levelSetPoint.y, PI_Level.SP)
                               annotation (Line(
      points={{-59,30},{-50,30},{-50,-26},{-44,-26}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(valveLinear.port_b,boundary. ports[1]) annotation (Line(
      points={{114,-54},{122,-54}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(Inlet.ports[1], tank.ports[1])     annotation (Line(
      points={{26,20},{26,-12},{56,-12},{56,-1.11022e-15},{56.6667,-1.11022e-15}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pipe.port_a,tank. ports[2]) annotation (Line(
      points={{66,-54},{62,-54},{62,-1.11022e-15}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(actuator.y, valveLinear.opening)        annotation (Line(
      points={{93,-32},{104,-32},{104,-46}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(disturb.y, Inlet.m_flow_in)     annotation (Line(
      points={{-59,70},{34,70},{34,40}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(PI_Level.CS, actuator.u)        annotation (Line(
      points={{-27,-32},{70,-32}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(pipe.port_b, valveLinear.port_a) annotation (Line(
      points={{86,-54},{94,-54}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pSensor.port, tank.ports[3]) annotation (Line(
      points={{170,-16},{67.3333,-16},{67.3333,-1.11022e-15}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(rho_times_g.y, div.u2) annotation (Line(
      points={{219,-36},{226,-36},{226,-28},{242,-28}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(pSensor.p, sub.u1) annotation (Line(
      points={{181,-6},{190.5,-6},{190.5,-6},{200,-6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(p_amb.y, sub.u2) annotation (Line(
      points={{185,-34},{190,-34},{190,-14},{200,-14}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(sub.y, div.u1) annotation (Line(
      points={{217,-10},{226,-10},{226,-20},{242,-20}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(div.y, PI_Level.PV) annotation (Line(
      points={{259,-24},{268,-24},{268,-84},{-50,-84},{-50,-32},{-44,-32},{-44,-33}},
      color={0,0,127},
      smooth=Smooth.None));

  annotation (Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
            {300,100}}),
                      graphics={
        Rectangle(
          extent={{-10,50},{146,-74}},
          lineColor={0,0,0},
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-94,6},{-16,6},{-16,-78},{152,-78},{152,16},{288,16},{288,-94},
              {-94,-94},{-94,6}},
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
          extent={{-98,0},{-48,-12}},
          lineColor={0,0,0},
          fillColor={213,255,170},
          fillPattern=FillPattern.Solid,
          textString="Control")}),
                                 Icon(coordinateSystem(preserveAspectRatio=true,
          extent={{-100,-100},{300,100}})),
    experiment(StopTime=4500),
    __Dymola_experimentSetupOutput(equdistant=false, events=false),
    Documentation(info="<HTML>
  <h4>Description</h4>
  <p>
  Level control with a PI regulator.<br>
  The considered system is a tank filled with water. The water level is the process variable to be controlled.<br>
  The system (see the figure below) is composed by a tank and one pipe connected to a linear valve that discharges 
  the water in the atmosphere. The valve actuator is represented by a first order filter.<br>
  The control system is composed by the measurement part and the controller. The pressure sensor measures the absolute pressure<br>
  on the bottom of the tank.<br>
  <img src=\"modelica://IndustrialControlSystems/help/images/Applications/ControlProblems/LevelControl_Scheme.png\"><br>
  The measured pressure is subtracted from the atmospheric pressure and then divided by the<br>
  gravity acceleration and the water density in order to obtain the water level.
  <pre>
  level = (p - p0)/(rho*g)
  </pre>
  The PI controller, given the level measurement and the set point reference compute the control action. Such a control<br>
  action is the desidered valve position<br>
  <ul>
  <li>CS = 0 valve closed,</li>
  <li>CS = 1 valve fully open</li>
  </ul><br>
  
  The tank is 2 m height, and the water level at t=0 is L = 1 m.<br>
  In the first phase the controller is asked to maintain the level at the initial value (SP = 1 m), at t = 1200 s the level set point<br>
  decrease as a step (SP = 0.5 m). The controller has to act on the valve in order to decrease the water level to the desired value.<br>
  A disturb represented by a water mass flow rate entering the tank, becomes different from zero at time t = 3600 s.<br>
  <br>Set Point reference, water level and valve position command<br>
  <img src=\"modelica://IndustrialControlSystems/help/images/Applications/ControlProblems/LevelControl_1.png\"><br>
  The simulation can be perfomed at an initial stage assuming that the controller is a continuous time one (<FONT FACE=Courier>Ts = 0</FONT>)
  , that the math<br> operations are in double precision (<FONT FACE=Courier>FixedPoint = false</FONT>). In such a phase it is possible to concentrate on the controller design.
  </p>
  <h4>Further stages</h4>
  <p>
  Once the controller has been designed and the parameters assigned, one should introduce more details in order to simulate
  a more realistic system.
  At first it is possible to introduce the time discretisation and investigate the effect of the sampling time.<br> 
  Here follows the results for a sapling time <FONT FACE=Courier>Ts = 5</FONT>.<br>
  <img src=\"modelica://IndustrialControlSystems/help/images/Applications/ControlProblems/LevelControl_2.png\"><br><br>
  An additional level of detail can be the introduction of the fixed point math operation in the level measurement process.
  In this case has been choosen a number of bit
  <FONT FACE=Courier>Nbit = 24</FONT>
  this means that the integer number that can be represented are comprises between <FONT FACE=Courier>MIN = -8388609</FONT> and <FONT FACE=Courier>MAX = 8388608</FONT>.
  At the first stage, the measured pressure have to be subtracted of the ambient one. In the wors case, the higher pressure value
  that can be read as input from the math operation block is
  <pre>
  101325 + 1000*9.81*2 = 120945
  </pre>
  that is more or less two order of magnitude less that the higher integer number MAX.
  This means that the input numbers can be multiplied by a scale factor comprises between 10 and 50. 
  In this case the scale factor that has been choosen is <FONT FACE=Courier>sFactor = 20</FONT>.
  In a similat way the scale factor of the division can be choosen. In this case <FONT FACE=Courier>sFactor = 500</FONT>.
  <br>
  <b>N.B.</b> A large amount of bit is requireb because the pressure variation is small with respect to its absolute value.
  Using such a modelling approach it is possible to estimate the amount of bits required and test directly the correctness 
  of the design strategy. In the following image the numerical errors due to a wrong design are visible on the Control Signal<br>
  <img src=\"modelica://IndustrialControlSystems/help/images/Applications/ControlProblems/LevelControl_3.png\"><br><br>
  
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
end LevelControl;
