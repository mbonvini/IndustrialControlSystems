within IndustrialControlSystems.Controllers.Examples;
model TestPID_tracking
  "Test of the Proportional + Integral + Derivative controller -- Tracking mode"
  extends Modelica.Icons.Example;
  parameter Real Ts = 0.01
    "|Sampling time| if Ts>=0 then discrete time controller, otherwise continuous time";

  Modelica.Blocks.Sources.Step step(startTime=10)
                                    annotation (
      Placement(transformation(extent={{-100,70},{-80,90}},rotation=0)));
  PID                          R(
    AntiWindup=true,
    CSmin=0,
    Ts=Ts,
    eps=0.001,
    CSmax=2,
    Kp=10,
    Ti=5,
    Td=0.5)
    annotation (Placement(transformation(extent={{-40,64},{-20,84}})));
  PID                          R_track(
    useTS=true,
    useBIAS=false,
    AntiWindup=true,
    CSmin=0,
    Ts=Ts,
    eps=0.001,
    CSmax=2,
    Kp=10,
    Ti=5,
    Td=0.5)
    annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
  Modelica.Blocks.Sources.BooleanTable TSsignal(startValue=false, table={40,85})
               annotation (                         Placement(
        transformation(extent={{-100,30},{-80,50}},rotation=0)));
  Modelica.Blocks.Sources.TimeTable TrackRef(
    offset=0,
    startTime=0,
    table=[0,0; 40,0; 40,0.94; 60,0.6; 100,0.6])
                 annotation (                            Placement(
        transformation(extent={{-100,0},{-80,20}},    rotation=0)));
  LinearSystems.Continuous.TransferFunction process(num={12,1}, den={20,12,1})
            annotation (Placement(transformation(extent={{10,62},{34,86}})));
  LinearSystems.Continuous.TransferFunction processTrack(num={12,1}, den={20,12,
        1}) annotation (Placement(transformation(extent={{10,-2},{34,22}})));
  PID R_Bump(
    useTS=true,
    useBIAS=false,
    AntiWindup=true,
    CSmin=0,
    Ts=Ts,
    eps=0.001,
    CSmax=2,
    Kp=10,
    Ti=5,
    Td=0.5)
    annotation (Placement(transformation(extent={{-40,-80},{-20,-60}})));
  LinearSystems.Continuous.TransferFunction processBump(num={12,1}, den={20,12,1})
            annotation (Placement(transformation(extent={{10,-82},{34,-58}})));
  Modelica.Blocks.Sources.TimeTable TrackRefBump(
    offset=0,
    startTime=0,
    table=[0,0; 40,0; 40,0.94; 60,0.6; 70,1; 100,1])
                 annotation (                            Placement(
        transformation(extent={{-100,-80},{-80,-60}}, rotation=0)));
  Modelica.Blocks.Sources.BooleanTable TSsignalBump(startValue=false, table={40,
        100})  annotation (                         Placement(
        transformation(extent={{-100,-40},{-80,-20}},
                                                   rotation=0)));
equation

  connect(step.y,R. SP)  annotation (Line(
      points={{-79,80},{-38,80}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(step.y,R_track. SP)
                           annotation (Line(
      points={{-79,80},{-70,80},{-70,16},{-38,16}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(TSsignal.y,R_track. TS)
                               annotation (Line(
      points={{-79,40},{-26,40},{-26,18}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(TrackRef.y,R_track. TR)
                               annotation (Line(
      points={{-79,10},{-76,10},{-76,24},{-30,24},{-30,18}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(R.CS,process. u) annotation (Line(
      points={{-21,74},{12.4,74}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(process.y,R. PV) annotation (Line(
      points={{32.8,74},{42,74},{42,54},{-52,54},{-52,73},{-38,73}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(R_track.CS,processTrack. u) annotation (Line(
      points={{-21,10},{12.4,10}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(processTrack.y,R_track. PV) annotation (Line(
      points={{32.8,10},{42,10},{42,-20},{-52,-20},{-52,9},{-38,9}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(step.y,R_Bump. SP)
                           annotation (Line(
      points={{-79,80},{-70,80},{-70,-64},{-38,-64}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(R_Bump.CS,processBump. u)   annotation (Line(
      points={{-21,-70},{12.4,-70}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(processBump.y,R_Bump. PV)   annotation (Line(
      points={{32.8,-70},{42,-70},{42,-96},{-52,-96},{-52,-71},{-38,-71}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(TrackRefBump.y,R_Bump. TR) annotation (Line(
      points={{-79,-70},{-76,-70},{-76,-48},{-30,-48},{-30,-62}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(TSsignalBump.y,R_Bump. TS) annotation (Line(
      points={{-79,-30},{-26,-30},{-26,-62}},
      color={255,0,255},
      smooth=Smooth.None));
  annotation (Diagram(graphics),
    experiment(StopTime=200),
    experimentSetupOutput,
    Documentation(revisions="<html>
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
</dl></html>", info="<HTML>
  <h4>Description</h4>
  <p>
  In this example have been tested the tracking mode of the proportional + integral + derivative controller.<br>
  The process to be controlled has the following transfer function
  <pre>
   Y(s)          (1+15s)
   ----  =  ----------------
   U(s)       (1+10s)(1+2s)
  </pre>
  There are two processes:<br>
  <ul>
  <li>with a PID controller,</li> 
  <li>and a PID controller with tracking mode</li> 
  </ul><br>
  The output signal of the process controlled without tracking is the red line, while the green line is the 
  output of the process controlled with the tracking mode.<br>
  <img src=\"modelica://IndustrialControlSystems/help/images/Controllers/Examples/PID_track_PV.png\"><br><br>
  The CS of the controller becomes equal to the track reference signal TR when the Track Switch signal becomes true.
  <br>
  <img src=\"modelica://IndustrialControlSystems/help/images/Controllers/Examples/PID_track_CS.png\"><br><br>
  <br>
  <h4>Bumpless transition</h4>
  If the Track Reference signal moves the Process Variable at the Set Point reference value, once the Tracking mode 
  is disabled there should be a bumpless transition. The images below show a bumpless transition.<br>
  <img src=\"modelica://IndustrialControlSystems/help/images/Controllers/Examples/PID_track_PV_Bump.png\"><br>
  <br>
  <img src=\"modelica://IndustrialControlSystems/help/images/Controllers/Examples/PID_track_CS_Bump.png\"><br>
  The integrative effect, represented by the integrator in the feedback path of the PID controller 
  (see the PID block diagram <a href=\"modelica://ControlLibrary.Controllers.PID\">here</a>), is forced to follow 
  the tracking reference (Iaction signal in the last figure). In the same figure there is a small variation of the CS
  when the automatic mode start again, because the PV is not exactly at the SP value and thus the proportional
  action introduce a little displacement (the blue line at t = 100).<br><br>
  
  <h4>Discrete time</h4>
  If the model parameter <FONT FACE=Courier>Ts</FONT> is <FONT FACE=Courier>>=0</FONT> the continuous time controllers are 
  replaced by their discrete time versions.<br>
  The effect of various discretisation method can be studied.
  <h4>examples</h4><br>
  <FONT FACE=Courier>Ts = 0.01 s</FONT> and <FONT FACE=Courier>method = BE</FONT>
  <br>
  <img src=\"modelica://IndustrialControlSystems/help/images/Controllers/Examples/PID_track_CS_001.png\"><br><br>
  <br>
  <FONT FACE=Courier>Ts = 0.05 s</FONT> and <FONT FACE=Courier>method = BE</FONT>
  <br>
  <img src=\"modelica://IndustrialControlSystems/help/images/Controllers/Examples/PID_track_CS_005.png\"><br><br>
  </HTML>"));
end TestPID_tracking;
