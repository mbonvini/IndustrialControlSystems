within IndustrialControlSystems.Controllers.Blocks.Examples;
model TestTrackingFO "Tracking test mode for FO block"
  extends Modelica.Icons.Example;

  IndustrialControlSystems.Controllers.Blocks.FO FOtr(useTS=true, T=0.4)
    annotation (Placement(transformation(extent={{-44,-24},{-22,-2}})));
  IndustrialControlSystems.Controllers.Blocks.FO FOaw(
    mu=1,
    AntiWindup=true,
    T=0.4,
    useTS=true,
    Ymin=0,
    Ymax=2)                   annotation (
      Placement(transformation(extent={{-40,20},{-20,40}}, rotation=0)));
  Modelica.Blocks.Sources.Step signal(startTime=2, height=2)
    annotation (                          Placement(transformation(extent={{-100,74},
            {-80,94}}, rotation=0)));
  Modelica.Blocks.Sources.BooleanPulse TSsignal(
    startTime=4,
    width=10,
    period=40) annotation (Placement(transformation(extent={{-100,0},{-80,
            20}}, rotation=0)));
  Modelica.Blocks.Sources.Trapezoid TrackRef(
    amplitude=5,
    rising=1,
    width=2,
    falling=1,
    period=8,
    nperiod=1,
    startTime=4) annotation (Placement(transformation(extent={{-100,-32},{
            -80,-12}}, rotation=0)));
  IndustrialControlSystems.Controllers.Blocks.FO FO(mu=1, T=0.4)
                              annotation (
      Placement(transformation(extent={{-42,74},{-22,94}}, rotation=0)));
equation
  connect(signal.y, FO.u) annotation (Line(points={{-79,84},{-60,84},{-40,84}},
        color={0,0,127}));
  connect(TSsignal.y, FOtr.TS) annotation (Line(
      points={{-79,10},{-27.5,10},{-27.5,-4.2}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(TrackRef.y, FOtr.TR) annotation (Line(
      points={{-79,-22},{-70,-22},{-70,4},{-32.78,4},{-32.78,-4.2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(signal.y, FOtr.u) annotation (Line(
      points={{-79,84},{-60,84},{-60,-13},{-41.8,-13}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(signal.y, FOaw.u) annotation (Line(
      points={{-79,84},{-60,84},{-60,30},{-38,30}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(TSsignal.y, FOaw.TS) annotation (Line(
      points={{-79,10},{-74,10},{-74,54},{-25,54},{-25,38}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(TrackRef.y, FOaw.TR) annotation (Line(
      points={{-79,-22},{-70,-22},{-70,50},{-29.8,50},{-29.8,38}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (
    Diagram(graphics),
    experiment(StopTime=15),
    experimentSetupOutput,Documentation(info="
  <HTML>
  <h4>Description</h4>
  <p>
  In this example has been tested the Tracking mode of the First Order block.<br>
  The images show the output <FONT FACE=Courier>y</FONT> of the first order block, with a 
  step as input <FONT FACE=Courier>u</FONT>.<br>
  During the tracking phase the stave variable is forced to follow the Track Reference signal.
  
  <h4>input and output</h4><br>
  <img src=\"modelica://IndustrialControlSystems/help/images/Controllers/Blocks/Examples/FOTrack.png\"><br>
  
  <h4>Tracking switch signal and Track reference</h4>
  <img src=\"modelica://IndustrialControlSystems/help/images/Controllers/Blocks/Examples/FOTrack2.png\">
  
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
end TestTrackingFO;
