within IndustrialControlSystems.Applications.ControlProblems;
model SmithPredictor "Smith predictor controller for delayed processes"
  extends Modelica.Icons.Example;

  LinearSystems.Continuous.TransferFunction process(num={1}, den={0.2,1.2,1})
    annotation (Placement(transformation(extent={{26,66},{50,94}})));
  IndustrialControlSystems.LinearSystems.Continuous.Delay delay(T=8)
    annotation (Placement(transformation(extent={{-16,70},{12,90}})));
  Modelica.Blocks.Sources.Step SetPoint(height=1, startTime=2)
    annotation (Placement(transformation(extent={{-100,70},{-80,90}})));
  LinearSystems.Continuous.TransferFunction processSmith1(num={1}, den={0.2,1.2,
        1}) annotation (Placement(transformation(extent={{26,26},{50,54}})));
  IndustrialControlSystems.LinearSystems.Continuous.Delay delay1(T=8)
    annotation (Placement(transformation(extent={{-16,30},{12,50}})));
  Controllers.PI Regulator1(Ti=1, Kp=2,
    AntiWindup=true,
    CSmin=0,
    CSmax=2)
    annotation (Placement(transformation(extent={{-52,30},{-32,50}})));
  LinearSystems.Continuous.TransferFunction processModel1(num={1}, den={0.2,1.2,
        1}) annotation (Placement(transformation(extent={{26,-14},{50,14}})));
  IndustrialControlSystems.LinearSystems.Continuous.SmithDelay smithDelay1(T=8)
    annotation (Placement(transformation(extent={{-16,-14},{14,14}})));
  Modelica.Blocks.Math.Add add1
    annotation (Placement(transformation(extent={{70,10},{90,30}})));
  LinearSystems.Continuous.TransferFunction processSmith2(num={1}, den={0.2,1.2,
        1}) annotation (Placement(transformation(extent={{26,-50},{50,-22}})));
  IndustrialControlSystems.LinearSystems.Continuous.Delay delay2(T=8)
    annotation (Placement(transformation(extent={{-16,-46},{12,-26}})));
  Controllers.PI Regulator2(Ti=1, Kp=2,
    AntiWindup=true,
    CSmin=0,
    CSmax=2)
    annotation (Placement(transformation(extent={{-52,-46},{-32,-26}})));
  LinearSystems.Continuous.TransferFunction processModel2(num={1}, den={1.2,1})
    annotation (Placement(transformation(extent={{26,-90},{50,-62}})));
  IndustrialControlSystems.LinearSystems.Continuous.SmithDelay smithDelay2(T=8)
    annotation (Placement(transformation(extent={{-16,-90},{14,-62}})));
  Modelica.Blocks.Math.Add add2
    annotation (Placement(transformation(extent={{70,-66},{90,-46}})));
equation
  connect(delay.y, process.u) annotation (Line(
      points={{10.6,80},{28.4,80}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(delay1.y, processSmith1.u) annotation (Line(
      points={{10.6,40},{28.4,40}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(Regulator1.CS, delay1.u) annotation (Line(
      points={{-33,40},{-13.2,40}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(SetPoint.y, Regulator1.SP) annotation (Line(
      points={{-79,80},{-60,80},{-60,46},{-50,46}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(processSmith1.y, add1.u1) annotation (Line(
      points={{48.8,40},{62,40},{62,26},{68,26}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(add1.y, Regulator1.PV) annotation (Line(
      points={{91,20},{94,20},{94,-20},{-60,-20},{-60,39},{-50,39}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(SetPoint.y, delay.u) annotation (Line(
      points={{-79,80},{-13.2,80}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(Regulator1.CS, smithDelay1.u) annotation (Line(
      points={{-33,40},{-22,40},{-22,1.4877e-15},{-13,1.4877e-15}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(smithDelay1.y, processModel1.u) annotation (Line(
      points={{12.5,1.40998e-15},{20,1.40998e-15},{20,0},{22,0},{22,1.4877e-15},
          {28.4,1.4877e-15}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(processModel1.y, add1.u2) annotation (Line(
      points={{48.8,1.40998e-15},{62,1.40998e-15},{62,14},{68,14}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(delay2.y, processSmith2.u) annotation (Line(
      points={{10.6,-36},{28.4,-36}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(Regulator2.CS, delay2.u) annotation (Line(
      points={{-33,-36},{-13.2,-36}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(SetPoint.y, Regulator2.SP) annotation (Line(
      points={{-79,80},{-70,80},{-70,-30},{-50,-30}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(processSmith2.y, add2.u1) annotation (Line(
      points={{48.8,-36},{62,-36},{62,-50},{68,-50}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(add2.y, Regulator2.PV) annotation (Line(
      points={{91,-56},{94,-56},{94,-96},{-60,-96},{-60,-37},{-50,-37}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(Regulator2.CS, smithDelay2.u) annotation (Line(
      points={{-33,-36},{-22,-36},{-22,-76},{-13,-76}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(smithDelay2.y, processModel2.u) annotation (Line(
      points={{12.5,-76},{28.4,-76}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(processModel2.y, add2.u2) annotation (Line(
      points={{48.8,-76},{62,-76},{62,-62},{68,-62}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(graphics), Documentation(revisions="<html>
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
</dl></html>", info="<HTML>
  <h4>Description</h4>
  <p>
  The aim of this example is to show how classic control strategy can be implemented with the models contained within the <b>ControlLibrary</b>.<br>
  The system to be controlled is a delayed second order one<br>
  <pre>
          Y(s)           1           -8T
   P(s) = ----  =  ---------------- e
          U(s)       (1+0.2s)(1+s)
  </pre>
  <br>
  In this case the delay is too high in order to control the process with a simple PI controller. However, the same simple<br>
  controller can be used within a more complex structure called Smith predictor. This scheme is based on the knowledge of the process<br>
  since it is a model based control strategy.
  The control scheme follows, and can be replicated with the blocks contained in the library<br><br>
  <img src=\"modelica://IndustrialControlSystems/help/images/Applications/ControlProblems/Smith.png\"><br><br>
  
  Two different scheme have been tested. In the first scheme the Smith predictor is based on a model that is equal to the<br>
  real process (M(s) = P(s)), while in the second one the model is an approximation of the process. The step responces are reported below
  <br>
  <img src=\"modelica://IndustrialControlSystems/help/images/Applications/ControlProblems/SmithPV.png\"><br>
  The red line is the process responce without the controller action, the green line is the process controlled with the
  Smith predictor (M(s) = P(s)) while the pink one is the responce of the Smith predictor with an approximate model.<br>
  Every 8 seconds (the time delay) there is an action due to the uncorrectness of the model M. However, the amplitude<br>
  of these peacks decrease with time. The control signal of the two controllers are reported below.<br>
  <img src=\"modelica://IndustrialControlSystems/help/images/Applications/ControlProblems/SmithCS.png\"><br>
  
  
</html>"));
end SmithPredictor;
