within IndustrialControlSystems.Controllers.AutoTuning.Examples;
model Test_ATPIrelayNCdigital
  "Test of a PI digital controller with Automatic Tuning"
  extends Modelica.Icons.Example;

  ATPIrelayNCdigital ControllerPm45(
    Ts=0.1,
    Kp=0.2,
    Ti=2,
    slope=0.02,
    pm=45)
    annotation (Placement(transformation(extent={{-40,40},{-14,64}},
                                                                   rotation=0)));
  Modelica.Blocks.Sources.Step SP(
    offset=0.5,
    startTime=120,
    height=0.3) annotation (Placement(transformation(extent={{-100,62},{-80,82}},
          rotation=0)));
  Modelica.Blocks.Sources.BooleanTable      ATpulse(table={60,60.1})
                          annotation (Placement(transformation(extent={{-100,20},
            {-80,40}}, rotation=0)));
  LinearSystems.Continuous.TransferFunction ProcessPm45(num={1}, den={1,3,3,1})
    annotation (Placement(transformation(extent={{54,26},{80,46}}, rotation=0)));
  Modelica.Blocks.Sources.Step Disturb(
    offset=0,
    startTime=180,
    height=-0.5)
                annotation (Placement(transformation(extent={{-20,80},{0,100}},
          rotation=0)));
  Modelica.Blocks.Math.Feedback sum  annotation (Placement(transformation(
          extent={{24,26},{44,46}}, rotation=0)));
  ATPIrelayNCdigital ControllerPm60(
    Ts=0.1,
    Kp=0.2,
    Ti=2,
    slope=0.02,
    pm=60)
    annotation (Placement(transformation(extent={{-40,-22},{-14,2}},
                                                                   rotation=0)));
  LinearSystems.Continuous.TransferFunction ProcessPm60(num={1}, den={1,3,3,1})
    annotation (Placement(transformation(extent={{54,-20},{80,0}}, rotation=0)));
  Modelica.Blocks.Math.Feedback sum1 annotation (Placement(transformation(
          extent={{20,-20},{40,0}}, rotation=0)));
  ATPIrelayNCdigital ControllerPm70(
    Ts=0.1,
    Kp=0.2,
    Ti=2,
    slope=0.02,
    pm=70)
    annotation (Placement(transformation(extent={{-40,-72},{-14,-48}},
                                                                   rotation=0)));
  LinearSystems.Continuous.TransferFunction ProcessPm70(num={1}, den={1,3,3,1})
    annotation (Placement(transformation(extent={{54,-70},{80,-50}},
                                                                   rotation=0)));
  Modelica.Blocks.Math.Feedback sum2 annotation (Placement(transformation(
          extent={{20,-70},{40,-50}},
                                    rotation=0)));
equation
  connect(SP.y, ControllerPm45.SP) annotation (Line(points={{-79,72},{-54,72},{-54,
          59.2},{-37.4,59.2}},
        color={0,0,127}));
  connect(sum.y, ProcessPm45.u)    annotation (Line(points={{43,36},{43,36},{56.6,
          36}},
        color={0,0,127}));
  connect(ProcessPm45.y, ControllerPm45.PV)
                                      annotation (Line(points={{78.7,36},{86,36},
          {86,12},{-46,12},{-46,50.8},{-37.4,50.8}},
                                              color={0,0,127}));
  connect(ControllerPm45.CS, sum.u1)
                                   annotation (Line(
      points={{-15.3,52},{14,52},{14,36},{26,36}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(Disturb.y, sum.u2) annotation (Line(
      points={{1,90},{12,90},{12,18},{34,18},{34,28}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(sum1.y, ProcessPm60.u) annotation (Line(
      points={{39,-10},{56.6,-10}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(ControllerPm60.CS, sum1.u1) annotation (Line(
      points={{-15.3,-10},{22,-10}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(Disturb.y, sum1.u2) annotation (Line(
      points={{1,90},{12,90},{12,-18},{30,-18}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(ProcessPm60.y, ControllerPm60.PV) annotation (Line(
      points={{78.7,-10},{84,-10},{84,-40},{-46,-40},{-46,-11.2},{-37.4,-11.2}},
      color={0,0,127},
      smooth=Smooth.None));

  connect(ATpulse.y, ControllerPm60.ATreq) annotation (Line(
      points={{-79,30},{-64,30},{-64,-19.6},{-37.4,-19.6}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(SP.y, ControllerPm60.SP) annotation (Line(
      points={{-79,72},{-54,72},{-54,-2.8},{-37.4,-2.8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(ATpulse.y, ControllerPm45.ATreq) annotation (Line(
      points={{-79,30},{-64,30},{-64,42.4},{-37.4,42.4}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(sum2.y, ProcessPm70.u) annotation (Line(
      points={{39,-60},{56.6,-60}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(ControllerPm70.CS, sum2.u1) annotation (Line(
      points={{-15.3,-60},{22,-60}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(Disturb.y, sum2.u2) annotation (Line(
      points={{1,90},{12,90},{12,-68},{30,-68}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(ProcessPm70.y, ControllerPm70.PV) annotation (Line(
      points={{78.7,-60},{84,-60},{84,-88},{-46,-88},{-46,-61.2},{-37.4,-61.2}},
      color={0,0,127},
      smooth=Smooth.None));

  connect(ATpulse.y, ControllerPm70.ATreq) annotation (Line(
      points={{-79,30},{-64,30},{-64,-69.6},{-37.4,-69.6}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(SP.y, ControllerPm70.SP) annotation (Line(
      points={{-79,72},{-54,72},{-54,-52.8},{-37.4,-52.8}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(graphics),
    experiment(StopTime=240),
    experimentSetupOutput(equdistant=false),Documentation(info="
  <HTML>
  <h4>Description</h4>
  <p>
  In this example have been tested the functionalities of the digital PI with Automatic Tuning.<br>
  The PI has to control the process with transfer function
  <pre>
   Y(s)           1
   ----  =  --------------
   U(s)       (s + 1)^3
  </pre>
  There are three PIs that are automatically tuned. The PIs have different Phase Margin requirements: 45, 60 and 70 respectively.<br>
  The first image shows the process variables controlled by the three PIs <FONT FACE=Courier>PV</FONT>.<br>
  <br>
  There are thre phases:
  <ul>
  <li>Normal mode [0,50]: PIs working with default parameters values,</li> 
  <li>Auto Tuning phase [50,120]: PIs excite the processes in order to identify some characteristic parameters,</li> 
  <li>Normal mode [120,end]: PIs working with tuned parameters values</li> 
  </ul><br>
  <img src=\"modelica://IndustrialControlSystems/help/images/Controllers/AutoTuning/Examples/ATPI_PV.png\"><br>
  Control signals
  <img src=\"modelica://IndustrialControlSystems/help/images/Controllers/AutoTuning/Examples/ATPI_CS.png\"><br>
  
  <h4>References</h4>
  For more information please refers to the following
  <a href=\"modelica://IndustrialControlSystems/help/refs/EffHybPITuning.pdf\">paper</a>:<br><br>
  <b>Efficient hybrid simulation of autotuning PI controllers</b><br>
  Alberto Leva, Marco Bonvini<br>
  8th Modelica Conference, Dresden, Germany<br>
  march 20-22, 2011<br>
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
end Test_ATPIrelayNCdigital;
