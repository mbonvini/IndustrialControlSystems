within IndustrialControlSystems.Logical.Timers.Examples;
model testT_OffDelay
  extends Modelica.Icons.Example;

  IndustrialControlSystems.Logical.Timers.Timer_OffDelay timer
    annotation (Placement(transformation(extent={{0,60},{20,80}})));
  Modelica.Blocks.Sources.Constant timerVALUE(k=10) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-30,30})));
  Modelica.Blocks.Sources.BooleanTable SetSignal(table={0.5,4,6.5})
    annotation (Placement(transformation(extent={{-100,78},{-80,98}})));
  Modelica.Blocks.Sources.BooleanTable ResetSignal(table={5,6.5})
    annotation (Placement(transformation(extent={{-100,46},{-80,66}})));
equation
  connect(timerVALUE.y, timer.PV)   annotation (Line(
      points={{-19,30},{6,30},{6,62}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(SetSignal.y, timer.S) annotation (Line(
      points={{-79,88},{-40,88},{-40,74},{2,74}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(ResetSignal.y, timer.R) annotation (Line(
      points={{-79,56},{-40,56},{-40,66},{2,66}},
      color={255,0,255},
      smooth=Smooth.None));
  annotation (Diagram(graphics),
    experiment(StopTime=50),
    experimentSetupOutput,
    Documentation(revisions="<html>
<dl><dt>First release of the Industrial Control Systems: April-May 2012</dt>
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
<dd><i>The IndustrialControlSystems package is <b>free</b> software; it can be redistributed and/or modified under the terms of the <b>Modelica license</b>, see the license conditions and the accompanying <b>disclaimer</b> in the documentation of package Modelica in file &QUOT;Modelica/package.mo&QUOT;.</i><br/></dd>
</dl></html>"));
end testT_OffDelay;
