within IndustrialControlSystems.Applications.ControlProblems;
model PI_ContinuousVsDigital
  "Comparison between continuous time PID and its discrete time implementations"
  extends Modelica.Icons.Example;

  LinearSystems.Continuous.TransferFunction      P_disc(num={12,1}, den={20,12,1})
    annotation (Placement(transformation(extent={{54,60},{80,80}})));
  Controllers.PID               R_disc(
    Ti=5,
    CS_start=0,
    CSmin=0,
    CSmax=2,
    Td=0.5,
    b=1,
    c=1,
    Ts=0.01,
    Kp=10,
    N=8,
    AntiWindup=true)
    annotation (Placement(transformation(extent={{-10,60},{10,80}})));
  Modelica.Blocks.Sources.Step SetPointSTEP(height=0.5, startTime=5)
                                    annotation (
      Placement(transformation(extent={{-100,70},{-80,90}},rotation=0)));
  Controllers.PID               R_cont(
    Ti=5,
    CS_start=0,
    CSmin=0,
    CSmax=2,
    Td=0.5,
    b=1,
    c=1,
    Kp=10,
    Ts=0,
    N=8,
    AntiWindup=true)
    annotation (Placement(transformation(extent={{-10,0},{10,20}})));
  Modelica.Blocks.Math.Feedback sum1
    annotation (Placement(transformation(extent={{20,60},{40,80}})));
  Modelica.Blocks.Math.Feedback sum2
    annotation (Placement(transformation(extent={{20,0},{40,20}})));
  Modelica.Blocks.Sources.Step Disturb(
    offset=0,
    height=-0.2,
    startTime=30)
    annotation (Placement(transformation(extent={{-80,-80},{-60,-60}})));
  Modelica.Blocks.Math.Feedback sum3
    annotation (Placement(transformation(extent={{22,-60},{42,-40}})));
  Controllers.Digital.PID_2dof R_dig(
    Ti=5,
    CS_start=0,
    CSmin=0,
    CSmax=2,
    Td=0.5,
    b=1,
    c=1,
    Ts=0.01,
    Kp=10,
    N=8,
    AntiWindup=true)
    annotation (Placement(transformation(extent={{-10,-60},{10,-40}})));
  LinearSystems.Continuous.TransferFunction P_cont(num={12,1}, den={20,12,1})
    annotation (Placement(transformation(extent={{54,0},{80,20}})));
  LinearSystems.Continuous.TransferFunction P_dig(num={12,1}, den={20,12,1})
    annotation (Placement(transformation(extent={{54,-60},{80,-40}})));
  Modelica.Blocks.Sources.Ramp SetPointRAMP(
    height=0.5,
    startTime=5,
    duration=5)                     annotation (
      Placement(transformation(extent={{-100,-40},{-80,-20}},
                                                           rotation=0)));
  Modelica.Blocks.Logical.Switch switch
    annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
  Modelica.Blocks.Sources.BooleanConstant SelectSP(k=true)
    "if true the SP is a step, otherwise is a ramp"
    annotation (Placement(transformation(extent={{-100,34},{-80,54}})));
equation
  connect(R_disc.CS, sum1.u1)
                          annotation (Line(
      points={{9,70},{22,70}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(R_cont.CS,sum2. u1)
                          annotation (Line(
      points={{9,10},{22,10}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(Disturb.y,sum2. u2) annotation (Line(
      points={{-59,-70},{-30,-70},{-30,-18},{30,-18},{30,2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(Disturb.y, sum1.u2)
                             annotation (Line(
      points={{-59,-70},{-30,-70},{-30,42},{30,42},{30,62}},
      color={0,0,127},
      smooth=Smooth.None));

  connect(sum1.y, P_disc.u)
                       annotation (Line(
      points={{39,70},{56.6,70}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(P_disc.y, R_disc.PV)  annotation (Line(
      points={{78.7,70},{90,70},{90,44},{-16,44},{-16,69},{-8,69}},
      color={0,0,127},
      smooth=Smooth.None));

  connect(R_dig.CS, sum3.u1) annotation (Line(
      points={{9,-50},{24,-50}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(sum2.y, P_cont.u) annotation (Line(
      points={{39,10},{56.6,10}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(P_cont.y, R_cont.PV) annotation (Line(
      points={{78.7,10},{90,10},{90,-14},{-16,-14},{-16,9},{-8,9}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(Disturb.y, sum3.u2) annotation (Line(
      points={{-59,-70},{32,-70},{32,-58}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(sum3.y, P_dig.u) annotation (Line(
      points={{41,-50},{56.6,-50}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(P_dig.y, R_dig.PV) annotation (Line(
      points={{78.7,-50},{90,-50},{90,-76},{-18,-76},{-18,-46},{-8,-46}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(SetPointSTEP.y, switch.u1) annotation (Line(
      points={{-79,80},{-74,80},{-74,58},{-62,58}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(SetPointRAMP.y, switch.u3) annotation (Line(
      points={{-79,-30},{-74,-30},{-74,42},{-62,42}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(switch.y, R_disc.SP) annotation (Line(
      points={{-39,50},{-26,50},{-26,76},{-8,76}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(switch.y, R_cont.SP) annotation (Line(
      points={{-39,50},{-26,50},{-26,16},{-8,16}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(switch.y, R_dig.SP) annotation (Line(
      points={{-39,50},{-26,50},{-26,-42},{-8,-42}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(SelectSP.y, switch.u2) annotation (Line(
      points={{-79,44},{-74,44},{-74,50},{-62,50}},
      color={255,0,255},
      smooth=Smooth.None));
  annotation (Diagram(graphics),
    experiment(StopTime=50),
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
  In this examples are compared three PID controllers:
  <ul>
  <li>Continuous time PID with two degrees of freedom
  (model <a href=\"modelica://IndustrialControlSystems.Controllers.PID\">PID </a>(with Ts=0) ),</li>
  <li>the discretised version of the continuous time PID with two degrees of freedom
  (model <a href=\"modelica://IndustrialControlSystems.Controllers.PID\">PID</a> ),</li>
  <li>and the digital implementation of the PID with two degrees of freedom in the incremental form
  (model <a href=\"modelica://IndustrialControlSystems.Controllers.Digital.PID_2dof\">PID_2dof</a> ).</li>
  </ul><br>
  There controllers regulates a second order process with trasfer function<br>
  <pre>
   Y(s)          (1+15s)
   ----  =  ----------------
   U(s)       (1+10s)(1+2s)
  </pre>
  <br>
  
  The following images show the SetPoint following and disturbance rejection without saturation<br><br>
  <b>Set Point and Process Variables</b><br>
  <img src=\"modelica://IndustrialControlSystems/help/images/Applications/ControlProblems/CvsD_PV.png\"><br>
  <b>Control Signals</b><br>
  <img src=\"modelica://IndustrialControlSystems/help/images/Applications/ControlProblems/CvsD_CS.png\"><br>
  <br>
  
  To be noticed that the discretised version of the PID and the digital implementation of the incremental PID have 
  the same behaviour.<br>
  The same is not valid when the saturation is introduced. If limiting the controller action between [0,2] the 
  discrete time version and the digital one behave quite differently<br><br>
  <b>Set Point and Process Variables</b><br>
  <img src=\"modelica://IndustrialControlSystems/help/images/Applications/ControlProblems/CvsD_PV_aw.png\"><br>
  <b>Control Signals</b><br>
  <img src=\"modelica://IndustrialControlSystems/help/images/Applications/ControlProblems/CvsD_CS_aw.png\"><br>
  <img src=\"modelica://IndustrialControlSystems/help/images/Applications/ControlProblems/CvsD_CS_aw2.png\"><br>
  <br>
  
  This difference is due to the nature of the digital implementation that is incremental, while the other two are 
  positional.<br>
  This problem does not appear if the Set Point reference changes soothly, switching to a ramp Set Point signal, 
  as shown in the following picture.
  <br><br>
  <b>Process Variables and Control Signals with a ramp Set Point</b><br>
  <img src=\"modelica://IndustrialControlSystems/help/images/Applications/ControlProblems/CvsD_ramp.png\"><br>
  
</html>"));
end PI_ContinuousVsDigital;
