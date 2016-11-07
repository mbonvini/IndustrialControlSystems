within IndustrialControlSystems.Applications.ProcessControl;
model VelocityDriveControl_AutoTuning
  "Velocity control of an electric engine with Automatic Tuning"
  extends Modelica.Icons.Example;
   Controllers.AutoTuning.ATPIrelayNCmixedMode    ATPIdigital(
    CSmax=24,
    Ts=0.01,
    slope=1,
    AntiWindup=true,
    CSmin=0,
    Kp=0.2,
    Ti=0.5,
    pm=70)
    annotation (Placement(transformation(extent={{-20,20},{6,40}}, rotation=0)));
  Modelica.Blocks.Sources.Step SP(
    height=50,
    offset=20,
    startTime=8)
                annotation (Placement(transformation(extent={{-70,26},{-50,46}},
          rotation=0)));
  Modelica.Blocks.Sources.BooleanExpression ATpulse(y=time > 4 and time <
        4.1)              annotation (Placement(transformation(extent={{-80,-12},
            {-40,12}}, rotation=0)));
  Modelica.Electrical.Machines.BasicMachines.DCMachines.DC_PermanentMagnet
    M1(
    VaNominal=24,
    IaNominal=5,
    Jr =    0.0005,
    wNominal=(1000)*2*3.14159265358979323846/60)
                   annotation (Placement(transformation(extent={{66,-16},{86,4}},
          rotation=0)));
  Modelica.Electrical.Analog.Sources.SignalVoltage VG1
    annotation (Placement(transformation(
        origin={40,30},
        extent={{-10,10},{10,-10}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Ground ground
    annotation (Placement(transformation(extent={{30,-16},{50,4}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.Resistor R1(R=0.01)
    annotation (Placement(transformation(extent={{58,30},{78,50}}, rotation=0)));
  Modelica.Mechanics.Rotational.Components.SpringDamper
                                             J1(c=0.2, d=0.03)
    annotation (Placement(transformation(
        origin={104,-6},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  Modelica.Mechanics.Rotational.Components.Inertia
                                        L1(J=0.004)
    annotation (Placement(transformation(
        origin={130,-6},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  Modelica.Mechanics.Rotational.Sensors.SpeedSensor speedSensor
    annotation (Placement(transformation(extent={{148,-16},{168,4}}, rotation=0)));
  Modelica.Blocks.Math.Add addNoise
                                annotation (Placement(transformation(extent={{118,
            20},{138,40}}, rotation=0)));
  MathOperations.RealType.Signals.noiseGen noiseGen(amp=0.1)
    annotation (Placement(transformation(extent={{40,60},{60,80}})));
equation
  connect(SP.y, ATPIdigital.SP)    annotation (Line(points={{-49,36},{-17.4,36}},
        color={0,0,127}));
  connect(ATpulse.y, ATPIdigital.ATreq) annotation (Line(points={{-38,
          -3.77476e-16},{-30,-3.77476e-16},{-30,22},{-17.4,22}},
                              color={255,0,255}));
  connect(VG1.n,ground. p) annotation (Line(points={{40,20},{40,4}}, color={0,0,
          255}));
  connect(ground.p,M1. pin_an) annotation (Line(points={{40,4},{48,4},{70,4},{
          70,4}},
               color={0,0,255}));
  connect(R1.n,M1. pin_ap) annotation (Line(points={{78,40},{82,40},{82,4}},
        color={0,0,255}));
  connect(VG1.p,R1. p) annotation (Line(points={{40,40},{58,40}}, color={0,0,255}));
  connect(M1.flange,J1.   flange_b) annotation (Line(points={{86,-6},{94,-6},{
          94,-6}},
                color={0,0,0}));
  connect(J1.flange_a,L1. flange_b)
    annotation (Line(points={{114,-6},{120,-6},{120,-6}}, color={0,0,0}));
  connect(L1.flange_a,speedSensor.flange)
    annotation (Line(points={{140,-6},{148,-6},{148,-6}}, color={0,0,0}));
  connect(speedSensor.w, addNoise.u2)
                                  annotation (Line(points={{169,-6},{174,-6},{
          174,12},{108,12},{108,24},{116,24}},
                                           color={0,0,127}));
  connect(ATPIdigital.CS, VG1.v) annotation (Line(
      points={{4.7,30},{33,30}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(noiseGen.y, addNoise.u1)
                               annotation (Line(
      points={{59,70},{106,70},{106,36},{116,36}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(addNoise.y, ATPIdigital.PV)
                                  annotation (Line(
      points={{139,30},{180,30},{180,-26},{-26,-26},{-26,29},{-17.4,29}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
            {200,100}}), graphics),
    experiment(StopTime=12),
    experimentSetupOutput(equdistant=false),
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{200,100}})),
    Documentation(info="<HTML>
  <h4>Description</h4>
  <p>
  Velocity control of an electric engine with a PI controller.<br><br>
  <img src=\"modelica://IndustrialControlSystems/help/images/Applications/ControlProblems/AutoTuningPIMotor.png\"><br><br>
  The PI controller regulates the voltage source of the electric engine, and measures its angular velocity (corrupted by noise).
  The aim of this example is to show how a controller with Automatic Tuning can be used in a real context.
  <br><br>
  In the following table are listed the controller parameters before and after the Automatic tuning
  <TABLE BORDER=1 CELLSPACING=0 CELLPADDING=2 >
  <TR bgcolor=#e0e0e0><TH>Parameter</TH><TH>Before</TH><TH>After AT</TH></TR>
  <tr><td>Kp</td><td>0.2</td><td>0.5167</td></tr>
  <tr><td>Ti</td><td>0.5</td><td>0.1399</td></tr>
  </table><br><br>
  Automatic Tuning algorithm parameters
  <TABLE BORDER=1 CELLSPACING=0 CELLPADDING=2 >
  <TR bgcolor=#e0e0e0><TH>Parameter</TH><TH>Value</TH></TR>
  <tr><td>slope</td><td>5</td></tr>
  <tr><td>PermOxPeriodPerc</td><td>5</td></tr>
  <tr><td>pm</td><td>70</td></tr>
  <tr><td>nOxMin</td><td>3</td></tr>
  </table><br><br>
  The figure below show the velocity set point, the measured process variable and the control signal, that is limited between 0 and 24 V.
  <img src=\"modelica://IndustrialControlSystems/help/images/Applications/ControlProblems/AutoTuningPIMotorPV.png\"><br><br>
  
  <h4>References</h4>
  For more information please refers to the following
  <a href=\"modelica://IndustrialControlSystems/help/refs/EffHybPITuning.pdf\">paper</a>:<br><br>
  <b>Efficient hybrid simulation of autotuning PI controllers</b><br>
  Alberto Leva, Marco Bonvini<br>
  8th Modelica Conference, Dresden, Germany<br>
  march 20-22, 2011<br>
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
end VelocityDriveControl_AutoTuning;
