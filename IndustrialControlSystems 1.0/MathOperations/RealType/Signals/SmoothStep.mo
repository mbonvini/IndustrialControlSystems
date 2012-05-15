within IndustrialControlSystems.MathOperations.RealType.Signals;
model SmoothStep "Smooth step Set pointgenerator"
  extends Interfaces.RealNinOperation(final useInputs=false, final FixedPoint=false, final Nbit = 1, final scaleFactor = 1, final MAX = 1, final MIN = 0);
  parameter Real tin = 10 "|Smooth step| Initial time";
  parameter Real alfa = 0.1
    "|Smooth step| Portion of time for parabolic junctions";
  parameter Real yin = 0 "|Smooth step| Output initial value";
  parameter Real yfin = 1 "|Smooth step| Output final value";
  parameter Real m = 0.1 "|Smooth step| Slope of the ramp";
equation
  assert(alfa>=0 and alfa<=1,"alfa out of range [0,1]");

  y = IndustrialControlSystems.MathOperations.RealType.Functions.fSmoothStep(
    time,
    tin,
    alfa,
    m,
    yin,
    yfin);

  // No Fixed Point here
  Ufp = zeros(nInput);
  Yfp = 0;

  annotation (Icon(graphics={Line(
          points={{-94,-86},{-62,-86},{-56,-84},{-50,-80},{-42,-72},{-32,-58},{22,
              60},{30,70},{38,76},{48,80},{62,82},{82,82}},
          color={0,0,0},
          smooth=Smooth.None,
          thickness=0.5), Text(
          extent={{-100,126},{100,106}},
          lineColor={0,0,0},
          textString="smooth step")}),
                            Documentation(info="
  <HTML>
  <h4>Description</h4>
  <p>
  Model of a smooth step signal.
  <br><br>
  <img src=\"modelica://IndustrialControlSystems/help/images/Math/RealType/Signals/SmoothStep.png\">
  <br><br>
  The output ( <FONT FACE=Courier>y</FONT> ) remains at its initial value <FONT FACE=Courier>yin</FONT> until time 
  is equal to <FONT FACE=Courier>tin</FONT>.<br>
  Then the signal changes smoothly. After the smoth start the signal grows up linearly with a slope <FONT FACE=Courier>m</FONT>.
  When the output signal is close to the final value <FONT FACE=Courier>yfin</FONT>, it is reached smoothly.<br>
  The parameter <FONT FACE=Courier>alfa</FONT> (that has to be coprises between 0 and 1), indicates the portion of the rising 
  time occupied by the smooth junction.<br>
  In this case <FONT FACE=Courier>alfa = 0.1</FONT>, this indicates that each junction occupy the 10 % of the total rising time.  
    </p>
  <p><br><b>Fixed Point not available in this model</b>  </p>
  </HTML>", revisions="<html>
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
end SmoothStep;
