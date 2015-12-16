within IndustrialControlSystems.Logical.LogicalOperations.Examples;
model FliFlop "Flip Flop test"
  extends Modelica.Icons.Example;

  FlipFlopSR flipFlopSR(              Ts=0.1, q_start=false)
    annotation (Placement(transformation(extent={{-20,0},{0,20}})));
  Modelica.Blocks.Sources.BooleanTable setSIGNAL(startValue=false,
      table={1,5,8,10,12,15})
    annotation (Placement(transformation(extent={{-100,20},{-80,40}})));
  Modelica.Blocks.Sources.BooleanTable resetSIGNAL(startValue=false,
      table={6,7,12,14})
    annotation (Placement(transformation(extent={{-100,-20},{-80,0}})));
equation
  connect(setSIGNAL.y, flipFlopSR.u1) annotation (Line(
      points={{-79,30},{-50,30},{-50,15},{-18,15}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(resetSIGNAL.y, flipFlopSR.u2) annotation (Line(
      points={{-79,-10},{-50,-10},{-50,5},{-18,5}},
      color={255,0,255},
      smooth=Smooth.None));
  annotation (
    Diagram(graphics),
    experiment(StopTime=20),
    experimentSetupOutput,
    Documentation(revisions="<html>
<dl><dt>First release of the Industrial Control Systems: April-May 2012</dt>
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
<dd><i>The IndustrialControlSystems package is <b>free</b> software; it can be redistributed and/or modified under the terms of the <b>Modelica license</b>, see the license conditions and the accompanying <b>disclaimer</b> in the documentation of package Modelica in file &quot;Modelica/package.mo&quot;.</i><br/></dd>
</dl></html>", info="<html>
<h4>Description</h4>
<p>
In this examples is tested the Set reset Flip Flop.<br>
In this case <FONT FACE=Courier>Ts = 0.1</FONT> and the initial value of the FF is <FONT FACE=Courier>Q = false</FONT>.
<br>When a rising edge of the SET signal is detected, the output Q becomes true while a rising edge of the RESET signal is detected the output Q becomes false.
<br><br>
<img src=\"modelica://IndustrialControlSystems/help/images/Logical/LogicalOperations/Examples/FLIPFLOP.png\"><br><br>
<br><br>
</p>
</html>"));
end FliFlop;
