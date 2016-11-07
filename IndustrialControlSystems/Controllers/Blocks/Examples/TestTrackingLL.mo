within IndustrialControlSystems.Controllers.Blocks.Examples;
model TestTrackingLL "Tracking test mode for LL block"
  extends Modelica.Icons.Example;

  IndustrialControlSystems.Controllers.Blocks.LeadLAG LLaw(
    Ymin=0,
    AntiWindup=true,
    mu=1,
    Tp=2,
    Tz=1,
    y_start=1,
    Ymax=3,
    useTS=true)
    annotation (Placement(transformation(extent={{-44,0},{-20,24}})));
  IndustrialControlSystems.Controllers.Blocks.LeadLAG LLtr(
    mu=1,
    Tp=2,
    Tz=1,
    y_start=1,
    useTS=true,
    Ymax=4,
    AntiWindup=true)
    annotation (Placement(transformation(extent={{-44,-46},{-20,-22}})));
  Modelica.Blocks.Sources.BooleanPulse TSsignal(
    width=10,
    period=40,
    startTime=10)
               annotation (                         Placement(
        transformation(extent={{-100,-20},{-80,0}},rotation=0)));
  Modelica.Blocks.Sources.Trapezoid TrackRef(
    rising=1,
    width=2,
    falling=1,
    period=8,
    nperiod=1,
    startTime=10,
    amplitude=3,
    offset=2)    annotation (                            Placement(
        transformation(extent={{-100,-60},{-80,-40}}, rotation=0)));
  Modelica.Blocks.Sources.Step signal(
    offset=1,
    startTime=2,
    height=1)
    annotation (Placement(transformation(extent={{-100,74},{-80,94}},
          rotation=0)));
  IndustrialControlSystems.Controllers.Blocks.LeadLAG LL(
    mu=1,
    Tp=2,
    Tz=1,
    y_start=1)
          annotation (                         Placement(transformation(
          extent={{-46,74},{-26,94}}, rotation=0)));
equation
  connect(signal.y, LL.u) annotation (Line(points={{-79,84},{-44,84}},
        color={0,0,127}));
  connect(signal.y, LLaw.u) annotation (Line(
      points={{-79,84},{-66,84},{-66,12},{-41.6,12}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(signal.y, LLtr.u) annotation (Line(
      points={{-79,84},{-66,84},{-66,-34},{-41.6,-34}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(TSsignal.y, LLtr.TS) annotation (Line(
      points={{-79,-10},{-26,-10},{-26,-24.4}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(TrackRef.y, LLtr.TR) annotation (Line(
      points={{-79,-50},{-56,-50},{-56,-16},{-31.76,-16},{-31.76,-24.4}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(TSsignal.y, LLaw.TS) annotation (Line(
      points={{-79,-10},{-72,-10},{-72,40},{-26,40},{-26,21.6}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(TrackRef.y, LLaw.TR) annotation (Line(
      points={{-79,-50},{-56,-50},{-56,34},{-31.76,34},{-31.76,21.6}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (
    Diagram(graphics),
    experiment(StopTime=22),
    experimentSetupOutput,Documentation(info="
  <HTML>
  <h4>Description</h4>
  <p>
  In this example has been tested the Tracking mode of the Lead Lag block.<br>
  The images show the output <FONT FACE=Courier>y</FONT> of the lead Lag block, with a 
  step as input <FONT FACE=Courier>u</FONT>.<br>
  During the tracking phase the stave variable is forced to follow the Track Reference signal.
  
  <h4>input and output</h4><br>
  <img src=\"modelica://IndustrialControlSystems/help/images/Controllers/Blocks/Examples/LLTrack.png\"><br>
  
  <h4>Tracking switch signal and Track reference</h4>
  <img src=\"modelica://IndustrialControlSystems/help/images/Controllers/Blocks/Examples/LLTrack2.png\">
  
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
end TestTrackingLL;
