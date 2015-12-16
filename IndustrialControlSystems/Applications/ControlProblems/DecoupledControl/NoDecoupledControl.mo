within IndustrialControlSystems.Applications.ControlProblems.DecoupledControl;
model NoDecoupledControl "Control scheme without decoupler"
  extends Modelica.Icons.Example;
  Process process(
    P12_den={4,1},
    P22_num={1},
    P22_den={2,1},
    P11_num={1},
    P11_den={5,1},
    P12_num={0.5},
    P21_num={0.5},
    P21_den={3,1})
    annotation (Placement(transformation(extent={{40,0},{80,40}})));
  Controllers.PI controller1(
    useBIAS=false,
    Ti=5,
    Kp=5,
    AntiWindup=true,
    CSmin=-20,
    CSmax=20)
    annotation (Placement(transformation(extent={{-40,40},{-20,60}})));
  Controllers.PI controller2(
    useBIAS=false,
    Ti=2,
    Kp=2,
    AntiWindup=true,
    CSmin=-20,
    CSmax=20)
    annotation (Placement(transformation(extent={{-40,-20},{-20,0}})));
  Modelica.Blocks.Sources.Step setPoint1(
    offset=0,
    height=10,
    startTime=0)          annotation (Placement(transformation(extent={{-84,46},
            {-64,66}})));
  Modelica.Blocks.Sources.Step setPoint2(
    offset=0,
    height=10,
    startTime=30)
              annotation (Placement(transformation(extent={{-84,-14},{-64,6}})));
equation
  connect(process.y1, controller1.PV)
                             annotation (Line(
      points={{78,32},{92,32},{92,80},{-46,80},{-46,49},{-38,49}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(process.y2, controller2.PV)
                              annotation (Line(
      points={{78,12},{92,12},{92,-38},{-46,-38},{-46,-11},{-38,-11}},
      color={0,0,127},
      smooth=Smooth.None));

  connect(setPoint1.y, controller1.SP)
                         annotation (Line(
      points={{-63,56},{-38,56}},
      color={0,0,127},
      smooth=Smooth.None));

  connect(controller1.CS, process.u1) annotation (Line(
      points={{-21,50},{-10,50},{-10,32},{44,32}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(controller2.CS, process.u2) annotation (Line(
      points={{-21,-10},{-8,-10},{-8,12},{44,12}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(setPoint2.y, controller2.SP) annotation (Line(
      points={{-63,-4},{-56.75,-4},{-56.75,-4},{-50.5,-4},{-50.5,-4},{-38,-4}},
      color={0,0,127},
      smooth=Smooth.None));

  annotation (Diagram(graphics), Documentation(revisions="<html>
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
</dl></html>",
             info="<html>
<p><b>Description</b> </p>
<p>
The 2x2 process reported below has to be controlled<br/><br/>
<img src=\"modelica://IndustrialControlSystems/help/images/Applications/ControlProblems/DecoupledController/Process.png\"/><br/><br/>
The process is controlled using two PIs ( R1(s) and R2(s) ), each one controlling the corresponding output signal.<br/>
<img src=\"modelica://IndustrialControlSystems/help/images/Applications/ControlProblems/DecoupledController/NoDecouplerController.png\"/><br/><br/>
The goal of the control system is to maintain the output of the processe as close as possible to the set point references,<br>
avoiding the cross effects between the first input and the second output and vice versa.<br><br>

</html>"),
    experiment(StopTime=50),
    __Dymola_experimentSetupOutput(events=false));
end NoDecoupledControl;
