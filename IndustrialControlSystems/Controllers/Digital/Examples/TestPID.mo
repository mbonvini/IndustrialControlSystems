within IndustrialControlSystems.Controllers.Digital.Examples;
model TestPID "Test of the 2DoF digital PID controller"
  extends Modelica.Icons.Example;

  Modelica.Blocks.Sources.Step step(startTime=10)
                                    annotation (
      Placement(transformation(extent={{-100,70},{-80,90}},rotation=0)));
  IndustrialControlSystems.Controllers.Digital.PID_2dof Controller(
    useTS=true,
    AntiWindup=true,
    CSmax=2,
    b=1,
    c=0,
    Kp=20,
    N=5,
    useBIAS=true,
    useForbid=true,
    useMAN=true,
    Ts=0.1,
    Td=0.1,
    Ti=3,
    CSmin=-2)
    annotation (Placement(transformation(extent={{-32,-20},{-12,0}})));
  LinearSystems.Continuous.TransferFunction Process(num={5,1}, den={20,12,
        1})
    annotation (Placement(transformation(extent={{26,-22},{52,2}})));
  Modelica.Blocks.Sources.BooleanTable TSsignal(startValue=false, table={40,130})
               annotation (                         Placement(
        transformation(extent={{-100,30},{-80,50}},rotation=0)));
  Modelica.Blocks.Sources.TimeTable TrackRef(
    offset=0,
    startTime=0,
    table=[0,0; 40,0; 40,1; 60,0.6; 70,0.6; 100,1; 200,1])
                 annotation (                            Placement(
        transformation(extent={{-100,0},{-80,20}},    rotation=0)));
  Modelica.Blocks.Math.Feedback sub annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={8,-10})));
  Modelica.Blocks.Sources.Step disturb(height=0.2, startTime=180)
                                    annotation (
      Placement(transformation(extent={{-60,70},{-40,90}}, rotation=0)));
  Modelica.Blocks.Sources.BooleanTable ForbinINC(startValue=true, table={15})
               annotation (                         Placement(
        transformation(extent={{-80,-80},{-60,-60}},
                                                   rotation=0)));
  Modelica.Blocks.Sources.BooleanTable ForbinDEC(startValue=false, table=
        {12,18})
               annotation (                         Placement(
        transformation(extent={{-60,-100},{-40,-80}},
                                                   rotation=0)));
  Modelica.Blocks.Sources.BooleanTable man(startValue=false, table={200,
        300})  annotation (                         Placement(
        transformation(extent={{-100,-30},{-80,-10}},
                                                   rotation=0)));
  Modelica.Blocks.Sources.TimeTable deltaCS(
    offset=0,
    startTime=0,
    table=[0,-0.004; 200,-0.004; 280,0.004; 280,0; 300,0])
                                    annotation (
      Placement(transformation(extent={{-100,-58},{-80,-38}},
                                                           rotation=0)));
  LinearSystems.Continuous.TransferFunction ProcessNoControl(num={5,1}, den={20,
        12,1})
    annotation (Placement(transformation(extent={{26,38},{52,62}})));
equation
  connect(step.y, Controller.SP)
                           annotation (Line(
      points={{-79,80},{-68,80},{-68,-2},{-30,-2}},
      color={0,0,127},
      smooth=Smooth.None));

  connect(TSsignal.y, Controller.TS)
                               annotation (Line(
      points={{-79,40},{-18,40},{-18,-2}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(TrackRef.y, Controller.TR)
                               annotation (Line(
      points={{-79,10},{-22,10},{-22,-2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(Controller.CS, sub.u1) annotation (Line(
      points={{-13,-10},{-4.44089e-16,-10}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(sub.y, Process.u) annotation (Line(
      points={{17,-10},{28.6,-10}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(disturb.y, sub.u2) annotation (Line(
      points={{-39,80},{-6,80},{-6,-26},{8,-26},{8,-18}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(disturb.y, Controller.BIAS) annotation (Line(
      points={{-39,80},{-26,80},{-26,-2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(ForbinINC.y, Controller.Finc) annotation (Line(
      points={{-59,-70},{-26,-70},{-26,-18}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(ForbinDEC.y, Controller.Fdec) annotation (Line(
      points={{-39,-90},{-20,-90},{-20,-18}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(Process.y, Controller.PV) annotation (Line(
      points={{50.7,-10},{60,-10},{60,-40},{-40,-40},{-40,-6},{-30,-6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(man.y, Controller.MAN) annotation (Line(
      points={{-79,-20},{-74,-20},{-74,-10},{-30,-10}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(deltaCS.y, Controller.CSinc) annotation (Line(
      points={{-79,-48},{-64,-48},{-64,-14},{-30,-14}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(step.y, ProcessNoControl.u) annotation (Line(
      points={{-79,80},{-68,80},{-68,50},{28.6,50}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(graphics),
    experiment(StopTime=340),
    experimentSetupOutput,Documentation(info="
  <HTML>
  <h4>Description</h4>
  <p>
  In this example have been tested the functionalities of the 2DoF incremental PID.<br>
  The PID has to control the process with transfer function
  <pre>
   Y(s)             5*s +1
   ----  =  -----------------------
   U(s)        20*s^2 + 12*s + 1
  </pre>
  The image compares the outputs of the process <FONT FACE=Courier>y</FONT> with and without the controller action.<br>
  <img src=\"modelica://IndustrialControlSystems/help/images/Controllers/Digital/Examples/PIDincDigRisp.png\"><br>
  
  
  <h4>Functionalities</h4>
  In the following figure are shown the functionalities of the block. At the beginning the process variable<br>
  does not grows because the <FONT FACE=Courier>Finc</FONT> signal that forbid the <FONT FACE=Courier>CS</FONT> increment is true.<br>
  At t = 15 it becomes false and the PID start to act on the process, leading the <FONT FACE=Courier>PV</FONT> to the Set Point desidered value.<br><br>
  At t = 40 the <FONT FACE=Courier>TS</FONT> signal becomes true and it is maintained until t = 130. In such a period the<br>
  Control signal follows the TR one (the green one). To note that at the end the transition between Tracking and Automatic mode<br>
  is bumpless.<br>
  Between t = 200 and t = 300, the PID manual mode is enabled. In this phase the Control Signal varies according to the CSinc signal (see figure below).<br> 
  <img src=\"modelica://IndustrialControlSystems/help/images/Controllers/Digital/Examples/PIDincDig.png\"><br>
  <img src=\"modelica://IndustrialControlSystems/help/images/Controllers/Digital/Examples/PIDincDig_csinc.png\">
  
  </HTML>",
      revisions="<html>
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
end TestPID;
