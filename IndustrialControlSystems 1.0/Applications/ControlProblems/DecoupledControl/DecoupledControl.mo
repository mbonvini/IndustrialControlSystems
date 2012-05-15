within IndustrialControlSystems.Applications.ControlProblems.DecoupledControl;
model DecoupledControl "Control scheme with decoupler"
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
  Decoupler decoupler(
    P_21_22_num={1,0.5},
    P_21_22_den={3,1},
    P_12_11_num={2.5,0.5},
    P_12_11_den={4,1})
    annotation (Placement(transformation(extent={{-22,0},{18,40}})));
  Controllers.PI controller1(
    useBIAS=true,
    Kp=5,
    Ti=5,
    Ts=0.05,
    AntiWindup=true,
    CSmin=-20,
    CSmax=20)
    annotation (Placement(transformation(extent={{-52,40},{-32,60}})));
  Controllers.PI controller2(
    useBIAS=true,
    Kp=2,
    Ti=2,
    Ts=0.05,
    AntiWindup=true,
    CSmin=-20,
    CSmax=20)
    annotation (Placement(transformation(extent={{-52,-40},{-32,-20}})));
  Modelica.Blocks.Sources.Step setPoint1(
    offset=0,
    height=10,
    startTime=0)          annotation (Placement(transformation(extent={{-82,46},
            {-62,66}})));
  Modelica.Blocks.Sources.Step setPoint2(
    offset=0,
    height=10,
    startTime=30)
              annotation (Placement(transformation(extent={{-82,-34},{-62,-14}})));
equation
  connect(controller1.CS, decoupler.u1)
                               annotation (Line(
      points={{-33,50},{-28,50},{-28,32},{-18,32}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(controller2.CS, decoupler.u2)
                                annotation (Line(
      points={{-33,-30},{-28,-30},{-28,12},{-18,12}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(decoupler.y1, process.u1) annotation (Line(
      points={{16,32},{44,32}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(decoupler.y2, process.u2) annotation (Line(
      points={{16,12},{44,12}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(process.y1, controller1.PV)
                             annotation (Line(
      points={{78,32},{86,32},{86,86},{-56,86},{-56,49},{-50,49}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(process.y2, controller2.PV)
                              annotation (Line(
      points={{78,12},{86,12},{86,-48},{-56,-48},{-56,-31},{-50,-31}},
      color={0,0,127},
      smooth=Smooth.None));

  connect(setPoint1.y, controller1.SP)
                         annotation (Line(
      points={{-61,56},{-50,56}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(setPoint2.y, controller2.SP)
                           annotation (Line(
      points={{-61,-24},{-50,-24}},
      color={0,0,127},
      smooth=Smooth.None));

  connect(decoupler.toU1, controller1.BIAS) annotation (Line(
      points={{16,26},{24,26},{24,70},{-46,70},{-46,58}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(decoupler.toU2, controller2.BIAS) annotation (Line(
      points={{16,18},{24,18},{24,-14},{-46,-14},{-46,-22}},
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
</dl></html>",
             info="<html>
<p><b>Description</b> </p>
<p>
The 2x2 process reported below has to be controlled<br/><br/>
<img src=\"modelica://IndustrialControlSystems/help/images/Applications/ControlProblems/DecoupledController/Process.png\"/><br/><br/>
The process is controlled using a decoupler and two PIs ( R1(s) and R2(s) ), each one controlling the corresponding output signal.<br/>
<img src=\"modelica://IndustrialControlSystems/help/images/Applications/ControlProblems/DecoupledController/DecouplerController.png\"/><br/><br/>
The goal of the control system is to maintain the output of the processe as close as possible to the set point references,<br>
avoiding the cross effects between the first input and the second output and vice versa.<br>

</html>"));
end DecoupledControl;
