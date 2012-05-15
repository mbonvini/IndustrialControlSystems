within IndustrialControlSystems.Controllers.Blocks.Examples;
model TestTrackingP "Tracking test mode for P block"
  extends Modelica.Icons.Example;

  IndustrialControlSystems.Controllers.Blocks.P P "proportional controller"
                 annotation (Placement(transformation(extent={{-60,60},{-40,
            80}}, rotation=0)));
  Modelica.Blocks.Sources.Sine Input(amplitude=2)
    annotation (Placement(transformation(extent={{-100,60},{-80,80}},
          rotation=0)));
  IndustrialControlSystems.Controllers.Blocks.P Ptr(useTS=true)
    "proportional controller with tracking mode"
                  annotation (Placement(transformation(extent={{-60,-80},{
            -40,-60}}, rotation=0)));
  Modelica.Blocks.Sources.BooleanPulse TSsignal(period=8, startTime=4)
    annotation (Placement(transformation(extent={{-100,-20},{-80,0}},
          rotation=0)));
  Modelica.Blocks.Sources.Trapezoid TrackRef(
    amplitude=5,
    rising=1,
    width=2,
    falling=1,
    period=8,
    nperiod=1,
    startTime=4) annotation (Placement(transformation(extent={{-100,-60},{
            -80,-40}}, rotation=0)));
equation
  connect(Input.y, P.u) annotation (Line(points={{-79,70},{-58,70}}, color=
          {0,0,127}));
  connect(Input.y, Ptr.u)
                         annotation (Line(points={{-79,70},{-72,70},{-72,
          -70},{-58,-70}}, color={0,0,127}));
  connect(TSsignal.y, Ptr.TS)
                          annotation (Line(points={{-79,-10},{-45,-10},{-45,
          -62}}, color={255,0,255}));
  connect(TrackRef.y, Ptr.TR)
                          annotation (Line(points={{-79,-50},{-49.8,-50},{
          -49.8,-62}}, color={0,0,127}));
  annotation (
    Diagram(graphics),
    experiment(StopTime=10),
    experimentSetupOutput,Documentation(info="
  <HTML>
  <h4>Description</h4>
  <p>
  In this example has been tested the Tracking mode of the proportional block.<br>
  The images show the output <FONT FACE=Courier>y</FONT> of the proportional controller, with a 
  sine wave as input <FONT FACE=Courier>u</FONT>.
  
  <h4>input and output</h4>
  <img src=\"modelica://IndustrialControlSystems/help/images/Controllers/Blocks/Examples/PropTrack.png\"><br>
  
  <h4>Tracking switch signal and Track reference</h4>
  <img src=\"modelica://IndustrialControlSystems/help/images/Controllers/Blocks/Examples/PropTrack2.png\">
  
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
end TestTrackingP;
