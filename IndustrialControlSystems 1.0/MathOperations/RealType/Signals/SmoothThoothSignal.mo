within IndustrialControlSystems.MathOperations.RealType.Signals;
model SmoothThoothSignal "Smooth thooth Set Point generator, driven by signals"
  extends Interfaces.RealNinOperation(final useInputs=true,final nInput = 2, final FixedPoint=false, final Nbit = 1, final scaleFactor = 1, final MAX = 1, final MIN = 0);
  Modelica.Blocks.Interfaces.BooleanInput ENup annotation (Placement(
        transformation(extent={{-100,36},{-60,76}}), iconTransformation(extent={{-100,40},
            {-60,80}})));
  Modelica.Blocks.Interfaces.BooleanInput ENdown annotation (Placement(
        transformation(extent={{-100,-70},{-60,-30}}),
                                                     iconTransformation(extent={{-100,
            -80},{-60,-40}})));
  Real ts;
  Real td;
  Boolean Sali(start=false);
  Boolean Scendi(start=false);
  parameter Real alfa =  0.1
    "|Smooth step| Portion of time for parabolic junctions";
  parameter Real m =     0.1 "|Smooth step| Slope of the ramp";
  parameter Real wait_s = 0 "|Smooth step| Rising delay";
  parameter Real wait_d = 0 "|Smooth step| Falling delay";
protected
  discrete Boolean Ed_d;
  discrete Boolean Es_d;
equation
  Ed_d = ENdown;
  Es_d = ENup;

  when
      (pre(Ed_d)== false and Ed_d==true) then
    td = time + wait_d;
    Scendi = true;
  end when;

  when
      (pre(Es_d)== false and Es_d==true) then
    ts = time + wait_s;
    Sali = true;
  end when;

  y = Functions.f(
    Sali,
    Scendi,
    time,
    ts,
    td,
    alfa,
    m,
    u[1],
    u[2]);

  // No Fixed Point here
  Ufp = zeros(nInput);
  Yfp = 0;

  annotation (Icon(graphics={Line(
          points={{-82,-72},{-66,-72},{-60,-70},{-58,-68},{-54,-62},{-48,-48},{-30,
              38},{-26,48},{-20,52},{-16,54},{26,54},{32,52},{38,48},{42,40},{54,
              -46},{58,-60},{62,-66},{66,-70},{72,-72},{88,-72}},
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
  <img src=\"modelica://IndustrialControlSystems/help/images/Math/RealType/Signals/SmoothThoothSignal.png\">
  <br><br>
  The output ( <FONT FACE=Courier>y</FONT> ) remains at its initial value <FONT FACE=Courier>yin</FONT> 
  until the enabling input <FONT FACE=Courier>ENup</FONT> remains <FONT FACE=Courier>false</FONT>.<br>
  Then the signal changes smoothly. After the smoth start the signal grows up linearly with a slope <FONT FACE=Courier>m</FONT>.
  When the output signal is close to the final value <FONT FACE=Courier>yfin</FONT>, it is reached smoothly.<br>
  The signal returns at its initial value in a specular way, when the input <FONT FACE=Courier>ENup</FONT> becomes <FONT FACE=Courier>true</FONT>.<br>
  The parameter <FONT FACE=Courier>alfa</FONT> (that has to be coprises between 0 and 1), indicates the portion of the rising 
  time occupied by the smooth junction.<br>
  The rising is delayed by <FONT FACE=Courier>wait_s</FONT> seconds, while the falling is delayed by <FONT FACE=Courier>wait_d</FONT> seconds.<br>
  Initial and final values are externally defined.
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
</dl></html>"),
    Diagram(graphics));
end SmoothThoothSignal;
