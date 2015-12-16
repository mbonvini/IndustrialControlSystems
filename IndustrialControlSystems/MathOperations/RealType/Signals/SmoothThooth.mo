within IndustrialControlSystems.MathOperations.RealType.Signals;
model SmoothThooth "Smooth thooth Set point generator"
  extends Interfaces.RealNinOperation(final useInputs=false, final FixedPoint=false, final Nbit = 1, final scaleFactor = 1, final MAX = 1, final MIN = 0);
  parameter Real ts = 10 "|Smooth step| Initial rising time";
  parameter Real td = 29 "|Smooth step| Initial falling time";
  parameter Real alfa = 0.1
    "|Smooth step| Portion of time for parabolic junctions";
  parameter Real yin = 0 "|Smooth step| Output initial value";
  parameter Real yfin = 1 "|Smooth step| Output final value";
  parameter Real m = 0.1 "|Smooth step| Slope of the ramp";
equation
  assert(alfa>=0 and alfa<=1,"alfa out of range [0,1]");
  assert(td>ts+(abs(yin-yfin)/m)*(1+alfa),"you have to increase td");

  y = if (time<td) then
         Functions.fSmoothStep(time,ts,alfa,m,yin,yfin) else
         Functions.fSmoothStep(time,td,alfa,m,yfin,yin);

  // No Fixed Point here
  Ufp = zeros(nInput);
  Yfp = 0;

  annotation (Icon(graphics={Line(
          points={{-86,-64},{-70,-64},{-64,-62},{-62,-60},{-58,-54},{
              -52,-40},{-34,46},{-30,56},{-24,60},{-20,62},{22,62},{
              28,60},{34,56},{38,48},{50,-38},{54,-52},{58,-58},{62,
              -62},{68,-64},{84,-64}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None), Text(
          extent={{-102,126},{100,108}},
          lineColor={0,0,0},
          textString="smooth thooth")}),
                                 Documentation(info="
  <HTML>
  <h4>Description</h4>
  <p>
  Model of a smooth thooth signal.
  <br><br>
  <img src=\"modelica://IndustrialControlSystems/help/images/Math/RealType/Signals/SmoothThooth.png\">
  <br><br>
  The output ( <FONT FACE=Courier>y</FONT> ) remains at its initial value <FONT FACE=Courier>yin</FONT> until time 
  is equal to <FONT FACE=Courier>ts</FONT>.<br>
  Then the signal changes smoothly. After the smoth start the signal grows up linearly with a slope <FONT FACE=Courier>m</FONT>.
  When the output signal is close to the final value <FONT FACE=Courier>yfin</FONT>, it is reached smoothly.<br>
  At time <FONT FACE=Courier>td</FONT> the signal returns at its initial value in a specular way.<br>
  The parameter <FONT FACE=Courier>alfa</FONT> (that has to be coprises between 0 and 1), indicates the portion of the rising 
  time occupied by the smooth junction.<br>
  In figure are compared two models that have respectively <FONT FACE=Courier>alfa = 0.1</FONT> and <FONT FACE=Courier>alfa = 0.4</FONT>.
  </p>
  <p><br><b>Fixed Point not available in this model</b>  </p>
  </HTML>", revisions="<html>
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
end SmoothThooth;
