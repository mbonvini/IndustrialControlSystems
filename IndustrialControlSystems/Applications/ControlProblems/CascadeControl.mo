within IndustrialControlSystems.Applications.ControlProblems;
model CascadeControl "Cascade control"
  extends Modelica.Icons.Example;
  parameter Real Ts = 0.5 "|Sampling time| Outer loop sampling time";
  parameter Real Ts_inner = 0.01 "|Sampling time| Inner loop sampling time";
  LinearSystems.Continuous.TransferFunction
                                      P1(
    y_start=0,
    num={1},
    den={0.05,1})
          annotation (Placement(transformation(extent={{-26,44},{-2,64}})));
  LinearSystems.Continuous.TransferFunction
                                      P2(
    y_start=0,
    num={1},
    den={1,2,1})
          annotation (Placement(transformation(extent={{60,44},{84,64}})));
  Controllers.PI            R(
    CSmax=5,
    CSmin=0,
    Ti=1,
    Kp=0.5,
    Ts=Ts,
    CS_start=0,
    AntiWindup=true)
    annotation (Placement(transformation(extent={{-60,44},{-40,64}})));
  Modelica.Blocks.Math.Add add
    annotation (Placement(transformation(extent={{30,50},{50,70}})));
  Modelica.Blocks.Sources.Step Disturb(height=-2, startTime=50)
    annotation (Placement(transformation(extent={{-20,74},{0,94}})));
  LinearSystems.Continuous.TransferFunction
                                      P_inner(
    y_start=0,
    num={1},
    den={0.05,1})
          annotation (Placement(transformation(extent={{-4,-40},{20,-20}})));
  LinearSystems.Continuous.TransferFunction
                                        P_outer(
    y_start=0,
    num={1},
    den={1,2,1})
          annotation (Placement(transformation(extent={{60,-40},{84,-20}})));
  Controllers.PI R_outer(
    CSmax=5,
    CSmin=0,
    Ti=1,
    Kp=0.5,
    Ts=Ts,
    CS_start=0,
    AntiWindup=true)
    annotation (Placement(transformation(extent={{-60,-34},{-40,-14}})));
  Modelica.Blocks.Sources.Step SetPoint(height=1, startTime=2)
    annotation (Placement(transformation(extent={{-100,0},{-80,20}})));
  Modelica.Blocks.Math.Add add_C
    annotation (Placement(transformation(extent={{30,-34},{50,-14}})));
  Controllers.PI R_inner(
    CSmax=5,
    CSmin=0,
    Ti=0.05,
    Kp=5,
    Ts=Ts_inner,
    CS_start=0,
    AntiWindup=true)
    annotation (Placement(transformation(extent={{-32,-40},{-12,-20}})));
equation
  connect(P2.y, R.PV)      annotation (Line(
      points={{82.8,54},{94,54},{94,20},{-64,20},{-64,53},{-58,53}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(add.y, P2.u) annotation (Line(
      points={{51,60},{56,60},{56,54},{62.4,54}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(add.u2, P1.y) annotation (Line(
      points={{28,54},{-3.2,54}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(Disturb.y, add.u1) annotation (Line(
      points={{1,84},{20,84},{20,66},{28,66}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(R.CS, P1.u) annotation (Line(
      points={{-41,54},{-23.6,54}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(P_outer.y, R_outer.PV)
                           annotation (Line(
      points={{82.8,-30},{88,-30},{88,-60},{-64,-60},{-64,-25},{-58,-25}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(SetPoint.y, R_outer.SP)
                                 annotation (Line(
      points={{-79,10},{-68.5,10},{-68.5,-18},{-58,-18}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(add_C.y, P_outer.u)
                           annotation (Line(
      points={{51,-24},{54,-24},{54,-30},{62.4,-30}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(add_C.u2, P_inner.y)
                            annotation (Line(
      points={{28,-30},{18.8,-30}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(R_inner.CS, P_inner.u)
                           annotation (Line(
      points={{-13,-30},{-1.6,-30}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(Disturb.y, add_C.u1) annotation (Line(
      points={{1,84},{20,84},{20,-18},{28,-18}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(add_C.y, R_inner.PV)
                            annotation (Line(
      points={{51,-24},{54,-24},{54,-50},{-36,-50},{-36,-32},{-30,-32},{-30,-31}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(SetPoint.y, R.SP)  annotation (Line(
      points={{-79,10},{-68,10},{-68,60},{-58,60}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(R_outer.CS, R_inner.SP) annotation (Line(
      points={{-41,-24},{-30,-24}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(graphics),
    experiment(StopTime=90),
    __Dymola_experimentSetupOutput,
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
  In this examples are compared two control schemes. The aim of this example is to show how classic control
  strategy can be implemented with the models contained within the <b>ControlLibrary</b>.<br>
  The system to be controlled is composed by two dynamics: a fast one and a slow one.
  The trasfer functions follow:<br>
  <b>Fast</b>
  <pre>
           Y(s)           1
   P1(s) = ----  =  -------------
           U(s)       (1+0.05s)
  </pre>
  <br>
  <b>Slow</b><br>
  <pre>
           Y(s)           1
   P2(s) = ----  =  -------------
           U(s)       (1+2s+s^2)
  </pre>
  <br>
  Two different control scheme (both using discrete dime controllers) are compared. In the first one there is one controller
  that acts <br> directly on the fast process P1 and measures the output of the second process P2.<br>
  In the second case, there are two controllers that act respectively on the fast and slow dynamics. 
  The second approach is called cascade control.<br><br>
  <img src=\"modelica://IndustrialControlSystems/help/images/Applications/ControlProblems/Cascade.png\"><br>
  The Step responce of the two scheme are listed below.<br>
  <img src=\"modelica://IndustrialControlSystems/help/images/Applications/ControlProblems/CascadePV.png\"><br>
  Despite for a step variation of the Set Point, the two responces (classic scheme red line, and cascade the green one) are<br>
  practically the same, this is not true when disturbances occur. It is evident that the cascade control scheme<br>
  performs better than the classic one. Below are reported the control signal of the controllers<br>
  <img src=\"modelica://IndustrialControlSystems/help/images/Applications/ControlProblems/CascadeCS.png\"><br>
  where is evidenced the fast action of the inner control loop.<br><br>
   
  Since the controller are discrete time ones, it is important to choose the right sampling time for each loop <br>
  (external and internal one). In this case have been choosen a sampling time of 0.5 s for the outer loop, while a <br>
  sampling time of 0.01 s for the inner one.
</html>"));
end CascadeControl;
