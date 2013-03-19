within IndustrialControlSystems.Controllers.Logic.Examples;
model TestRelay "Test of relay controllers"
  extends Modelica.Icons.Example;

  Modelica.Blocks.Sources.Sine Input(freqHz=1, amplitude=1)
    annotation (Placement(transformation(extent={{-100,60},{-80,80}},
          rotation=0)));
  IndustrialControlSystems.Controllers.Logic.RelayHysteresis Rhyst_DIGITAL(
    initState=false,
    ThL=-0.5,
    ThH=0.5,
    Ymax=1,
    Ymin=-1,
    Ts=0.1)
    annotation (Placement(transformation(extent={{-40,60},{-20,80}})));
  IndustrialControlSystems.Controllers.Logic.Relay R_DIGITAL(Ts=0.2)
    annotation (Placement(transformation(extent={{-40,-40},{-20,-20}})));
  IndustrialControlSystems.Controllers.Logic.RelayHysteresis Rhyst(
    initState=false,
    ThL=-0.5,
    ThH=0.5,
    Ymax=1,
    Ymin=-1,
    Ts=0)
    annotation (Placement(transformation(extent={{-40,30},{-20,50}})));
  IndustrialControlSystems.Controllers.Logic.Relay R
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
equation

  connect(Rhyst_DIGITAL.u, Input.y)
                            annotation (Line(
      points={{-38,70},{-79,70}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(R_DIGITAL.u, Input.y)
                        annotation (Line(
      points={{-38,-30},{-68,-30},{-68,70},{-79,70}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(Input.y, Rhyst.u) annotation (Line(
      points={{-79,70},{-68,70},{-68,40},{-38,40}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(Input.y, R.u) annotation (Line(
      points={{-79,70},{-68,70},{-68,6.66134e-16},{-38,6.66134e-16}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (
    Diagram(graphics),
    experiment(StopTime=4),
    experimentSetupOutput,Documentation(info="
  <HTML>
  <h4>Description</h4>
  <p>
  In this example have been tested the Relay with hysteresis and without.<br>
  The images show the output <FONT FACE=Courier>y</FONT> of the tro blocks, with a 
  sine wave as input <FONT FACE=Courier>u</FONT>.
  
  <h4>RELAY: input and output</h4><br>
  <img src=\"modelica://IndustrialControlSystems/help/images/Controllers/Logic/Examples/Relay.png\"><br>
  
  <h4>RELAY WITH HYST (0.5, -0.5): input and output</h4><br>
  <img src=\"modelica://IndustrialControlSystems/help/images/Controllers/Logic/Examples/RelayHyst.png\">
  
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
end TestRelay;
